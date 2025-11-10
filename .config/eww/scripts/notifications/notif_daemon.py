#!/usr/bin/env python3
import dbus
import dbus.service
from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import GLib
import threading
import time
from itertools import count


class Notification:
    def __init__(
        self,
        nid,
        app_name,
        replaces_id,
        app_icon,
        summary,
        body,
        actions,
        hints,
        timeout,
    ):
        self.id = nid
        self.app_name = app_name
        self.replaces_id = replaces_id
        self.app_icon = app_icon
        self.summary = summary
        self.body = body
        self.actions = actions
        self.hints = hints
        self.timeout = timeout


class NotificationManager:
    def __init__(self):
        self.notifications = []
        self.notifications_lock = threading.Lock()

    def print_notifications(self):
        string = ""
        for item in self.notifications:
            string = (
                string
                + f"""
                      (button :class 'notif'
                       (box :orientation 'horizontal' :space-evenly false
                          (box :orientation 'vertical'
                            (label :width 100 :wrap true :text '{item.summary or ""}')
                            (label :width 100 :wrap true :text '{item.body or ""}')
                      )))
                      """
            )
        string = string.replace("\n", " ")
        print(rf"""(box :orientation 'vertical' {string or ""})""", flush=True)

    def add_object(self, notification):
        with self.notifications_lock:
            if notification.replaces_id != 0:
                for item in self.notifications:
                    if item.id == notification.replaces_id:
                        self.notifications.remove(item)
            self.notifications.insert(0, notification)
            self.print_notifications()

        timer_thread = threading.Thread(
            target=self.remove_object, args=(notification,), daemon=True
        )
        timer_thread.start()

    def remove_object(self, notification):
        timeout = 10
        if notification.timeout > 1:
            timeout = notification.timeout / 1000
        time.sleep(timeout)
        with self.notifications_lock:
            if notification in self.notifications:
                self.notifications.remove(notification)
            self.print_notifications()


class NotificationServer(dbus.service.Object):
    def __init__(self):
        self.notif_manager = NotificationManager()
        self.id_counter = count(1)
        bus_name = dbus.service.BusName(
            "org.freedesktop.Notifications", bus=dbus.SessionBus()
        )
        dbus.service.Object.__init__(self, bus_name, "/org/freedesktop/Notifications")

    @dbus.service.method(
        "org.freedesktop.Notifications", in_signature="susssasa{ss}i", out_signature="u"
    )
    def Notify(
        self, app_name, replaces_id, app_icon, summary, body, actions, hints, timeout
    ):
        nid = next(self.id_counter)
        if replaces_id != 0:
            nid = replaces_id
        else:
            nid = next(self.id_counter)
        self.notif_manager.add_object(
            Notification(
                nid,
                app_name,
                replaces_id,
                app_icon,
                summary,
                body,
                actions,
                hints,
                timeout,
            )
        )
        return nid

    @dbus.service.method("org.freedesktop.Notifications", out_signature="ssss")
    def GetServerInformation(self):
        return ("Custom Notification Server", "ExampleNS", "1.0", "1.2")

    @dbus.service.method("org.freedesktop.Notifications", out_signature="as")
    def GetCapabilities(self):
        return ("body", "body-markup", "icon-static", "actions")

    @dbus.service.method(
        "org.freedesktop.Notifications", in_signature="u", out_signature=""
    )
    def CloseNotification(self, nid):
        with self.notif_manager.notifications_lock:
            item_to_delete = None
            for item in self.notif_manager.notifications:
                if item.id == nid:
                    item_to_delete = item
                    break
            if item_to_delete is None:
                return
            self.notif_manager.notifications.remove(item_to_delete)
            self.NotificationClosed(nid, 1)  # 1 = closed by user
            self.notif_manager.print_notifications()

    @dbus.service.signal("org.freedesktop.Notifications", signature="uu")
    def NotificationClosed(self, id, reason):
        pass

    @dbus.service.signal("org.freedesktop.Notifications", signature="us")
    def ActionInvoked(self, id, action_key):
        pass


DBusGMainLoop(set_as_default=True)

if __name__ == "__main__":
    server = NotificationServer()
    mainloop = GLib.MainLoop()
    mainloop.run()

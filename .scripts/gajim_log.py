#!/usr/bin/env python
# -*- encoding: utf-8 -*-

import sys
import os
import sqlite3 as sqlite
from time import localtime, strftime
import codecs

logs = {}

def mkline(log_id, line, folder):
    try:
        file = logs[log_id]
        if file is None:
            raise KeyError
    except KeyError:
        # log_id may contain slashes -- think resource in MUC
        log_id = log_id.replace("/", "_")
        filename = os.path.join(folder, "%s.log" % log_id)
        try:
            #print "open %s" % filename
            logs[log_id] = codecs.open(filename, "w", "utf-8")
        except IOError: # Too many opened files
            print "purge opened files"
            for id in logs:
                logs[id].close()
                logs[id] = None
            print "open %s" % filename
            logs[log_id] = codecs.open(filename, "a", "utf-8")
        file = logs[log_id]
    file.write(line)
    file.write("\n")
    #print line

def export_logs(database, folder):
    link = sqlite.connect(database)
    cur = link.cursor()
    
    result = cur.execute("""
        SELECT
            jids.jid, jids.type, logs.contact_name, logs.time, logs.kind, 
            logs.show, logs.message, logs.subject
        FROM
            jids, logs
        WHERE
            jids.jid_id = logs.jid_id
        ORDER BY logs.time ASC;""")

    current_day = None

    for row in result:
        jid, type, contact_name, time, kind, show, message, subject = row
        t = localtime(time)          
        time_str = strftime("%H:%M:%S", t)
        groupchat = (kind == 1 or kind == 2)
        privatechat = (kind == 4 or kind == 6)
        privatemsg = (kind == 5 or kind == 7)
        log_id = strftime("%Y-%m", t) + "-" + jid

        if groupchat:
            log_id = "group-" + log_id
        else:
            if not contact_name:
                contact_name = jid
            else:
                contact_name = "%s|%s" % (jid, contact_name)
        
        # add a new line and the current date when the day changes
        if t[2] != current_day:
            current_day = t[2]
            mkline(log_id, "", folder)            
            mkline(log_id, strftime("%a %d %b %Y - %Z", t), folder)

        if show:
            show = ("online", "chat", "away", "xa", "dnd", "offline")[show]
        
        kind = ("status",
                "status", # groupchat
                "msg", # groupchat
                "recvmsg", # privatemsg
                "recvchat", # privatechat
                "sentmsg", # privatemsg
                "sentchat",   # privatechat
                "error")[kind]

        if groupchat:
            prefix1 = "%s | %s |" % (time_str, jid)
            prefix2 = prefix1
            prefix3 = "%s %s" % (prefix2, ("<%s>" % contact_name).rjust(30))
        else:
            prefix1 = "%s |" %  time_str
            if show:
                prefix2 = "%s %s" % (prefix1, ("[%s]" % show).ljust(9))
            else:
                prefix2 = prefix1
            prefix3 = prefix2

        if subject:
            line = prefix3 + " Subject: %s" % subject
            mkline(log_id, line, folder)

        if kind == 'status':
            line = prefix1 + " status %s %s: %s" % (contact_name, show, 
    message)
        elif kind == 'msg':
            line = prefix3 + " %s" % message
        elif kind == 'recvmsg':
            line = prefix3 + " [%s] %s" % (contact_name, message)
        elif kind == 'recvchat':
            line = prefix3 + " [%s] %s" % (contact_name, message)
        elif kind == 'sentmsg':
            line = prefix3 + " [me] %s" % message
        elif kind == 'sentchat':
            line = prefix3 + " [me] %s" % message
        else:
            line = prefix3 + " %s %s" % (("[%s]" % kind), message)

        mkline(log_id, line, folder)

def usage():
    print("usage : export_gajim.py path/to/logs.db")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        usage()
        sys.exit(0)

    database = sys.argv[1]  
    if not os.path.isfile(database):
        print("database not found")
        usage()
        sys.exit(0)

    export_folder = os.path.join(os.path.dirname(database), "logs")
    try:
        os.mkdir(export_folder)
    except OSError:
        pass
    print "exporting log history to %s" % export_folder

    export_logs(database, export_folder)


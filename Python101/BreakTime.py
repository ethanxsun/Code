        # -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
import time
import webbrowser

total_breaks = 3
break_count = 0

print("This program started on " +  time.ctime())
while(break_count < total_breaks):
    
    time.sleep(5)
    webbrowser.open("http://www.baidu.com")
    break_count = break_count + 1
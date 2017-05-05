#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Wed May  3 15:42:50 2017

@author: ethansun
"""

import os

def rename_files():
    
    # 1 get file names from a folder
    file_list = os.listdir("/Users/ethansun/Data/Python101/Photo50/prank")
    print(file_list)      
    
    # 2 for each file, rename filename
    saved_path = os.getcwd()
    print("current pwd is: " + saved_path)
    os.chdir("/Users/ethansun/Data/Python101/Photo50/prank")
    
    for file_name in file_list:
        os.rename(file_name, file_name.translate(None, "0123456789"))
    
rename_files

rename_files()
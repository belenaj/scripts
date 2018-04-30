# -*- coding: utf-8 -*-
#####################################################
# name: downloadImages.py                           #
# author: Jorge Belena                              #
# description: download jpgs from a list of         #
# URLs given in a text file                         #
#####################################################

import requests
import time
import os.path
import urllib.parse

if __name__ == '__main__':

    print("# Starting script at: " + time.strftime("%Y-%m-%d %H:%M:%S"))
    inputFile = "URLs.txt"
    print("# Getting URL list from: " + inputFile)

    with open(inputFile) as f:
        for line in f:
            print("# Downloading picture from: " + line)
            img_data = requests.get(line).content
            outputFilename = (urllib.parse.urlparse(line.rstrip()))[2].rpartition('/')[2]
            with open(os.path.join("img", outputFilename), 'wb') as handler:
                handler.write(img_data)

    print("# Finishing script at: " + time.strftime("%Y-%m-%d %H:%M:%S"))

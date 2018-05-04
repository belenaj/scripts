# -*- coding: utf-8 -*-
#####################################################
# name: downloadImages.py                           #
# author: Jorge Belena                              #
# description: download jpgs from a list of         #
# URLs given in a text file                         #
#####################################################

"""
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# downloadImages.py :: download jpgs from a list of URLs given in a text file
#
# Version: 1.01
#
# Usage:
# downloadImages.py
# -----------------------------------------------------------------------------
"""

import requests
import time
import os.path
import urllib.parse
import sys


def main():
    print("# Starting script at: " + time.strftime("%Y-%m-%d %H:%M:%S"))
    inputfile = "URLs.txt"
    print("# Getting URL list from: " + inputfile)

    with open(inputfile) as f:
        for line in f:
            print("# Downloading picture from: " + line)
            img_data = requests.get(line).content
            outputfilename = (urllib.parse.urlparse(line.rstrip()))[2].rpartition('/')[2]
            with open(os.path.join("img", outputfilename), 'wb') as handler:
                handler.write(img_data)
    print("# Finishing script at: " + time.strftime("%Y-%m-%d %H:%M:%S"))


# Program start
if __name__ == '__main__':
    if not len(sys.argv) == 1:
        print(__doc__)
        sys.exit(1)
    main()

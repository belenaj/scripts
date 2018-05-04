# -*- coding: utf-8 -*-
#####################################################
# name: mergePDFs.py                                #
# author: Jorge Belena                              #
# description: given a root directory, merges       #
# all the founded .pdf files                        #
# following alphabetical order                      #
# pyPdf2 is needed: pip install pyPdf2              #
#####################################################

"""
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# mergePDFs.py :: given a root directory, merges all the founded .pdf files
# following alphabetical order
#
# Version: 1.00
#
#  Usage:
#    mergePDFs.py
# -----------------------------------------------------------------------------
"""

import time
import sys
import os
from PyPDF2 import PdfFileMerger, PdfFileReader


def main():
    print("# Starting script at: " + time.strftime("%Y-%m-%d %H:%M:%S"))

    # raw strings
    rootdir = r'C:\tmp'
    outputfile = 'output.pdf'

    # removes output file
    if os.path.exists(outputfile):
        os.remove(outputfile)
    merger = PdfFileMerger()

    for subdir, dirs, files in os.walk(rootdir):
        for f in files:
            if f.endswith(".pdf"):
                filename = os.path.join(subdir, f)
                print(filename)
                merger.append(PdfFileReader(filename, 'rb'))

    merger.write(outputfile)
    print("# Finishing script at: " + time.strftime("%Y-%m-%d %H:%M:%S"))


# Program start
if __name__ == '__main__':
    if not len(sys.argv) == 1:
        print(__doc__)
        sys.exit(1)
    main()

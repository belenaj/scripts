import glob
import os

path = '/Volumes/abc/'


jpeg = []
raw = []

for root, dirs, files in os.walk(path):
    for filename in files:
        if filename.endswith(".JPG"):
            jpeg.append(os.path.splitext(filename)[0])
            #print(filename)
        if filename.endswith(".CR2"):
            raw.append(os.path.splitext(filename)[0])
            #print(filename)

print(jpeg)
print(raw)

diff_list = list(set(jpeg) - set(raw))

print(diff_list)

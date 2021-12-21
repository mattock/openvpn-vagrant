#!/usr/bin/env python3
#
# Get version used by OpenVPN tarballs. For example "2.6_git". This could be
# optimized, but performance has near-zero impact in here.

import re

pv={}

major = re.compile('define\(\[PRODUCT_VERSION_MAJOR\],\s\[(\d+)\]\)')
minor = re.compile('define\(\[PRODUCT_VERSION_MINOR\],\s\[(\d+)\]\)')
patch = re.compile('define\(\[PRODUCT_VERSION_PATCH\],\s\[(.*)]\)')

with open('version.m4', 'r') as version_m4:
    for line in version_m4:
         ma = major.match(line)
         mi = minor.match(line)
         pa = patch.match(line)

         if ma:
            pv['major'] = ma.group(1)
         elif mi:
            pv['minor'] = mi.group(1)
         elif pa:
            pv['patch'] = pa.group(1)

print("%s.%s%s" % (pv['major'], pv['minor'], pv['patch']))

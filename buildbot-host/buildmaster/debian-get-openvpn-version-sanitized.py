#!/usr/bin/env python3
#
# Get sanitized OpenVPN version number from version.m4. For example 2.5.
#
import re

with open('version.m4', 'r') as version_m4:
    for line in version_m4:
        pvr = re.compile('define\(\[PRODUCT_VERSION_RESOURCE\],\s\[(\d+,\d+),\d+,\d+\]\)')
        m = pvr.match(line)
        if m:
            print(m.group(1).replace(",", "."))

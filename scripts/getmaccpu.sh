#!/bin/bash

# this script get's the Mac's number of cpu

echo $(sysctl hw.physicalcpu_max | cut -d ":" -f2 | cut -d " " -f2)

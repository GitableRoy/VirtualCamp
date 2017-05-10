#!/bin/bash

# This script gathers your Mac's hardware specs

system_profiler SPHardwareDataType | grep "Memory"

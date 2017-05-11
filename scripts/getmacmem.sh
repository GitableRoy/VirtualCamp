#!/bin/bash

# This script gathers your Mac's RAM size

RAM=$(sysctl audit.session.member_clear_sflags_mask | cut -d ":" -f2 | cut -d " " -f2)
echo $(($RAM/4))

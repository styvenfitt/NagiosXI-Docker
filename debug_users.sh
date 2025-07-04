#!/bin/bash
echo "=== Debugging user commands ==="
echo "PATH: $PATH"
echo "Checking for useradd:"
ls -la /usr/sbin/useradd 2>/dev/null && echo "Found /usr/sbin/useradd" || echo "NOT found /usr/sbin/useradd"
ls -la /sbin/useradd 2>/dev/null && echo "Found /sbin/useradd" || echo "NOT found /sbin/useradd"
which useradd 2>/dev/null && echo "useradd found in PATH" || echo "useradd NOT in PATH"

echo "Checking for groupadd:"
ls -la /usr/sbin/groupadd 2>/dev/null && echo "Found /usr/sbin/groupadd" || echo "NOT found /usr/sbin/groupadd"
ls -la /sbin/groupadd 2>/dev/null && echo "Found /sbin/groupadd" || echo "NOT found /sbin/groupadd"
which groupadd 2>/dev/null && echo "groupadd found in PATH" || echo "groupadd NOT in PATH"

echo "Checking for usermod:"
ls -la /usr/sbin/usermod 2>/dev/null && echo "Found /usr/sbin/usermod" || echo "NOT found /usr/sbin/usermod"
ls -la /sbin/usermod 2>/dev/null && echo "Found /sbin/usermod" || echo "NOT found /sbin/usermod"
which usermod 2>/dev/null && echo "usermod found in PATH" || echo "usermod NOT in PATH"

echo "Available packages related to user management:"
dpkg -l | grep -E "(passwd|adduser|login)"

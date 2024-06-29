#!/bin/sh
timestamp=$(date '+%Y-%m-%dT%H:%M:%SZ')
user=$(whoami)
hostname=$(hostname)
echo "" &&
    echo $timestamp &&
    echo "Welcome $user!" &&
    echo "You have logged in to a $hostname instance. Note that all session activity is being logged." &&
    echo "Please don't directly input any password in the console!" &&
    exec /bin/bash
cd ~

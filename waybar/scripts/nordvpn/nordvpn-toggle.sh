#!/bin/bash

# Check if NordVPN is currently connected
if nordvpn status | grep -q "Status: Connected"; then
  # If connected, disconnect
  nordvpn disconnect
else
  # If disconnected, connect to the best available server
  nordvpn connect
fi

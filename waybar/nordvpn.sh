#!/bin/bash

STATUS=$(nordvpn status)

if echo "$STATUS" | grep -q "Status: Connected"; then
  SERVER=$(echo "$STATUS" | grep "Current server:" | awk '{print $3}')
  echo "{\"text\": \"VPN: ${SERVER}\", \"tooltip\": \"Connected\", \"class\": \"connected\", \"on-click\": \"nordvpn disconnect\"}"
  exit 0
else
  echo "{\"text\": \"VPN: Disconnected\", \"tooltip\": \"Disconnected\", \"class\": \"disconnected\", \"on-click\": \"nordvpn connect\"}"
  exit 1
fi

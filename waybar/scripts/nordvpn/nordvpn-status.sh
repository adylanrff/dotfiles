#!/bin/bash

STATUS=$(nordvpn status)

if echo "$STATUS" | grep -q "Status: Connected"; then
  SERVER=$(echo "$STATUS" | grep "Server:" | awk '{print $2}')
  echo "{\"text\": \"VPN: ${SERVER}\", \"tooltip\": \"Connected\", \"class\": \"connected\", \"on-click\": \"nordvpn disconnect\"}"
else
  echo "{\"text\": \"VPN: Disconnected\", \"tooltip\": \"Disconnected\", \"class\": \"disconnected\", \"on-click\": \"nordvpn connect\"}"
fi

exit 0

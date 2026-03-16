#!/bin/bash
{ echo "get serial number"; echo "get robot model"; echo "safetystatus"; echo "get operational mode"; sleep 0.5; echo "quit"; } | nc localhost 29999
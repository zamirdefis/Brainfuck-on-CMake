#!/bin/bash
cmake -G "Ninja Multi-Config" -S . -B "../build" "$@"

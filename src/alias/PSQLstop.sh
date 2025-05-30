#!/bin/bash

s() { sudo systemctl $1 postgresql; }
s stop
s status

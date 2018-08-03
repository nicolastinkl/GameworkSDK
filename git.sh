#!/bin/bash

git add .
date +%F > timefile
currentTime=$(<timefile)
git commit -m "commit message push by m,and time: $currentTime "
git push
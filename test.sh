#!/bin/bash
sudo docker container rm -f $(sudo docker container ls -a | awk 'NR != 1 {print $1}')

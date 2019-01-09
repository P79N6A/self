#!/bin/bash
echo -n "Please enter the url you want to test:"
read url
curl ${url} > /dev/null

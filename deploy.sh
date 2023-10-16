#! /bin/bash

git add -A

if $1; then
    git commit -m "[Specified] $1"
else
    git commit -m "[Default] Synchronization"
fi

git push -u origin main

mkdocs gh-deploy
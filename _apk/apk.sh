#!/bin/sh

is_installed() {
   apk list --installed "$1"
}



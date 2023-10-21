#!/bin/bash

genisoimage -output cloud-init.iso -volid CIDATA -joliet -rock user-data meta-data


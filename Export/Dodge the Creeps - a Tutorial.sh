#!/bin/sh
echo -ne '\033c\033]0;Dodge the Creeps - a Tutorial\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Dodge the Creeps - a Tutorial.x86_64" "$@"

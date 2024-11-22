#!/bin/sh

err() { printf 'ERROR %s\n' "$1"; exit 1; }

[ -z "$1" ] && {
	printf  'Usage: mkfs_structure.sh <location>\n'
	exit 1
}

[ -e "$1" ] || err "directory '$1' does not exist" 
[ -d "$1" ] || err "'$1' is not a directory"
[ -w "$1" ] || err "cannot write to '$1' permission denied"

dir_path="${1:-./}"

tab="$(printf '\t')"

while IFS= read -r ln; do
	depth="${ln%%[!"$tab"]*}"
	depth="${#depth}"

	dir_name="${ln##"${ln%%[!"$tab"]*}"}"

	while [ "$((depth - prev_depth))" -le 0 ] ; do
		dir_path="${dir_path%/*}"

		prev_depth="$((prev_depth - 1))"
	done

	dir_path="${dir_path%/}/${dir_name}"

	printf -- '[%d] %s\n' "$depth" "$dir_path"
	mkdir -p "$dir_path"

	prev_depth="$depth"

done <<__DIR_STRUCT__
	01-projects
		01-software_development
		02-hardware_development
		03-system_configuration
		04-device_modification
		99-archive
	02-sandbox
		01-code
			awk
			bash
			c
			fish
			haskell
			latex
			python
			rust
			sh
			sqlite
			zig
		02-software
			01-sources
			99-archive
	03-file_library
		01-software_binaries
		02-multimedia
			01-books
				01-non_fiction
					01-computer
					02-philosophy
					03-psychology
					04-maths
					05-science
					06-history
				02-fiction
				03-comics
				98-files
				99-archive
			02-music
			03-movies
				01-files
				02-subtitles
				99-archive
			04-pictures
		03-documents
			01-personal
			03-RSGC
				01-Sem_1
				02-Sem_2
				03-Sem_3
				04-Sem_4
				05-Sem_5
					01-A5SB3E_android_progrmming
					02-A5CS5_relational_database_management_systems
					03-A5CSEL1A_digital_computer_fundamentals_and_architecture
					04-A5CSEL2A_operating_system
					05-A5COELO1_e-commerce
					06-A522CSEC_internet_programming
				06-Sem_6
				98-unsorted
			04-mummy
			99-archive
		04-OS_ISOs
	04-knowledge
		01-computer_science
		02-maths
		03-science
		04-literature
		05-language
	05-shared
	99-archive
		01-thoughts_archive
		03-message_workspace
			01-emails
			02-messages
		04-certificates
			certs
			ssh
__DIR_STRUCT__

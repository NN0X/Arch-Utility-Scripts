#!/bin/bash

echo "This script is not meant to be executed directly"
exit

backup_target="/home/nox"
exclude=". .. Backup Seafile Windows"

target=$(ls -a $backup_target)

for i in $exclude ; do
	if [[ ${target[@]} =~ $i ]]; then
		target=(${target[@]/$i})
	fi
done

echo "Creating backup directory..."

backup_dir="/home/nox/Backup/$(date +%s)"
mkdir $backup_dir
touch $backup_dir/log

echo "Backup directory created: $backup_dir"

echo "Creating file list..."
files=()
for i in ${target[@]} ; do
	if [[ -f "/home/nox/$i" ]]; then
		files+=(/home/nox/$i)
	fi
done

target_dirs=()
for i in ${target[@]} ; do
	if [[ -d "/home/nox/$i" ]]; then
		target_dirs+=(/home/nox/$i)
	fi
done

for i in ${target_dirs[@]} ; do
	files+=($(find $i -type f))
done

echo "File list created"

num_files=${#files[@]}
echo "Number of files: $num_files"

echo "Copying files..."
echo "0% done"
index=1
prev_percent=0
for i in ${files[@]} ; do
	# check if file is not read-only
	if [[ ! -w $i ]]; then
		echo "Skipping $i" >> $backup_dir/log
		continue
	fi
	path=(${i//\// })
	filename=${path[${#path[@]}-1]}
	unset path[${#path[@]}-1]
	unset path[0]
	unset path[1]
	pathall=()
	pathtemp=$backup_dir
	for j in ${path[@]} ; do
		pathtemp="$pathtemp/$j"
		pathall+=($pathtemp)
	done
	for j in ${pathall[@]} ; do
		if [[ ! -d $j ]]; then
			mkdir $j
		fi
	done
	cp $i "$pathtemp/$filename"
	percent=$((index*100/num_files))
	if [[ $percent -ne $prev_percent ]]; then
		echo -e "\033[1A\033[K$percent% done"
		prev_percent=$percent
	fi
	index=$((index+1))
done

echo "Files copied"

echo "Creating tarball..."
# create tarball and print progress using pv
tar -czf - $backup_dir | pv -s $(du -sb $backup_dir | awk '{print $1}') | dd of="$backup_dir.tar.gz" bs=4096
rm -rf $backup_dir

echo "Tarball created: $backup_dir.tar.gz"

echo "Backup complete"

#!/bin/sh
#
# Write/remove a task to do later.
#
# Select an existing entry to remove it from the file, or type a new entry to
# add it.
#

file="$HOME/.todo"
touch "$file"
height=$(wc -l "$file" | awk '{print $1}')

cmd=$(dmenu -g 1 -l "$height" -p tasks "$@" < "$file")
while [ -n "$cmd" ]; do
 	if grep -q "^$cmd\$" "$file"; then
		grep -v "^$cmd\$" "$file" > "$file.$$"
		mv "$file.$$" "$file"
        height=$(( height - 1 ))
 	else
		echo "$cmd" >> "$file"
		height=$(( height + 1 ))
 	fi

	cmd=$(dmenu -g 1 -l "$height" "$@" < "$file")
done

exit 0

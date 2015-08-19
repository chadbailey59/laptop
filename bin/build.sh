#!/bin/sh

for MANIFEST in Manifest.*; do
  FILENAME=$(printf "$MANIFEST" | sed s/Manifest\.//)
  rm -f "$FILENAME"

  printf "\nBuilding $MANIFEST into $FILENAME\n"

  while read file; do
    if ! echo "$file" | grep -qs "^//"; then
      printf "Including: scripts/$file\n"

      cat "scripts/$file" >> "$FILENAME"

      printf "### end $file\n\n" >> "$FILENAME"
    else
      printf "Skipping $file\n"
    fi
  done < "$MANIFEST"
done

chmod a+x $FILENAME


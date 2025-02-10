# #!/bin/bash

FILES=$(rg --files-with-matches "^\s\senabled = true" -g '*.lua')

for FILE in $FILES; do
  # if filename starts with -x, remove it
  if [[ $FILE == *"x-"* ]]; then
    NEW_FILE=$(echo $FILE | sed "s/x-//")
    mv $FILE $NEW_FILE
    echo "Renamed $FILE to $NEW_FILE"
  fi
done

FILES=$(rg --files-with-matches "^\s\senabled = false" -g '*.lua')

for FILE in $FILES; do
  if [[ $FILE != *"x-"* ]]; then
    NEW_FILE=$(echo $FILE | sed "s/^/x-/")
    mv $FILE $NEW_FILE
    echo "Renamed $FILE to $NEW_FILE"
  fi
done

if $(rg --files-without-match "^\s\senabled" -g '*.lua'); then
  echo "Files without 'enabled' directive:"
  rg --files-without-match "^\s\senabled" -g '*.lua'
fi

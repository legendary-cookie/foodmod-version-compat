#!/bin/bash
for f in $(find . -type f -not -path '*/\.git/*')
do
	dos2unix $f
done

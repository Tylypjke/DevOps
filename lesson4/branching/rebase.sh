#!/bin/bash
# display command line options

count=1
for param in "$@"; do
<<<<<<< .merge_file_p2NC2O
    echo "Next parameter: $param"
=======
    echo "\$@ Parameter #$count = $param"
>>>>>>> .merge_file_rYBJQk
    count=$(( $count + 1 ))
done

echo "====="

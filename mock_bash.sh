# `awk`, `sed`, `cut`, and `sort`, cp`, `mv`, `find`, `grep`, and `chmod`, `awk`, `sed`, `cut`, `sort`, `uniq`, and `tr`

# The wc (word count) command in Unix/Linux is used to count the number of lines, words, characters, 
# and bytes in a file or from standard input (like a pipeline). 
# It's a versatile command for gathering basic text statistics.

# wc -l: Counts the number of lines in a file.
# wc -w: Counts the number of words in a file.
# wc -c: Counts the number of bytes in a file.
# wc -m: Counts the number of characters in a file.
# wc -L: Displays the length of the longest line in a file.

# "find"

# find allows you to search for files and directories throughout your file system hierarchy. 
# You can specify the starting directory for the search and use various options to filter the results based on your needs.

# Filtering Options: The power of find lies in its ability to filter search results using a wide range of criteria. 
# Here are some common filtering options:
# 	• Name: Search by filename patterns using wildcards like "*" (matches any characters) or "?" (matches a single character).
# 	• Type: Search for specific file types like regular files (-type f), directories (-type d), symbolic links (-l), etc.
# 	• Permissions: Search for files based on their permission settings (read, write, execute) for owner, group, and others.
# 	• Size: Locate files within a specific size range (e.g., larger than 10MB).
# 	• Date: Search for files modified or accessed within a particular date range.
# 	• Owner/Group: Find files owned by a specific user or group.

# 1. Name: Search by Filename Patterns
# The -name option allows you to search for files and directories by their names, using wildcards like * and ?.

# Find all files with a .txt extension in the current directory and its subdirectories:

# `find . -name "*.txt"`

# Find all files that start with "report" and have any extension:

# `find . -name "report.*"`

# Find all files with a name containing exactly four characters:

# `find . -name "????"`

# 2. Type: Search for Specific File Types
# The -type option allows you to search for files of a specific type.

# Find all regular files (not directories) in the current directory:

# `find . -type f`

# Find all directories:

# `find . -type d`

# 3. Permissions: Search for Files Based on Permission Settings
# The -perm option allows you to search for files with specific permissions.

# Find all files that are executable by the owner:

# `find . -perm /u=x`

# Find all files with exact permissions 755:

# `find . -perm 755`

# Find files that are writable by the group:

# `find . -perm /g=w`

# 4. Size: Locate Files Within a Specific Size Range
# The -size option allows you to search for files based on their size.

# Find all files larger than 10MB:

# `find . -size +10M`

# Find all files smaller than 1KB:

# `find . -size -1k`

# Find files exactly 500 bytes in size:

# `find . -size 500c`

# 5. Date: Search for Files Modified or Accessed Within a Particular Date Range
# The -mtime (modified time) and -atime (accessed time) options allow you to find files based on when they were modified or accessed.

# Example:
# Find all files modified in the last 7 days:

# `find . -mtime -7`

# Find files accessed more than 30 days ago:

# `find . -atime +30`

# Find files modified exactly 2 days ago:

# `find . -mtime 2`


# "sed: A Stream Editor"

# sed is a powerful command-line tool used for manipulating text streams. 
# It operates on a line-by-line basis, allowing you to perform various actions like:

# 	• Substitution: Replacing text within lines.
# 	• Deletion: Removing lines based on specific patterns.   
# 	• Insertion: Adding new lines or text at specific positions.   
# Filtering: Selecting lines based on certain criteria.

# 1. Substitute text:

# Replace all occurrences of old with new in each line of file.txt:

# sed 's/old/new/g' file.txt

# 2. Delete lines containing a pattern:

# sed '/pattern/d' file.txt


# The tr command in Unix/Linux is a useful utility for translating, squeezing, and deleting characters from standard input. 
# It's often used for simple text manipulation tasks, like converting lowercase letters to uppercase, removing unwanted characters, 
# or replacing specific characters in a text stream.

# Common Uses:
# Translate Characters:
# You can use tr to replace or translate characters in a stream of text.

# `echo "hello world" | tr 'a-z' 'A-Z'`

# This command converts all lowercase letters to uppercase, resulting in:

# `HELLO WORLD`

# Delete Characters:
# You can use the -d option to delete specific characters from the input.

# `echo "hello 123 world" | tr -d '0-9'`

# This command removes all digits from the input, resulting in:

# `hello  world`

# Replace Characters:
# You can use tr to replace specific characters.

# `echo "apple" | tr 'ae' 'xy'`

# This command replaces a with x and e with y, resulting in:

# `xpplx`


# The cut command in Bash is a text-processing tool used to extract specific sections or columns from each line of a file or 
# from standard input. It's particularly useful when working with text data that is organized in a structured format, 
# such as CSV files, logs, or any text with a consistent delimiter.

# To extract the first and second fields (e.g., first and last names):

# `cut -d ',' -f 1,2 data.csv`

# Extract the first 5 characters from each line in a file:

# `cut -c 1-5 filename.txt`

# To extract all fields except the second field in a comma-separated file:

# `cut -d ',' --complement -f 2 data.csv`


# The sort command in Bash is used to sort lines of text files or standard input in various ways, 
# such as alphabetically, numerically, or based on specific fields. 
# It's a powerful tool for organizing and processing data, and it's commonly used 
# in combination with other commands in pipelines.

# Default Sort:
# By default, sort arranges lines in alphabetical order.

# Sort the lines in a file alphabetically:
# sort filename.txt

# -r (Reverse Order):
# Sorts the lines in reverse order.

# Sort the lines in reverse alphabetical order:

# sort -r filename.txt

# -n (Numeric Sort):
# Sorts lines based on numeric values rather than alphabetically. This is useful for files containing numbers.

# sort -n numbers.txt

# -k (Sort by Key/Field):
# Sorts the file based on a specific column or field. You can specify which field (or column) to sort by using the -k option.


# Sort the file based on the second field (grades):

# sort -k 2 grades.txt

# -t (Specify Delimiter):
# Specifies the field delimiter. The default delimiter is whitespace, but you can specify a different delimiter using -t.

# sort -t ',' -k 3 data.csv

# Sort the file and remove duplicates:

# sort -u names.txt

# -o (Output to File):
# Directs the sorted output to a file. This allows you to overwrite the original file or save the sorted output to a new file

# Sort the file and save the output to sorted.txt:

# sort filename.txt -o sorted.txt

# -c (Check If Sorted):
# Checks if a file is already sorted. If the file is not sorted, 
# sort -c will display an error message indicating where the first disorder occurs.

# Check if filename.txt is sorted:

# sort -c filename.txt

# Sort a log file by the second field, which might represent timestamps:

# sort -k 2 logfile.log


if []; then
elif [] ;
else
fi 

for item in "${options[@]}"; do
done 

while IFS= read -r line; do
done < $sort_file 

case "$variable" in
  pattern1)
    # Commands to execute if $variable matches pattern1
    ;;
  pattern2)
    # Commands to execute if $variable matches pattern2
    ;;
  *)
    # Commands to execute if $variable doesn't match any of the above patterns
    ;;
esac

a_function (){
    blah="$1"
}

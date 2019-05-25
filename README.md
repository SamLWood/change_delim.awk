change_delim.awk
================

Because of their simplicity, CSV files are great for processing spreadsheets in shell. Using `awk`, you can pull any field from them with one simple line. The only problem is that, occasionally, the fields themselves will have commas in them, and, without any special care, this will result in `awk` splitting single fields in two and breaking the whole operation.

This script allows you to swap out the delimiting comma with any character (or characters) that you want, depending on your needs. Just find a character that's not used in the spreadsheet, use that as your delimiter, and use it as the field separator in the `awk` command that accesses the spreadsheet.

Change the character indicated by the comment in the script and run it like so to get your reformatted spreadsheet.

    $ awk -f change_delim.awk <spreadsheet>.csv > <new-spreadsheet>

change_delim.awk
================

Because of their simplicity, CSV files are great for processing spreadsheets in shell. Using `awk`, you can pull any field from them with one simple line:

    $ awk -F ',' '{ if (FNR == <line number>) print $<column number> }' spreadsheet.csv

The only problem is that, occasionally, the fields themselves will have commas in them, and, without any special care, this will result in `awk` splitting single fields in two and breaking the whole operation.

This script allows you to swap out the delimiting commas with any character (or characters) that you want, depending on your needs. Just find a character that's not used in the spreadsheet, set that as your delimiter, and use it as the field separator in the `awk` command that accesses the spreadsheet.

Change the character indicated by the comment in the script and run it like so to get your reformatted spreadsheet.

    $ awk -f change_delim.awk <spreadsheet>.csv > <new spreadsheet>

Other notes
-----------

1.) In normal CSV files, fields can be quoted to denote literal commas, double quote characters, or line breaks. Given a delimiter that is not used in the fields, this becomes unnecessary and only adds complexity, so these characters are removed.
2.) Literal double quotes, denoted by two adjacent double quote characters inside of a quoted field, are preserved as normal double quote characters, but embedded line breaks, because they interfere with `awk`'s ability to parse the lines, are replaced with spaces.
3.) Depending on where you got your spreadsheet, it is recommended that you also pipe the output of this script through `tr -d '\r'` to get rid of any carriage return characters in the file, since they are unnecessary in UNIX environments and tend to break things.

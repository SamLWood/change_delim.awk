# This script takes a CSV spreadsheet as input and produces, as output,
# a spreadsheet with the same contents and the same formatting, with
# the exception that all delimiting commas are replaced with a character
# specified by the user, (or '|', by default). This new version of the
# spreadsheet is written to standard output.
#
# There is another change that is made to the new spreadsheet concerning
# double quote characters ("). In the standard CSV format, these characters
# are placed on either end of a cell value that contains either one or more
# comma or newline characters, in order to indicate that these characters
# are part of the value of the cell, and not part of the structure of the
# spreadsheet. The primary purpose of this script is to remove the need for
# this special case by allowing the user to specify a delimiter character
# that will not appear in the content of the spreadsheet, so double
# quotes of this kind are simply removed. Double quote characters that
# are themselves part of a cell's value, which appear as two consecutive
# double quote characters (""), are presevered as single double quote
# characters.  embedded newlines, because they break the structure of the
# new spreadsheet, are replaced with spaces.
#
# The user can specify the delimiter character to use using awk's '-v'
# option.  For example:
# 
# 	$ awk -f chdelim.awk -v delim='*' somefile.csv
# 
# This command generates a version of somefile.csv that uses the asterisk
# character as its delimiter.

BEGIN {
	if (delim == "")
		delim = "|";
	quoted = 0;
};
{
	line = "";
	for (i = 1; i <= length($0); i++) {
		char = substr($0, i, 1);
		if (char == "\"") {
			if (quoted == 1 && i < length($0) && substr($0, i + 1, 1) == "\"")
				i++;
			else {
				char = "";
				quoted = (quoted + 1) % 2;
			}
		}
		if (char == "," && quoted == 0)
			char = delim;
		line = line char;
	}
	if (quoted == 1)
		printf line " ";
	else print line;
};

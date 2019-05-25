{
	line = ""
	if (FNR == 1)
		quoted = 0
	for (i = 1; i <= length($0); i++) {
		char = substr($0, i, 1)
		if (char == "\"") {
			if (quoted == 1 && i < length($0) && substr($0, i + 1, 1) == "\"")
				i++
			else {
				char = ""
				quoted = (quoted + 1) % 2
			}
		}
		if (char == "," && quoted == 0)
			char = "|"
		line = line char
	}
	if (quoted == 1)
		printf line " "
	else print line
}
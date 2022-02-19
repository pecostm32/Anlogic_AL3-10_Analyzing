#!/usr/bin/env python3

keypos = 0
key = ''
items = []
line4 = []
line7 = []
sections = []
inputfile = None
outputfile = None


def get_items():
	global items
	global inputfile
	strinp = inputfile.readline()
	items = strinp.split()

	if strinp != '':
		done = 0
	else:
		done = 1
	return done


def print_output():
	global items
	global outputfile
	out = " ".join(items)
	print(out, file=outputfile)


def	get_and_output_items():
	get_items()
	print_output()


def decode_string(input):
	global keypos
	global key
	o = ""
	i = 0
	while i < len(input):
		inp = ord(input[i])
		mod = ord(key[keypos])
		z = inp - mod
		if (inp < mod):
			z = z + 0x5d
		if (z < 0x20):
			z = z + 0x5d
		if (inp == 0x20):
			z = 0x20
		keypos += 1
		if (keypos == len(key)):
			keypos = 0
		if (inp != 0x21):
			o += chr(z)
		else:
			i += 1
			o += input[i]
		i += 1
	return o


def decode_and_output_item(index):
	global items

	get_items()
	items[index] = decode_string(items[index])
	print_output()


def decode_header_line():
	global items
	global sections

	# Get a line from the input file
	get_items()

	# First item always needs to be decoded
	items[0] = decode_string(items[0])

	# The second item is a count for decoding extra items in the header
	# A minimum of one item always needs to be done
	stop = int(items[1]) + 3
	for x in range(2, stop):
		items[x] = decode_string(items[x])

	# Set the sections information for further processing
	sections[0] = items[1]

	x = x + 1
	sections[1:] = items[x:]

	# Write the decoded line to the output file
	print_output()


def decode_group_data(index):
	global items
	global sections

	count = int(sections[index])

	if index == 3 or index == 6:
		flag = 1
	else:
		flag = 2

	# sections[0] signals if there are multiple sets of data that need to be handled
	for y in range(int(sections[0]) + 1):
		for x in range(count):
			get_items()

			# Flag signals the group has an encoded first item
			if flag == 1 or flag == 2:
				items[0] = decode_string(items[0])
				n = 1
			else:
				n = 0

			# Only for flag 0 and 1 the pairs need to be decoded
			if flag == 0 or flag == 1:
				# The item pointed to by n gives a count of pairs to handle
				pairs = (int(items[n]) * 2) + 2

				for i in range(2, pairs, 2):
					items[i] = decode_string(items[i])

			print_output()

		# Next set of data is different from the first
		flag = 0


def decode_file():
	global items
	global line4
	global line7
	global sections
	global keypos
	global key

	# First line contain encryption key
	get_and_output_items()

	# Set and initialize the key and key position
	key = items[0]
	keypos = 0

	# Next three lines are not decoded sp get and output them
	for i in range(3):
		get_and_output_items()

	# The fourth line holds count information so save it
	line4 = items

	# The fifth line has one decoded item
	decode_and_output_item(0)

	# The sixth line holds the names of the files used to make this project
	get_and_output_items()

	# The seventh line holds count information so save it
	# line7[2] is the number of parts, which get named in the section line7[0]is the count for
	get_and_output_items()
	line7 = items

	# The eight line holds names of parts in the file
	get_and_output_items()

	# The next part of the file is a number of encoded lines. Count is in line7[3]
	# Only the first item is encoded
	for i in range(int(line7[3])):
		decode_and_output_item(0)

	# Skip an empty line
	get_and_output_items()

	# The next part is a number of encoded lines. Count is in line7[4] and can be zero
	for i in range(int(line7[4])):
		decode_and_output_item(0)

	# Skip an empty line
	get_and_output_items()

	# The next section has counts in the items of data pairs, where the first of the pair needs to be decoded
	# items[1] is a section id?? and items[2] is the number of pairs that follow
	# lin7[0] is the number of lines to decode
	for i in range(int(line7[0])):
		get_items()
		items[0] = decode_string(items[0])

		for n in range(int(items[2])):
			j = (n * 2) + 3
			items[j] = decode_string(items[j])

		print_output()

	# The following section holds line4[1] - 1 parts
	for z in range(int(line4[1]) - 1):
		# The next line again gives some counts on what follows
		decode_and_output_item(0)
		sections = items

		# A maximum of three lines with a variable number of item pairs follow. This is indicated by sections[2 - 4]
		for i in range(2,6):
			get_items()
			if int(sections[i]) != 0:
				for n in range(int(sections[i])):
					j = (n * 2)
					items[j] = decode_string(items[j])

			print_output()

	# What follows a number of lines where the first item is encoded
	# line4[2] points to the number of lines to process for this section
	for i in range(int(line4[2]) - 1):
		decode_and_output_item(0)

	# The next set of data is not encoded and is line4[4] lines long
	for i in range(int(line4[4]) - 1):
		get_and_output_items()

	# Next bit is again guess work. I think line4[5] gives the number of sections that follow
	# and each section starts with a line that hold information about the section
	for z in range(int(line4[5]) - 1):
		# The next line again gives some counts on what follows
		decode_and_output_item(0)
		sections = items

		# I think the sections[4 - 8] give some counts on what follows
		# The first three seem to indicate undecoded items on a line
		for i in range(3):
			get_and_output_items()

		# The next one gives a number of packets to decode
		# Each packet consist of a line that need decoding and gives a count for the next set of lines to decode
		# At the end a single line needs to be skipped
		if int(sections[9]) != 0:
			for i in range(int(sections[9])):
				decode_and_output_item(0)
				lines = int(items[1])
				for n in range(lines):
					decode_and_output_item(0)

				get_and_output_items()

		# Skip an in between line
		get_and_output_items()

		# The next one gives a number of lines to copy
		if int(sections[8]) != 0:
			for i in range(int(sections[8])):
				get_and_output_items()

		# This item can signal a number of items on the same line that need to be decoded
		get_items()
		lines = int(items[0])

		if lines != 0:
			lines = (lines * 2) + 1
			for i in range(1,lines):
				items[i] = decode_string(items[i])

		print_output()

		# The next line signals extra lines if it is < 0
		get_and_output_items()
		lines = abs(int(items[0]))

		if lines != 0:
			for n in range(lines):
				decode_and_output_item(0)

		# Each section seems to end with two lines
		for i in range(2):
			get_and_output_items()

	# Next bit is again guess work. I think line4[6] gives the number of sections that follow
	# and each section starts with a line that hold information about the section
	# Only here the second item is encoded
	for z in range(int(line4[6]) - 1):
		# The next line again gives some counts on what follows
		decode_and_output_item(1)

		# I think the items[5 - 8] give some counts on what follows
		# They seem to indicate plain items on a line
		for i in range(4):
			get_and_output_items()

	# Next bit is again guess work. I think line4[7] gives the number of sections that follow
	# and each section starts with a line that hold information about the section
	# This seems to be a range of two lines per part, where the first line is encoded and the second is plain
	for z in range(int(line4[7]) - 1):
		decode_and_output_item(0)
		get_and_output_items()

	# I think line4[3] gives the number of sections that follow
	# and each section starts with a line that hold information about the section
	# Here the first line has two items that need decoding (0 and 3)
	# After this a set of data follows based on the counts in the header line
	for z in range(int(line4[3]) - 1):
		get_items()
		items[0] = decode_string(items[0])
		items[3] = decode_string(items[3])
		print_output()
		sections = items

		# First count item sections[4] signals a number of plain lines
		for i in range(int(sections[4])):
			get_and_output_items()

		# For the next three lines the sections[5 - 7] signal a number of pairs to decode
		for i in range(3):
			get_items()
			pairs = int(sections[i + 5])

			if pairs != 0:
				pairs = (pairs * 2)
				for n in range(0, pairs, 2):
					items[n] = decode_string(items[n])

			print_output()

		# Next is a line with a variable number of plain items
		get_and_output_items()

		# For the next line the sections[9] signal a number of pairs to decode
		get_items()
		pairs = int(sections[9])

		if pairs != 0:
			pairs = pairs * 2
			for n in range(pairs):
				items[n] = decode_string(items[n])

		print_output()

		# Next is a line with a variable number of plain items
		get_and_output_items()

		# Based on a flag there is an extra line
		if int(sections[2]) == 2048:
			get_and_output_items()

			# More data can be present when items[2] or items[3] are set
			# Not sure but there might be a relation with sections[11] or sections[12]
			# The counts set there are not conclusive and it looks like it uses data from the previous line
			# It looks like the data does not use encoding
			lines1 = int(items[2])
			lines2 = int(items[3])

			# lines1 signals a number of sets of data. First line seems to be an index, second line holds counts
			# These counts seem to point to again numbers of lines that follow
			for x in range(lines1):
				get_and_output_items()
				get_and_output_items()
				lines3 = int(items[2])
				lines4 = int(items[3])

				for y in range(lines3):
					get_and_output_items()

				for y in range(lines4):
					get_and_output_items()

			# lines2 signals a number of sets of data. A set is three lines
			for x in range(lines2):
				for y in range(3):
					get_and_output_items()

		# Each section is followed by 4 fixed lines
		for i in range(4):
			get_and_output_items()

	# It looks like the next bit is a fixed set of data of 1332 lines long
	for i in range(1332):
		get_and_output_items()

	# Next line seems to be a standard line with encoded items
	get_items()
	for n in range(len(items) - 1):
		items[n] = decode_string(items[n])

	print_output()

	# Next up is some data with a line count and encoded pairs
	get_and_output_items()
	get_and_output_items()

	lines = int(items[0])

	# This is the list of used pins and their names in the verilog
	for n in range(lines):
		get_items()
		items[0] = decode_string(items[0])
		items[1] = decode_string(items[1])
		print_output()

	# Just copy the next 10 lines
	for i in range(10):
		get_and_output_items()

	# The last line is a count of how many encoded packets follow
	packets = int(items[0])

	# Each packet has a header with a number of lines count
	for i in range(packets):
		decode_and_output_item(0)
		lines = int(items[1])

		for n in range(lines):
			get_items()
			items[0] = decode_string(items[0])
			items[1] = decode_string(items[1])
			print_output()

		# Skip an empty line
		get_and_output_items()

	# Next line seems to be a count of packets to follow
	get_and_output_items()
	packets = int(items[0])

	# Each packet has a header with a number of lines count
	for i in range(packets):
		get_and_output_items()
		lines = int(items[1])

		for n in range(lines):
			get_items()
			items[0] = decode_string(items[0])
			items[1] = decode_string(items[1])
			print_output()

		# Skip an empty line
		get_and_output_items()

	# Then a fixed set of data seems to follow. Looks like 29 lines
	for i in range(29):
		get_and_output_items()

	# The last line is again a packet count
	packets = int(items[0])

	# Each packet has a header with a number of lines count
	for i in range(packets):
		decode_and_output_item(0)
		lines = int(items[1])

		for n in range(lines):
			get_items()
			for x in range(3):
				items[x] = decode_string(items[x])

			print_output()

		# Skip an empty line
		get_and_output_items()

	# Skip an empty line
	get_and_output_items()

	# Skip a plain line
	get_and_output_items()

	# This is the start of yet another section where counts are in the header
	get_items()
	items[0] = decode_string(items[0])
	items[2] = decode_string(items[2])
	print_output()
	sections = items

	# sections[5] tells how many packets follow
	for z in range(int(sections[5])):
		get_items()
		items[0] = decode_string(items[0])

		# For this data the second item gives a count of pars to handle
		pairs = (int(items[1]) * 2) + 2

		for i in range(2, pairs, 2):
			items[i] = decode_string(items[i])

		print_output()

	# sections[6] tells how many packets follow
	# No idea if this one is correct
	for z in range(int(sections[6])):
		decode_and_output_item(0)

	# sections[7] tells how many packets follow
	for z in range(int(sections[7])):
		decode_and_output_item(0)

	# sections[8] tells how many packets follow
	for z in range(int(sections[8])):
		get_items()
		items[0] = decode_string(items[0])

		# For this data the second item gives a count of pars to handle
		pairs = (int(items[1]) * 2) + 2

		for i in range(2, pairs, 2):
			items[i] = decode_string(items[i])

		print_output()

	# sections[9] tells how many packets follow
	for z in range(int(sections[9])):
		decode_and_output_item(0)

	# The next section seems to have repeating data. Might be line4[9] minus one
	# In this section the header can have more items to decode depending on items[1]
	for z in range(int(line4[9]) - 1):
		decode_header_line()

		if items[2] == "adcA1_buffer":
			pairs = 24

		# sections[3 - 6] give a line count for next sets of data
		for i in range(3, 8):
			decode_group_data(i)



def main():
	global inputfile
	global outputfile

	# Lines 4 and 7 at the top of the .db file give information about how many items per group need to be processed
	# The meaning of each group and the items within needs to be determined
	# The counts on line 4 are plus 1, so a 1 means no items

	# Need to restructure the program and make more functions for the different data sections.
	# See the information in the netbeans project for the bitstream analyzer

	inputfile = open("/home/peter/Data/Anlogic_projects/pin_test/pin_test_pr.db", "rt")
	outputfile = open("/home/peter/Data/Anlogic_projects/pin_test/pin_test_pr.db.txt", "wt")
	decode_file()
	inputfile.close()
	outputfile.close()

	inputfile = open("/home/peter/Data/Anlogic_projects/Scope11_06-02-2022/Scope11_pr.db", "rt")
	outputfile = open("/home/peter/Data/Anlogic_projects/Scope11_06-02-2022/Scope11_pr.db.txt", "wt")
	decode_file()
	inputfile.close()
	outputfile.close()


if __name__ == "__main__":
	main()

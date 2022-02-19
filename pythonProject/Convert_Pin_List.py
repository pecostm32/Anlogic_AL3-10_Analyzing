
def main():
    inputfile = open("lqfp144_io_pads.txt", "rt")
    outputfile = open("lqfp144_io_pads.h", "wt")

    strinp = inputfile.readline()

    while strinp != '':
        items = strinp.split()

        pin = items[0][1:]
        pad = items[1]
        bank = items[2]

        location = pad[1:2]
        index = pad[2:len(pad)-1]
        ion = pad[len(pad)-1]

        if location == 'l':
            x = "0"
            y = index
        elif location == 'r':
            x = "34"
            y = index
        elif location == 't':
            x = index
            y = "37"
        elif location == 'b':
            x = index
            y = "0"

        if ion == 'a':
            ion = "0"
        elif ion == 'b':
            ion = "1"
        elif ion == 'c':
            ion = "2"
        elif ion == 'd':
            ion = "3"

        # out = "  { " + x + ", " + y + ", " + ion + ", " + pin + ", " + bank + " },"
        out = x + "," + y + "," + ion + "," + pin + "," + bank

        print(out, file=outputfile)

        strinp = inputfile.readline()


if __name__ == "__main__":
    main()

import json


def main():
    inputfile = open("/home/peter/Data/Projects/prjtang/database/al3/al3_10/bits/plb.json", "rt")
    outputfile = open("/home/peter/Data/Projects/prjtang/list_files/plb.csv", "wt")

    bitdata = json.load(fp=inputfile)

    for i in range(len(bitdata)):
        name = bitdata[i]["name"]
        type = bitdata[i]["type"]
        x = bitdata[i]["y"]
        y = bitdata[i]["x"]
        xoff = bitdata[i]["xoff"]
        yoff = bitdata[i]["yoff"]

        expr = bitdata[i]["expr"]
        data = bitdata[i]["data"]

        line = name + "," + type + ",," + str(x) + "," + str(y) + "," + str(xoff) + "," + str(yoff) + ",,\""

        for n in range(len(expr)):
            line = line + expr[n]

        line = line + "\""

        for n in data:
            line = line + "," + n + ",\"" + data[n] + "\""

        print(line, file=outputfile)






if __name__ == "__main__":
    main()

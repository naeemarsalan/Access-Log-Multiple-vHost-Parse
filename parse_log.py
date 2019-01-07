#!/bin/python
import csv,warnings
from ipwhois import IPWhois
from operator import itemgetter, attrgetter
from os import listdir


warnings.filterwarnings("ignore")

Parse = True

#report = "asari.web.netline.net.uk"
files = listdir("report");
table = []

if (Parse):
    for i in range(len(files)):
        with open("report/" + files[i], newline='') as csvfile:
            data = list(csv.reader(csvfile))
        print("Looking up file..." + files[i])
        for i in range(len(data)):
            #if data[i][1] == '127.0.0.1' || data[i][1] == '10.':
               # continue
            if int(data[i][2]) >= 10:
                try:
                    obj = IPWhois('{}'.format(data[i][1])).lookup_rdap(depth=0)
                    table.append([int(data[i][2]),data[i][1],obj['asn_description'],data[i][0]])
                except Exception as exc:
                    print(exc)
                    continue



#table = [["8.8.8.8","ASN INFO",2000,"File.log"],["1.1.1.1","ASN1 INFO",1000,"File1.log"]]

table = sorted(table, key=lambda x: x[0])

file = open("daily_report","w+")
for i in range(len(table)):
    #print('Testing %s %s' % (table[i][0], table[i][1]))
    file.write("%d %s %s %s\r\n" % (table[i][0],table[i][1],table[i][2],table[i][3]))

file.close

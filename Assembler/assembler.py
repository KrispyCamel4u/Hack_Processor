from predifined_symbols import symboldict
from table import comp,dest,jump

addr=input("Enter file name with its location: ")
if "\\" in addr:
    fname=addr[addr.rfind("\\")+1:addr.find('.')]
    location=addr[:addr.rfind("\\")+1]
else:
    fname=addr[addr.rfind('/')+1:addr.find('.')]
    location=addr[:addr.rfind('/')+1]

ext=".asm"

print("Removing empty lines")
with open(location+fname+ext,"r") as f, open(location+fname+"LL"+ext,"w+") as outfile:
 for i in f.readlines():
        if not i.strip():
           continue
        
        ti=i.split("//")[0]
        if(len(ti)==0):
            continue
        if(len(i.split("//"))>1):
            ti+="\n"
        if ti:
           outfile.write(ti)
print("Empty Lines removed")

##scanning for (lables)
print("Scanning for labels")
lineNum=0
with open(location+fname+"LL"+ext,"r+") as f:
    lines=f.readlines()
with open(location+fname+"LL"+ext,"w") as f: 
    for line in lines:
        if(line[0]=='('):
            line=line[line.find('(')+1:line.find(')')]
            if line not in symboldict:
                symboldict[line]=lineNum
        else:
            lineNum+=1
            f.writelines(line)    
print("Scanning successful")

##scanning for variables
print("Scanning for variables")
Memloc=16
with open(location+fname+"LL"+ext,"r") as f:
    for line in f.readlines():
        line=line.replace(" ","")
        if(line[0]=='@'):
            line=line.strip("@\n")
            issymbol=False
            try:
                int(line)
            except:
                issymbol=True
            if line not in symboldict and issymbol :
                symboldict[line]=Memloc
                Memloc+=1 
print("Scanning successful")

#print(symboldict)

N=16
with open(location+fname+"LL"+ext,"r+") as f,open(location+fname+"labelLess"+ext,"w") as labelless:
    lines=f.readlines()
    labelless.writelines(lines)
## True Assembling starts from here
print("Assembling")
with open(location+fname+"LL"+ext,"w") as symbolLess, open(location+fname+".hack","w") as outfile:
    for line in lines:
        line=line.replace(" ","")
        line=line.strip('\n')

        ##A type instruction
        if(line[0]=='@'):
            line=line.strip('@')
            ##modifying the symbol less file
            try:
                symbolLess.write('@'+str(symboldict[line])+'\n')
                binins=bin(symboldict[line])[2:]
            except:
                symbolLess.write('@'+line+'\n')
                binins=bin(int(line))[2:]
            binins=binins.rjust(N,'0')
            outfile.write(binins+'\n')

        ## C-type instruction
        else:
            ##writing symbolless file
            symbolLess.write(line+'\n')

            #seperating different parts(PARSER)
            if ';' in line:
                jumpString=line[line.find(';')+1:]
                if '=' in line:
                    compString=line[line.find('=')+1:line.find(';')]
                    destString=line[:line.find('=')]
                else:
                    compString=line[:line.find(';')]
                    destString="null"
            else:
                jumpString="null"
                if '=' in line:
                    destString=line[:line.find('=')]
                    compString=line[line.find('=')+1:]
            ##using the tabel to make the instruction
            binins=bin(0b1110000000000000+comp[compString]+dest[destString]+jump[jumpString])[2:]
            #print(binins)
            outfile.write(binins+'\n')
print("Assembled")
x=input()
            
JSON2XML

It transforms the json file into an XML file.

To use, it is necessary to install the programs: gcc, bison and flex.

to compile run:
make

To delete all intermediate files:
make clean

After compiling, to transform json file, run, like this:

./json2xml <example/test1.json >result.xml 

*There are two JSON files in the example directory.*  
*(Both examples are copied from the web)*  
**Do not forget to write '<' before your json file**  


And to see the results, run command:  

gedit result.xml&



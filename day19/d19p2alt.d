import std;
string [] a;
alias go = memoize !(goImpl);
long goImpl (string s) {return s.empty ? 1L :
	a.filter !(c => s.startsWith (c)).map !(c => go (s[c.length..$])).sum;}
void main () {a = readln.strip.split (", "); readln;
	stdin.byLineCopy.map!go.sum.writeln;}

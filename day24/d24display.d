import core.bitop;
import std;

void main ()
{
	string s;
	int [string] v;
	while ((s = readln.strip) != "")
	{
		auto t = s.split (": ");
		v[t[0]] = t[1].to !(int);
	}

	alias Record = Tuple !(string, q{arg1}, string, q{arg2}, string, q{res}, string, q{op});
	Record [] a;
	// for https://dreampuf.github.io/GraphvizOnline/
	writeln ("Digraph G {");
	while ((s = readln.strip) != "")
	{
		auto t = s.split (" ");
		auto b = Record (t[0], t[2], t[4], t[1]);
		enforce (b.res !in v);
		v[b.res] = -1;
		a ~= b;
		writefln !("%s -> %s [name = %s]") (t[0], t[4], t[1]);
		writefln !("%s -> %s [name = %s]") (t[2], t[4], t[1]);
	}
	writeln ("}");
}

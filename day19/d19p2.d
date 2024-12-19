import std;

string [] a;

alias go = memoize !(goImpl);
long goImpl (string s)
{
	if (s.empty)
	{
		return 1;
	}
	long res = 0;
	foreach (ref c; a)
	{
		if (s.startsWith (c))
		{
			res += go (s[c.length..$]);
		}
	}
	return res;
}

void main ()
{
	a = readln.strip.split (", ");
	readln;

	long res = 0;
	foreach (q; stdin.byLineCopy)
	{
		res += go (q);
	}
	writeln (res);
}

import std;

string [] a;

alias go = memoize !(goImpl);
bool goImpl (string s)
{
	if (s.empty)
	{
		return true;
	}
	foreach (ref c; a)
	{
		if (s.startsWith (c) && go (s[c.length..$]))
		{
			return true;
		}
	}
	return false;
}

void main ()
{
	a = readln.strip.split (", ");
	readln;

	int res = 0;
	foreach (q; stdin.byLineCopy)
	{
		if (go (q))
		{
			res += 1;
		}
	}
	writeln (res);
}

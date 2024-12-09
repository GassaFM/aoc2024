import std;

immutable int NA = -1;

void main ()
{
	auto s = readln.strip.map !(q{a - '0'}).array;
	int [] a;
	foreach (int i, ref x; s)
	{
		auto cur = (i & 1) ? NA : (i >> 1);
		a ~= cur.repeat (x).array;
	}
	int lo = 0;
	while (true)
	{
		while (lo < a.length && a[lo] != NA)
		{
			lo += 1;
		}
		if (lo >= a.length)
		{
			break;
		}
		swap (a[lo], a.back);
		a.length -= 1;
	}
//	debug {writeln (a);}
	long res = 0;
	foreach (i, x; a)
	{
		res += i * x;
	}
	writeln (res);
}

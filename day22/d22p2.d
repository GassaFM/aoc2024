import std;

immutable int steps = 2000;
immutable int base = 10;

long next (long value)
{
	value = (value ^ (value << 6)) & 0xFFFFFF;
	value = (value ^ (value >> 5)) & 0xFFFFFF;
	value = (value ^ (value << 11)) & 0xFFFFFF;
	return value;
}

void main ()
{
	auto a = stdin.byLineCopy.map !(to !(long)).array;
	auto k = a.length.to !(int);

	int [int [4]] vis;
	auto d = new int [int [4]] [k];
	foreach (j, n; a)
	{
		int [4] c;
		c[] = base;
		foreach (i; 0..steps)
		{
			auto t = next (n);
			c[0] = c[1];
			c[1] = c[2];
			c[2] = c[3];
			c[3] = t % base - n % base;
			vis[c] += 1;
			if (c[0] != base && c !in d[j])
			{
				d[j][c] = t % base;
			}
			n = t;
		}
	}
	debug {writeln (vis.length); stdout.flush;}

	long res = 0;
	foreach (ref c, _; vis)
	{
		long cur = 0;
		foreach (j, n; a)
		{
			auto add = d[j].get (c, 0);
			cur += max (0, add);
		}
		debug {writeln (c, " ", cur); stdout.flush;}
		res = max (res, cur);
	}
	writeln (res);
}

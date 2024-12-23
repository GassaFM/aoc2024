import std;

void main ()
{
	auto e = stdin.byLineCopy.map !(s => s.split ("-")).array;
	bool [string] [string] a;
	bool [string] m;
	foreach (ref p; e)
	{
		a[p[0]][p[1]] = true;
		a[p[1]][p[0]] = true;
		m[p[0]] = true;
		m[p[1]] = true;
	}

	auto names = m.byKey.array;
	sort (names);
	auto n = names.length.to !(int);
	writeln (n);
	auto g = new int [] [n];
	auto h = new bool [] [] (n, n);
	foreach (i; 0..n)
	{
		foreach (j; 0..n)
		{
			if (names[i] in a[names[j]])
			{
				g[i] ~= j;
				h[i][j] = true;
			}
		}
	}

	int res = 0;
	int [] best;

	void recur (int [] v)
	{
		if (best.length < v.length)
		{
			best = v.dup;
		}
		for (int i = v.back + 1; i < n; i++)
		{
			if (v.all !(j => h[i][j]))
			{
				recur (v ~ i);
			}
		}
	}

	foreach (i; 0..n)
	{
		foreach (j; g[i])
		{
			if (j > i)
			{
				recur ([i, j]);
			}
		}
	}
	writefln !("%-(%s,%)") (best.map !(i => names[i]));
}

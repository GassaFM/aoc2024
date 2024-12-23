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
	int res = 0;
	writeln (names);
	foreach (u; names)
	{
		foreach (v; names)
		{
			if (v in a[u])
			{
				foreach (w; names)
				{
					if (w in a[u] && w in a[v])
					{
						res += (u[0] == 't' ||
						    v[0] == 't' ||
						    w[0] == 't');
					}
				}
			}
		}
	}
	writeln (res, " ", res / 6);
}

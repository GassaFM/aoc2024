import std;

void main ()
{
	auto s = stdin.byLineCopy.array;
	auto t = s.split ("");
	auto locks = t.filter !(s => s.front.all !(q{a == '#'}));
	auto keys = t.filter !(s => s.back.all !(q{a == '#'}));
	int res = 0;
	foreach (l; locks)
	{
		foreach (k; keys)
		{
			bool bad = false;
			foreach (i; 0..l.length)
			{
				foreach (j; 0..l.front.length)
				{
					if (l[i][j] == '#' && k[i][j] == '#')
					{
						bad = true;
					}
				}
			}
			res += !bad;
		}
	}
	writeln (res);
}

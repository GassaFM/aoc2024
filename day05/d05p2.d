import std;

void main ()
{
	string [] s;
	string [] [] a;
	while ((s = readln.strip.split ("|")) !is null)
	{
		a ~= s;
	}
	string [] [] b;
	while ((s = readln.strip.split (",")) !is null)
	{
		b ~= s;
	}
	int res = 0;
	foreach (ref c; b)
	{
		bool ok = true;
		foreach (ref r; a)
		{
			auto u = c.countUntil (r[0]);
			auto v = c.countUntil (r[1]);
			if (u >= 0 && v >= 0 && u > v)
			{
				ok = false;
			}
		}
		if (ok)
		{
			continue;
		}
		while (!ok)
		{
			ok = true;
			foreach (ref r; a)
			{
				auto u = c.countUntil (r[0]);
				auto v = c.countUntil (r[1]);
				if (u >= 0 && v >= 0 && u > v)
				{
					ok = false;
					swap (c[u], c[v]);
				}
			}
		}
		res += c[$ / 2].to !(int);
	}
	writeln (res);
}

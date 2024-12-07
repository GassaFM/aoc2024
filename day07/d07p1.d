import std;

bool ok (long [] p, long value)
{
	auto n = p.length;
	auto n2 = 1 << (n - 1);
	auto q = p.dup;
	foreach (u; 0..n2)
	{
		q[] = p[];
		foreach (i; 0..n - 1)
		{
			if (u & (1 << i))
			{
				q[i + 1] *= q[i];
				q[i] = 0;
			}
			else
			{
				q[i + 1] += q[i];
				q[i] = 0;
			}
		}
		if (value == q.sum)
		{
			writeln (q, value);
			return true;
		}
	}
	return false;
}

void main ()
{
	long res = 0;
	foreach (s; stdin.byLineCopy)
	{
		auto t = s.split;
		auto value = t[0][0..$ - 1].to !(long);
		auto p = t[1..$].to !(long []);
		if (ok (p, value))
		{
			res += value;
		}
	}
	writeln (res);
}

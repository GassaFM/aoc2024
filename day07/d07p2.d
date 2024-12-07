import std;

bool ok (BigInt [] p, BigInt value)
{
	auto n = p.length;

	bool go (int pos, BigInt cur)
	{
		if (pos == n)
		{
			return cur == value;
		}
		return go (pos + 1, cur + p[pos]) ||
		    go (pos + 1, cur * p[pos]) ||
		    go (pos + 1, to !(BigInt) (cur.text ~ p[pos].text));
	}

	return go (1, p[0]);
}

void main ()
{
	BigInt res = 0;
	foreach (s; stdin.byLineCopy)
	{
		auto t = s.split;
		auto value = t[0][0..$ - 1].to !(BigInt);
		auto p = t[1..$].to !(BigInt []);
		if (ok (p, value))
		{
			res += value;
		}
	}
	writeln (res);
}

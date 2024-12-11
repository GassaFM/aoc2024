import std;

immutable int limit = 10_000;
immutable int steps = 75;

auto mem = new long [] [] (steps + 1, limit);

long calc (long value, int s)
{
	if (s == 0)
	{
		return 1;
	}
	if (value < limit && mem[s][value])
	{
		return mem[s][value];
	}
	long res;
	scope (exit)
	{
		if (value < limit)
		{
			mem[s][value] = res;
		}
	}
	if (value == 0)
	{
		res = calc (1, s - 1);
		return res;
	}
	auto t = value.text;
	if (t.length % 2 == 0)
	{
		res = calc (t[0..$ / 2].to !(long), s - 1);
		res += calc (t[$ / 2..$].to !(long), s - 1);
		return res;
	}
	res = calc (value * 2024, s - 1);
	return res;
}

void main ()
{
	auto a = readln.split.to !(long []);
	a.map !(x => calc (x, steps)).sum.writeln;
}

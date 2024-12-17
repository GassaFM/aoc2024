import std;

int [] simulate (long a, long b, long c, const int [] p, int n)
{
	alias combo = x => x == 4 ? a : x == 5 ? b : x == 6 ? c : x;

	int [] res;
	int cur = 0;
	while (cur < n)
	{
		auto cmd = p[cur];
		auto ar = p[cur + 1];
		cur += 2;
		switch (cmd)
		{
		case 0: a = a >> clamp (combo (ar), 0, 63); break;
		case 1: b ^= ar; break;
		case 2: b = combo (ar) & 7; break;
		case 3: if (a) cur = ar; break;
		case 4: b ^= c; break;
		case 5: res ~= combo (ar) & 7; break;
		case 6: b = a >> clamp (combo (ar), 0, 63); break;
		case 7: c = a >> clamp (combo (ar), 0, 63); break;
		default: assert (false);
		}
	}
	return res;
}

void main ()
{
	auto a = readln.strip.findSplitAfter ("Register A: ")[1].to !(long);
	auto b = readln.strip.findSplitAfter ("Register B: ")[1].to !(long);
	auto c = readln.strip.findSplitAfter ("Register C: ")[1].to !(long);
	readln;
	auto p = readln.strip.findSplitAfter ("Program: ")[1].split (",")
	    .map !(to !(int)).array;

	auto n = p.length.to !(int);

	long add = 1;
	for (a = 0; ; a += add)
	{
		auto res = simulate (a, b, c, p, n);
		auto cm = zip (p, res ~ -1).countUntil !(q{a[0] != a[1]});
		if (cm == -1)
		{
			writeln (a);
			break;
		}
		add = max (add, 1 << (max (0, cm - 3) * 3));
		debug {writefln !("%s %(%s,%) %s %s") (a, res, add, cm); stdout.flush;}
	}
}

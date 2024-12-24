import core.bitop;
import std;

immutable int NA = -1;

void main ()
{
	string s;
	int [string] v;
	while ((s = readln.strip) != "")
	{
		auto t = s.split (": ");
		v[t[0]] = t[1].to !(int);
	}

	alias Record = Tuple !(string, q{arg1}, string, q{arg2}, string, q{res}, string, q{op});
	Record [] a;
	string [] med;
	while ((s = readln.strip) != "")
	{
		auto t = s.split (" ");
		auto b = Record (t[0], t[2], t[4], t[1]);
		enforce (b.res !in v);
		med ~= b.res;
		v[b.res] = NA;
		a ~= b;
	}
	auto n = a.length.to !(int);
	writeln ("n = ", n);

	void apply (ref Record b)
	{
		if (b.op == "AND") {v[b.res] = v[b.arg1] & v[b.arg2];}
		if (b.op == "OR") {v[b.res] = v[b.arg1] | v[b.arg2];}
		if (b.op == "XOR") {v[b.res] = v[b.arg1] ^ v[b.arg2];}
	}

	void reorder ()
	{
		Record [] c;
		while (!a.empty)
		{
			foreach (int i, ref b; a)
			{
				if (v[b.arg1] != NA && v[b.arg2] != NA)
				{
					apply (b);
					c ~= b;
					a = a[0..i] ~ a[i + 1..$];
					break;
				}
			}
		}
		a = c;
	}

	reorder;

	void simulate ()
	{
		foreach (ref x; med)
		{
			v[x] = NA;
		}
		int left = med.length.to !(int);
		while (left > 0)
		{
			foreach (ref b; a)
			{
				if (v[b.arg1] != NA && v[b.arg2] != NA)
				{
					apply (b);
					left -= 1;
				}
			}
		}
	}

	auto bits = iota (0, 100).countUntil !(i => format !("x%02d") (i) !in v).to !(int);
	writeln ("bits = ", bits);

	long wrongBits (long x, long y)
	{
		long z = x + y;
		foreach (i; 0..bits)
		{
			v[format !("x%02d") (i)] = ((x >> i) & 1);
			v[format !("y%02d") (i)] = ((y >> i) & 1);
		}
		simulate;
		long res = 0;
		foreach (i; 0..bits + 1)
		{
			if (v[format !("z%02d") (i)] != ((z >> i) & 1))
			{
				res |= 1L << i;
			}
		}
		return res;
	}

	long wrongMore (int tries = 50)
	{
		long res = 0L;
		foreach (k; 0..tries)
		{
			auto x = uniform (0, 1L << bits);
			auto y = uniform (0, 1L << bits);
			res |= wrongBits (x, y);
		}
		return res;
	}

	auto base = wrongMore (10 ^^ 4);
	writefln !("%0*b %d") (bits + 1, base, base.popcnt);

	auto f = n.iota.array;
	auto k = f.length.to !(int);
	writeln ("k = ", k);
	string [] answer;
	foreach (step; 0..4)
	{
		auto name = format !("z%02d") (base.bsf);
		int best = int.max;
		int bestI, bestJ;
		foreach (r; 0..2)
		{
			foreach (i; 0..k)
			{
				auto cur1 = f[i];
				foreach (j; i + 1..k)
				{
					auto cur2 = f[j];
					if (r == 0 && a[cur1].res != name && a[cur2].res != name)
					{
						continue;
					}
					swap (a[cur1].res, a[cur2].res);
					auto temp = wrongMore;
					swap (a[cur1].res, a[cur2].res);
					if (temp.bsf <= base.bsf)
					{
						continue;
					}
					auto value = temp.popcnt;
					best = value;
					bestI = i;
					bestJ = j;
					writeln (cur1, " ", cur2, " ", temp.popcnt);
					writeln (temp.bsf, " ", base.bsf);
					stdout.flush;
				}
			}
			if (best < int.max)
			{
				break;
			}
		}
		auto cur1 = f[bestI];
		auto cur2 = f[bestJ];
		swap (a[cur1].res, a[cur2].res);
		base = wrongMore (10 ^^ 4);
		answer ~= a[cur1].res;
		answer ~= a[cur2].res;
		writeln ("step ", step, ": ", cur1, " ", cur2, " ", best, " ", base.popcnt);
		writeln (a[cur1].res, " ", a[cur2].res);
		writefln !("%0*b %d") (bits + 1, base, base.popcnt);
		stdout.flush;
	}
	answer.sort.writefln !("%-(%s,%)");
}

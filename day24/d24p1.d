import std;

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
	while ((s = readln.strip) != "")
	{
		auto t = s.split (" ");
		auto b = Record (t[0], t[2], t[4], t[1]);
		enforce (b.res !in v);
		v[b.res] = -1;
		a ~= b;
	}

	void apply (ref Record b)
	{
		if (b.op == "AND") {v[b.res] = v[b.arg1] & v[b.arg2];}
		if (b.op == "OR") {v[b.res] = v[b.arg1] | v[b.arg2];}
		if (b.op == "XOR") {v[b.res] = v[b.arg1] ^ v[b.arg2];}
	}

	int steps = a.length.to !(int);
	foreach (step; 0..steps)
	{
		foreach (ref b; a)
		{
			apply (b);
		}
	}

	long res = 0;
	foreach (i; 0..100)
	{
		auto name = format !("z%02d") (i);
		if (name in v)
		{
			res |= cast (long) (v[name]) << i;
		}
	}
	writeln (res);
}

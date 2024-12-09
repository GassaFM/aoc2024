import std;

immutable int NA = -1;

void main ()
{
	auto s = readln.strip.map !(q{a - '0'}).array;
	alias Record = Tuple !(int, q{id}, int, q{len});
	Record [] b;
	foreach (int i, ref x; s)
	{
		auto cur = (i & 1) ? NA : (i >> 1);
		b ~= Record (cur, x);
	}
	for (int i = b.length.to !(int) - 1; i >= 0; i--) if (b[i].id != NA)
	{
		foreach (j; 0..i) if (b[j].id == NA && b[j].len >= b[i].len)
		{
			b[j].len -= b[i].len;
			b = b[0..j] ~ b[i] ~ b[j..i] ~
			    Record (NA, b[i].len) ~ b[i + 1..$];
			i += 1;
			break;
		}
	}
//	debug {writeln (b);}

	int [] a;
	foreach (r; b)
	{
		a ~= r.id.repeat (r.len).array;
	}
//	debug {writeln (a);}
	long res = 0;
	foreach (i, x; a)
	{
		if (x >= 0)
		{
			res += i * x;
		}
	}
	writeln (res);
}

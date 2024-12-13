import std;

alias Coord = Tuple !(long, q{x}, long, q{y});
immutable long add = 10L ^^ 13;
immutable long limit = 10 ^^ 5;

void main ()
{
	auto d = stdin.byLineCopy.map !(u => u.matchAll (r"\d+")
	    .map !(v => v.front.to !(long)).array)
	    .array.filter !(q{!a.empty}).chunks (3).map !(array).array;
	auto total = 0L;
	foreach (ref m; d)
	{
		debug {writeln (m);}
		auto a = Coord (m[0][0], m[0][1]);
		auto b = Coord (m[1][0], m[1][1]);
		auto c = Coord (m[2][0] + add, m[2][1] + add);
		debug {writeln (c);}
//		assert ((a.x >= a.y) != (b.x >= b.y));
		auto res = long.max;
		long cur0, s0, t0;
		long cur1, s1, t1;
		for (long cur = 0; c.x >= 0 && cur < limit;
		    c.x -= a.x, c.y -= a.y, cur++)
		{
			if (c.x % b.x != 0 || c.y % b.y != 0)
			{
				continue;
			}
			auto s = c.x / b.x;
			auto t = c.y / b.y;
			if (s == t)
			{
				res = min (res, cur * 3 + t);
			}
			if (!s0) {cur0 = cur; s0 = s - t, t0 = t;}
			else {cur1 = cur; s1 = s - t, t1 = t; break;}
		}
		if (!s1) continue;
		debug {writeln ([cur0, s0, t0]);}
		debug {writeln ([cur1, s1, t1]);}
		auto vc = (cur1 - cur0);
		auto hi = min (c.x / a.x, c.y / a.y) / vc;
		auto vs = s0 - s1;
		if (s1 % vs != 0) continue;
		auto steps = s1 / vs;
		debug {writeln (vc, " ", hi, " ", steps);}
		if (steps < 0 || steps > hi) continue;
		auto vt = t1 - t0;
		auto cur2 = cur1 + vc * steps;
		auto s2 = s1 - vs * steps;
		auto t2 = t1 + vt * steps;
		res = min (res, cur2 * 3 + t2);
		debug {writeln (cur2, " ", s2, " ", t2, " ", res);}
		if (res != long.max)
		{
			total += res;
		}
	}
	writeln (total);
}

import std;

alias Coord = Tuple !(int, q{x}, int, q{y});

void main ()
{
	auto d = stdin.byLineCopy.map !(u => u.matchAll (r"\d+")
	    .map !(v => v.front.to !(int)).array)
	    .array.filter !(q{!a.empty}).chunks (3).map !(array).array;
	auto total = 0;
	foreach (ref m; d)
	{
		debug {writeln (m);}
		auto a = Coord (m[0][0], m[0][1]);
		auto b = Coord (m[1][0], m[1][1]);
		auto c = Coord (m[2][0], m[2][1]);
		auto res = int.max;
		for (int cur = 0; c.x >= 0; c.x -= a.x, c.y -= a.y, cur += 3)
		{
			if (c.x % b.x != 0 || c.y % b.y != 0)
			{
				continue;
			}
			auto t = c.x / b.x;
			if (t == c.y / b.y)
			{
				res = min (res, cur + t);
			}
		}
		if (res != int.max)
		{
			total += res;
		}
	}
	writeln (total);
}

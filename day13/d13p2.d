import std;

alias Coord = Tuple !(long, q{x}, long, q{y});
immutable long add = 10L ^^ 13;

void main ()
{
	auto d = stdin.byLineCopy.map !(u => u.matchAll (r"\d+")
	    .map !(v => v.front.to !(long)).array)
	    .array.filter !(q{!a.empty}).chunks (3).map !(array).array;
	long total = 0L;
	foreach (ref m; d)
	{
		auto a = Coord (m[0][0], m[0][1]);
		auto b = Coord (m[1][0], m[1][1]);
		auto c = Coord (m[2][0] + add, m[2][1] + add);
		auto a1 = a.x, b1 = b.x, c1 = -c.x;
		auto a2 = a.y, b2 = b.y, c2 = -c.y;
		auto x = b1 * c2 - c1 * b2;
		auto y = c1 * a2 - a1 * c2;
		auto z = a1 * b2 - b1 * a2;
		if (x % z != 0 || y % z != 0)
		{
			continue;
		}
		x /= z;
		y /= z;
		if (x >= 0 && y >= 0)
		{
			total += x * 3 + y;
		}
	}
	writeln (total);
}

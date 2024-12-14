import std;

void main ()
{
	auto p = stdin.byLineCopy.map !(u => u.matchAll (r"\-?\d+").array).array;
	alias Robot = Tuple !(int, q{x}, int, q{y}, int, q{vx}, int, q{vy});
	Robot [] r;
	foreach (ref line; p)
	{
		auto t = line.map !(c => c.front.to !(int)).array;
		r ~= Robot (t[0], t[1], t[2], t[3]);
	}
	auto sx = 101; // 11;
	auto sy = 103; // 7;
	auto t = 100;
	foreach (ref c; r)
	{
		c.x = (((c.x + c.vx * t) % sx) + sx) % sx;
		c.y = (((c.y + c.vy * t) % sy) + sy) % sy;
	}
	auto d = new int [] [] (2, 2);
	auto hx = sx / 2;
	auto hy = sy / 2;
	foreach (ref c; r)
	{
		if (c.x != hx && c.y != hy)
		{
			d[c.x / (hx + 1)][c.y / (hy + 1)] += 1;
		}
	}
	auto res = d.map !(v => v.fold !(q{a * b}) (1L)).fold !(q{a * b}) (1L);
	writeln (res);
}

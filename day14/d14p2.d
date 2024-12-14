import std;

void main ()
{
	auto p = stdin.byLineCopy.map !(u => u.matchAll (r"\-?\d+").array).array;
	alias Robot = Tuple !(int, q{x}, int, q{y}, int, q{vx}, int, q{vy});
	Robot [] r;
	auto sx = 101; // 11;
	auto sy = 103; // 7;
	foreach (ref line; p)
	{
		auto t = line.map !(c => c.front.to !(int)).array;
		auto c = Robot (t[0], t[1], t[2], t[3]);
		c.vx = (c.vx + sx) % sx;
		c.vy = (c.vy + sy) % sy;
		r ~= c;
	}
	auto t = 10_000;
	auto cur = new long [] [] (sx + 2, sy + 2);
	foreach (s; 1..t + 1)
	{
		int qual = 0;
		foreach (ref c; r)
		{
			c.x = (c.x + c.vx) % sx;
			c.y = (c.y + c.vy) % sy;
			cur[c.x + 1][c.y + 1] = s;
			qual += (cur[c.x + 1][c.y + 0] == s);
			qual += (cur[c.x + 0][c.y + 1] == s);
			qual += (cur[c.x + 1][c.y + 2] == s);
			qual += (cur[c.x + 2][c.y + 1] == s);
		}
		if (qual >= r.length)
		{
			writeln (s, " ", qual);
			break;
		}
	}
	auto board = new char [] [] (sx, sy);
	foreach (ref line; board)
	{
		line[] = '.';
	}
	foreach (ref c; r)
	{
		board[c.x][c.y] = '#';
	}
	writefln !("%-(%s\n%)") (board);
}

import std;

immutable int dirs = 4;
immutable int [dirs] dRow = [-1,  0, +1,  0];
immutable int [dirs] dCol = [ 0, -1,  0, +1];
immutable int oo = int.max / 4;

alias Coord = Tuple !(int, q{row}, int, q{col}, int, q{dir});

void main ()
{
	auto a = stdin.byLineCopy.map !(q{a.dup}).array;
	auto rows = a.length.to !(int);
	auto cols = a.front.length.to !(int);
	int rowS, colS, rowE, colE;
	Coord s, e;
	foreach (row; 0..rows)
	{
		foreach (col; 0..cols)
		{
			if (a[row][col] == 'S')
			{
				s = Coord (row, col, 3);
				a[row][col] = '.';
			}
			if (a[row][col] == 'E')
			{
				e = Coord (row, col, dirs);
				a[row][col] = '.';
			}
		}
	}
	Coord [] q;
	auto d = new int [dirs] [] [] (rows, cols);
	auto p = new int [dirs] [] [] (rows, cols);
	foreach (ref x; d)
	{
		foreach (ref y; x)
		{
			y[] = oo;
		}
	}

	void add (Coord v, int dist, int prev)
	{
		if (a[v.row][v.col] == '#')
		{
			return;
		}
		if (d[v.row][v.col][v.dir] > dist)
		{
			q ~= v;
			d[v.row][v.col][v.dir] = dist;
			p[v.row][v.col][v.dir] = 0;
		}
		if (d[v.row][v.col][v.dir] == dist)
		{
			p[v.row][v.col][v.dir] |= 1 << prev;
		}
	}

	Coord rem ()
	{
		auto res = q.front;
		q.popFront ();
		q.assumeSafeAppend ();
		return res;
	}

	add (s, 0, dirs);
	while (!q.empty)
	{
		auto c = rem ();
		auto dist = d[c.row][c.col][c.dir];
		add (Coord (c.row + dRow[c.dir], c.col + dCol[c.dir], c.dir),
		    dist + 1, c.dir);
		add (Coord (c.row, c.col, (c.dir + 1) % dirs),
		    dist + 1000, c.dir);
		add (Coord (c.row, c.col, (c.dir + dirs - 1) % dirs),
		    dist + 1000, c.dir);
	}

	auto vis = new int [] [] (rows, cols);

	void add2 (Coord v)
	{
		if (vis[v.row][v.col] & (1 << v.dir))
		{
			return;
		}
		vis[v.row][v.col] |= 1 << v.dir;
		q ~= v;
	}

	auto best = d[e.row][e.col][].minElement;
	foreach (dir; 0..dirs)
	{
		if (d[e.row][e.col][dir] == best)
		{
			add2 (Coord (e.row, e.col, dir));
		}
	}
	while (!q.empty)
	{
		auto c = rem ();
		foreach (dir; 0..dirs)
		{
			if (p[c.row][c.col][c.dir] & (1 << dir))
			{
				add2 (Coord (c.row - dRow[dir], c.col - dCol[dir], dir));
			}
		}
	}
	debug {writefln !("%(%(%X%)\n%)") (vis);}
	writeln (vis.map !(line => line.count !(q{a > 0})).sum - 1);
}

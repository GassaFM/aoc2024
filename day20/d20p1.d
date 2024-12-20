import std;

immutable int dirs = 4;
immutable int [dirs] dRow = [-1,  0, +1,  0];
immutable int [dirs] dCol = [ 0, -1,  0, +1];
immutable int oo = int.max / 4;

alias Coord = Tuple !(int, q{row}, int, q{col});

void main ()
{
	auto a = stdin.byLineCopy.map !(q{a.dup}).array;
	auto rows = a.length.to !(int);
	auto cols = a.front.length.to !(int);
	Coord s, e;
	foreach (row; 0..rows)
	{
		foreach (col; 0..cols)
		{
			if (a[row][col] == 'S')
			{
				s = Coord (row, col);
				a[row][col] = '.';
			}
			if (a[row][col] == 'E')
			{
				e = Coord (row, col);
				a[row][col] = '.';
			}
		}
	}

	auto go ()
	{
		Coord [] q;
		auto d = new int [] [] (rows, cols);
		foreach (ref line; d)
		{
			line[] = oo;
		}

		void add (Coord v, int dist)
		{
			if (0 <= v.row && v.row < rows &&
			    0 <= v.col && v.col < cols &&
			    a[v.row][v.col] != '#' &&
			    d[v.row][v.col] > dist)
			{
				q ~= v;
				d[v.row][v.col] = dist;
			}
		}

		Coord rem ()
		{
			auto res = q.front;
			q.popFront ();
			q.assumeSafeAppend ();
			return res;
		}

		add (s, 0);
		while (!q.empty)
		{
			auto c = rem ();
			auto dist = d[c.row][c.col];
			foreach (dir; 0..dirs)
			{
				auto v = Coord (c.row + dRow[dir], c.col + dCol[dir]);
				add (v, dist + 1);
			}
		}
		return d;
	}

	auto d = go ();
	auto base = d[e.row][e.col];
	int res = 0;
	foreach (row; 1..rows - 1)
	{
		foreach (col; 1..cols - 1)
		{
			if (a[row][col] == '#')
			{
				foreach (dir; 0..dirs)
				{
					auto d1 = d[row - dRow[dir]][col - dCol[dir]];
					auto d2 = d[row + dRow[dir]][col + dCol[dir]];
					if (d1 != oo && d2 != oo && d1 > d2)
					{
						a[row][col] ^= '#' ^ '.';
						auto v = go ();
						auto better = base - v[e.row][e.col];
						debug {writeln (better);}
						res += (better >= 100);
						a[row][col] ^= '#' ^ '.';
					}
				}
			}
		}
	}
	writeln (res);
}

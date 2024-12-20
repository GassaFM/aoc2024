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

	auto go (Coord start)
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

		add (start, 0);
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

	auto d = go (s);
	auto base = d[e.row][e.col];
	auto f = go (e);
	int res = 0;
	immutable int limit = 20;
	foreach (row; 0..rows)
	{
		foreach (col; 0..cols)
		{
			if (d[row][col] != oo)
			{
				foreach (row2; max (0, row - limit)..
				    min (rows, row + limit + 1))
				{
					auto limit2 = limit - abs (row2 - row);
					foreach (col2; max (0, col - limit2)..
					    min (cols, col + limit2 + 1))
					{
						auto spent = abs (row2 - row) +
						    abs (col2 - col);
						if (f[row2][col2] != oo)
						{
							auto better = base - (d[row][col] + f[row2][col2] + spent);
							debug {if (better > 0) writeln (better);}
							res += (better >= 100);
						}
					}
				}
			}
		}
	}
	writeln (res);
}

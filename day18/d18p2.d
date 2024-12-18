import std;

immutable int dirs = 4;
immutable int [dirs] dRow = [-1,  0, +1,  0];
immutable int [dirs] dCol = [ 0, -1,  0, +1];
immutable int oo = int.max / 4;

alias Coord = Tuple !(int, q{row}, int, q{col});

void main ()
{
	auto a = stdin.byLineCopy.map !(a => a.split (',').to !(int []))
	    .map !(a => Coord (a[0], a[1])).array;
	auto rows = a.map !(q{a.row}).maxElement + 1;
	auto cols = a.map !(q{a.col}).maxElement + 1;
	auto s = Coord (0, 0);
	auto e = Coord (rows - 1, cols - 1);

	bool solve (int limit)
	{
		auto board = new char [] [] (rows, cols);
		foreach (ref line; board)
		{
				line[] = '.';
		}
		foreach (ref c; a[0..limit])
		{
			board[c.row][c.col] = '#';
		}

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
			    board[v.row][v.col] != '#' &&
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
				auto v = Coord (c.row + dRow[dir],
				c.col + dCol[dir]);
				add (v, dist + 1);
			}
		}
		return d[e.row][e.col] < oo;
	}

//	a = (a.length < 1024 ? a[0..12] : a[0..1024]);
	int lo = 0;
	int hi = a.length.to !(int);
	while (lo + 1 < hi)
	{
		auto me = (lo + hi) / 2;
		if (solve (me))
		{
			lo = me;
		}
		else
		{
			hi = me;
		}
	}
	writeln (a[lo].row, ',', a[lo].col);
}

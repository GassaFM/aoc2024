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
				e = Coord (row, col, 1);
				a[row][col] = '.';
			}
		}
	}
	Coord [] q;
	auto d = new int [dirs] [] [] (rows, cols);
	foreach (ref x; d)
	{
		foreach (ref y; x)
		{
			y[] = oo;
		}
	}

	void add (Coord v, int dist)
	{
		if (a[v.row][v.col] != '#' && d[v.row][v.col][v.dir] > dist)
		{
			q ~= v;
			d[v.row][v.col][v.dir] = dist;
		}
	}

	add (s, 0);
	while (!q.empty)
	{
		auto c = q.front;
		q.popFront ();
		q.assumeSafeAppend ();
		auto dist = d[c.row][c.col][c.dir];
		add (Coord (c.row + dRow[c.dir], c.col + dCol[c.dir], c.dir), dist + 1);
		add (Coord (c.row, c.col, (c.dir + 1) % dirs), dist + 1000);
		add (Coord (c.row, c.col, (c.dir + dirs - 1) % dirs), dist + 1000);
	}
	d[e.row][e.col][].minElement.writeln;
}

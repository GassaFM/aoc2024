import std;

immutable int dirs = 4;
immutable int [dirs] dRow = [-1,  0, +1,  0];
immutable int [dirs] dCol = [ 0, -1,  0, +1];

bool solve (const char [] [] a)
{
	auto rows = a.length.to !(int);
	auto cols = a.front.length.to !(int);
	auto vis = new int [] [] (rows, cols);
	auto row = a.countUntil !(line => line.canFind ('^')).to !(int);
	auto col = a[row].countUntil ('^');
	auto dir = 0;
	while (!(vis[row][col] & (1 << dir)))
	{
		vis[row][col] |= 1 << dir;
		auto nRow = row + dRow[dir];
		auto nCol = col + dCol[dir];
		if (nRow < 0 || rows <= nRow ||
		    nCol < 0 || cols <= nCol)
		{
			return false;
		}
		else if (a[nRow][nCol] == '#')
		{
			dir = (dir + 3) % dirs;
		}
		else
		{
			row = nRow;
			col = nCol;
		}
	}
	return true;
}

void main ()
{
	auto a = stdin.byLineCopy.map !(q{a.dup}).array;
	auto rows = a.length.to !(int);
	auto cols = a.front.length.to !(int);
	int res = 0;
	foreach (row; 0..rows)
	{
		foreach (col; 0..cols)
		{
			if (a[row][col] == '.')
			{
				a[row][col] = '#';
				res += solve (a);
				a[row][col] = '.';
			}
		}
	}
	writeln (res);
}

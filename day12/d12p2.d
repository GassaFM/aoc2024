import std;

immutable int dirs = 4;
immutable int [dirs] dRow = [-1,  0, +1,  0];
immutable int [dirs] dCol = [ 0, -1,  0, +1];

void main ()
{
	auto a = stdin.byLineCopy.array;
	auto rows = a.length.to !(int);
	auto cols = a.front.length.to !(int);
	auto guard = '.'.repeat (cols + 2).text;
	a = guard ~ a.map !(line => '.' ~ line ~ '.').array ~ guard;
	auto vis = new bool [] [] (rows + 2, cols + 2);

	int area;
	int perimeter;

	void go (int row, int col)
	{
		vis[row][col] = true;
		area += 1;
		foreach (dir; 0..dirs)
		{
			auto nRow = row + dRow[dir];
			auto nCol = col + dCol[dir];
			if (a[nRow][nCol] != a[row][col])
			{
				perimeter += 1;
				auto dir2 = (dir + 1) % dirs;
				auto sRow = row + dRow[dir2];
				auto sCol = col + dCol[dir2];
				auto tRow = nRow + dRow[dir2];
				auto tCol = nCol + dCol[dir2];
				perimeter -=
				    (a[sRow][sCol] == a[row][col] &&
				    a[tRow][tCol] != a[row][col]);
			}
			else if (!vis[nRow][nCol])
			{
				go (nRow, nCol);
			}
		}
	}

	long res = 0;
	foreach (row; 1..rows + 1)
	{
		foreach (col; 1..cols + 1)
		{
			if (!vis[row][col])
			{
				area = 0;
				perimeter = 0;
				go (row, col);
				debug {writeln (area, " ", perimeter);}
				res += area * 1L * perimeter;
			}
		}
	}
	writeln (res);
}

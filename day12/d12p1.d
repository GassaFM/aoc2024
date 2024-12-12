import std;

immutable int dirs = 4;
immutable int [dirs] dRow = [-1,  0, +1,  0];
immutable int [dirs] dCol = [ 0, -1,  0, +1];

void main ()
{
	auto a = stdin.byLineCopy.array;
	auto rows = a.length.to !(int);
	auto cols = a.front.length.to !(int);
	auto vis = new bool [] [] (rows, cols);

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
			if (nRow < 0 || rows <= nRow ||
			    nCol < 0 || cols <= nCol ||
			    a[nRow][nCol] != a[row][col])
			{
				perimeter += 1;
			}
			else if (!vis[nRow][nCol])
			{
				go (nRow, nCol);
			}
		}
	}

	long res = 0;
	foreach (row; 0..rows)
	{
		foreach (col; 0..cols)
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

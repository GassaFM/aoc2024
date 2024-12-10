import std;

immutable int dirs = 4;
immutable int [dirs] dRow = [-1,  0, +1,  0];
immutable int [dirs] dCol = [ 0, -1,  0, +1];

void main ()
{
	auto a = stdin.byLineCopy.map !(line =>
	    line.map !(q{a - '0'}).array).array;
	auto rows = a.length.to !(int);
	auto cols = a.front.length.to !(int);

	int score (int row0, int col0)
	{
		auto f = new int [] [] (rows, cols);
		auto g = new int [] [] (rows, cols);
		f[row0][col0] = 1;

		auto mark (int row, int col, int d)
		{
			foreach (dir; 0..dirs)
			{
				auto nRow = row + dRow[dir];
				auto nCol = col + dCol[dir];
					if (0 <= nRow && nRow < rows &&
					    0 <= nCol && nCol < cols &&
					    a[nRow][nCol] == d)
					{
						g[nRow][nCol] += f[row][col];
					}
			}
		}

		immutable int limit = 10;
		foreach (d; 1..limit)
		{
			foreach (ref line; g)
			{
				line[] = 0;
			}
			foreach (row; 0..rows)
			{
				foreach (col; 0..cols)
				{
					mark (row, col, d);
				}
			}
			swap (f, g);
		}

		return f.map !(sum).sum;
	}

	int res = 0;
	foreach (row; 0..rows)
	{
		foreach (col; 0..cols)
		{
			if (a[row][col] == 0)
			{
				res += score (row, col);
			}
		}
	}
	writeln (res);
}

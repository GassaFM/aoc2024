import std;

void main ()
{
	auto a = stdin.byLineCopy.array;
	auto rows = a.length.to !(int);
	auto cols = a.front.length.to !(int);
	auto vis = new bool [] [] (rows, cols);

	void step (int row1, int col1, int row2, int col2)
	{
		auto row3 = row2;
		auto col3 = col2;
		while (0 <= row3 && row3 < rows && 0 <= col3 && col3 < cols)
		{
			vis[row3][col3] = true;
			row3 += row2 - row1;
			col3 += col2 - col1;
		}
	}

	void go (int row1, int col1)
	{
		debug {writeln (row1, " ", col1);}
		foreach (row2; 0..rows)
		{
			foreach (col2; 0..cols)
			{
				if (tuple (row1, col1) != tuple (row2, col2))
				{
					if (a[row1][col1] == a[row2][col2])
					{
						step (row1, col1, row2, col2);
						step (row2, col2, row1, col1);
					}
				}
			}
		}
	}

	foreach (row1; 0..rows)
	{
		foreach (col1; 0..cols)
		{
			if (a[row1][col1] != '.')
			{
				go (row1, col1);
			}
		}
	}

	vis.map !(sum).sum.writeln;
}

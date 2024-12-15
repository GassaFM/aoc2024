import std;

immutable int dirs = 4;
immutable int  [dirs] dRow  = [ -1,   0,  +1,   0];
immutable int  [dirs] dCol  = [  0,  -1,   0,  +1];
immutable char [dirs] dName = ['^', '<', 'v', '>'];

void main ()
{
	char [] [] board;
	string s;
	while ((s = readln.strip) != "")
	{
		string temp;
		foreach (const char x; s)
		{
			foreach (y; zip (".#O@", ["..", "##", "[]", "@."]))
			{
				if (x == y[0])
				{
					temp ~= y[1];
				}
			}
		}
		board ~= temp.dup;
	}
	auto cmd = stdin.byLineCopy.join;

	auto rows = board.length.to !(int);
	auto cols = board.front.length.to !(int);
	int row;
	int col;
	foreach (r; 0..rows)
	{
		foreach (c; 0..cols)
		{
			if (board[r][c] == '@')
			{
				board[r][c] = '.';
				row = r;
				col = c;
			}
		}
	}

	void display ()
	{
		board[row][col] ^= '@' ^ '.';
		writefln !("%-(%s\n%)\n") (board);
		board[row][col] ^= '@' ^ '.';
	}

	void moveCol (int dir)
	{
		int nRow = row;
		int nCol = col;
		do
		{
			nRow += dRow[dir];
			nCol += dCol[dir];
		}
		while (board[nRow][nCol] == '[' || board[nRow][nCol] == ']');
		if (board[nRow][nCol] == '#')
		{
			return;
		}
		do
		{
			swap (board[nRow][nCol],
			    board[nRow - dRow[dir]][nCol - dCol[dir]]);
			nRow -= dRow[dir];
			nCol -= dCol[dir];
		}
		while (row != nRow || col != nCol);
		row += dRow[dir];
		col += dCol[dir];
	}

	auto vis = new bool [cols];
	auto nVis = new bool [cols];
	auto nBoard = new char [] [] (rows, cols);

	void moveRow (int dir)
	{
		foreach (r; 0..rows)
		{
			nBoard[r][] = board[r][];
		}

		int r = row;
		vis[] = false;
		vis[col] = true;

		while (vis.any)
		{
			nVis[] = false;
			r += dRow[dir];
			auto r2 = r + dRow[dir];
			debug {writefln !("%(%d%)") (vis);}
			foreach (c; 0..cols)
			{
				if (vis[c])
				{
					if (board[r][c] == '#')
					{
						return;
					}
					if (board[r][c] == '[')
					{
						nVis[c + 0] = true;
						nVis[c + 1] = true;
						nBoard[r][c + 0] ^= '[' ^ '.';
						nBoard[r][c + 1] ^= ']' ^ '.';
						nBoard[r2][c + 0] ^= '[' ^ '.';
						nBoard[r2][c + 1] ^= ']' ^ '.';
						vis[c + 1] = false;
					}
					if (board[r][c] == ']')
					{
						nVis[c - 1] = true;
						nVis[c - 0] = true;
						nBoard[r][c - 1] ^= '[' ^ '.';
						nBoard[r][c - 0] ^= ']' ^ '.';
						nBoard[r2][c - 1] ^= '[' ^ '.';
						nBoard[r2][c - 0] ^= ']' ^ '.';
					}
				}
			}
			swap (vis, nVis);
		}

		debug {writeln ("ok");}
		swap (board, nBoard);
		row += dRow[dir];
		col += dCol[dir];
	}

	foreach (dir; cmd.map !(x => dName[].countUntil (x).to !(int)))
	{
		if (dir & 1)
		{
			moveCol (dir);
		}
		else
		{
			moveRow (dir);
		}
		debug {display;}
	}
	debug {display;}

	int res = 0;
	foreach (r; 0..rows)
	{
		foreach (c; 0..cols)
		{
			if (board[r][c] == '[')
			{
				res += 100 * r + c;
			}
		}
	}
	writeln (res);
}

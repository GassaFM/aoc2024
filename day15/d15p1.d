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
		board ~= s.dup;
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

	foreach (dir; cmd.map !(x => dName[].countUntil (x).to !(int)))
	{
		int nRow = row;
		int nCol = col;
		do
		{
			nRow += dRow[dir];
			nCol += dCol[dir];
		}
		while (board[nRow][nCol] == 'O');
		if (board[nRow][nCol] == '#')
		{
			continue;
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
	debug {writefln !("%-(%s\n%)") (board);}

	int res = 0;
	foreach (r; 0..rows)
	{
		foreach (c; 0..cols)
		{
			if (board[r][c] == 'O')
			{
				res += 100 * r + c;
			}
		}
	}
	writeln (res);
}

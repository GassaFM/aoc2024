import std;

string [] rotate90 (string [] a)
{
	auto rows = a.length;
	auto cols = a.front.length;
	string [] res;
	foreach_reverse (col; 0..cols)
	{
		res ~= rows.iota.map !(row => a[row][col]).text;
	}
	return res;
}

int go (string [] a)
{
	auto rows = a.length;
	auto cols = a.front.length;
	int res = 0;
	foreach (row; 0..rows - 2)
	{
		foreach (col; 0..cols - 2)
		{
			bool found = true;
			found &= (a[row + 0][col + 0] == 'M');
			found &= (a[row + 0][col + 2] == 'M');
			found &= (a[row + 1][col + 1] == 'A');
			found &= (a[row + 2][col + 0] == 'S');
			found &= (a[row + 2][col + 2] == 'S');
			res += found;
		}
	}
	return res;
}

void main ()
{
	string [] a;
	foreach (s; stdin.byLineCopy)
	{
		a ~= s;
	}
	int res = 0;
	foreach (k; 0..4)
	{
		res += go (a);
		a = rotate90 (a);
	}
	writeln (res);
}

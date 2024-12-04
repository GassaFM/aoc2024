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

int go (string [] a, string p)
{
	auto rows = a.length;
	auto cols = a.front.length;
	auto len = p.length;
	int res = 0;
	foreach (row; 0..rows)
	{
		foreach (col; 0..cols - len + 1)
		{
			res += a[row][col..col + len] == p;
		}
	}
	return res;
}

int go2 (string [] a, string p)
{
	auto rows = a.length;
	auto cols = a.front.length;
	auto len = p.length;
	int res = 0;
	foreach (row; 0..rows - len + 1)
	{
		foreach (col; 0..cols - len + 1)
		{
			bool found = true;
			foreach (i; 0..len)
			{
				found &= (a[row + i][col + i] == p[i]);
			}
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
		res += go (a, "XMAS");
		res += go2 (a, "XMAS");
		a = rotate90 (a);
	}
	writeln (res);
}

import std;

bool good (int [] a)
{
	return a.isSorted && a.zip (a.drop (1)).all
	    !(q{1 <= a[1] - a[0] && a[1] - a[0] <= 3});
}

void main ()
{
	int res = 0;
	foreach (s; stdin.byLineCopy ())
	{
		auto a = s.split.to !(int []);
		auto n = a.length.to !(int);
		bool ok = false;
		ok |= good (a);
		foreach (i; 0..n)
		{
			ok |= good (a[0..i] ~ a[i + 1..$]);
		}
		reverse (a);
		ok |= good (a);
		foreach (i; 0..n)
		{
			ok |= good (a[0..i] ~ a[i + 1..$]);
		}
		res += ok;
	}
	writeln (res);
}

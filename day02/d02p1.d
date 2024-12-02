import std;

void main ()
{
	int res = 0;
	foreach (s; stdin.byLineCopy ())
	{
		auto a = s.split.to !(int []);
		bool ok = false;
		ok |= a.isSorted && a.zip (a.drop (1)).all
		    !(q{1 <= a[1] - a[0] && a[1] - a[0] <= 3});
		reverse (a);
		ok |= a.isSorted && a.zip (a.drop (1)).all
		    !(q{1 <= a[1] - a[0] && a[1] - a[0] <= 3});
		res += ok;
	}
	writeln (res);
}

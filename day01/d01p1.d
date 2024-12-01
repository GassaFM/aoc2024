import std;

void main ()
{
	int [] a;
	int [] b;
	foreach (s; stdin.byLineCopy ())
	{
		auto t = s.split.map !(to !(int)).array;
		a ~= t[0];
		b ~= t[1];
	}
	sort (a);
	sort (b);
	long res = 0;
	foreach (i; 0..a.length)
	{
		res += abs (a[i] - b[i]);
	}
	writeln (res);
}

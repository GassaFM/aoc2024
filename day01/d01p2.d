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
	int [int] c;
	foreach (ref x; b)
	{
		c[x] += 1;
	}
	long res = 0;
	foreach (i; 0..a.length)
	{
		res += a[i] * c.get (a[i], 0);
	}
	writeln (res);
}

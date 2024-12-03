import std;

void main ()
{
	long res = 0;
        foreach (s; stdin.byLineCopy)
        {
		auto r = matchAll (s, r"mul\((\d+)\,(\d+)\)");
		debug {writeln (r);}
		foreach (ref x; r)
		{
			res += x[1].to !(int) * x[2].to !(int);
		}
	}
	writeln (res);
}

import std;

void main ()
{
	long res = 0;
	bool on = true;
        foreach (s; stdin.byLineCopy)
        {
		auto r = matchAll (s, r"do\(\)|don't\(\)|mul\((\d+)\,(\d+)\)");
		debug {writeln (r);}
		foreach (ref x; r)
		{
			if (x[0] == "do()")
			{
				on = true;
			}
			else if (x[0] == "don't()")
			{
				on = false;
			}
			else if (on)
			{
				res += x[1].to !(int) * x[2].to !(int);
	        	}
		}
	}
	writeln (res);
}

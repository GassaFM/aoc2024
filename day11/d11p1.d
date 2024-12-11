import std;

void main ()
{
	auto a = readln.split.to !(long []);
	auto steps = 25;
	foreach (s; 0..steps)
	{
		long [] b;
		foreach (ref x; a)
		{
			if (x == 0)
			{
				b ~= 1;
				continue;
			}
			auto t = x.text;
			if (t.length % 2 == 0)
			{
				b ~= t[0..$ / 2].to !(long);
				b ~= t[$ / 2..$].to !(long);
				continue;
			}
			b ~= x * 2024;
		}
		a = b;
		debug {writeln (s + 1, " ", a);}
	}
	a.length.writeln;
}

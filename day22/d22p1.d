import std;

immutable int steps = 2000;

long next (long value)
{
	value = (value ^ (value << 6)) & 0xFFFFFF;
	value = (value ^ (value >> 5)) & 0xFFFFFF;
	value = (value ^ (value << 11)) & 0xFFFFFF;
	return value;
}

void main ()
{
        long res = 0;
	foreach (s; stdin.byLineCopy)
	{
		auto n = s.to !(long);
		foreach (i; 0..steps)
		{
			n = next (n);
		}
		res += n;
	}
	writeln (res);
}

import std;

void main ()
{
	auto a = readln.strip.findSplitAfter ("Register A: ")[1].to !(long);
	auto b = readln.strip.findSplitAfter ("Register B: ")[1].to !(long);
	auto c = readln.strip.findSplitAfter ("Register C: ")[1].to !(long);
	readln;
	auto p = readln.strip.findSplitAfter ("Program: ")[1].split (",")
	    .map !(to !(int)).array;

	alias combo = x => [0, 1, 2, 3, a, b, c][x];

	auto n = p.length.to !(int);
	int cur = 0;
	int [] answer;
	while (cur < n)
	{
		auto cmd = p[cur];
		auto ar = p[cur + 1];
		cur += 2;
		switch (cmd)
		{
		case 0: writefln !("a = a >> combo (%s)") (ar); break;
		case 1: writefln !("b ^= %s") (ar); break;
		case 2: writefln !("b = combo (%s) & 7") (ar); break;
		case 3: writefln !("if (a) cur = %s") (ar); break;
		case 4: writefln !("b ^= c"); break;
		case 5: writefln !("answer ~= combo (%s) & 7") (ar); break;
		case 6: writefln !("b = a >> combo (%s)") (ar); break;
		case 7: writefln !("c = a >> combo (%s)") (ar); break;
		default: assert (false);
		}
	}
	answer.writefln !("%(%s,%)");
}

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
		case 0: a = a >> clamp (combo (ar), 0, 63); break;
		case 1: b ^= ar; break;
		case 2: b = combo (ar) & 7; break;
		case 3: if (a) cur = ar; break;
		case 4: b ^= c; break;
		case 5: answer ~= combo (ar) & 7; break;
		case 6: b = a >> clamp (combo (ar), 0, 63); break;
		case 7: c = a >> clamp (combo (ar), 0, 63); break;
		default: assert (false);
		}
	}
	answer.writefln !("%(%s,%)");
}

import std;

immutable string [] board1 = ["789", "456", "123", ".0A"];
immutable string [] board2 = [".^A", "<v>"];

alias Coord = Tuple !(int, q{r}, int, q{c});

Coord findPos (immutable string [] s) (char v)
{
	foreach (r; 0..s.length.to !(int))
	{
		foreach (c; 0..s.front.length.to !(int))
		{
			if (s[r][c] == v)
			{
				return Coord (r, c);
			}
		}
	}
	assert (false);
}

alias find1 = findPos !(board1);
alias find2 = findPos !(board2);
immutable auto start1 = find1 ('A');
immutable auto start2 = find2 ('A');

int solve (string s)
{
	Coord u1 = start1, u2 = start2, u3 = start2, u4 = start2;
	string r1, r2, r3, r4;
	int d1, d2, d3, d4;

	void push (alias f, alias p, immutable string [] b)
	    (char c, ref Coord e, ref int d, ref string r)
	{
		d += 1;
		r ~= c;
		auto t = f (c);
		auto w = uniform (0, 2);
		if (b[e.r][t.c] == '.') w = 0;
		if (b[t.r][e.c] == '.') w = 1;
		if (w)
		{
			while (e.c < t.c) {p ('>'); e.c += 1; assert (b[e.r][e.c] != '.');}
			while (e.c > t.c) {p ('<'); e.c -= 1; assert (b[e.r][e.c] != '.');}
			while (e.r < t.r) {p ('v'); e.r += 1; assert (b[e.r][e.c] != '.');}
			while (e.r > t.r) {p ('^'); e.r -= 1; assert (b[e.r][e.c] != '.');}
		}
		else
		{
			while (e.r < t.r) {p ('v'); e.r += 1; assert (b[e.r][e.c] != '.');}
			while (e.r > t.r) {p ('^'); e.r -= 1; assert (b[e.r][e.c] != '.');}
			while (e.c < t.c) {p ('>'); e.c += 1; assert (b[e.r][e.c] != '.');}
			while (e.c > t.c) {p ('<'); e.c -= 1; assert (b[e.r][e.c] != '.');}
		}
		p ('A');
	}

	alias push5 = (char c) {};
	alias push4 = c => push !(find2, push5, board2) (c, u4, d4, r4);
	alias push3 = c => push !(find2, push4, board2) (c, u3, d3, r3);
	alias push2 = c => push !(find2, push3, board2) (c, u2, d2, r2);
	alias push1 = c => push !(find1, push2, board1) (c, u1, d1, r1);

	foreach (ref c; s)
	{
		push1 (c);
	}
//	debug {writeln (d1, " ", d2, " ", d3, " ", d4);}
//	debug {writeln (r4, "\n", r3, "\n", r2, "\n", r1);}
	return d4;
}

void main ()
{
	long total = 0;
	foreach (s; stdin.byLineCopy)
	{
		string res;
		auto cur = s[0..$ - 1].to !(int);

		auto d4 = int.max;
		foreach (step; 0..10_000)
		{
			d4 = min (d4, solve (s));
	        }
	        debug {writeln (s, " ", d4);}
		total += cur * (d4);
	}
	writeln (total);
}

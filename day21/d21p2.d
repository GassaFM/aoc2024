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

alias push (immutable string [] b, alias f, int depth) =
    memoize !(pushImpl !(b, f, depth));

long pushImpl (immutable string [] b, alias f, int depth)
    (char prev, char next)
    if (depth == 0)
{
	return 1L;
}

long pushImpl (immutable string [] b, alias f, int depth)
    (char prev, char next)
    if (depth > 0)
{
	Coord e = f (prev);
	Coord t = f (next);
	auto e0 = e;
	long res = long.max;
	if (b[e.r][t.c] != '.')
	{
		string r = "A";
		long temp = 0;
		while (e.c < t.c) {r ~= '>'; e.c += 1; assert (b[e.r][e.c] != '.');}
		while (e.c > t.c) {r ~= '<'; e.c -= 1; assert (b[e.r][e.c] != '.');}
		while (e.r < t.r) {r ~= 'v'; e.r += 1; assert (b[e.r][e.c] != '.');}
		while (e.r > t.r) {r ~= '^'; e.r -= 1; assert (b[e.r][e.c] != '.');}
		r ~= 'A';
		foreach (i; 1..r.length)
		{
			temp += push !(board2, find2, depth - 1) (r[i - 1], r[i]);
		}
		res = min (res, temp);
	}
	e = e0;
	if (b[t.r][e.c] != '.')
	{
		string r = "A";
		long temp = 0;
		while (e.r < t.r) {r ~= 'v'; e.r += 1; assert (b[e.r][e.c] != '.');}
		while (e.r > t.r) {r ~= '^'; e.r -= 1; assert (b[e.r][e.c] != '.');}
		while (e.c < t.c) {r ~= '>'; e.c += 1; assert (b[e.r][e.c] != '.');}
		while (e.c > t.c) {r ~= '<'; e.c -= 1; assert (b[e.r][e.c] != '.');}
		r ~= 'A';
		foreach (i; 1..r.length)
		{
			temp += push !(board2, find2, depth - 1) (r[i - 1], r[i]);
		}
		res = min (res, temp);
	}
	writefln !("push %s %s %s = %s") (depth, prev, next, res);
	return res;
}

long solve (string s)
{
	immutable int height = 26; // part 1: 3, part 2: 26
	auto r = 'A' ~ s;
	long res = 0;
	foreach (i; 1..r.length)
	{
		res += push !(board1, find1, height) (r[i - 1], r[i]);
	}
	writeln (s, " ", res);
	return res;
}

void main ()
{
	long total = 0;
	foreach (s; stdin.byLineCopy)
	{
		string res;
		auto cur = s[0..$ - 1].to !(int);
		total += cur * solve (s);
	}
	writeln (total);
}

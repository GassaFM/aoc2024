import std;
alias calc = memoize !(calcImpl);
long calcImpl (long value, int s) {
	if (!s) return 1;
	if (!value) return calc (1, s - 1);
	auto t = value.text;
	return t.length % 2 ? calc (value * 2024, s - 1) :
	    calc (t[0..$ / 2].to !(long), s - 1) +
	    calc (t[$ / 2..$].to !(long), s - 1);
}
void main () {
	readln.split.to !(long []).map !(x => calc (x, 75)).sum.writeln;
}

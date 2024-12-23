import std;
void main () {
	// read graph
	auto e = stdin.byLineCopy.map !(s => s.split ("-")).array;
	bool [string] [string] a;
	bool [string] m;
	foreach (ref p; e) a[p[0]][p[1]] = a[p[1]][p[0]] = m[p[0]] = m[p[1]] = true;
	// convert graph to numbers
	auto names = m.byKey.array.sort;
	auto n = names.length.to !(int);
	auto h = new bool [] [] (n, n);
	foreach (i; 0..n) foreach (j; 0..n) h[i][j] = (names[i] in a[names[j]]) !is null;
	// recursive brute force
	int [] best;
	void recur (int [] v) {
		if (best.length < v.length) best = v.dup;
		foreach (i; v.back + 1..n) if (v.all !(j => h[i][j])) recur (v ~ i);
	}
	foreach (i; 0..n) recur ([i]);
	best.map !(i => names[i]).writefln !("%-(%s,%)");
}

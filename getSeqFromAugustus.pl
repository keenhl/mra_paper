
$file = "output.toxoplasma.gff";

die unless open (INFILE, "$file");

## outer loop to get gene
while($line = <INFILE>){
	
	chomp($line);
	
	if ($line =~ /\#\sstart\sgene\sg\d*/){

		($gene) = $line =~ /\#\sstart\sgene\s(g\d*)/;


		## inner loop to get protein sequence
		
		undef @a;

		while($line = <INFILE>){

			chomp($line);

			push(@a, $line);

			last if ($line =~ /\#\send\sgene\s(g\d*)/);
		}

		##

		$string = join("", @a);

		($protein) = $string =~ /protein\ssequence\s=\s\[(.*)\]/;

		$protein =~ s/\s//g;
		$protein =~ s/\#//g;

		##

		print ">$gene\n$protein\n";

		##
	}
}

close INFILE;
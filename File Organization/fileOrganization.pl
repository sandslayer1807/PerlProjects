use warnings;
use strict;
use File::Copy;

my $directory = "C:\\Users\\Ethan\\Downloads";
my @extensions = qw(
		\.mkv|\.mov|\.wmv|\.mpeg
		\.doc|\.docx|\.odt|\.ppt|\.pptx|\.txt|\.log|\.pdf
		\.pl|\.java|\.cpp|\.hpp|\.py|\.vb|\.cmd|\.bat
		\.exe|\.msi
		\.jpg|\.png|\.gif|\.bmp|\.tif|\.psd
		\.zip|\.7z|\.rar
		\.iso
);
my @folders = qw(Movies Documents Scripts Executables Pictures Archives ISOs);

opendir(DIR,$directory) or die $!;
while(my $file = readdir(DIR)) {
	next unless (-f "$directory\\$file");
	for(my $i = 0;$i <= $#extensions; $i++) {
		if($file =~ /$extensions[$i]/) {
			$new_directory = $directory."\\$folders[$i]";
 		unless(-d $new_directory) {
 			mkdir $new_directory or die $!;
 		}
 		move("$directory\\$file","$new_directory\\$file") or die $!;
 		last;
		}
	}
}
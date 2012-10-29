
#
#   Copyright (C) 2012  Ethan Wells

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Program: APOD Picture of the day script.
#		Will take the APOD picture of the day, download it to the specified directory, and (in Ubuntu) apply the saved picture as a wallpaper.

#Things to upgrade:
#	1. Make OS check so it knows what code to run as far as where to save and how to apply the wallpaper
#	2. Make the script sense what it is pulling from APOD so it knows what to append as far as file extensions (only accepts JPEGs right now)
#	3. Windows support!?

use warnings;
use strict;
use WWW::Mechanize;
use LWP::Simple;
use Time::localtime;

my $link_to_apod = 'http://apod.nasa.gov';

my $agent = WWW::Mechanize->new();
$agent -> get( $link_to_apod );
$agent -> follow_link( url_regex => qr/image/);

my $content = get( $agent -> uri());

#Getting the date so I can store the image with a better (unique) name
my $date = localtime;
my ($day,$month,$year) = ($date -> mday, $date -> mon + 1, $date -> year() + 1900);
my $date_string = $month . "_" . $day . "_" . $year . ".jpg";

#Saving the image
open(IMAGE, ">/home/ethan/Pictures/apod/$date_string") || die "image.jpg: $!";
binmode IMAGE;
print IMAGE $content;
close IMAGE;

my $cmd = "gsettings set org.gnome.desktop.background picture-uri file:///home/ethan/Pictures/apod/".$date_string;

system($cmd);

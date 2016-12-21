#!/usr/bin/perl  -w
#===============================================================================
#
#         FILE:  check_port.pl
#
#        USAGE:  check_port.pl -p <port> -h <host> (-c <critical> -w <warning> -v)
#
#  DESCRIPTION:  tests to see if the port is responding and can display timing
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Tim Pretlove
#      VERSION:  1.3
#      CREATED:  04/12/09 13:57:23
#     REVISION:  ---
#      LICENCE:  GNU
#
#       AUTHOR:  Jim Sander jim.sander@jdsmedia.net
#      VERSION:  1.2
#     MODIFIED:  10-04-2014 16:00
#         BUGS:  Socket::pack_sockaddr_in, length is 0 error for unresolvable hostnames
#        NOTES:  Fixed; now exits with '3', status UNKNOWN, and 'host lookup failed'
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#===============================================================================

use strict;
use warnings;
use Socket;
use Getopt::Long;
use Time::HiRes qw(gettimeofday tv_interval);

my ($crit, $warn, $timeout, $host, $portnum, $verbose);
GetOptions(
    'crtitical=s'   => \$crit,
    'warning=s'     => \$warn,
    'timeout=s'     => \$timeout,
    'host=s'        => \$host,
    'port=s'        => \$portnum,
    'verbose'       => \$verbose) or HELP_MESSAGE();

sub testport {
	my ($host,$port,$protocol,$timeout) = @_;
    my $startsec;
    my $elapsed = 0;
	if (!defined $timeout) { $timeout = 10 }
	if (!defined $protocol) { $protocol = "tcp" }
	my $proto = getprotobyname($protocol);
	my $iaddr = inet_aton($host);
	if ( !defined $iaddr ){ return 3,$elapsed; }
	my $paddr = sockaddr_in($port, $iaddr);
	$startsec = [gettimeofday()];
	socket(SOCKET, PF_INET, SOCK_STREAM, $proto) or die "socket: $!";
	eval {
		local $SIG{ALRM} = sub { die "timeout" };
		alarm($timeout);
		connect(SOCKET, $paddr) or error();
		alarm(0);
	};
	if ($@) {
		close SOCKET || die "close: $!";
		$elapsed = tv_interval ($startsec, [gettimeofday]);
		return "1",$elapsed;
	} else {
		close SOCKET || die "close: $!";
		$elapsed = tv_interval ($startsec, [gettimeofday]);
		return "0",$elapsed;
	}
}
sub HELP_MESSAGE {
	print "$0 -p <port> -h <host> (-c <critical> -w <warning> -v)\n"; 
	print "\t -p <port> # port number to examine\n";
	print "\t -h <hostname> # hostname or ip address to contact\n";
	print "\t -c <seconds> # the number of seconds to wait before a going critical\n";
	print "\t -w <seconds> # the number of seconds to wait before a flagging a warning\n";
	print "\t -v # displays nagios performance information\n";
	print "\te.g $0 -p 80 -h www.google.com -c 1.5 -w 1.0 -v\n";
    exit(4);
}

sub printperf {
    my ($warning,$critical,$elapsed) = @_;
	if ((defined $warning) && (defined $critical)) {
		print "|rta=$elapsed" . "s;$warning;$critical;0;$critical";
	} else {
		print "|rta=$elapsed" 
	}
}

sub test {
    my ($critical,$warning,$host,$portnum,$timeout) = @_;
    my $proto = "tcp";
	my ($rc,$elapsed) = testport($host,$portnum,$proto,$timeout); 
	if ($rc == 0) {
		if (defined $critical) {
			if ($critical <= $elapsed) {
				return 2,$elapsed;
			}
		}
		if (defined $warning) {
			if ($warning <= $elapsed) {
				return 1,$elapsed;
			}
		}
		return $rc,$elapsed;
	} else {
		return 2,$elapsed;
	}
}

unless ((defined $portnum) && (defined $host)) { 
	HELP_MESSAGE();
	exit 1;
}
if ((defined $crit) && (defined $warn)) {
	if ($crit <= $warn) {
		print "Error: warning is greater than critical will never reach warning\n";
		exit 4;
	}
}

my @mess = qw(OK WARNING CRITICAL UNKNOWN);
my @mess2 = ("is responding","is slow responding","is not responding","host lookup failed");
my ($rc,$elapsed) = test($crit,$warn,$host,$portnum,$timeout);
print "PORT $portnum $mess[$rc]: $host/$portnum $mess2[$rc]";
if (defined $verbose) {
	printperf($warn,$crit,$elapsed);
}
exit($rc);

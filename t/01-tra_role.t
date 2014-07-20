use Test::More tests => 2;
use Test::Moose;
use Test::Exception;
use MooseX::ClassCompositor;
use Test::Files;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use File::Temp qw(tempfile tempdir);
use Data::Dumper;

# setup the class creation process
my $test_class_factory = MooseX::ClassCompositor->new(
	{ class_basename => 'Test' }
	);

# create a temporary class based on the given Moose::Role package
my $test_class = $test_class_factory->class_for('NGS::Tools::Delly::Roles::Translocations');

# instantiate the test class based on the given role
my $delly;
my $tumour = "$Bin/example/tumour.bam";
my $normal = "$Bin/example/normal.bam";
lives_ok
	{
		$delly = $test_class->new(
			tumour => $tumour,
			normal => $normal
			);
		}
	'Class instantiated';

my $delly_tra = $delly->process_translocations();
my $expected_cmd = join(' ',
	'delly -t TRA',
	'-o tumour.tx.vcf',
	'-g /hpf/largeprojects/adam/local/reference/homosapiens/ucsc/hg19/fasta/hg19.fa',
	"$Bin/example/tumour.bam",
	"$Bin/example/normal.bam",
	);
is($delly_tra->{'cmd'}, $expected_cmd, 'Command matches expected');

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
my $test_class = $test_class_factory->class_for('NGS::Tools::Delly::Roles::Deletions');

# instantiate the test class based on the given role
my $delly;
lives_ok
    {
        $delly = $test_class->new();
        }
    'Class instantiated';
my $test_bam = 'test.bam';
my $delly_deletions = $delly->run_deletion_caller(
    bam => $test_bam,
    reference => 'hg19.fa'
    );
my $expected_cmd = join(' ',
    'delly',
    '-t DEL',
    '-o test.del.vcf',
    '-g hg19.fa',
    'test.bam'
    );
is($delly_deletions->{'cmd'}, $expected_cmd, "Command matches expected");

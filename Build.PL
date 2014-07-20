use 5.006;
use strict;
use warnings FATAL => 'all';
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'NGS::Tools::Delly',
    license             => 'Artistic_2_0',
    dist_author         => q{Richard de Borja <richard.deborja@sickkids.ca>},
    dist_abstract       => 'Delly Genomic Rearrangements Perl API',
    dist_version_from   => 'lib/NGS/Tools/Delly.pm',
    release_status      => 'stable',
    configure_requires => {
        'Module::Build' => 0,
    },
    build_requires => {
        'Test::More'                => 0,
				'MooseX::ClassCompositor'   => 0,
				'Test::Moose'               => 0,
				'Test::Exception'           => 0,
				'Test::Files'               => 0,
				'Data::Dumper'              => 0
    },
    requires => {
			  'Moose'                     => 0,
				'MooseX::Params::Validate'  => 0,
				'Carp'                      => 0,
				'File::Basename'            => 0,
        'Getopt::Long'              => 0,
        'Pod::Usage'                => 0
    },
    add_to_cleanup     => [ 'NGS-Tools-Delly-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();

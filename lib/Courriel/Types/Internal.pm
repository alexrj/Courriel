package Courriel::Types::Internal;

use strict;
use warnings;
use namespace::autoclean;

use MooseX::Types -declare => [
    qw(
        Body
        Charset
        ContentType
        Encoding
        EvenArrayRef
        Headers
        Part
        StringRef
        )
];

use MooseX::Types::Common::String qw( NonEmptyStr );
use MooseX::Types::Moose qw( ArrayRef HashRef ScalarRef Str );

#<<<
subtype Body,
    as role_type('Courriel::Role::Body');

subtype Headers,
    as role_type('Courriel::Role::Headers');

subtype Charset,
    as NonEmptyStr;

subtype ContentType,
    as class_type('Courriel::ContentType');

subtype Encoding,
    as NonEmptyStr;

subtype EvenArrayRef,
    as ArrayRef,
    where { @{$_} % 2 == 0 },
    message { 'The array reference must contain an even number of elements' };

coerce EvenArrayRef,
    from HashRef,
    via { %{@_} };

subtype Part,
    as role_type('Courriel::Role::Part');

subtype StringRef,
    as ScalarRef[Str];

coerce StringRef,
    from Str,
    via { my $str = $_; \$str };
#>>>

1;

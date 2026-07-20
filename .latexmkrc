# latexmk has a built-in rule for .idx -> .ind only, so setting $makeindex does
# nothing for the glossaries package: it writes .glo (symbols) and .acn
# (acronyms) instead. These custom dependencies make latexmk run makeglossaries
# on both, which is what fills the List of Symbols and List of Acronyms.

add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
    my ($base_name, $path) = fileparse($_[0]);
    pushd $path;
    my $return = system 'makeglossaries', $base_name;
    popd;
    return $return;
}

push @generated_exts, 'acn', 'acr', 'alg', 'glg', 'glo', 'gls', 'ist', 'xdy';

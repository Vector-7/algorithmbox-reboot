use strict; use warnings;

my @res = ();
sub makeNewGroup {
    my ($graphRef, $valuesRef, $a, $b) = @_;
    
    if(($a cmp $b) == 1) { 
        $$graphRef{$a} = $$graphRef{$b} = $a;
    } else { 
        $$graphRef{$a} = $$graphRef{$b} = $b; 
    }
    
    $$valuesRef{$a} = $$valuesRef{$b} = 2;

    return 2;
}
sub find {
    my ($graphRef, $name) = @_;
    if($$graphRef{$name} eq $name) { return $name; }
    
    my $friend_name = find($graphRef, $$graphRef{$name});
    $$graphRef{$name} = $friend_name;
    return $friend_name
}

sub update {
    my ($graphRef, $valueRef, $newName, $rootName) = @_;
    $$graphRef{$newName} = $rootName;
    $$valueRef{$rootName} += 1;

    return $$valueRef{$rootName};
}

sub unionFriend {
    my ($graphRef, $valuesRef, $name1, $name2) = @_;
    my ($root1, $root2) = (find($graphRef, $name1), find($graphRef, $name2));

    if(!($root1 eq $root2)) {
        # not same root
        if(($root1 cmp $root2) == 1) { 
            $$graphRef{$root1} = $$graphRef{$root2} = $root1;
            $$valuesRef{$root1} += $$valuesRef{$root2};
            return $$valuesRef{$root1};
        } else { 
            $$graphRef{$root2} = $$graphRef{$root1} = $root2;
            $$valuesRef{$root2} += $$valuesRef{$root1};
            return $$valuesRef{$root2};
        }
    } else {
        # already same
        return $$valuesRef{$root1};
    }
}

# process
sub process {
    my $resRef = [@_];
    my $N = <STDIN>;
    my %graph = ();
    # key: person, value: upper friends
    my %values = ();
    # key: person, value: friends size

    for(my $i = 0; $i < $N; $i++) {
        my $buf = <STDIN>;
        chomp($buf);
        my ($f1, $f2) = split / /, $buf;
        my ($f1Exists, $f2Exists) = (exists $graph{$f1}, exists $graph{$f2});
        my $friends_num = 0;

        if(!($f1Exists or $f2Exists)) {
            $friends_num = makeNewGroup(\%graph, \%values, $f1, $f2);
        } elsif($f1Exists and $f2Exists) {
            $friends_num = unionFriend(\%graph, \%values, $f1, $f2);
        } elsif(!$f1Exists) {
            # f1이 새로운 친구
            my $rootName = find(\%graph, $f2);
            $friends_num = update(\%graph, \%values, $f1, $rootName);

        } elsif(!$f2Exists) {
            # f2 가 새로운 친구
            my $rootName = find(\%graph, $f1);
            $friends_num = update(\%graph, \%values, $f2, $rootName);
        }
        push @res, $friends_num;
    }
}

my $T = <STDIN>;
for(my $i = 0; $i < $T; $i++) {
    process \@res;
}
for(my $i = 0; $i < @res; $i++) { print $res[$i] , "\n"; }
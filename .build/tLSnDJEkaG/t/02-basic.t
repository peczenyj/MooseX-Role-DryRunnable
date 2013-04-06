use Test::More tests => 2;

subtest "should do nothing if not in dry run" => sub {
  plan tests => 1;
  ok(0);
};

subtest "should change the behavior of some modue if in dry run" => sub {
  plan tests => 1;
  ok(0);
};
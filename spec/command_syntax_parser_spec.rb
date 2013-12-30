require 'java'
require 'fixtures/block_helper'

EOF = Purugin::Syntax::EOF

def lex(str)
  Purugin::Syntax::Lexer.new(str).to_a
end

def parse(str)
  Purugin::Syntax::Parser.parse(str)
end

def command(*words)
  Purugin::Syntax::Command.new(*words)
end

def variable(name, type=nil)
  Purugin::Syntax::Variable.new(name).tap do |var|
    var.type = Purugin::Syntax::Type.new(type) if type
  end
end

describe Purugin::Syntax::Lexer do
  it "Can lex barewords" do
    lex("a | d e").should == ['a', '|', 'd', 'e', EOF]
  end

  it "Can lex empty OR (|)" do
    lex("| d e").should == ['|', 'd', 'e', EOF]
  end

  it "Can lex variables" do
    lex("{a} | d").should == ['{', 'a', '}', '|', 'd', EOF]
  end

  it "Can lex variables with type declarations" do
    lex("{a} | {b:int}").should == 
      ['{', 'a', '}', '|', '{', 'b', ':', 'int', '}', EOF]
  end

  it "Can lex star (wild card)" do
    lex("{a} | *").should == ['{', 'a', '}', '|', '*', EOF]
  end
end

describe Purugin::Syntax::Parser do
  it "Can parse bareword commands" do
    parse("a | d e").should == [command('a'), command('d', 'e')]
  end

  it "Can parse empty OR (|)" do
    parse("| d e").should == [command(), command('d', 'e')]
  end

  it "Can parse variables" do
    parse("{a} | d").should == [command(variable('a')), command('d')]
  end

  it "Can parse variables with type declarations" do
    parse("{a} | {b:int}").should == 
      [command(variable('a')), command(variable('b', 'int'))]
  end

  it "Can lex star (wild card)" do
    parse("a | *").should == [command('a'), command('*')]
  end
end

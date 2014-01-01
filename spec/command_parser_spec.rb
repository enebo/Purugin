require 'java'
require 'fixtures/command_parser_helper'

describe Purugin::CommandParser::Lexer do
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

  it "Can lex mixed command" do
    lex("a {b}").should == ['a', '{', 'b', '}', EOF]
  end

  it "Can lex method name marker" do
    lex("<b> a").should == ['<', 'b', '>', 'a', EOF]
  end
end

describe Purugin::CommandParser::Parser do
  it "Can parse bareword commands" do
    commands = parse("a | d e")
    commands.should == [command('a'), command('d', 'e')]
    commands[0].method_suffix.should == '_a'
    commands[1].method_suffix.should == '_d_e'
    commands[1].arity.should == 2
  end

  it "Can parse empty OR (|)" do
    parse("| d e").should == [command(), command('d', 'e')]
  end

  it "Can parse a single variable" do
    parse("{foo}").should == [command(variable('foo'))]
  end

  it "Can parse variables" do
    parse("{a} | d").should == [command(variable('a')), command('d')]
  end

  it "Can parse variables with type declarations" do
    commands = parse("{a} | {b:byte}")
    commands.should == [command(variable('a')), command(variable('b', 'byte'))]
    commands[1].method_suffix.should == ''
    commands[1].words[0].type.should == type('byte')
    commands[1].arity.should == 1
  end

  it "Can parse a single typed variable" do
    parse("{foo:byte}").should == [command(variable('foo', 'byte'))]
  end

  it "Can parse star (wild card)" do
    commands = parse("a | *")
    commands.should == [command('a'), command('*')]
    commands[1].method_suffix.should == '_star'
    commands[1].arity.should == Purugin::CommandParser::Syntax::Command::MULTIPLE_ARGS
  end

  it "Can parse mixed command" do
    parse("a {b}").should == [command('a', variable('b'))]
  end

  it "Can parse empty string as no-arg command" do
    parse("").should == [command()]
  end

  it "Can parse method name marker" do
    command = command()
    command.name = 'none'
    commands = parse("<none>")
    commands.should == [command]
    commands[0].method_suffix.should == '_none'
  end

  it "Can parse method name marker in front of variable" do
    command = command()
    command.name = 'none'
    parse("<none> {foo}").should == [command(variable('foo'))]
  end

  it "Can parse method name marker in front of bareword" do
    command = command()
    command.name = 'none'
    commands = parse("<none> foo")
    commands.should == [command('foo')]
    commands[0].method_suffix.should == '_none'
  end
end

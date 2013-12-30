EOF = Purugin::CommandParser::Lexer::EOF

def lex(str)
  Purugin::CommandParser::Lexer.new(str).to_a
end

def parse(str)
  Purugin::CommandParser::Parser.parse(str)
end

def command(*words)
  Purugin::CommandParser::Syntax::Command.new(*words).tap do |command|
    command.post_process
  end
end

def type(name)
  Purugin::CommandParser::Syntax::Type.new(name)
end

def variable(name, type_name=nil)
  Purugin::CommandParser::Syntax::Variable.new(name).tap do |var|
    var.type = type(type_name) if type_name
  end
end

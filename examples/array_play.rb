# Exercise of writing Ruby versions from plugins in O'Reilly's
# Java Minecraft book.  Note: These were written from scratch and 
# the behavior is not neccesarily the same.  In this example it really 
# calculates your grade and is not simple hard-coded array access.

class ArrayPlayPlugin
  include Purugin::Plugin
  description 'ArrayPlay', 0.1

  GRADES = ['F', 'D', 'C', 'B', 'A']
  SCORES = [85, 92, 63]

  def on_enable
    player_command('arrayplay', 'play with arrays') do |sender, *args|
      average = SCORES.inject(0, &:+) / SCORES.length
      your_grade = GRADES[average / (100 / GRADES.length)]
    
      me.msg "Your grade is " + your_grade
      me.msg "There are #{GRADES.length} grades"
      me.msg "Your best quiz is " + SCORES.max
      me.msg "Your worst quiz is " + SCORES.min
      me.msg "All quizzes:"

      SCORES.each_with_index do |score, i|
        me.msg "Quiz score \##{i}: #{quizScores[i]}"
      end
    end
  end
end

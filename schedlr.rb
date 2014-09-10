# WIP 
# Takes in a popularity stack: a bunch of conference proposals
# sorted by popularity, and slots them in the schedule
# Constraints: pre-defined break slots, varying durations 
# (short and long in this example)

TITLE = 0
LENGTH = 1
LONG_SIZE = 2  # factors to a unit
SHORT_SIZE = 1 # of time, e.g 15mins

$short_flag = 0 # keeps track of next 
$long_flag = 0  # (possibly) available slot



def prepare_slot_flags(session, schedule)
  case session[LENGTH]
  when :short
    until !schedule[$short_flag]
      $short_flag+=1
    end

  when :long
    for index in $long_flag..$long_flag+LONG_SIZE-1
      if schedule[index]
        $long_flag = index+1
        prepare_slot_flags(session, schedule)
      end
    end
  end
end


def allot_slot(session, schedule)
  case session[LENGTH]
  when :short 
    schedule[$short_flag] = session[TITLE]
  when :long 
    index = $long_flag
    until index >= $long_flag + LONG_SIZE
      schedule[index] = session[TITLE] 
      index+=1
    end
    $long_flag = index
  end
end


def assign(session, schedule)

  prepare_slot_flags(session, schedule) # refresh slot to figure where session goes
  allot_slot(session, schedule)

end

def schedule
  schedule = []
  schedule[3] = :break
  schedule[5]  = :break
  schedule[9] = :break
  schedule[11] = :break
  popularity = [
                  ["sarup",:short],
                  ["jessica",:short], 
                  ["gnokii", :long],
                  ["stacy", :short],
                  ["giraffe", :long],
                  ["piggy", :long],
                  ["laura", :long],
                  ["michael", :short],
                  ["puyol", :short],
                  ["joomla", :long],
                  ["isabelle", :short]
               ]
  
  session = popularity.pop 
  # assign slots till no more sessions are left
  until session == nil 
    assign session, schedule
    session = popularity.pop
  end

  print schedule
end

schedule()

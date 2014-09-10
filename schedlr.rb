# WIP 
# Takes in a popularity stack: a bunch of conference proposals
# sorted by popularity, and slots them in the schedule
# Constraints: pre-defined break slots, varying durations 
# (short and long in this example)

TITLE = 0
LENGTH = 1
LONG_SIZE = 2  # factors to a unit
SHORT_SIZE = 1 # of time, e.g 15mins
SLOT_LIMIT = 25


$flag = 0 # keeps track of next (possibly) available short slot

def big_enough_for_long? session, slot_index, schedule
  index = slot_index
  until index >= slot_index+LONG_SIZE
    if schedule[index] == :break
      return false, index+1
    end
    index+=1
  end
  return true, slot_index
end

def allot_long session, slot_index, schedule
  index = slot_index
  until index >= slot_index+LONG_SIZE
    schedule[index] = session[TITLE]
    index+=1
  end
  return index
end

def assign session, slot_index, schedule
  if session == nil
    schedule.push :break
    return slot_index+1
  elsif session[LENGTH] == :short
    index=$flag
    until index > SLOT_LIMIT
      unless schedule[index]
        schedule[index] = session[TITLE]
        $flag = index+1
        break
      end
      index+=1
    end
    if index == slot_index
      return index+1
    end
    return slot_index
  elsif session[LENGTH] = :long
    enough_capacity = big_enough_for_long? session, slot_index, schedule
    if enough_capacity[0]
      return allot_long(session, slot_index, schedule)
    else
      assign session, enough_capacity[1], schedule
    end
  end
end

def schedule
  # initialize schedule; also, add break slots
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

  slot_index = 0

  until slot_index >= SLOT_LIMIT
    if schedule[slot_index] == :break
      slot_index+=1
    else
      slot_index = assign popularity.pop, slot_index, schedule
    end
  end
  print schedule
end

schedule()


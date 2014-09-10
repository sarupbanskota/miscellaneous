# WIP 
# Takes in a popularity stack: a bunch of conference proposals
# sorted by popularity, and slots them in the schedule
# Constraints: pre-defined free slots, varying durations 
# (short and long in this example)

$FREE = "Free"
$TITLE = 0
$LENGTH = 1
$LONG = "long"
$SHORT = "short"
$LONG_SIZE = 2
$SHORT_SIZE = 1
$FLAG = 0
$SLOT_LIMIT = 25

def big_enough_for_long? session, slot_index, schedule
  index = slot_index
  until index > slot_index+$LONG_SIZE-1 
    if schedule[index] == $FREE
      return false, index+1
    end
    index+=1
  end
  return true, slot_index
end

def allot_long session, slot_index, schedule
  index = slot_index
  until index > slot_index+$LONG_SIZE-1
    schedule[index] = session[$TITLE]
    index+=1
  end
  return index
end

def assign session, slot_index, schedule
  if session == nil
    schedule.push $FREE
    return slot_index+1
  elsif session[$LENGTH] == $SHORT
    index=$FLAG
    until index > $SLOT_LIMIT
      unless schedule[index]
        schedule[index] = session[$TITLE]
        $FLAG = index+1
        break
      end
      index+=1
    end
    if index == slot_index
      return index+1
    end
    return slot_index
  elsif session[$LENGTH] = $LONG
    enough_capacity = big_enough_for_long? session, slot_index, schedule
    if enough_capacity[0]
      return allot_long(session, slot_index, schedule)
    else
      assign session, enough_capacity[1], schedule
    end
  end
end

def schedule
  # initialize schedule; also, add free slots
  schedule = []
  schedule[3] = "Free"
  schedule[5]  = "Free"
  schedule[9] = "Free"
  schedule[11] = "Free"
  popularity = [
                  ["sarup","short"],
                  ["jessica","short"], 
                  ["gnokii", "long"],
                  ["stacy", "short"],
                  ["giraffe", "long"],
                  ["piggy", "long"],
                  ["laura", "long"],
                  ["michael", "short"],
                  ["puyol", "short"],
                  ["joomla", "long"],
                  ["isabelle", "short"]
               ]

  slot_index = 0

  until slot_index > $SLOT_LIMIT
    if schedule[slot_index] == $FREE
      slot_index+=1
    else
      slot_index = assign popularity.pop, slot_index, schedule
    end
  end
  print schedule
end

schedule()

# TODO:
# * Remove global variables, make methods to call

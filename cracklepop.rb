MAX = 100
index = 1

# just to extend to numbers beyond 3 and 5
crackle_test = 3 
pop_test = 5

until index > MAX do
  output=""
  output+= "Crackle" if index%crackle_test==0 
  output+= "Pop"     if index%pop_test==0     
  print ((output.empty?) ? index:output).to_s + "\n";
  index+=1
end

# README
# ----------------------------------------------------------------------------------------------------------------------
# Stolen from: http://www.danvk.org/wp/2007-01-30/boggle-2-the-shortest-solver/
# Does not perform well.  The big O is n2
#
# Input
#   Must be run with a 4x4 board (i.e. 16 letters for input)
#
# Output
#   Valid words found in the puzzle
#
# Run as:
#   bundle exec ruby lib/boggle.rb
#

# Load all 3-17 letter words into a hash for fast lookup
WORDS = Hash.new
IO.foreach("/usr/share/dict/words") do |line|
  line =~ /^([a-z]{3,17})\b/ and WORDS[$1] = true
end

FOUND = Hash.new                            # hash of words we've found
PREV = Array.new(4) { [false] * 4 }         # where have we been already?
BOARD = Array.new(4) { [0] * 4 }               # empty 4x4 array
(0..15).each { |i| BOARD[i/4][i%4] = ARGV[i] }

# All the different directions [dx,dy] we can look from a cell
DIRECTIONS = [ [-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1] ]
def solve(x, y, sofar)
  # p "solve for #{x}, #{y}"
  PREV[x][y]=true               # Mark our turf

  wd = sofar + BOARD[x][y]
  FOUND[wd]=true if WORDS[wd]   # count the new word

  DIRECTIONS.each do |dx,dy|
    # next unless (0..3)===(x+dx) # are we still
    next unless 0 <= x+dx && x+dx <= 3
    # next unless (0..3)===(y+dy) # on the board?
    next unless 0 <= y+dy && y+dy <= 3
    next if PREV[x+dx][y+dy]    # have we been here before?
    solve(x+dx,y+dy,wd)         # keep going!
  end

  PREV[x][y] = false            # We're done here
end

# Start a depth-first search from each cell on the board
(0..15).each { |i| solve(i/4, i%4, "") }

#         0, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16,17
# Scores = [0, 0, 0, 1, 1, 2, 3, 5,11,11,11,11,11,11,11,11,11,11]
# puts Found.keys.inject(0) { |sum,w| sum + Scores[w.length] }
puts FOUND.keys
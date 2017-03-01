require 'colorize'

module BoardPrint
  EDGES = {
    ul: "\u250c" + "\u2500",
    ur: "\u2500" + "\u2500" + "\u2510\n",
    midl: "\u251c" + "\u2500",
    midr: "\u2500" + "\u2524\n",
    ll: "\u2514" + "\u2500",
    lr: "\u2500" + "\u2500" + "\u2518\n",
    mid_edges: ("\u2500" + "\u2500" + "\u253c" + "\u2500") * 7 + "\u2500"
  }
  
  BORDER = {
    top_border: ("\u2500" + "\u2500" + "\u252c" + "\u2500") * 7,
    mid_border: EDGES[:midl] + EDGES[:mid_edges] + EDGES[:midr],
    bot_border: ("\u2500" + "\u2500" + "\u2534" + "\u2500") * 7
  }
  
  def cell_color(row, ind)
    if (even_row?(row) && even_ind?(ind)) || (!even_row?(row) && !even_ind?(ind))
      :light_black
    else
      :default
    end
  end
  
  def even_row?(row)
    row % 2 == 0
  end
  
  def even_ind?(ind)
    ind % 2 == 0
  end
  
  def to_s
    print "\n"
    print "    a   b   c   d   e   f   g   h \n"
    print "  " + EDGES[:ul] + BORDER[:top_border] + EDGES[:ur]
  
    8.times do |row|
      print "#{ (row - 8).abs } "
      self.data[row].each_with_index do |elem, ind|
        if elem
          print "\u2502" + " #{elem} ".colorize(background: cell_color(row, ind))
        else
          print "\u2502" + "   ".colorize(background: cell_color(row, ind))
        end
      end
      print "\u2502 #{ (row - 8).abs } \n"
      print "  " + BORDER[:mid_border] if row < 7
    end
    print "  " + EDGES[:ll] + BORDER[:bot_border] + EDGES[:lr]
    print "    a   b   c   d   e   f   g   h \n\n"
  end

end
  
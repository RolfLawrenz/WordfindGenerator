class WordfindGenerator

  attr_accessor :words, :width, :height, :lowercase

  BLANK_CHAR = '.'

  # 0 - top, 1 - top right, 2 - right, 3 - bottom right
  # 4 - bottom, 5 - bottom left, 6 - left, 7 - top left
  TOP = 0
  TOP_RIGHT = 1
  RIGHT = 2
  BOTTOM_RIGHT = 3
  BOTTOM = 4
  BOTTOM_LEFT = 5
  LEFT = 6
  TOP_LEFT = 7


  def initialize(words, width, height, lowercase = true)
    @words = lowercase ? words.map(&:downcase) : words.map(&:upcase)
    @width = width
    @height = height
    @lowercase = lowercase
  end

  def generate
    word_array = create_blank_word_array
    arrange_words(word_array)
  end

  def arrange_words(word_array)
    words_in_wordfind = []
    alphabet = @lowercase ? ('a'..'z') : ('A'..'Z')
    @words.each do |word|
      word_array_copy = word_array.dup
      wl = word.length
      # Random list of spaces in word find
      index_array = (0..(@width * @height - 1)).to_a.shuffle
      # Direction word show go
      dir_array = (0..7).to_a.shuffle
      # Iterate through all possible places in word find to place word
      index_array.each do |index|
        x = index_x(index)
        y = index_y(index)
        placed_word = false

        dir_array.each do |dai|
          # Check there is room for word in the direction
          next if [TOP, TOP_LEFT, TOP_RIGHT].include?(dai) && y < wl
          next if [RIGHT, TOP_RIGHT, BOTTOM_RIGHT].include?(dai) && (@width - x) < wl
          next if [BOTTOM, BOTTOM_LEFT, BOTTOM_RIGHT].include?(dai) && (@height - y) < wl
          next if [LEFT, TOP_LEFT, BOTTOM_LEFT].include?(dai) && x < wl

          # Got this far, so word fits. Add word to array if it fits
          all_letters_match = true
          wl.times.each do |wli|
            # Add letter if blank char or same char
            if word_array_copy[index(x,y)] == BLANK_CHAR || word_array_copy[index(x,y)] == word[wli]
              word_array_copy[index(x,y)] = word[wli]
            else
              all_letters_match = false
              break
            end
            x += 1 if [RIGHT, TOP_RIGHT, BOTTOM_RIGHT].include?(dai)
            x -= 1 if [LEFT, TOP_LEFT, BOTTOM_LEFT].include?(dai)
            y += 1 if [BOTTOM, BOTTOM_LEFT, BOTTOM_RIGHT].include?(dai)
            y -= 1 if [TOP, TOP_LEFT, TOP_RIGHT].include?(dai)
          end

          if all_letters_match
            # We fit word, so move onto next word
            word_array = word_array_copy
            words_in_wordfind << word
            placed_word = true
            break
          else
            # Doesnt fit, revert to previous copy
            word_array_copy = word_array.dup
          end
        end

        break if placed_word

      end
    end

    # Replace blank chars with random chars
    final_wordfind = word_array.dup
    final_wordfind.each do |k,v|
      final_wordfind[k] = alphabet.to_a[rand(26)] if v == BLANK_CHAR
    end

    {
        words_in_wordfind: words_in_wordfind.sort,
        words_not_in_wordfind: (@words - words_in_wordfind).sort,
        wordfind_solution: word_array,
        final_wordfind: final_wordfind
    }
  end

  def index_x(index)
    index % @width
  end

  def index_y(index)
    index / @width
  end

  def create_blank_word_array
    word_array = {}
    @width.times do |x|
      @height.times do |y|
        word_array[index(x,y)] = BLANK_CHAR
      end
    end
    word_array
  end

  def index(x, y)
    @width * y + x
  end

  def show(word_array)
    str = ""
    @width.times do |x|
      @height.times do |y|
        str += word_array[index(x,y)]
      end
      str += "\n"
    end
    puts str
  end
end

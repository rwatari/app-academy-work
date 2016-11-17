require 'set'

class WordChainer
  attr_reader :dictionary, :adjacent_words, :all_seen_words

  def initialize(dictionary_file_name)
    @dictionary = load_dictionary(dictionary_file_name)
    @current_words = Set.new
    @all_seen_words = {}
  end

  def load_dictionary(file_name)
    File.readlines(file_name).map(&:chomp).to_set
  end

  def adjacent_words(word)
    word_pool = same_length_words(word)
    result = []

    word.size.times do |i|
      pattern = word.dup
      pattern[i] = "."
      pattern = Regexp.new(pattern)
      result += word_pool.select { |w| w =~ pattern }
    end

    result
  end

  def same_length_words(word)
    dictionary.select { |dic_word| dic_word.length == word.length }
  end

  def run(start_word, target)
    @current_words << start_word
    @all_seen_words[start_word] = start_word

    until @current_words.empty?
      new_current_words = explore_current_words
      @current_words = new_current_words
      break if new_current_words.include?(target)
    end

    build_path(target)
  end

  def explore_current_words
    new_words = Set.new
    @current_words.each do |cur_word|
      adjacent_words(cur_word).each do |adj_word|
        unless @all_seen_words[adj_word]
          new_words << adj_word
          @all_seen_words[adj_word] = cur_word
        end
      end
    end

    new_words.each do |word|
      p "#{word} : #{@all_seen_words[word]}"
    end

    new_words
  end

  def build_path(target)
    return [target] if @all_seen_words[target] == target

    build_path(@all_seen_words[target]) + [target]
  end
end

require 'byebug'
def first_anagram?(str1, str2)
  str1_perms = str1.split('').permutation
  str1_perms.include?(str2.split(''))
end

def second_anagram?(str1, str2)
  str1_dup = str1.dup
  str2_dup = str2.dup
  str1.each_char do |char|
    if str2_dup.include?(char)
      str1_dup.sub!(char, "")
      str2_dup.sub!(char, "")
    end
  end
  str2_dup.empty? && str1_dup.empty?
end

def third_anagram?(str1, str2)
  sorted_1 = str1.split("").sort
  sorted_2 = str2.split("").sort
  sorted_2 == sorted_1
end


def fourth_anagram?(str1, str2)
  character_hash = Hash.new(0)

  str1.each_char do |char|
    character_hash[char] += 1
  end

  str2.each_char do |char|
    character_hash[char] -= 1
  end

  character_hash.values.all?(&:zero?)
end

require "minitest/autorun"

class Test < Minitest::Test

  def setup
    @test_array = [-10, 10, 250, -250, 10, 0, 1]
    @sorted_test_array = [-250, -10, 0, 1, 10, 10, 250]
  end

  def test_bubble_sort
    assert_equal @sorted_test_array, bubble_sort(@test_array)
  end

  def test_insertion_sort
    assert_equal @sorted_test_array, insertion_sort(@test_array)
  end

  def test_quick_sort
    assert_equal @sorted_test_array, bubble_sort(@test_array)
  end

  def test_count_sort
    assert_equal @sorted_test_array, count_sort(@test_array)
  end
end

def get_integer_array_from_console_input
  validation = false
  while validation == false do
    validation = true
    inputString = gets.chomp
    validation = check_for_an_empty_input_string(inputString, validation)
    stringArray = inputString.split(' ')
    validation = check_for_non_integers_in_array(stringArray, validation)
    integerArray = stringArray.map(&:to_i)
  end
  return integerArray
end

def check_for_an_empty_input_string(inputString, validation)
  if inputString.size == 0
    puts "Entered string is empty, please try again."
    validation = false
  end
  return validation
end

def check_for_non_integers_in_array(inputArray, validation)
  begin
    inputArray.map { |current| Integer(current) }
  rescue
    puts "Input contains non-integers, please try again"
    validation = false
    return validation
  end
  return validation
end

def show_min_and_max(input_array)
  puts "\nFinding minimal and maximal values in array..."
  min_and_max = get_min_and_max(input_array)
  puts "Minimal value in array = " + min_and_max[0].to_s + "\nMaximal value in array = " + min_and_max[1].to_s
end

def get_min_and_max(array)
  currentMin = array[0]
  currentMax = array[0]
  array.each do |current|
    currentMax = current if current > currentMax
    currentMin = current if current < currentMin
  end
  return [currentMin, currentMax] #returned values are used in countSort method
end

def bubble_sort(inputArray)
  array = inputArray.dup # making a copy of inputArray, to prevent changes to the original object
  puts "\nUsing bubble sort..."
  (array.size - 1).times do #in worse-case scenario, we should repeat the algorithm n - 1 times, where n is array length
    vasChanged = false #but if no two elements were swapped, that means that elements are sorted and we can break the cycle
    (0..array.size - 2).each do
    |currentIndex|
      if array[currentIndex] > array[currentIndex + 1]
        array[currentIndex], array[currentIndex + 1] = array[currentIndex + 1], array[currentIndex] #swapping two elements that aren`t in order
        vasChanged = true
      end
    end
    break if vasChanged == false
  end
  p array
  return array
end

def insertion_sort(inputArray)
  array = inputArray.dup # making a copy of inputArray, to prevent changes to the original object
  puts "\nUsing insertion sort..."
  (1...array.size).each do
  |i|
    i.downto(1) do
    |n|
      if array[n] < array[n - 1] then
        array[n], array[n - 1] = array[n - 1], array[n]
      else
        break
      end
    end
  end
  p array
  return array
end

def show_quick_sort(inputArray)
  array = inputArray.dup # making a copy of inputArray, to prevent changes to the original object
  puts "\nUsing quick sort..."
  p quick_sort(array)
  return array
end

def quick_sort(arr)
  return arr if arr.size < 2 # recursion exit condition

  pivot_id = arr.size / 2
  pivot = arr[pivot_id].dup
  arr.delete_at(pivot_id)
  less = Array.new
  more = Array.new

  arr.each do |e|
    if (e < pivot)
      less << e
    else
      more << e
    end
  end
  return quick_sort(less) << pivot << quick_sort(more)
end

def count_sort(inputArray)
  array = inputArray.dup # making a copy of inputArray, to prevent changes to the original object
  puts "\nUsing count sort..."
  min_and_max = get_min_and_max(inputArray)
  count = Array.new(min_and_max[1] - min_and_max[0] + 1, 0) # creating new array of optimal size and initializing it with zeros
  normalization_value = -min_and_max[0] # we will add this value to every element, making the lowest element of inputArray equal to 0, and disposing of negative values
  array.each do |current| # counting repeating values
    current += normalization_value
    count[current] += 1
  end
  array.clear
  (0...count.size).each do |current|
    count[current].times do
      array << current - normalization_value # returning the original values of inputArray elements
    end
  end
  p array
  return array
end

def main
  loop do
    puts "Enter an array of integers. Elements separated by space, press enter to complete input."
    input_array = get_integer_array_from_console_input

    loop do
      puts "\nWhat do you want to do? (enter the number of the task)\n\
0\tEnter new array\n\
1\tTo find minimal and maximal values\n\
2\tUse bubble sort\n\
3\tUse insert sort\n\
4\tUse quick sort\n\
5\tUse counting sort"
      case gets.chomp
      when '0'
        break
      when '1'
        show_min_and_max input_array
      when '2'
        bubble_sort input_array
      when '3'
        insertion_sort input_array
      when '4'
        show_quick_sort input_array
      when '5'
        count_sort input_array
      else
        puts "Unexpected input\n"
      end
    end
  end
end



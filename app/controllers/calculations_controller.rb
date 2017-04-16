class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    text_split_into_array = @text.downcase.split

    @word_count = text_split_into_array.length

    @character_count_with_spaces = @text.size

    @character_count_without_spaces = @text.size - @text.scan(/\s+/).size

    @occurrences = text_split_into_array.count(@special_word.downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = ((((@apr/100)/12) * @principal) / (1 - (1 + ((@apr/100)/12)) ** ( -(@years * 12))))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @weeks / 52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    sorted = @numbers.sort
    len = sorted.length

    def variance(array)
      arr = []
      array.each { |i| arr << (i - @sum/@count) ** 2}
      arr.sum/@count
    end

    def mode(array)
      hash = Hash.new(0)
      array.each do |i|
        hash[i]+=1
      end
      max = hash.values.max
      hash.select { |_,cnt| cnt == max }.keys
    end

    @sorted_numbers = sorted

    @count = len

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median = (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0

    @sum = @numbers.sum

    @mean = @sum/@count

    @variance = variance(@numbers)

    @standard_deviation = Math.sqrt(@variance)

    @mode = mode(@numbers)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end

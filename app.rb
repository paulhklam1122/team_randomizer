require "sinatra"
require "sinatra/reloader"
enable :sessions

get "/" do
  erb :index, layout: :app_layout
end

post '/acquire_team' do
  puts params
  session[:input] = params[:names]
  session[:names] = params[:names].split(",")
  session[:method] = params[:method]
  @check = params[:number].to_i
  if @check <= session[:names].length && @check != 0
    if session[:method] == "number_per_group"
      @number_per_group = params[:number].to_i
      # print "#{@pumber_per_group}!!!!!!!!!!!!!!!!!!!"
      @result = []
      @names_shuffled = session[:names].shuffle
      @member_1 = 0
      @length = @number_per_group
      begin
        @result << @names_shuffled.slice(@member_1, @length)
        @member_1 += @number_per_group
      end while @member_1 <= @names_shuffled.length-@length
      @temp = @names_shuffled - @result.flatten
      # print "temp: #{@temp}!!!!!"
      # print "result: #{@result}?????"
      if @temp
        (0...@temp.length).each do |index|
          @result[rand(@result.length)] << @temp[index]
        end
      end
      session[:result] = @result
    else
      # session[:number_of_group] = params[:number].to_i
      @result_1 = []
      @number_of_group = params[:number].to_i
      @names_shuffled = session[:names].shuffle
      @number_per_group = @names_shuffled.length / @number_of_group
      @member_1 = 0
      @length = @number_per_group
      begin
        @result_1 << @names_shuffled.slice(@member_1, @length)
        @member_1 += @number_per_group
      end while @member_1 <= @names_shuffled.length - @length 
      @temp = @names_shuffled - @result_1.flatten
      # print "temp: #{@temp}!!!!!"
      # print "result: #{@result_1}?????"
      if @temp
        (0...@temp.length).each do |index|
          @result_1[rand(@result_1.length)] << @temp[index]
        end
      end
    session[:result] = @result_1
    end
  else
  session[:result] = "Please enter a correct number!"
  end

  erb :index, layout: :app_layout
end

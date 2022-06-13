require 'ruby2d'
module Figures
=begin
    this module contains the functions to draw diferent figures
    using the ruby2d gem.(if you need more information about how
    this works visit https://www.ruby2d.com)
=end
    def draw_text(text,pos,color,z,size,rotate,style)
        #This function draw  text in an specific position
        if pos.length > 2 then
            raise "length of position container is grater than 2\n"
        end
        #The object where we put the position (x,y)
        position = []

        if pos.class == Hash then
            pos.each do |k,v|
                #Iteramos el contenedor
                position.push(v)
            end
        else
            pos.each do |i|
                #Iteramos el contenedor
                position.push(i)
            end
        end


        begin
            Text.new(
                text.to_s,
                x: position[0].to_i, y:position[1].to_i,
                style: style,
                size: size.to_i,
                color: color.to_s,
                rotate: rotate.to_i,
                z: z.to_i
              )
        rescue => exception
            raise "Invalid argument in draw_text function\n"
        end
    end


    def draw_square(pos,size,color,z)



        if pos.length > 2 || pos.length <= 1 then
            raise "length of position container is not (#{pos.length})"
        end
        #El objeto donde guardamos la posicion debe ser iteraable
        position = []

        if pos.class == Hash then
            pos.each do |k,v|
                #Iteramos el contenedor
                position.push(v)
            end
        else
            pos.each do |i|
                #Iteramos el contenedor
                position.push(i)
            end
        end
       begin
        Square.new(
            x: position[0].to_i, y: position[1].to_i,
            size: size.to_i,
            color: color.to_s,
            z: z.to_i)
       rescue => exception
            raise "Invalid argument in draw_text function\n"
       end
    end


    def draw_rectangle(pos,width,height,color,z)

        if pos.length > 2 || pos.length <= 1 then
            raise "length of position container is not (#{pos.length})"
        end
        #El objeto donde guardamos la posicion debe ser iteraable
        position = []

        if pos.class == Hash then
            pos.each do |k,v|
                #Iteramos el contenedor
                position.push(v)
            end
        else
            pos.each do |i|
                #Iteramos el contenedor
                position.push(i)
            end
        end
       begin
            Rectangle.new(
                x: position[0].to_i, y: position[1].to_i,
                width: width.to_i, height: height.to_i,
                color: color.to_s,
                z: z.to_i)
       rescue => exception
            raise "Invalid argument in draw_rectangle function\n"
       end
    end


end

class TextBox
    #This class help us to create a textbox where the user can introduce text
    include Figures
    attr_accessor :shapeA,:shapeB, :shapeText
    attr_accessor :text_limit

=begin
    This class create a textbox of an specific size where the user can introduce some text
    this class is initialized with the position(x,y) passed as an array, the size of the
    textbox, the color of the text,the z index(check ruby2d documentation), and the limits
    of the length of the string inside the textbox
=end
    def initialize(pos,width,height,text_color,z,text_limits)

        @shapeText = draw_text('',[pos[0]+5,pos[1]+10],'black',z+2,height/2,0,'bold')
        @shapeA = draw_rectangle(pos,width,height,'black',z)
        @shapeB = draw_rectangle(pos,width-5,height-5,'white',z+1)
        @text_limit = text_limits.to_i
    end


    #this function replace string for a new and delete the previous
    def update_text(str)
        self.shapeText.text = str
    end


    #this function add a character to the actual string
    def add_text(s)
        self.shapeText.text = self.shapeText.text + s
    end

    #delete the las element in the string
    def deletetext
        self.shapeText.text = self.shapeText.text.chop()
    end
    #clear the characters in the string
    def clear
        self.shapeText.text = ''
    end

    #Hide the textbox in the screen
    def hide
        self.shapeA.remove
        self.shapeB.remove
        self.shapeText.remove
    end

    #show the textbox in the screen
    def show
        self.shapeA.add
        self.shapeB.add
        self.shapeText.add
    end



    def selected(x,y)
        if shapeB.contains? x,y || shapeA.contains? x,y || shapeText.contains? x,y then
            true
        else
            false
        end

    end
end

set background: 'white'
set resizable: true
set diagnostics: true

a = TextBox.new([10,10],100,30,'blue',10,5)

=begin
    this code is complemetary for the textbox class the code below is an example
    to how to enable the keyboard interaction whit the textbox class, you can define
    the specific answer to any key.
    The code is an example to enable the text input in the textbox a , and delete the
    last element of the textbox if the user press the backspace key.
    but you can define your own protocol to the interaction with any key on the keyboard,
    only specifying the key you want selectbut you can define your own protocol to the
    interaction with any key on the keyboard, only specifying the key you want to select.
=end
on :key_down do |event|
    if a.text_limit != a.shapeText.text.length && event.key != 'backspace' then
        a.add_text(event.key.to_s)
    elsif event.key == 'backspace'
        a.deletetext
    end
end

show

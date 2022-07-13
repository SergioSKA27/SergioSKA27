require 'ruby2d'

#set the size of the window to 1280x720
set width: 1280, height: 720
set background: 'white'
set resizable: true
set diagnostics: true



#The Guiwindow class create a window with a title and a background color
#and contains an array of elements(this elements can be buttons, labels, etc).

class Guiwindow
    #create attr_accessor for the class
    attr_accessor :elements, :windowtitle, :sizeofwindow, :backgroundcolor, :positionofwindow

    def initialize(elements, windowtitle,sizeofwindow, backgroundcolor,positionofwindow)
        @elements = elements
        @windowtitle = windowtitle
        @sizeofwindow = sizeofwindow
        @backgroundcolor = backgroundcolor
        @positionofwindow = positionofwindow
    end

end

#define a scale function
def scale(x, in_min, in_max, out_min, out_max)
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end #end of scale function

=begin
    this module contains the functions to draw diferent figures
    using the ruby2d gem.(if you need more information about how
    this works visit https://www.ruby2d.com)
=end



# The above code is defining a module called Figures. The module contains functions that draw
# different shapes.
module Figures

   ##
   # It takes a string, a position, a color, a z-index, a size, a rotation, and a style, and returns a
   # Text object
   #
   # Args:
   #   text: The text to be drawn
   #   pos: The position of the text.
   #   color: The color of the text.
   #   z: The z-index of the text.
   #   size: The size of the text.
   #   rotate: The angle of rotation in degrees.
   #   style: :bold, :italic, :bold_italic, :normal
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


   ##
   # It takes a position, size, color, and z-index and draws a square
   #
   # Args:
   #   pos: The position of the square.
   #   size: size of the square
   #   color: The color of the square.
   #   z: z-index
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
            raise "Invalid argument in draw_square function\n"
       end
    end


   ##
   # It takes a position, width, height, color, and z-index and returns a rectangle object
   #
   # Args:
   #   pos: The position of the rectangle.
   #   width: width of the rectangle
   #   height: The height of the rectangle.
   #   color: The color of the rectangle.
   #   z: The z-index of the rectangle.
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

   ##
   # It takes a position, a radius, a color, a z-index, and the number of sectors to draw a circle
   #
   # Args:
   #   pos: The position of the circle.
   #   radius: The radius of the circle.
   #   color: The color of the circle.
   #   z: The z-index of the circle.
   #   sectors: The number of sectors to use to draw the circle. More sectors means a more accurate
   # circle, but at the expense of processing time.
    def draw_circle(pos,radius,color,z,sectors)

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
            Circle.new(radius: radius.to_i,
                x: position[0].to_i, y: position[1].to_i,
                color: color.to_s, z: z.to_i , sectors: sectors.to_i)
        rescue => exception
            raise "Invalid argument in draw_circle function\n"
        end

    end



end


=begin
    This class create a textbox of an specific size where the user can introduce some text
    this class is initialized with the position(x,y) passed as an array, the size of the
    textbox, the color of the text,the z index(check ruby2d documentation), and the limits
    of the length of the string inside the textbox.

    atributes description
    -shapeA : this shape is for create the first layer(you can set this shape to any color)
    -shapeB : this shape is for create the second layer(this shpe is the white shape, you
    can change the color but you need to consider the color of the textshape)
    -shapeText : this shape is for create the shape for the text(you can change the  color
    of the text, as the same way you can change the font(need the font file), the style of
    the text, and the orientantion)
    -text_limits : is the maximun length for a string in the current text
    -selected : help us to know if the textbox is selected by the user
    -key : is the specific identifier  for each textbox we want to create and make it easy to recongnize
=end
class TextBox
    #This class help us to create a textbox where the user can introduce text
    include Figures
    attr_accessor :shapeA,:shapeB, :shapeText
    attr_accessor :text_limit,:selected,:key


   ##
   # It creates a rectangle with a text box inside of it
   #
   # Args:
   #   pos: [x,y]
   #   width: width of the textbox
   #   height: The height of the text box
   #   text_color: The color of the text
   #   z: The z-index of the object.
   #   text_limits: The number of characters that can be entered into the textbox
   #   key: the key that will be used to identify the textbox
    def initialize(pos,width,height,text_color,z,text_limits,key)

        @shapeText = draw_text('',[pos[0]+5,pos[1]+10],'black',z+2,height/2,0,'bold')
        @shapeA = draw_rectangle(pos,width,height,'black',z)
        @shapeB = draw_rectangle(pos,width-5,height-5,'white',z+1)
        @text_limit = text_limits.to_i
        @selected = false
        self.key = key
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

    ##
    # If the mouse is clicked within the bounds of the shape, then return true, else return false
    #
    # Args:
    #   x: the x coordinate of the mouse click
    #   y: the y coordinate of the mouse click
    def is_selected(x,y)
        if shapeB.contains? x,y  or shapeA.contains? x,y or shapeText.contains? x,y then
            true
        else
            false
        end

    end

   ##
   # If the object is selected, then it is not selected. If the object is not selected, then it is
   # selected
    def select
        if self.selected
            @selected = false
        else
            @selected = true
        end
    end


end




#this is a color selector to choose a simple color or use the Hex Code to define it
class ColorSelector
    include Figures
    #this is a register of the custom color keys introduced by the user
    @@customcolork = []
    attr_accessor :key, :prinshape
    attr_accessor :navy , :aqua, :teal,:olive,:green, :lime, :yellow
    attr_accessor :orange, :red, :brown , :fuchsia,:purple, :maroon
    attr_accessor :white, :silver, :gray,:black,:hexcode
   ##
   # It creates a color picker
   #
   # Args:
   #   pos: the position of the top left corner of the color picker
   #   size: the size of the color picker
   #   colorwindow: the color of the window
   #   z: the z-index of the object
   #   key: the key that will be used to identify the color picker
    def initialize(pos,size,colorwindow,z,key)
        @prinshape = draw_square(pos,size,colorwindow,z)
        @key = key
        @navy = draw_square([pos[0]+(size/6),pos[1]+(size/6)],(size/8),'navy',z+1)
        @aqua = draw_square([pos[0]+(2*(size/6)),pos[1]+(size/6)],(size/8),'aqua',z+1)
        @teal = draw_square([pos[0]+(3*(size/6)),pos[1]+(size/6)],(size/8),'teal',z+1)
        @olive = draw_square([pos[0]+(4*(size/6)),pos[1]+(size/6)],(size/8),'olive',z+1)
        @green = draw_square([pos[0]+(5*(size/6)),pos[1]+(size/6)],(size/8),'green',z+1)

        @lime = draw_square([pos[0]+(size/6),pos[1]+(2*(size/6))],(size/8),'lime',z+1)
        @yellow = draw_square([pos[0]+(2*(size/6)),pos[1]+(2*(size/6))],(size/8),'yellow',z+1)
        @orange = draw_square([pos[0]+(3*(size/6)),pos[1]+(2*(size/6))],(size/8),'orange',z+1)
        @red = draw_square([pos[0]+(4*(size/6)),pos[1]+(2*(size/6))],(size/8),'red',z+1)
        @brown = draw_square([pos[0]+(5*(size/6)),pos[1]+(2*(size/6))],(size/8),'brown',z+1)

        @fuchsia = draw_square([pos[0]+(size/6),pos[1]+(3*(size/6))],(size/8),'fuchsia',z+1)
        @purple = draw_square([pos[0]+(2*(size/6)),pos[1]+(3*(size/6))],(size/8),'purple',z+1)
        @maroon = draw_square([pos[0]+(3*(size/6)),pos[1]+(3*(size/6))],(size/8),'maroon',z+1)
        @white = draw_square([pos[0]+(4*(size/6)),pos[1]+(3*(size/6))],(size/8),'white',z+1)
        @silver = draw_square([pos[0]+(5*(size/6)),pos[1]+(3*(size/6))],(size/8),'silver',z+1)

        @gray = draw_square([pos[0]+(size/6),pos[1]+(4*(size/6))],(size/8),'gray',z+1)
        @black = draw_square([pos[0]+(2*(size/6)),pos[1]+(4*(size/6))],(size/8),'black',z+1)

        @hexcode = TextBox.new([pos[0]+((size/6)),pos[1]+(5*(size/6))],(size/2),(size/8),'black',z+1,10,self.key.to_s + 'hexcode')





    end



   ##
   # If the user clicks on a color, return the color name
   #
   # Args:
   #   x: x-coordinate of the mouse click
   #   y: The y-coordinate of the mouse click
    def colorselcted(x,y)
        if self.navy.contains? x,y
            'navy'
        elsif self.aqua.contains? x,y
            'aqua'
        elsif self.teal.contains? x,y
            'teal'
        elsif self.olive.contains? x,y
            'olive'
        elsif self.green.contains? x,y
            'green'
        elsif self.lime.contains? x,y
            'lime'
        elsif self.yellow.contains? x,y
            'yellow'
        elsif self.orange.contains? x,y
            'orange'
        elsif self.red.contains? x,y
            'red'
        elsif self.brown.contains? x,y
            'brown'
        elsif self.fuchsia.contains? x,y
            'fuchsia'
        elsif self.purple.contains? x,y
            'purple'
        elsif self.maroon.contains? x,y
            'maroon'
        elsif self.white.contains? x,y
            'white'
        elsif self.silver.contains? x,y
            'silver'
        elsif self.gray.contains? x,y
            'gray'
        elsif self.black.contains? x,y
            'black'
        else
            nil
        end
    end
end


class Canvas
    include Figures
    attr_accessor :shapeA, :shapeB,:shapeincanvas
    attr_accessor :key

    ##
    # It creates a black square with a white square inside it
    #
    # Args:
    #   pos: the position of the square
    #   size: the size of the square
    #   key: the key that will be pressed to activate the button
    #   z: the z-index of the shape
    #   shape: the shape that is in the canvas
    def initialize(pos,size,key,z,shape)
        @shapeA =draw_square(pos,size,'black',z)
        @shapeB = draw_square(pos,size-5,'white',z+1)
        if shape != nil
        @shapeincanvas = shape.dup
        else
            @shapeincanvas = nil
        end
        @key = key
    end
end




c = ColorSelector.new([40,50], 250,'#9CCC65',10,'-colorselctor-')
can = Canvas.new([400,50],200,'canvas',10,nil)
#a = TextBox.new([80,50],250,50,'blue',10,5,'-txt1-')

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


# A Ruby2D event handler. It is called when a key is pressed.
on :key_down do |event|
    if c.hexcode.text_limit != c.hexcode.shapeText.text.length && event.key != 'backspace' && c.hexcode.selected then
        c.hexcode.add_text(event.key.to_s)
    elsif event.key == 'backspace' && c.hexcode.selected
        c.hexcode.deletetext
    end
end


# A Ruby2D event handler. It is called when a mouse button is pressed.
on :mouse_down do |event|
    # x and y coordinates of the mouse button event
    puts event.x, event.y

    # Read the button event
    case event.button
    when :left
        if c.hexcode.is_selected event.x, event.y
            c.hexcode.select
        end
        x = c.colorselcted event.x, event.y
        if x != nil
            puts x
        end
    when :middle
      # Middle mouse button pressed down
    when :right
      # Right mouse button pressed down
    end
end

show

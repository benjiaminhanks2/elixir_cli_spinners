defmodule CliSpinners do
  alias CliSpinners.Spinner
  @moduledoc """
  Documentation for CliSpinners.
  CliSpinners are nothing more like a loading animation in the command line     
  interface.                

  This module comes with different flavours of loadinl. The following is the        
  list of flavours you can pass
  
  # Loading Flavors        

  ### dots
  The dots  flavor comes with **12** combnations of loading animations.      
  From `dots` to `dots12`. There is no `dots1`. Here `dots1` is written      
  as just `dots`

  ### line
  Line comes with two combinations          
  > line line2

  ### pipe
  > pipe

  ### simple_dots
  > simple_dots  simple_dots_scrolling

  ### star
  > star  star2

  ### flip
  > flip
  ### hamburger
  > hamburger
  ### hamburger
  > hamburger
  ### grow
  > grow
  This grow format comes in two flavors           
  > `grow_vertical` `grow_horizontal`

  ### balloon
  > `balloon` `balloon2`
  ### noise
  > noise
  ### bounce
  > bounce
  ### box_bounce
  > `box_bounce` `box_bounce`
  ### Geometry
  > `triangle` `circle` `arc` `circle` `circle_quarters` `square_corners` `circle_halves`
  ### squish
  > squish
  ### toggle
  > toggle
  This **toggle** flavor comes in 13 flavors          

  > toggle toggle1 toggle2 ..... toggle13
  ### arrow
  This comes with 3 flavors
  > arrow arrow2 arrow3
  
  ### bouncing
  > bouncing_bar bouncing_ball

  ### smiley
  > smiley
  ### mokey
  > mokey
  ### hearts
  > hearts
  ### clock
  > clock
  ### earth
  > earth
  ### moon
  > moon
  ### pong
  > pong
  ### runner
  > runner
  ### shark
  > shark
  ### dqpb
  > dqpb

  """

  @doc ~S"""
  This is the default spinning function. It spins the default **line** spin.              
  for three seconds.
  After three secnods it stops spinning

  ##  Examples
       iex> CliSpinners.spin
  """
  def spin do
    CliSpinners.Spinner.render(fun())
  end

  @doc ~S"""
  This definition will spin the given animation for three seconds. The option               
  should be passed as either **atom** or **List** of frames but not both to be animated.

  There is another option here if you pass the **time** in milliseconds then it will        
  repeat the spinning of default animation up to the given interval of time

  ##  Examples

      iex> CliSpinners.spin :dots
      iex> CliSpinners.spin :dots12
      iex> ClisSpinner.spin(["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"])
      iex> CliSpinners.spin 5000

  """
  def spin(theme) when is_atom(theme) do
    Spinner.render([frames: theme],fun())
  end

  def spin(time) when is_integer(time) do
    Spinner.render(fun(time))
  end

  @doc ~S"""
  This is used to render the given animation for given interval time. You need             
  to pass two params. The first one is **atom** Name of the theme of the frames   
  and second is time in milli seconds.
  """
  def spin(theme,time) do
    CliSpinners.Spinner.render([frames: theme],fun(time))
  end
  
  @doc ~S"""
  This definition is used to run the animation until the function execution is over.
  How ever you can pass the **text** to be displayed while spinng the animation and end       
  of the animation.          

  The configuration is optional here. By default the text is `Loading...` while spinnig    
  and `Loaded.`

  The configuration is the list of key-value pair items.     

  ```elixir

    frames: :line,         # This theme is set when no theme is set 
    spinner_color: [],     # The color code of the spinner
    text: "Loading…",      # The prefix text of the spinner
    done: "Loaded.",       # This text prints after ending the apinning
    interval: 100,         # This is the default time interval used to render

  ```

  If you do no pass the cofiguration the above default configuration is used but      
  you suppose to be passing the function parameter, which is not optional.

  ##   Examples
        iex> CliSpinners.spin_fun([text: "loading_text_here",done: "end_text_here"],fn -> :timer.slee(5000) end)

  """

  def spin_fun(config \\ :default,function) do
    case config do
      :default -> 
        CliSpinners.Spinner.render ( function )
      conf when is_list(conf) ->
        CliSpinners.Spinner.render(config,function)
      _ -> IO.puts "Miss Matching the Configurations"
    end
  end

  @doc ~S"""
  This shows all the avilable spinning animatios for 2 seconds each  along its name.       
  It takes almost 2 min time for the demo .....require
  How ever you can break that by pressing the `Ctrl + C` for two times.
  """
  def demo do
    functions = CliSpinners.Spinners.__info__(:functions)
    for {fun_name,_} <- functions do 
      IO.write Atom.to_string fun_name
      spin(fun_name,2000)
    end
  end

  defp fun do
    fn -> :time.sleep(3000) end
  end

  defp fun(time) do
    fn -> :timer.sleep(time) end
  end
end

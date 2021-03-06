module Sass::Script
  # Methods in this module are accessible from the SassScript context.
  # For example, you can write
  #
  #     $color: hsl(120deg, 100%, 50%)
  #
  # and it will call {Sass::Script::Functions#hsl}.
  #
  # The following functions are provided:
  #
  # *Note: These functions are described in more detail below.*
  #
  # ## RGB Functions
  #
  # \{#rgb rgb($red, $green, $blue)}
  # : Creates a {Color} from red, green, and blue values.
  #
  # \{#rgba rgba($red, $green, $blue, $alpha)}
  # : Creates a {Color} from red, green, blue, and alpha values.
  #
  # \{#red red($color)}
  # : Gets the red component of a color.
  #
  # \{#green green($color)}
  # : Gets the green component of a color.
  #
  # \{#blue blue($color)}
  # : Gets the blue component of a color.
  #
  # \{#mix mix($color-1, $color-2, \[$weight\])}
  # : Mixes two colors together.
  #
  # ## HSL Functions
  #
  # \{#hsl hsl($hue, $saturation, $lightness)}
  # : Creates a {Color} from hue, saturation, and lightness values.
  #
  # \{#hsla hsla($hue, $saturation, $lightness, $alpha)}
  # : Creates a {Color} from hue, saturation, lightness, lightness, and alpha
  #   values.
  #
  # \{#hue hue($color)}
  # : Gets the hue component of a color.
  #
  # \{#saturation saturation($color)}
  # : Gets the saturation component of a color.
  #
  # \{#lightness lightness($color)}
  # : Gets the lightness component of a color.
  #
  # \{#adjust_hue adjust-hue($color, $degrees)}
  # : Changes the hue of a color.
  #
  # \{#lighten lighten($color, $amount)}
  # : Makes a color lighter.
  #
  # \{#darken darken($color, $amount)}
  # : Makes a color darker.
  #
  # \{#saturate saturate($color, $amount)}
  # : Makes a color more saturated.
  #
  # \{#desaturate desaturate($color, $amount)}
  # : Makes a color less saturated.
  #
  # \{#grayscale grayscale($color)}
  # : Converts a color to grayscale.
  #
  # \{#complement complement($color)}
  # : Returns the complement of a color.
  #
  # \{#invert invert($color)}
  # : Returns the inverse of a color.
  #
  # ## Opacity Functions
  #
  # \{#alpha alpha($color)} / \{#opacity opacity($color)}
  # : Gets the alpha component (opacity) of a color.
  #
  # \{#rgba rgba($color, $alpha)}
  # : Changes the alpha component for a color.
  #
  # \{#opacify opacify($color, $amount)} / \{#fade_in fade-in($color, $amount)}
  # : Makes a color more opaque.
  #
  # \{#transparentize transparentize($color, $amount)} / \{#fade_out fade-out($color, $amount)}
  # : Makes a color more transparent.
  #
  # ## Other Color Functions
  #
  # \{#adjust_color adjust-color($color, \[$red\], \[$green\], \[$blue\], \[$hue\], \[$saturation\], \[$lightness\], \[$alpha\])}
  # : Increases or decreases one or more components of a color.
  #
  # \{#scale_color scale-color($color, \[$red\], \[$green\], \[$blue\], \[$saturation\], \[$lightness\], \[$alpha\])}
  # : Fluidly scales one or more properties of a color.
  #
  # \{#change_color change-color($color, \[$red\], \[$green\], \[$blue\], \[$hue\], \[$saturation\], \[$lightness\], \[$alpha\])}
  # : Changes one or more properties of a color.
  #
  # \{#ie_hex_str ie-hex-str($color)}
  # : Converts a color into the format understood by IE filters.
  #
  # ## String Functions
  #
  # \{#unquote unquote($string)}
  # : Removes quotes from a string.
  #
  # \{#quote quote($string)}
  # : Adds quotes to a string.
  #
  # ## Number Functions
  #
  # \{#percentage percentage($value)}
  # : Converts a unitless number to a percentage.
  #
  # \{#round round($value)}
  # : Rounds a number to the nearest whole number.
  #
  # \{#ceil ceil($value)}
  # : Rounds a number up to the next whole number.
  #
  # \{#floor floor($value)}
  # : Rounds a number down to the previous whole number.
  #
  # \{#abs abs($value)}
  # : Returns the absolute value of a number.
  #
  # \{#min min($numbers...)\}
  # : Finds the minimum of several numbers.
  #
  # \{#max max($numbers...)\}
  # : Finds the maximum of several numbers.
  #
  # ## List Functions {#list-functions}
  #
  # \{#length length($list)}
  # : Returns the length of a list.
  #
  # \{#nth nth($list, $n)}
  # : Returns a specific item in a list.
  #
  # \{#join join($list1, $list2, \[$separator\])}
  # : Joins together two lists into one.
  #
  # \{#append append($list1, $val, \[$separator\])}
  # : Appends a single value onto the end of a list.
  #
  # \{#zip zip($lists...)}
  # : Combines several lists into a single multidimensional list.
  #
  # \{#index index($list, $value)}
  # : Returns the position of a value within a list.
  #
  # ## Introspection Functions
  #
  # \{#type_of type-of($value)}
  # : Returns the type of a value.
  #
  # \{#unit unit($number)}
  # : Returns the unit(s) associated with a number.
  #
  # \{#unitless unitless($number)}
  # : Returns whether a number has units.
  #
  # \{#comparable comparable($number-1, $number-2)}
  # : Returns whether two numbers can be added, subtracted, or compared.
  #
  # ## Miscellaneous Functions
  #
  # \{#if if($condition, $if-true, $if-false)}
  # : Returns one of two values, depending on whether or not `$condition` is
  #   true.
  #
  # ## Adding Custom Functions
  #
  # New Sass functions can be added by adding Ruby methods to this module.
  # For example:
  #
  #     module Sass::Script::Functions
  #       def reverse(string)
  #         assert_type string, :String
  #         Sass::Script::String.new(string.value.reverse)
  #       end
  #       declare :reverse, :args => [:string]
  #     end
  #
  # Calling {declare} tells Sass the argument names for your function.
  # If omitted, the function will still work, but will not be able to accept keyword arguments.
  # {declare} can also allow your function to take arbitrary keyword arguments.
  #
  # There are a few things to keep in mind when modifying this module.
  # First of all, the arguments passed are {Sass::Script::Literal} objects.
  # Literal objects are also expected to be returned.
  # This means that Ruby values must be unwrapped and wrapped.
  #
  # Most Literal objects support the {Sass::Script::Literal#value value} accessor
  # for getting their Ruby values.
  # Color objects, though, must be accessed using {Sass::Script::Color#rgb rgb},
  # {Sass::Script::Color#red red}, {Sass::Script::Color#blue green}, or {Sass::Script::Color#blue blue}.
  #
  # Second, making Ruby functions accessible from Sass introduces the temptation
  # to do things like database access within stylesheets.
  # This is generally a bad idea;
  # since Sass files are by default only compiled once,
  # dynamic code is not a great fit.
  #
  # If you really, really need to compile Sass on each request,
  # first make sure you have adequate caching set up.
  # Then you can use {Sass::Engine} to render the code,
  # using the {file:SASS_REFERENCE.md#custom-option `options` parameter}
  # to pass in data that {EvaluationContext#options can be accessed}
  # from your Sass functions.
  #
  # Within one of the functions in this module,
  # methods of {EvaluationContext} can be used.
  #
  # ### Caveats
  #
  # When creating new {Literal} objects within functions,
  # be aware that it's not safe to call {Literal#to_s #to_s}
  # (or other methods that use the string representation)
  # on those objects without first setting {Node#options= the #options attribute}.
  module Functions
    @signatures = {}

    # A class representing a Sass function signature.
    #
    # @attr args [Array<Symbol>] The names of the arguments to the function.
    # @attr var_args [Boolean] Whether the function takes a variable number of arguments.
    # @attr var_kwargs [Boolean] Whether the function takes an arbitrary set of keyword arguments.
    Signature = Struct.new(:args, :var_args, :var_kwargs)

    # Declare a Sass signature for a Ruby-defined function.
    # This includes the names of the arguments,
    # whether the function takes a variable number of arguments,
    # and whether the function takes an arbitrary set of keyword arguments.
    #
    # It's not necessary to declare a signature for a function.
    # However, without a signature it won't support keyword arguments.
    #
    # A single function can have multiple signatures declared
    # as long as each one takes a different number of arguments.
    # It's also possible to declare multiple signatures
    # that all take the same number of arguments,
    # but none of them but the first will be used
    # unless the user uses keyword arguments.
    #
    # @example
    #   declare :rgba, [:hex, :alpha]
    #   declare :rgba, [:red, :green, :blue, :alpha]
    #   declare :accepts_anything, [], :var_args => true, :var_kwargs => true
    #   declare :some_func, [:foo, :bar, :baz], :var_kwargs => true
    #
    # @param method_name [Symbol] The name of the method
    #   whose signature is being declared.
    # @param args [Array<Symbol>] The names of the arguments for the function signature.
    # @option options :var_args [Boolean] (false)
    #   Whether the function accepts a variable number of (unnamed) arguments
    #   in addition to the named arguments.
    # @option options :var_kwargs [Boolean] (false)
    #   Whether the function accepts other keyword arguments
    #   in addition to those in `:args`.
    #   If this is true, the Ruby function will be passed a hash from strings
    #   to {Sass::Script::Literal}s as the last argument.
    #   In addition, if this is true and `:var_args` is not,
    #   Sass will ensure that the last argument passed is a hash.
    def self.declare(method_name, args, options = {})
      @signatures[method_name] ||= []
      @signatures[method_name] << Signature.new(
        args.map {|s| s.to_s},
        options[:var_args],
        options[:var_kwargs])
    end

    # Determine the correct signature for the number of arguments
    # passed in for a given function.
    # If no signatures match, the first signature is returned for error messaging.
    #
    # @param method_name [Symbol] The name of the Ruby function to be called.
    # @param arg_arity [Number] The number of unnamed arguments the function was passed.
    # @param kwarg_arity [Number] The number of keyword arguments the function was passed.
    #
    # @return [{Symbol => Object}, nil]
    #   The signature options for the matching signature,
    #   or nil if no signatures are declared for this function. See {declare}.
    def self.signature(method_name, arg_arity, kwarg_arity)
      return unless @signatures[method_name]
      @signatures[method_name].each do |signature|
        return signature if signature.args.size == arg_arity + kwarg_arity
        next unless signature.args.size < arg_arity + kwarg_arity

        # We have enough args.
        # Now we need to figure out which args are varargs
        # and if the signature allows them.
        t_arg_arity, t_kwarg_arity = arg_arity, kwarg_arity
        if signature.args.size > t_arg_arity
          # we transfer some kwargs arity to args arity
          # if it does not have enough args -- assuming the names will work out.
          t_kwarg_arity -= (signature.args.size - t_arg_arity)
          t_arg_arity = signature.args.size
        end

        if (  t_arg_arity == signature.args.size ||   t_arg_arity > signature.args.size && signature.var_args  ) &&
           (t_kwarg_arity == 0                   || t_kwarg_arity > 0                   && signature.var_kwargs)
          return signature
        end
      end
      @signatures[method_name].first
    end

    # The context in which methods in {Script::Functions} are evaluated.
    # That means that all instance methods of {EvaluationContext}
    # are available to use in functions.
    class EvaluationContext
      include Functions

      # The options hash for the {Sass::Engine} that is processing the function call
      #
      # @return [{Symbol => Object}]
      attr_reader :options

      # @param options [{Symbol => Object}] See \{#options}
      def initialize(options)
        @options = options
      end

      # Asserts that the type of a given SassScript value
      # is the expected type (designated by a symbol).
      #
      # Valid types are `:Bool`, `:Color`, `:Number`, and `:String`.
      # Note that `:String` will match both double-quoted strings
      # and unquoted identifiers.
      #
      # @example
      #   assert_type value, :String
      #   assert_type value, :Number
      # @param value [Sass::Script::Literal] A SassScript value
      # @param type [Symbol] The name of the type the value is expected to be
      # @param name [String, Symbol, nil] The name of the argument.
      def assert_type(value, type, name = nil)
        return if value.is_a?(Sass::Script.const_get(type))
        err = "#{value.inspect} is not a #{type.to_s.downcase}"
        err = "$#{name.to_s.gsub('_', '-')}: " + err if name
        raise ArgumentError.new(err)
      end
    end

    class << self
      # Returns whether user function with a given name exists.
      #
      # @param function_name [String]
      # @return [Boolean]
      alias_method :callable?, :public_method_defined?

      private
      def include(*args)
        r = super
        # We have to re-include ourselves into EvaluationContext to work around
        # an icky Ruby restriction.
        EvaluationContext.send :include, self
        r
      end
    end

    # Creates a {Color} object from red, green, and blue values.
    #
    # @see #rgba
    # @overload rgb($red, $green, $blue)
    # @param $red [Number] The amount of red in the color. Must be between 0 and
    #   255 inclusive, or between `0%` and `100%` inclusive
    # @param $green [Number] The amount of green in the color. Must be between 0
    #   and 255 inclusive, or between `0%` and `100%` inclusive
    # @param $blue [Number] The amount of blue in the color. Must be between 0
    #   and 255 inclusive, or between `0%` and `100%` inclusive
    # @return [Color]
    # @raise [ArgumentError] if any parameter is the wrong type or out of bounds
    def rgb(red, green, blue)
      assert_type red, :Number, :red
      assert_type green, :Number, :green
      assert_type blue, :Number, :blue

      Color.new([[red, :red], [green, :green], [blue, :blue]].map do |(c, name)|
          v = c.value
          if c.numerator_units == ["%"] && c.denominator_units.empty?
            v = Sass::Util.check_range("$#{name}: Color value", 0..100, c, '%')
            v * 255 / 100.0
          else
            Sass::Util.check_range("$#{name}: Color value", 0..255, c)
          end
        end)
    end
    declare :rgb, [:red, :green, :blue]

    # Creates a {Color} from red, green, blue, and alpha values.
    # @see #rgb
    #
    # @overload rgba($red, $green, $blue, $alpha)
    #   @param $red [Number] The amount of red in the color. Must be between 0
    #     and 255 inclusive
    #   @param $green [Number] The amount of green in the color. Must be between
    #     0 and 255 inclusive
    #   @param $blue [Number] The amount of blue in the color. Must be between 0
    #     and 255 inclusive
    #   @param $alpha [Number] The opacity of the color. Must be between 0 and 1
    #     inclusive
    #   @return [Color]
    #   @raise [ArgumentError] if any parameter is the wrong type or out of
    #     bounds
    #
    # @overload rgba($color, $alpha)
    #   Sets the opacity of an existing color.
    #
    #   @example
    #     rgba(#102030, 0.5) => rgba(16, 32, 48, 0.5)
    #     rgba(blue, 0.2)    => rgba(0, 0, 255, 0.2)
    #
    #   @param $color [Color] The color whose opacity will be changed.
    #   @param $alpha [Number] The new opacity of the color. Must be between 0
    #     and 1 inclusive
    #   @return [Color]
    #   @raise [ArgumentError] if `$alpha` is out of bounds or either parameter
    #     is the wrong type
    def rgba(*args)
      case args.size
      when 2
        color, alpha = args

        assert_type color, :Color, :color
        assert_type alpha, :Number, :alpha

        Sass::Util.check_range('Alpha channel', 0..1, alpha)
        color.with(:alpha => alpha.value)
      when 4
        red, green, blue, alpha = args
        rgba(rgb(red, green, blue), alpha)
      else
        raise ArgumentError.new("wrong number of arguments (#{args.size} for 4)")
      end
    end
    declare :rgba, [:red, :green, :blue, :alpha]
    declare :rgba, [:color, :alpha]

    # Creates a {Color} from hue, saturation, and lightness values. Uses the
    # algorithm from the [CSS3 spec][].
    #
    # [CSS3 spec]: http://www.w3.org/TR/css3-color/#hsl-color
    #
    # @see #hsla
    # @overload hsl($hue, $saturation, $lightness)
    # @param $hue [Number] The hue of the color. Should be between 0 and 360
    #   degrees, inclusive
    # @param $saturation [Number] The saturation of the color. Must be between
    #   `0%` and `100%`, inclusive
    # @param $lightness [Number] The lightness of the color. Must be between
    #   `0%` and `100%`, inclusive
    # @return [Color]
    # @raise [ArgumentError] if `$saturation` or `$lightness` are out of bounds
    #   or any parameter is the wrong type
    def hsl(hue, saturation, lightness)
      hsla(hue, saturation, lightness, Number.new(1))
    end
    declare :hsl, [:hue, :saturation, :lightness]

    # Creates a {Color} from hue, saturation, lightness, lightness, and alpha
    # values. Uses the algorithm from the [CSS3 spec][].
    #
    # [CSS3 spec]: http://www.w3.org/TR/css3-color/#hsl-color
    #
    # @see #hsl
    # @overload hsla($hue, $saturation, $lightness, $alpha)
    # @param $hue [Number] The hue of the color. Should be between 0 and 360
    #   degrees, inclusive
    # @param $saturation [Number] The saturation of the color. Must be between
    #   `0%` and `100%`, inclusive
    # @param $lightness [Number] The lightness of the color. Must be between
    #   `0%` and `100%`, inclusive
    # @param $alpha [Number] The opacity of the color. Must be between 0 and 1,
    #   inclusive
    # @return [Color]
    # @raise [ArgumentError] if `$saturation`, `$lightness`, or `$alpha` are out
    #   of bounds or any parameter is the wrong type
    def hsla(hue, saturation, lightness, alpha)
      assert_type hue, :Number, :hue
      assert_type saturation, :Number, :saturation
      assert_type lightness, :Number, :lightness
      assert_type alpha, :Number, :alpha

      Sass::Util.check_range('Alpha channel', 0..1, alpha)

      h = hue.value
      s = Sass::Util.check_range('Saturation', 0..100, saturation, '%')
      l = Sass::Util.check_range('Lightness', 0..100, lightness, '%')

      Color.new(:hue => h, :saturation => s, :lightness => l, :alpha => alpha.value)
    end
    declare :hsla, [:hue, :saturation, :lightness, :alpha]

    # Gets the red component of a color. Calculated from HSL where necessary via
    # [this algorithm][hsl-to-rgb].
    #
    # [hsl-to-rgb]: http://www.w3.org/TR/css3-color/#hsl-color
    #
    # @overload red($color)
    # @param $color [Color]
    # @return [Number] The red component, between 0 and 255 inclusive
    # @raise [ArgumentError] if `$color` isn't a color
    def red(color)
      assert_type color, :Color, :color
      Sass::Script::Number.new(color.red)
    end
    declare :red, [:color]

    # Gets the green component of a color. Calculated from HSL where necessary
    # via [this algorithm][hsl-to-rgb].
    #
    # [hsl-to-rgb]: http://www.w3.org/TR/css3-color/#hsl-color
    #
    # @overload green($color)
    # @param $color [Color]
    # @return [Number] The green component, between 0 and 255 inclusive
    # @raise [ArgumentError] if `$color` isn't a color
    def green(color)
      assert_type color, :Color, :color
      Sass::Script::Number.new(color.green)
    end
    declare :green, [:color]

    # Gets the blue component of a color. Calculated from HSL where necessary
    # via [this algorithm][hsl-to-rgb].
    #
    # [hsl-to-rgb]: http://www.w3.org/TR/css3-color/#hsl-color
    #
    # @overload blue($color)
    # @param $color [Color]
    # @return [Number] The blue component, between 0 and 255 inclusive
    # @raise [ArgumentError] if `$color` isn't a color
    def blue(color)
      assert_type color, :Color, :color
      Sass::Script::Number.new(color.blue)
    end
    declare :blue, [:color]

    # Returns the hue component of a color. See [the CSS3 HSL
    # specification][hsl]. Calculated from RGB where necessary via [this
    # algorithm][rgb-to-hsl].
    #
    # [hsl]: http://en.wikipedia.org/wiki/HSL_and_HSV#Conversion_from_RGB_to_HSL_or_HSV
    # [rgb-to-hsl]: http://en.wikipedia.org/wiki/HSL_and_HSV#Conversion_from_RGB_to_HSL_or_HSV
    #
    # @overload hue($color)
    # @param $color [Color]
    # @return [Number] The hue component, between 0deg and 360deg
    # @raise [ArgumentError] if `$color` isn't a color
    def hue(color)
      assert_type color, :Color, :color
      Sass::Script::Number.new(color.hue, ["deg"])
    end
    declare :hue, [:color]

    # Returns the saturation component of a color. See [the CSS3 HSL
    # specification][hsl]. Calculated from RGB where necessary via [this
    # algorithm][rgb-to-hsl].
    #
    # [hsl]: http://en.wikipedia.org/wiki/HSL_and_HSV#Conversion_from_RGB_to_HSL_or_HSV
    # [rgb-to-hsl]: http://en.wikipedia.org/wiki/HSL_and_HSV#Conversion_from_RGB_to_HSL_or_HSV
    #
    # @overload saturation($color)
    # @param $color [Color]
    # @return [Number] The saturation component, between 0% and 100%
    # @raise [ArgumentError] if `$color` isn't a color
    def saturation(color)
      assert_type color, :Color, :color
      Sass::Script::Number.new(color.saturation, ["%"])
    end
    declare :saturation, [:color]

    # Returns the lightness component of a color. See [the CSS3 HSL
    # specification][hsl]. Calculated from RGB where necessary via [this
    # algorithm][rgb-to-hsl].
    #
    # [hsl]: http://en.wikipedia.org/wiki/HSL_and_HSV#Conversion_from_RGB_to_HSL_or_HSV
    # [rgb-to-hsl]: http://en.wikipedia.org/wiki/HSL_and_HSV#Conversion_from_RGB_to_HSL_or_HSV
    #
    # @overload lightness($color)
    # @param $color [Color]
    # @return [Number] The lightness component, between 0% and 100%
    # @raise [ArgumentError] if `$color` isn't a color
    def lightness(color)
      assert_type color, :Color, :color
      Sass::Script::Number.new(color.lightness, ["%"])
    end
    declare :lightness, [:color]

    # Returns the alpha component (opacity) of a color. This is 1 unless
    # otherwise specified.
    #
    # This function also supports the proprietary Microsoft `alpha(opacity=20)`
    # syntax as a special case.
    #
    # @overload alpha($color)
    # @param $color [Color]
    # @return [Number] The alpha component, between 0 and 1
    # @raise [ArgumentError] if `$color` isn't a color
    def alpha(*args)
      if args.all? do |a|
          a.is_a?(Sass::Script::String) && a.type == :identifier &&
            a.value =~ /^[a-zA-Z]+\s*=/
        end
        # Support the proprietary MS alpha() function
        return Sass::Script::String.new("alpha(#{args.map {|a| a.to_s}.join(", ")})")
      end

      raise ArgumentError.new("wrong number of arguments (#{args.size} for 1)") if args.size != 1

      assert_type args.first, :Color, :color
      Sass::Script::Number.new(args.first.alpha)
    end
    declare :alpha, [:color]

    # Returns the alpha component (opacity) of a color. This is 1 unless
    # otherwise specified.
    #
    # @overload opacity($color)
    # @param $color [Color]
    # @return [Number] The alpha component, between 0 and 1
    # @raise [ArgumentError] if `$color` isn't a color
    def opacity(color)
      return Sass::Script::String.new("opacity(#{color})") if color.is_a?(Sass::Script::Number)
      assert_type color, :Color, :color
      Sass::Script::Number.new(color.alpha)
    end
    declare :opacity, [:color]

    # Makes a color more opaque. Takes a color and a number between 0 and 1, and
    # returns a color with the opacity increased by that amount.
    #
    # @see #transparentize
    # @example
    #   opacify(rgba(0, 0, 0, 0.5), 0.1) => rgba(0, 0, 0, 0.6)
    #   opacify(rgba(0, 0, 17, 0.8), 0.2) => #001
    # @overload opacify($color, $amount)
    # @param $color [Color]
    # @param $amount [Number] The amount to increase the opacity by, between 0
    #   and 1
    # @return [Color]
    # @raise [ArgumentError] if `$amount` is out of bounds, or either parameter
    #   is the wrong type
    def opacify(color, amount)
      _adjust(color, amount, :alpha, 0..1, :+)
    end
    declare :opacify, [:color, :amount]

    alias_method :fade_in, :opacify
    declare :fade_in, [:color, :amount]

    # Makes a color more transparent. Takes a color and a number between 0 and
    # 1, and returns a color with the opacity decreased by that amount.
    #
    # @see #opacify
    # @example
    #   transparentize(rgba(0, 0, 0, 0.5), 0.1) => rgba(0, 0, 0, 0.4)
    #   transparentize(rgba(0, 0, 0, 0.8), 0.2) => rgba(0, 0, 0, 0.6)
    # @overload transparentize($color, $amount)
    # @param $color [Color]
    # @param $amount [Number] The amount to decrease the opacity by, between 0
    #   and 1
    # @return [Color]
    # @raise [ArgumentError] if `$amount` is out of bounds, or either parameter
    #   is the wrong type
    def transparentize(color, amount)
      _adjust(color, amount, :alpha, 0..1, :-)
    end
    declare :transparentize, [:color, :amount]

    alias_method :fade_out, :transparentize
    declare :fade_out, [:color, :amount]

    # Makes a color lighter. Takes a color and a number between `0%` and `100%`,
    # and returns a color with the lightness increased by that amount.
    #
    # @see #darken
    # @example
    #   lighten(hsl(0, 0%, 0%), 30%) => hsl(0, 0, 30)
    #   lighten(#800, 20%) => #e00
    # @overload lighten($color, $amount)
    # @param $color [Color]
    # @param $amount [Number] The amount to increase the lightness by, between
    #   `0%` and `100%`
    # @return [Color]
    # @raise [ArgumentError] if `$amount` is out of bounds, or either parameter
    #   is the wrong type
    def lighten(color, amount)
      _adjust(color, amount, :lightness, 0..100, :+, "%")
    end
    declare :lighten, [:color, :amount]

    # Makes a color darker. Takes a color and a number between 0% and 100%, and
    # returns a color with the lightness decreased by that amount.
    #
    # @see #lighten
    # @example
    #   darken(hsl(25, 100%, 80%), 30%) => hsl(25, 100%, 50%)
    #   darken(#800, 20%) => #200
    # @overload darken($color, $amount)
    # @param $color [Color]
    # @param $amount [Number] The amount to dencrease the lightness by, between
    #   `0%` and `100%`
    # @return [Color]
    # @raise [ArgumentError] if `$amount` is out of bounds, or either parameter
    #   is the wrong type
    def darken(color, amount)
      _adjust(color, amount, :lightness, 0..100, :-, "%")
    end
    declare :darken, [:color, :amount]

    # Makes a color more saturated. Takes a color and a number between 0% and
    # 100%, and returns a color with the saturation increased by that amount.
    #
    # @see #desaturate
    # @example
    #   saturate(hsl(120, 30%, 90%), 20%) => hsl(120, 50%, 90%)
    #   saturate(#855, 20%) => #9e3f3f
    # @overload saturate($color, $amount)
    # @param $color [Color]
    # @param $amount [Number] The amount to increase the saturation by, between
    #   `0%` and `100%`
    # @return [Color]
    # @raise [ArgumentError] if `$amount` is out of bounds, or either parameter
    #   is the wrong type
    def saturate(color, amount = nil)
      # Support the filter effects definition of saturate.
      # https://dvcs.w3.org/hg/FXTF/raw-file/tip/filters/index.html
      return Sass::Script::String.new("saturate(#{color})") if amount.nil?
      _adjust(color, amount, :saturation, 0..100, :+, "%")
    end
    declare :saturate, [:color, :amount]
    declare :saturate, [:amount]

    # Makes a color less saturated. Takes a color and a number between 0% and
    # 100%, and returns a color with the saturation decreased by that value.
    #
    # @see #saturate
    # @example
    #   desaturate(hsl(120, 30%, 90%), 20%) => hsl(120, 10%, 90%)
    #   desaturate(#855, 20%) => #726b6b
    # @overload desaturate($color, $amount)
    # @param $color [Color]
    # @param $amount [Number] The amount to decrease the saturation by, between
    #   `0%` and `100%`
    # @return [Color]
    # @raise [ArgumentError] if `$amount` is out of bounds, or either parameter
    #   is the wrong type
    def desaturate(color, amount)
      _adjust(color, amount, :saturation, 0..100, :-, "%")
    end
    declare :desaturate, [:color, :amount]

    # Changes the hue of a color. Takes a color and a number of degrees (usually
    # between `-360deg` and `360deg`), and returns a color with the hue rotated
    # along the color wheel by that amount.
    #
    # @example
    #   adjust-hue(hsl(120, 30%, 90%), 60deg) => hsl(180, 30%, 90%)
    #   adjust-hue(hsl(120, 30%, 90%), 060deg) => hsl(60, 30%, 90%)
    #   adjust-hue(#811, 45deg) => #886a11
    # @overload adjust_hue($color, $degrees)
    # @param $color [Color]
    # @param $degrees [Number] The number of degrees to rotate the hue
    # @return [Color]
    # @raise [ArgumentError] if either parameter is the wrong type
    def adjust_hue(color, degrees)
      assert_type color, :Color, :color
      assert_type degrees, :Number, :degrees
      color.with(:hue => color.hue + degrees.value)
    end
    declare :adjust_hue, [:color, :degrees]

    # Converts a color into the format understood by IE filters.
    #
    # @example
    #   ie-hex-str(#abc) => #FFAABBCC
    #   ie-hex-str(#3322BB) => #FF3322BB
    #   ie-hex-str(rgba(0, 255, 0, 0.5)) => #8000FF00
    # @overload ie_hex_str($color)
    # @param $color [Color]
    # @return [String] The IE-formatted string representation of the color
    # @raise [ArgumentError] if `$color` isn't a color
    def ie_hex_str(color)
      assert_type color, :Color, :color
      alpha = (color.alpha * 255).round.to_s(16).rjust(2, '0')
      Sass::Script::String.new("##{alpha}#{color.send(:hex_str)[1..-1]}".upcase)
    end
    declare :ie_hex_str, [:color]

    # Increases or decreases one or more properties of a color. This can change
    # the red, green, blue, hue, saturation, value, and alpha properties. The
    # properties are specified as keyword arguments, and are added to or
    # subtracted from the color's current value for that property.
    #
    # All properties are optional. You can't specify both RGB properties
    # (`$red`, `$green`, `$blue`) and HSL properties (`$hue`, `$saturation`,
    # `$value`) at the same time.
    #
    # @example
    #   adjust-color(#102030, $blue: 5) => #102035
    #   adjust-color(#102030, $red: -5, $blue: 5) => #0b2035
    #   adjust-color(hsl(25, 100%, 80%), $lightness: -30%, $alpha: -0.4) => hsla(25, 100%, 50%, 0.6)
    # @overload adjust_color($color, [$red], [$green], [$blue], [$hue], [$saturation], [$lightness], [$alpha])
    # @param $color [Color]
    # @param $red [Number] The adjustment to make on the red component, between
    #   -255 and 255 inclusive
    # @param $green [Number] The adjustment to make on the green component,
    #   between -255 and 255 inclusive
    # @param $blue [Number] The adjustment to make on the blue component, between
    #   -255 and 255 inclusive
    # @param $hue [Number] The adjustment to make on the hue component, in
    #   degrees
    # @param $saturation [Number] The adjustment to make on the saturation
    #   component, between `-100%` and `100%` inclusive
    # @param $lightness [Number] The adjustment to make on the lightness
    #   component, between `-100%` and `100%` inclusive
    # @param $alpha [Number] The adjustment to make on the alpha component,
    #   between -1 and 1 inclusive
    # @return [Color]
    # @raise [ArgumentError] if any parameter is the wrong type or out-of
    #   bounds, or if RGB properties and HSL properties are adjusted at the
    #   same time
    def adjust_color(color, kwargs)
      assert_type color, :Color, :color
      with = Sass::Util.map_hash({
          "red" => [-255..255, ""],
          "green" => [-255..255, ""],
          "blue" => [-255..255, ""],
          "hue" => nil,
          "saturation" => [-100..100, "%"],
          "lightness" => [-100..100, "%"],
          "alpha" => [-1..1, ""]
        }) do |name, (range, units)|

        next unless val = kwargs.delete(name)
        assert_type val, :Number, name
        Sass::Util.check_range("$#{name}: Amount", range, val, units) if range
        adjusted = color.send(name) + val.value
        adjusted = [0, Sass::Util.restrict(adjusted, range)].max if range
        [name.to_sym, adjusted]
      end

      unless kwargs.empty?
        name, val = kwargs.to_a.first
        raise ArgumentError.new("Unknown argument $#{name} (#{val})")
      end

      color.with(with)
    end
    declare :adjust_color, [:color], :var_kwargs => true

    # Fluidly scales one or more properties of a color. Unlike
    # \{#adjust_color adjust-color}, which changes a color's properties by fixed
    # amounts, \{#scale_color scale-color} fluidly changes them based on how
    # high or low they already are. That means that lightening an already-light
    # color with \{#scale_color scale-color} won't change the lightness much,
    # but lightening a dark color by the same amount will change it more
    # dramatically. This has the benefit of making `scale-color($color, ...)`
    # have a similar effect regardless of what `$color` is.
    #
    # For example, the lightness of a color can be anywhere between `0%` and
    # `100%`. If `scale-color($color, $lightness: 40%)` is called, the resulting
    # color's lightness will be 40% of the way between its original lightness
    # and 100. If `scale-color($color, $lightness: -40%)` is called instead, the
    # lightness will be 40% of the way between the original and 0.
    #
    # This can change the red, green, blue, saturation, value, and alpha
    # properties. The properties are specified as keyword arguments. All
    # arguments should be percentages between `0%` and `100%`.
    #
    # All properties are optional. You can't specify both RGB properties
    # (`$red`, `$green`, `$blue`) and HSL properties (`$saturation`, `$value`)
    # at the same time.
    #
    # @example
    #   scale-color(hsl(120, 70%, 80%), $lightness: 50%) => hsl(120, 70%, 90%)
    #   scale-color(rgb(200, 150%, 170%), $green: -40%, $blue: 70%) => rgb(200, 90, 229)
    #   scale-color(hsl(200, 70%, 80%), $saturation: -90%, $alpha: -30%) => hsla(200, 7%, 80%, 0.7)
    # @overload scale_color($color, [$red], [$green], [$blue], [$saturation], [$lightness], [$alpha])
    # @param $color [Color]
    # @param $red [Number]
    # @param $green [Number]
    # @param $blue [Number]
    # @param $saturation [Number]
    # @param $lightness [Number]
    # @param $alpha [Number]
    # @return [Color]
    # @raise [ArgumentError] if any parameter is the wrong type or out-of
    #   bounds, or if RGB properties and HSL properties are adjusted at the
    #   same time
    def scale_color(color, kwargs)
      assert_type color, :Color, :color
      with = Sass::Util.map_hash({
          "red" => 255,
          "green" => 255,
          "blue" => 255,
          "saturation" => 100,
          "lightness" => 100,
          "alpha" => 1
        }) do |name, max|

        next unless val = kwargs.delete(name)
        assert_type val, :Number, name
        if !(val.numerator_units == ['%'] && val.denominator_units.empty?)
          raise ArgumentError.new("$#{name}: Amount #{val} must be a % (e.g. #{val.value}%)")
        else
          Sass::Util.check_range("$#{name}: Amount", -100..100, val, '%')
        end

        current = color.send(name)
        scale = val.value/100.0
        diff = scale > 0 ? max - current : current
        [name.to_sym, current + diff*scale]
      end

      unless kwargs.empty?
        name, val = kwargs.to_a.first
        raise ArgumentError.new("Unknown argument $#{name} (#{val})")
      end

      color.with(with)
    end
    declare :scale_color, [:color], :var_kwargs => true

    # Changes one or more properties of a color. This can change the red, green,
    # blue, hue, saturation, value, and alpha properties. The properties are
    # specified as keyword arguments, and replace the color's current value for
    # that property.
    #
    # All properties are optional. You can't specify both RGB properties
    # (`$red`, `$green`, `$blue`) and HSL properties (`$hue`, `$saturation`,
    # `$value`) at the same time.
    #
    # @example
    #   change-color(#102030, $blue: 5) => #102005
    #   change-color(#102030, $red: 120, $blue: 5) => #782005
    #   change-color(hsl(25, 100%, 80%), $lightness: 40%, $alpha: 0.8) => hsla(25, 100%, 40%, 0.8)
    # @overload change_color($color, [$red], [$green], [$blue], [$hue], [$saturation], [$lightness], [$alpha])
    # @param $color [Color]
    # @param $red [Number] The new red component for the color, within 0 and 255
    #   inclusive
    # @param $green [Number] The new green component for the color, within 0 and
    #   255 inclusive
    # @param $blue [Number] The new blue component for the color, within 0 and
    #   255 inclusive
    # @param $hue [Number] The new hue component for the color, in degrees
    # @param $saturation [Number] The new saturation component for the color,
    #   between `0%` and `100%` inclusive
    # @param $lightness [Number] The new lightness component for the color,
    #   within `0%` and `100%` inclusive
    # @param $alpha [Number] The new alpha component for the color, within 0 and
    #   1 inclusive
    # @return [Color]
    # @raise [ArgumentError] if any parameter is the wrong type or out-of
    #   bounds, or if RGB properties and HSL properties are adjusted at the
    #   same time
    def change_color(color, kwargs)
      assert_type color, :Color, :color
      with = Sass::Util.map_hash(%w[red green blue hue saturation lightness alpha]) do |name, max|
        next unless val = kwargs.delete(name)
        assert_type val, :Number, name
        [name.to_sym, val.value]
      end

      unless kwargs.empty?
        name, val = kwargs.to_a.first
        raise ArgumentError.new("Unknown argument $#{name} (#{val})")
      end

      color.with(with)
    end
    declare :change_color, [:color], :var_kwargs => true

    # Mixes two colors together. Specifically, takes the average of each of the
    # RGB components, optionally weighted by the given percentage. The opacity
    # of the colors is also considered when weighting the components.
    #
    # The weight specifies the amount of the first color that should be included
    # in the returned color. The default, `50%`, means that half the first color
    # and half the second color should be used. `25%` means that a quarter of
    # the first color and three quarters of the second color should be used.
    #
    # @example
    #   mix(#f00, #00f) => #7f007f
    #   mix(#f00, #00f, 25%) => #3f00bf
    #   mix(rgba(255, 0, 0, 0.5), #00f) => rgba(63, 0, 191, 0.75)
    # @overload mix($color-1, $color-2, $weight: 50%)
    # @param $color-1 [Color]
    # @param $color-2 [Color]
    # @param $weight [Number] The relative weight of each color. Closer to `0%`
    #   gives more weight to `$color`, closer to `100%` gives more weight to
    #   `$color2`
    # @return [Color]
    # @raise [ArgumentError] if `$weight` is out of bounds or any parameter is
    #   the wrong type
    def mix(color_1, color_2, weight = Number.new(50))
      assert_type color_1, :Color, :color_1
      assert_type color_2, :Color, :color_2
      assert_type weight, :Number, :weight

      Sass::Util.check_range("Weight", 0..100, weight, '%')

      # This algorithm factors in both the user-provided weight (w) and the
      # difference between the alpha values of the two colors (a) to decide how
      # to perform the weighted average of the two RGB values.
      #
      # It works by first normalizing both parameters to be within [-1, 1],
      # where 1 indicates "only use color_1", -1 indicates "only use color_2", and
      # all values in between indicated a proportionately weighted average.
      #
      # Once we have the normalized variables w and a, we apply the formula
      # (w + a)/(1 + w*a) to get the combined weight (in [-1, 1]) of color_1.
      # This formula has two especially nice properties:
      #
      #   * When either w or a are -1 or 1, the combined weight is also that number
      #     (cases where w * a == -1 are undefined, and handled as a special case).
      #
      #   * When a is 0, the combined weight is w, and vice versa.
      #
      # Finally, the weight of color_1 is renormalized to be within [0, 1]
      # and the weight of color_2 is given by 1 minus the weight of color_1.
      p = (weight.value/100.0).to_f
      w = p*2 - 1
      a = color_1.alpha - color_2.alpha

      w1 = (((w * a == -1) ? w : (w + a)/(1 + w*a)) + 1)/2.0
      w2 = 1 - w1

      rgb = color_1.rgb.zip(color_2.rgb).map {|v1, v2| v1*w1 + v2*w2}
      alpha = color_1.alpha*p + color_2.alpha*(1-p)
      Color.new(rgb + [alpha])
    end
    declare :mix, [:color_1, :color_2]
    declare :mix, [:color_1, :color_2, :weight]

    # Converts a color to grayscale. This is identical to `desaturate(color,
    # 100%)`.
    #
    # @see #desaturate
    # @overload grayscale($color)
    # @param $color [Color]
    # @return [Color]
    # @raise [ArgumentError] if `$color` isn't a color
    def grayscale(color)
      return Sass::Script::String.new("grayscale(#{color})") if color.is_a?(Sass::Script::Number)
      desaturate color, Number.new(100)
    end
    declare :grayscale, [:color]

    # Returns the complement of a color. This is identical to `adjust-hue(color,
    # 180deg)`.
    #
    # @see #adjust_hue #adjust-hue
    # @overload complement($color)
    # @param $color [Color]
    # @return [Color]
    # @raise [ArgumentError] if `$color` isn't a color
    def complement(color)
      adjust_hue color, Number.new(180)
    end
    declare :complement, [:color]

    # Returns the inverse (negative) of a color. The red, green, and blue values
    # are inverted, while the opacity is left alone.
    #
    # @overload invert($color)
    # @param $color [Color]
    # @return [Color]
    # @raise [ArgumentError] if `$color` isn't a color
    def invert(color)
      return Sass::Script::String.new("invert(#{color})") if color.is_a?(Sass::Script::Number)

      assert_type color, :Color, :color
      color.with(
        :red => (255 - color.red),
        :green => (255 - color.green),
        :blue => (255 - color.blue))
    end
    declare :invert, [:color]

    # Removes quotes from a string. If the string is already unquoted, this will
    # return it unmodified.
    #
    # @see #quote
    # @example
    #   unquote("foo") => foo
    #   unquote(foo) => foo
    # @overload unquote($string)
    # @param $string [String]
    # @return [String]
    # @raise [ArgumentError] if `$string` isn't a string
    def unquote(string)
      if string.is_a?(Sass::Script::String)
        Sass::Script::String.new(string.value, :identifier)
      else
        string
      end
    end
    declare :unquote, [:string]

    # Add quotes to a string if the string isn't quoted,
    # or returns the same string if it is.
    #
    # @see #unquote
    # @example
    #   quote("foo") => "foo"
    #   quote(foo) => "foo"
    # @overload quote($string)
    # @param $string [String]
    # @return [String]
    # @raise [ArgumentError] if `$string` isn't a string
    def quote(string)
      assert_type string, :String, :string
      Sass::Script::String.new(string.value, :string)
    end
    declare :quote, [:string]

    # Returns the type of a value.
    #
    # @example
    #   type-of(100px)  => number
    #   type-of(asdf)   => string
    #   type-of("asdf") => string
    #   type-of(true)   => bool
    #   type-of(#fff)   => color
    #   type-of(blue)   => color
    # @overload type_of($value)
    # @param $value [Literal] The value to inspect
    # @return [String] The unquoted string name of the value's type
    def type_of(value)
      Sass::Script::String.new(value.class.name.gsub(/Sass::Script::/,'').downcase)
    end
    declare :type_of, [:value]

    # Returns the unit(s) associated with a number. Complex units are sorted in
    # alphabetical order by numerator and denominator.
    #
    # @example
    #   unit(100) => ""
    #   unit(100px) => "px"
    #   unit(3em) => "em"
    #   unit(10px * 5em) => "em*px"
    #   unit(10px * 5em / 30cm / 1rem) => "em*px/cm*rem"
    # @overload unit($number)
    # @param $number [Number]
    # @return [String] The unit(s) of the number, as a quoted string
    # @raise [ArgumentError] if `$number` isn't a number
    def unit(number)
      assert_type number, :Number, :number
      Sass::Script::String.new(number.unit_str, :string)
    end
    declare :unit, [:number]

    # Returns whether a number has units.
    #
    # @example
    #   unitless(100) => true
    #   unitless(100px) => false
    # @overload unitless($number)
    # @param $number [Number]
    # @return [Bool]
    # @raise [ArgumentError] if `$number` isn't a number
    def unitless(number)
      assert_type number, :Number, :number
      Sass::Script::Bool.new(number.unitless?)
    end
    declare :unitless, [:number]

    # Returns whether two numbers can added, subtracted, or compared.
    #
    # @example
    #   comparable(2px, 1px) => true
    #   comparable(100px, 3em) => false
    #   comparable(10cm, 3mm) => true
    # @overload comparable($number-1, $number-2)
    # @param $number-1 [Number]
    # @param $number-2 [Number]
    # @return [Bool]
    # @raise [ArgumentError] if either parameter is the wrong type
    def comparable(number_1, number_2)
      assert_type number_1, :Number, :number_1
      assert_type number_2, :Number, :number_2
      Sass::Script::Bool.new(number_1.comparable_to?(number_2))
    end
    declare :comparable, [:number_1, :number_2]

    # Converts a unitless number to a percentage.
    #
    # @example
    #   percentage(0.2) => 20%
    #   percentage(100px / 50px) => 200%
    # @overload percentage($value)
    # @param $value [Number]
    # @return [Number]
    # @raise [ArgumentError] if `$value` isn't a unitless number
    def percentage(value)
      unless value.is_a?(Sass::Script::Number) && value.unitless?
        raise ArgumentError.new("$value: #{value.inspect} is not a unitless number")
      end
      Sass::Script::Number.new(value.value * 100, ['%'])
    end
    declare :percentage, [:value]

    # Rounds a number to the nearest whole number.
    #
    # @example
    #   round(10.4px) => 10px
    #   round(10.6px) => 11px
    # @overload round($value)
    # @param $value [Number]
    # @return [Number]
    # @raise [ArgumentError] if `$value` isn't a number
    def round(value)
      numeric_transformation(value) {|n| n.round}
    end
    declare :round, [:value]

    # Rounds a number up to the next whole number.
    #
    # @example
    #   ceil(10.4px) => 11px
    #   ceil(10.6px) => 11px
    # @overload ceil($value)
    # @param $value [Number]
    # @return [Number]
    # @raise [ArgumentError] if `$value` isn't a number
    def ceil(value)
      numeric_transformation(value) {|n| n.ceil}
    end
    declare :ceil, [:value]

    # Rounds a number down to the previous whole number.
    #
    # @example
    #   floor(10.4px) => 10px
    #   floor(10.6px) => 10px
    # @overload floor($value)
    # @param $value [Number]
    # @return [Number]
    # @raise [ArgumentError] if `$value` isn't a number
    def floor(value)
      numeric_transformation(value) {|n| n.floor}
    end
    declare :floor, [:value]

    # Returns the absolute value of a number.
    #
    # @example
    #   abs(10px) => 10px
    #   abs(-10px) => 10px
    # @overload abs($value)
    # @param $value [Number]
    # @return [Number]
    # @raise [ArgumentError] if `$value` isn't a number
    def abs(value)
      numeric_transformation(value) {|n| n.abs}
    end
    declare :abs, [:value]

    # Finds the minimum of several numbers. This function takes any number of
    # arguments.
    #
    # @example
    #   min(1px, 4px) => 1px
    #   min(5em, 3em, 4em) => 3em
    # @overload min($numbers...)
    # @param $numbers [[Number]]
    # @return [Number]
    # @raise [ArgumentError] if any argument isn't a number, or if not all of
    #   the arguments have comparable units
    def min(*numbers)
      numbers.each {|n| assert_type n, :Number}
      numbers.inject {|min, num| min.lt(num).to_bool ? min : num}
    end
    declare :min, [], :var_args => :true

    # Finds the maximum of several numbers. This function takes any number of
    # arguments.
    #
    # @example
    #   max(1px, 4px) => 4px
    #   max(5em, 3em, 4em) => 5em
    # @overload max($numbers...)
    # @param $numbers [[Number]]
    # @return [Number]
    # @raise [ArgumentError] if any argument isn't a number, or if not all of
    #   the arguments have comparable units
    def max(*values)
      values.each {|v| assert_type v, :Number}
      values.inject {|max, val| max.gt(val).to_bool ? max : val}
    end
    declare :max, [], :var_args => :true

    # Return the length of a list.
    #
    # @example
    #   length(10px) => 1
    #   length(10px 20px 30px) => 3
    # @overload length($list)
    # @param $list [Literal]
    # @return [Number]
    def length(list)
      Sass::Script::Number.new(list.to_a.size)
    end
    declare :length, [:list]

    # Gets the nth item in a list.
    #
    # Note that unlike some languages, the first item in a Sass list is number
    # 1, the second number 2, and so forth.
    #
    # @example
    #   nth(10px 20px 30px, 1) => 10px
    #   nth((Helvetica, Arial, sans-serif), 3) => sans-serif
    # @overload nth($list, $n)
    # @param $list [Literal]
    # @param $n [Number] The index of the item to get
    # @return [Literal]
    # @raise [ArgumentError] if `$n` isn't an integer between 1 and the length
    #   of `$list`
    def nth(list, n)
      assert_type n, :Number, :n
      if !n.int?
        raise ArgumentError.new("List index #{n} must be an integer")
      elsif n.to_i < 1
        raise ArgumentError.new("List index #{n} must be greater than or equal to 1")
      elsif list.to_a.size == 0
        raise ArgumentError.new("List index is #{n} but list has no items")
      elsif n.to_i > (size = list.to_a.size)
        raise ArgumentError.new("List index is #{n} but list is only #{size} item#{'s' if size != 1} long")
      end

      list.to_a[n.to_i - 1]
    end
    declare :nth, [:list, :n]

    # Joins together two lists into one.
    #
    # Unless `$separator` is passed, if one list is comma-separated and one is
    # space-separated, the first parameter's separator is used for the resulting
    # list. If both lists have fewer than two items, spaces are used for the
    # resulting list.
    #
    # @example
    #   join(10px 20px, 30px 40px) => 10px 20px 30px 40px
    #   join((blue, red), (#abc, #def)) => blue, red, #abc, #def
    #   join(10px, 20px) => 10px 20px
    #   join(10px, 20px, comma) => 10px, 20px
    #   join((blue, red), (#abc, #def), space) => blue red #abc #def
    # @overload join($list1, $list2, $separator: auto)
    # @param $list1 [Literal]
    # @param $list2 [Literal]
    # @param $separator [String] The list separator to use. If this is `comma`
    #   or `space`, that separator will be used. If this is `auto` (the
    #   default), the separator is determined as explained above.
    # @return [List]
    def join(list1, list2, separator = Sass::Script::String.new("auto"))
      assert_type separator, :String, :separator
      unless %w[auto space comma].include?(separator.value)
        raise ArgumentError.new("Separator name must be space, comma, or auto")
      end
      sep1 = list1.separator if list1.is_a?(Sass::Script::List) && !list1.value.empty?
      sep2 = list2.separator if list2.is_a?(Sass::Script::List) && !list2.value.empty?
      Sass::Script::List.new(
        list1.to_a + list2.to_a,
        if separator.value == 'auto'
          sep1 || sep2 || :space
        else
          separator.value.to_sym
        end)
    end
    declare :join, [:list1, :list2]
    declare :join, [:list1, :list2, :separator]

    # Appends a single value onto the end of a list.
    #
    # Unless the `$separator` argument is passed, if the list had only one item,
    # the resulting list will be space-separated.
    #
    # @example
    #   append(10px 20px, 30px) => 10px 20px 30px
    #   append((blue, red), green) => blue, red, green
    #   append(10px 20px, 30px 40px) => 10px 20px (30px 40px)
    #   append(10px, 20px, comma) => 10px, 20px
    #   append((blue, red), green, space) => blue red green
    # @overload append($list, $val, $separator: auto)
    # @param $list [Literal]
    # @param $val [Literal]
    # @param $separator [String] The list separator to use. If this is `comma`
    #   or `space`, that separator will be used. If this is `auto` (the
    #   default), the separator is determined as explained above.
    # @return [List]
    def append(list, val, separator = Sass::Script::String.new("auto"))
      assert_type separator, :String, :separator
      unless %w[auto space comma].include?(separator.value)
        raise ArgumentError.new("Separator name must be space, comma, or auto")
      end
      sep = list.separator if list.is_a?(Sass::Script::List)
      Sass::Script::List.new(
        list.to_a + [val],
        if separator.value == 'auto'
          sep || :space
        else
          separator.value.to_sym
        end)
    end
    declare :append, [:list, :val]
    declare :append, [:list, :val, :separator]

    # Combines several lists into a single multidimensional list. The nth value
    # of the resulting list is a space separated list of the source lists' nth
    # values.
    #
    # The length of the resulting list is the length of the
    # shortest list.
    #
    # @example
    #   zip(1px 1px 3px, solid dashed solid, red green blue)
    #   => 1px solid red, 1px dashed green, 3px solid blue
    # @overload zip($lists...)
    # @param $lists [[Literal]]
    # @return [List]
    def zip(*lists)
      length = nil
      values = []
      lists.each do |list|
        array = list.to_a
        values << array.dup
        length = length.nil? ? array.length : [length, array.length].min
      end
      values.each do |value|
        value.slice!(length)
      end
      new_list_value = values.first.zip(*values[1..-1])
      List.new(new_list_value.map{|list| List.new(list, :space)}, :comma)
    end
    declare :zip, [], :var_args => true


    # Returns the position of a value within a list. If the value isn't found,
    # returns false instead.
    #
    # Note that unlike some languages, the first item in a Sass list is number
    # 1, the second number 2, and so forth.
    #
    # @example
    #   index(1px solid red, solid) => 2
    #   index(1px solid red, dashed) => false
    # @overload index($list, $value)
    # @param $list [Literal]
    # @param $value [Literal]
    # @return [Number, Bool] The 1-based index of `$value` in `$list`, or
    #   `false`
    def index(list, value)
      index = list.to_a.index {|e| e.eq(value).to_bool }
      if index
        Number.new(index + 1)
      else
        Bool.new(false)
      end
    end
    declare :index, [:list, :value]

    # Returns one of two values, depending on whether or not `$condition` is
    # true. Just like in `@if`, all values other than `false` and `null` are
    # considered to be true.
    #
    # @example
    #   if(true, 1px, 2px) => 1px
    #   if(false, 1px, 2px) => 2px
    # @overload if($condition, $if-true, $if-false)
    # @param $condition [Literal] Whether the `$if-true` or `$if-false` will be
    #   returned
    # @param $if-true [Literal]
    # @param $if-false [Literal]
    # @return [Literal] `$if-true` or `$if-false`
    def if(condition, if_true, if_false)
      if condition.to_bool
        if_true
      else
        if_false
      end
    end
    declare :if, [:condition, :if_true, :if_false]

    # This function only exists as a workaround for IE7's [`content:counter`
    # bug][bug]. It works identically to any other plain-CSS function, except it
    # avoids adding spaces between the argument commas.
    #
    # [bug]: http://jes.st/2013/ie7s-css-breaking-content-counter-bug/
    #
    # @example
    #   counter(item, ".") => counter(item,".")
    # @overload counter($args...)
    # @return [String]
    def counter(*args)
      Sass::Script::String.new("counter(#{args.map {|a| a.to_s(options)}.join(',')})")
    end
    declare :counter, [], :var_args => true

    private

    # This method implements the pattern of transforming a numeric value into
    # another numeric value with the same units.
    # It yields a number to a block to perform the operation and return a number
    def numeric_transformation(value)
      assert_type value, :Number, :value
      Sass::Script::Number.new(yield(value.value), value.numerator_units, value.denominator_units)
    end

    def _adjust(color, amount, attr, range, op, units = "")
      assert_type color, :Color, :color
      assert_type amount, :Number, :amount
      Sass::Util.check_range('Amount', range, amount, units)

      # TODO: is it worth restricting here,
      # or should we do so in the Color constructor itself,
      # and allow clipping in rgb() et al?
      color.with(attr => Sass::Util.restrict(
          color.send(attr).send(op, amount.value), range))
    end
  end
end

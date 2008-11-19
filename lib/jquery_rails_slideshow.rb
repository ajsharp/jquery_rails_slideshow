# JqueryRailsSlideshow
module JqueryRailsSlideshow
  def jquery_slideshow(dir)
    image_tags_for_dir(dir)
  end
  
  def image_tags_for_dir(dir = 'home_page_slideshow', opts = {})
    opts[:img_dir] ||= "./public/images/"
    imgs = opts[:img_dir] + dir
    Dir.new(imgs).to_a.select { |file| File.file?("#{imgs}/#{file}") }.collect {|f| image_tag("#{dir}/#{f}", :alt => "") }.join("\n")
  end
  
  # Output a block of javascript; takes a hash of options that will be inserted into the javascript block that is returned.
  # 
  # Options
  # =======
  # <tt>:wrap_id</tt> - Dom id of the html element surrounding your slideshow
  # <tt>:active</tt>  - The class you've set in your CSS for the active image
  # <tt>:last_active</tt> - The class for the fading image
  # <tt>:cycle_time</tt>  - Miliseconds between image transitions (1000 == 1 second)
  # <tt>:transition_time</tt> - Length in miliseconds of image transition effect.
  # <tt>:selector</tt> - The selector that will be used to advance the slideshow; defaults to 'img'
  # <tt>:prototype</tt> - If set to true, the javascript block will use jQuery's noConflict() function.
  def jrs_javascript(opts = {})
    opts[:wrap_id]      ||= 'slideshow'
    opts[:active]       ||= 'active'
    opts[:last_active]  ||= 'last-active'
    opts[:cycle_time]   ||= 4000
    opts[:selector]     ||= 'img'
    opts[:transition_time] ||= 1000
    jq = (opts[:prototype] == true) ? 'jQuery' : '$'
    javascript_tag do
      str = <<STR
        #{"jQuery.noConflict();" if opts[:prototype]}
        function slideSwitch() {
            var $active = (#{jq}('##{opts[:wrap_id]} #{opts[:selector]}.#{opts[:active]}').length == 0) ? #{jq}('##{opts[:wrap_id]} #{opts[:selector]}:last') : #{jq}('##{opts[:wrap_id]} #{opts[:selector]}.#{opts[:active]}');
            var $next = $active.next().length ? $active.next('#{opts[:selector]}') : #{jq}('##{opts[:wrap_id]} #{opts[:selector]}:first');

            $active.addClass('#{opts[:last_active]}');

            $next.css({opacity: 0.0}).addClass('#{opts[:active]}').animate({opacity: 1.0}, #{opts[:transition_time]}, function() {
              $active.removeClass('#{opts[:active]} #{opts[:last_active]}');
            });
        }

        jQuery(function() { 
          setInterval( "slideSwitch()", #{opts[:cycle_time]} );
        });
STR
    end
  end
end

# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# -= Guard notifications =-

# notification :growl
# notification :libnotify, :timeout => 5, :transient => true, :append => false, :urgency => :critical
# notification :notifu, :time => 5, :nosound => true, :xp => true

# -= Guarded paths =-

PATHS = { :in => 'src', :out => 'public' }

# -= Guard preprocessors =-

group :templates do
  guard 'haml', :input => PATHS[:in], :output => PATHS[:out] do
    watch(%r{#{PATHS[:in]}/.+(\.html\.haml)$})
  end
end

group :javascripts do
  guard 'coffeescript', :input => "#{PATHS[:in]}/javascripts", :output => "#{PATHS[:out]}/javascripts"
end

group :stylesheets do
  guard 'less', :all_on_start => true, :all_after_change => true, :output => "#{PATHS[:out]}/stylesheets"  do
    watch(%r{^.+\.less$})
  end

  guard 'sass', :input => "#{PATHS[:in]}/stylesheets", :output => "#{PATHS[:out]}/stylesheets"
end

# -= Livereload =-
group :reload do
  guard 'livereload' do
    watch(%r{#{PATHS[:out]}/.+\.html$})
    watch(%r{#{PATHS[:out]}/stylesheets/.+\.css$})
    watch(%r{#{PATHS[:out]}/javascripts/.+\.js$})
  end
end

guard 'markdown', :convert_on_start => true do  
	# See README for info on the watch statement below
	# Will not convert while :dry_run is true. Once you're happy with your watch statements remove it
	watch (/README\.md/) { "README.md|#{PATHS[:out]}/templates/README.html|template.html.erb" } 
	#watch (/source_dir\/(.+\/)*(.+\.)(md|markdown)/i) { |m| "source_dir/#{m[1]}#{m[2]}#{m[3]}|output_dir/#{m[1]}#{m[2]}html|optional_template.html.erb"}
end

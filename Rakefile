#coding:utf-8

require 'rake/clean'
include Rake::DSL

task :default => [:watch]

HAML = FileList['src/*.haml']
HTML = HAML.ext('html')

CLEAN.include HTML

#This task is just for convenience, it depends on the implicit 
#file tasks which are created by the rule at the end of the rakefile.
#Without this task you had to call the implicit file tasks for every
#file yourself.
desc 'Generates the html files'
task :preview => HTML

desc 'Watch the site and regenerate when it changes'
task :watch => :preview do
  require 'fssm'
  FSSM.monitor do
    path "#{File.dirname(__FILE__)}" do
      glob '**/*.haml'
      update {|base, relative| refresh()}
      delete {|base, relative| refresh()}
      create {|base, relative| refresh()}
    end
  end
end

#This function programmatically invokes the preview task.
#There are other ways to achieve this, but this method is simple and works.
desc 'Refreshes the preview by calling rake preview'
def refresh()
  sh "rake preview"
end

#This declares the rule to convert a haml file into html.
#Implicitly this rule creates a file task for every haml file.
#E.g. if you have a file index.haml, this rule creates the 
#file task index.html.
rule '.html' => '.haml' do |t|
  puts "Rebuilding #{t.name}"
  sh "haml #{t.source} #{t.name}"
end

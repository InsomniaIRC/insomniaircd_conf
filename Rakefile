$:.push File.expand_path("../lib", __FILE__)

require 'rake'
require 'insomniaircd_conf'

INPUT = "config-src"
OUTPUT = "conf"


directory OUTPUT

task :default do
  Rake::Task["compile"].invoke(ENV["HOSTNAME"])
end

task :clean do
    rm_rf OUTPUT
end

task :compile, [:hostname] => [OUTPUT] do |t, args|
  conf = InsomniaIRCDConf.new(args[:hostname], get_key)

  files = Rake::FileList["#{INPUT}/*"]

  files.each do |filename|
    next if !File.file? filename
    if filename =~ /.erb$/
      template = File.read("#{filename}")
      File.open("#{OUTPUT}/" + File.basename(filename[0..-5]), "w") do |file|
        file.puts conf.render_template(template)
      end
    elsif filename =~ /.encrypted$/

    else
      cp filename, "#{OUTPUT}/"
    end
  end
end

namespace "secret" do
  task :mkkey do
    File.write("secure.key", InsomniaIRCDConf::Secure::random_key)
  end

  task :encrypt, [:secret] do |t, args|
    secure = InsomniaIRCDConf::Secure.new(get_key)
    puts "Encryption result: " + secure.encrypt(args[:secret])
  end

  task :decrypt, [:secret] do |t, args|
    secure = InsomniaIRCDConf::Secure.new(get_key)
    puts "Decryption result: " + secure.decrypt(args[:secret])
  end
end

def get_key
  if ENV.has_key? "SECRET_KEY"
    ENV["SECRET_KEY"]
  else
    if File.file? "secret.key"
      File.read("secret.key")
    else
      raise "SECRET_KEY variable not set!"
    end
  end
end


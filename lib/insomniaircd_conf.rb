require 'erb'
require 'ostruct'
require 'resolv'
require 'yaml'
require 'insomniaircd_conf/secure'

class InsomniaIRCDConf
  def initialize(hostname, secret_key)
    @secure = InsomniaIRCDConf::Secure.new(secret_key)

    @hostname = hostname
    @network = OpenStruct.new(YAML.load_file("network.yaml"))

    raise ArgumentError, "No such server #{hostname}" unless @network.servers.has_key? hostname
    @server = OpenStruct.new(@network.servers[hostname])

    @opers = []
    @network.opers.each do |oper|
      oper["password"] = @secure.decrypt(oper["password"])
      @opers << oper
    end
  end

  def hostname
    @hostname
  end

  def network
    @network
  end

  def server
    @server
  end

  def opers
    @opers
  end

  def secret(key)
    @secure.decrypt @network.secrets[key.to_s]
  end

  def render_template(input)
    template = ERB.new(input)
    template.result(binding)
  end
end


class Player
  attr_reader :marker

  def initialize(**opts)
    @marker = opts[:marker]

    post_initialize(opts)
  end

  def post_initialize(opts); end
end

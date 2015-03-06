module RPG
  class System
    class Terms
      def initialize
        @basic = Array.new(8) {''}
        @params = Array.new(8) {''}
        @etypes = Array.new(5) {''}
        @commands = Array.new(23) {''}
      end

      # @return [Array<String>]
      attr_accessor :basic
      # @return [Array<String>]
      attr_accessor :params
      # @return [Array<String>]
      attr_accessor :etypes
      # @return [Array<String>]
      attr_accessor :commands
    end
  end
end

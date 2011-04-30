# Copyright (c) 2011 Vincent Landgraf
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
module Istat
  module Frames
    class RegisterRequest < Request
      # create a new register request frame
      # @param [String] hostname the hostname to use for registering (e.g. example.com)
      # @param [String] duuid the duuid to use for registering (e.g. 19be1f6285ae9019254c93a880db7285)
      def initialize(hostname, duuid)
        super create([:h, hostname], [:duuid, duuid])
      end
    end
    
    class RegisterResponse < Response
      # check if the user has to authorize using password
      # @return [Boolean] true if the user should authorize
      def authorize?
        @root.attributes["ath"].to_i == 1
      end
      
      # calculate the uptime value
      # @return [Integer] a timestamp (Time.now - val)
      def uptime
        @root.attributes["n"].to_i
      end
      
      # calculate the next_uptime value
      # @return [Integer] a timestamp (Time.now - val)
      def next_uptime
        @root.attributes["c"].to_i
      end
      
      # @return static value 6
      def ss
        @root.attributes["ss"].to_i
      end
      
      # @return static value 2
      def pl
        @root.attributes["pl"].to_i
      end
    end
  end
end

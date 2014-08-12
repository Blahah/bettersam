#!/usr/bin/env	ruby

require 'helper'

class TestFasterSam < Test::Unit::TestCase

  context "FasterSam" do

    should "read a SAM file" do
      path = File.join(File.dirname(__FILE__), 'data', 'basic.sam')
      fs = FasterSam.new path
      fs.each_record do |record|
        p record.inspect
      end
    end

  end

end

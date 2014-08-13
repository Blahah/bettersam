#!/usr/bin/env	ruby

require 'helper'

class TestFasterSam < Test::Unit::TestCase

  context "FasterSam" do

    should "read a SAM file" do
      path = File.join(File.dirname(__FILE__), 'data', 'basic.sam')
      expected = [
        {:rname => "nivara_3s", :pos => 1572276, :xm => 4, :nm => 0},
        {:rname => "chromosome03", :pos => 1789384, :xm => 3, :nm => 8},
        {:rname => "chromosome03", :pos => 1789377, :xm => 6, :nm => 8},
        {:rname => "nivara_3s", :pos => 1572267, :xm => 4, :nm => 9},
        {:rname => "chromosome03", :pos => 1789378, :xm => 4, :nm => 13},
        {:rname => "Sb02g000720.1", :pos => 1186, :xm => 0, :nm => 0}
      ]
      fs = FasterSam.new path
      i = 0
      fs.each_record do |record|
        assert_equal expected[i][:rname], record.rname, "chromosome"
        assert_equal expected[i][:pos], record.pos, "position"
        assert_equal expected[i][:xm], record.tags.xm, "mismatches"
        assert_equal expected[i][:nm], record.tags.nm, "edit distance"
        i += 1
      end
    end

  end

end

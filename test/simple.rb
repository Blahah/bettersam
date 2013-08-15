require "minitest/autorun"

load "#{File.dirname(__FILE__)}/../lib/better_sam.rb"

for line in lines
  sam = Sam.new(line)

  puts line.gsub("\t", "  \\t  ")
  puts
  for f in [:name, :flag, :chrom, :pos, :mapq, :cigar, :mchrom, :mpos, :insert, :seq, :qual, :tags]
    puts "#{f}\t\t#{sam.send(f).inspect}"
  end
  puts
end

class TestBetterSam < Minitest::TestBetterSam
  def setup
    @read = "readname 0 chrX  46615805  37  76M * 0 0 AAATCTT...  edaecdd...  XT:A:U  NM:i:0  X0:i:1"
  end

  def test_that_readname_is_captured

  end

  def test_that_flags_parse
    assert @read
  end
end
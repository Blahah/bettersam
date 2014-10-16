#!/usr/bin/env	ruby

require 'helper'

class TestBetterSam < Test::Unit::TestCase

  context "BetterSam" do

    setup do
      path = File.join(File.dirname(__FILE__), 'data', 'basic.sam')
      @fs = BetterSam.new path
      # this is run before each test
      @l1 = BetterSam.new("FCC00CKABXX:2:1101:10117:6470#CAGATCAT	81	nivara_3s	1572276	40	100M	=	1571527	-849	AGGATCGGGCCTCGTGAGCCGACGGTGAGCGAGTTGTTGTTGTTCCATACGGGGGCGCCGGAGTTGGTGCTCCACAGCGGGCCGTTGAACGAGCTCGACG	ZbaX^_baX\_S]_ZdYccYebeffddZdbebdadc[bdVeeeceeeddggggggggggggggggegeggdffbfefegggggggggggggggggggggg	AS:i:-24	XN:i:0	XM:i:4	XO:i:0	XG:i:0	NM:i:0	MD:Z:1T1G3T0A91	YS:i:-5	YT:Z:DP")
      @l2 = BetterSam.new("FCC00CKABXX:2:1101:10117:6470#CAGATCAT	81	chromosome03	1789384	24	4M5I91M	=	1788782	-697	AGGATCGGGCCTCGTGAGCCGACGGTGAGCGAGTTGTTGTTGTTCCATACGGGGGCGCCGGAGTTGGTGCTCCACAGCGGGCCGTTGAACGAGCTCGACG	ZbaX^_baX\_S]_ZdYccYebeffddZdbebdadc[bdVeeeceeeddggggggggggggggggegeggdffbfefegggggggggggggggggggggg	AS:i:-38	XN:i:0	XM:i:3	XO:i:1	XG:i:5	NM:i:8	MD:Z:0C1T6G85	YS:i:-5	YT:Z:DP")
      @l3 = BetterSam.new("FCC00CKABXX:2:1101:19524:66398#CAGATCAT	145	chromosome03	1789377	23	4M1I2M1D93M	=	1788766	-711	GGAGGATCGGGCCTCGTGGGCCGACGGTGAGCGAGTTGTTGTTGTTCCATACGGGGGCGCCGGAGTTGGTGCTCCACAGCGGGCCGTTGAACGAGCTCGA	Bc`aaT\Y_]RLMKKMHEMV_T[Y[deaeeeaadbaaa\_feecedddddadfcegdcXdggcggggggggg`gfbecbcggggggggeggggggggggg	AS:i:-51	XN:i:0	XM:i:6	XO:i:2	XG:i:2	NM:i:8	MD:Z:2T0C2^A2T0A5G1A81	YS:i:0	YT:Z:DP")
      @l4l = BetterSam.new("FCC00CKABXX:2:1101:16909:83925#CAGATCAT	145	nivara_3s	1572267	23	5M2D3M2I3M1I86M	=	1571498	-868	GTCCTCCAGGAGGATCGGGCCTCGTGAGCCGACGGTGAGCGAGTTGTTGTTGTTCCATACGGGGGCGCCGGAGTTGGTGCTCCACAGCGGGCCGTTGAAC	BBBBBB_Z`cU]^SZS][]USKV[L`ac`dedeageeefagegagffdd`egedgggedgggggggdggggggggefeeeQgeagggggggggggggggg	AS:i:-53	XN:i:0	XM:i:4	XO:i:3	XG:i:5	NM:i:9	MD:Z:2G2^TG3T5T0A81	YS:i:0	YT:Z:DP")
      @l4r = BetterSam.new("FCC00CKABXX:2:1101:16909:83925#CAGATCAT	145	chromosome03	1789378	23	7M4I3M5I81M	=	1788753	-716	GTCCTCCAGGAGGATCGGGCCTCGTGAGCCGACGGTGAGCGAGTTGTTGTTGTTCCATACGGGGGCGCCGGAGTTGGTGCTCCACAGCGGGCCGTTGAAC	BBBBBB_Z`cU]^SZS][]USKV[L`ac`dedeageeefagegagffdd`egedgggedgggggggdggggggggefeeeQgeagggggggggggggggg	AS:i:-59	XN:i:0	XM:i:4	XO:i:2	XG:i:9	NM:i:13	MD:Z:3A1A2T6G75	YS:i:0	YT:Z:DP")
      @l5l = BetterSam.new("FCC2HFRACXX:7:2314:9299:67450#TGACCAAT	355	Sb02g000720.1	1186	18	71M	=	1238	-150	CGTCATCTTCTCTCATATATTTGTATCACCCATCCATCCATCTGCCTTCGATATGCATCTCCACTCCGCCG	__^cc]^\`eegea`ffdfghhfd]eghhfffef``degfhf_^gdfhfg_fghhhfdhffdfhffbeWcW	AS:i:142	XN:i:0	XM:i:0	XO:i:0	XG:i:0	MD:Z:71	YS:i:44	YT:Z:CP") #   NM:i:0
    end

    should "read a SAM file" do
      expected = [
        {:rname => "nivara_3s", :pos => 1572276, :xm => 4, :nm => 0},
        {:rname => "chromosome03", :pos => 1789384, :xm => 3, :nm => 8},
        {:rname => "chromosome03", :pos => 1789377, :xm => 6, :nm => 8},
        {:rname => "nivara_3s", :pos => 1572267, :xm => 4, :nm => 9},
        {:rname => "chromosome03", :pos => 1789378, :xm => 4, :nm => 13},
        {:rname => "Sb02g000720.1", :pos => 1186, :xm => 0, :nm => 0}
      ]
      i = 0
      @fs.each_record do |record|
        assert_equal expected[i][:rname], record.rname, "chromosome"
        assert_equal expected[i][:pos], record.pos, "position"
        assert_equal expected[i][:xm], record.tags.xm, "mismatches"
        assert_equal expected[i][:nm], record.tags.nm, "edit distance"
        i += 1
      end
    end

    should "detect a paired read" do
      expected = [true, true, true, true, true, true]
      i = 0
      @fs.each_record do |record|
        assert_equal expected[i], record.read_paired?, "record ##{i+1}"
        i += 1
      end
    end

    should "detect reverse strand" do
      expected = [true, true, true, true, true, false]
      i = 0
      @fs.each_record do |record|
        assert_equal expected[i], record.read_reverse_strand?, "record ##{i+1}"
        i += 1
      end
    end

    should "detect the first read in a pair" do
      expected = [true, true, false, false, false, true]
      i = 0
      @fs.each_record do |record|
        assert_equal expected[i], record.first_in_pair?, "record ##{i+1}"
        i += 1
      end
    end

    should "get the mapping position" do
      expected = [1572276, 1789384, 1789377, 1572267, 1789378, 1186]
      i = 0
      @fs.each_record do |record|
        assert_equal expected[i], record.pos, "record ##{i+1}"
        i += 1
      end
    end

    should "get the end position" do
      expected = [1572276, 1789384, 1789377, 1572267, 1789378, 1186]
      expected = expected.map { |x| x + 100 }
      i = 0
      @fs.each_record do |record|
        assert_equal expected[i], record.endpos, "record ##{i+1}"
        i += 1
      end
    end

    should "detect exact matches" do
      expected = [true, false, false, false, false, true]
      i = 0
      @fs.each_record do |record|
        assert_equal expected[i], record.exact_match?, "record ##{i+1}"
        i += 1
      end
    end

  end
end

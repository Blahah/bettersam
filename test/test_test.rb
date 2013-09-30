#!/usr/bin/env	ruby

require 'helper'

class TestBetterSam < Test::Unit::TestCase

  context "BetterSam" do

    setup do
      # this is run before each test
      @l1 = BetterSam.new("FCC00CKABXX:2:1101:10117:6470#CAGATCAT	81	nivara_3s	1572276	40	100M	=	1571527	-849	AGGATCGGGCCTCGTGAGCCGACGGTGAGCGAGTTGTTGTTGTTCCATACGGGGGCGCCGGAGTTGGTGCTCCACAGCGGGCCGTTGAACGAGCTCGACG	ZbaX^_baX\_S]_ZdYccYebeffddZdbebdadc[bdVeeeceeeddggggggggggggggggegeggdffbfefegggggggggggggggggggggg	AS:i:-24	XN:i:0	XM:i:4	XO:i:0	XG:i:0	NM:i:4	MD:Z:1T1G3T0A91	YS:i:-5	YT:Z:DP")
      @l2 = BetterSam.new("FCC00CKABXX:2:1101:10117:6470#CAGATCAT	81	chromosome03	1789384	24	4M5I91M	=	1788782	-697	AGGATCGGGCCTCGTGAGCCGACGGTGAGCGAGTTGTTGTTGTTCCATACGGGGGCGCCGGAGTTGGTGCTCCACAGCGGGCCGTTGAACGAGCTCGACG	ZbaX^_baX\_S]_ZdYccYebeffddZdbebdadc[bdVeeeceeeddggggggggggggggggegeggdffbfefegggggggggggggggggggggg	AS:i:-38	XN:i:0	XM:i:3	XO:i:1	XG:i:5	NM:i:8	MD:Z:0C1T6G85	YS:i:-5	YT:Z:DP")
    end

    should "be a paired read" do
      assert @l1.read_paired?
    end

    should "be on the reverse strand" do
      assert @l1.read_reverse_strand?
    end

    should "be the first pair" do
      assert @l1.first_in_pair?
    end

    should "get the mappping position" do
      assert @l1.pos == 1572276
    end

    should "get the end position" do
      assert @l1.endpos == 1572376
    end

    should "get the end position too" do
      assert @l2.endpos == 1789479, "this is #{@l1.endpos} but should be 1789479"
    end

    should "be exact match" do
      assert @l1.exact_match?
    end

    should "contain snp" do
      assert @l1.contains_snp?(1572283)
    end

    should "give A" do
      assert @l1.get_base_at(0)=="A", "this is #{@l1.get_base_at(0)}, but should be A"
    end

    should "mark a snp" do
      assert @l1.mark_snp(1572283)==7, "this is #{@l1.mark_snp(1572283)}, but i think it should be 7"
    end

    should "mark a snp as well" do
      assert @l2.mark_snp(1789386)==2, "this is #{@l2.mark_snp(1789386)}, but i think it should be 3"
    end # TODO make more tests like this
  end
end
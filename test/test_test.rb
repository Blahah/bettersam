#!/usr/bin/env	ruby

require 'helper'

class TestBetterSam < Test::Unit::TestCase

  context "BetterSam" do

    setup do
      # this is run before each test
      @l1 = BetterSam.new("FCC00CKABXX:2:1101:10117:6470#CAGATCAT	81	nivara_3s	1572276	40	100M	=	1571527	-849	AGGATCGGGCCTCGTGAGCCGACGGTGAGCGAGTTGTTGTTGTTCCATACGGGGGCGCCGGAGTTGGTGCTCCACAGCGGGCCGTTGAACGAGCTCGACG	ZbaX^_baX\_S]_ZdYccYebeffddZdbebdadc[bdVeeeceeeddggggggggggggggggegeggdffbfefegggggggggggggggggggggg	AS:i:-24	XN:i:0	XM:i:4	XO:i:0	XG:i:0	NM:i:4	MD:Z:1T1G3T0A91	YS:i:-5	YT:Z:DP")
      @l2 = BetterSam.new("FCC00CKABXX:2:1101:10117:6470#CAGATCAT	81	chromosome03	1789384	24	4M5I91M	=	1788782	-697	AGGATCGGGCCTCGTGAGCCGACGGTGAGCGAGTTGTTGTTGTTCCATACGGGGGCGCCGGAGTTGGTGCTCCACAGCGGGCCGTTGAACGAGCTCGACG	ZbaX^_baX\_S]_ZdYccYebeffddZdbebdadc[bdVeeeceeeddggggggggggggggggegeggdffbfefegggggggggggggggggggggg	AS:i:-38	XN:i:0	XM:i:3	XO:i:1	XG:i:5	NM:i:8	MD:Z:0C1T6G85	YS:i:-5	YT:Z:DP")
      @l3 = BetterSam.new("FCC00CKABXX:2:1101:19524:66398#CAGATCAT	145	chromosome03	1789377	23	4M1I2M1D93M	=	1788766	-711	GGAGGATCGGGCCTCGTGGGCCGACGGTGAGCGAGTTGTTGTTGTTCCATACGGGGGCGCCGGAGTTGGTGCTCCACAGCGGGCCGTTGAACGAGCTCGA	Bc`aaT\Y_]RLMKKMHEMV_T[Y[deaeeeaadbaaa\_feecedddddadfcegdcXdggcggggggggg`gfbecbcggggggggeggggggggggg	AS:i:-51	XN:i:0	XM:i:6	XO:i:2	XG:i:2	NM:i:8	MD:Z:2T0C2^A2T0A5G1A81	YS:i:0	YT:Z:DP")
  	  @l4l = BetterSam.new("FCC00CKABXX:2:1101:16909:83925#CAGATCAT	145	nivara_3s	1572267	23	5M2D3M2I3M1I86M	=	1571498	-868	GTCCTCCAGGAGGATCGGGCCTCGTGAGCCGACGGTGAGCGAGTTGTTGTTGTTCCATACGGGGGCGCCGGAGTTGGTGCTCCACAGCGGGCCGTTGAAC	BBBBBB_Z`cU]^SZS][]USKV[L`ac`dedeageeefagegagffdd`egedgggedgggggggdggggggggefeeeQgeagggggggggggggggg	AS:i:-53	XN:i:0	XM:i:4	XO:i:3	XG:i:5	NM:i:9	MD:Z:2G2^TG3T5T0A81	YS:i:0	YT:Z:DP")
	    @l4r = BetterSam.new("FCC00CKABXX:2:1101:16909:83925#CAGATCAT	145	chromosome03	1789378	23	7M4I3M5I81M	=	1788753	-716	GTCCTCCAGGAGGATCGGGCCTCGTGAGCCGACGGTGAGCGAGTTGTTGTTGTTCCATACGGGGGCGCCGGAGTTGGTGCTCCACAGCGGGCCGTTGAAC	BBBBBB_Z`cU]^SZS][]USKV[L`ac`dedeageeefagegagffdd`egedgggedgggggggdggggggggefeeeQgeagggggggggggggggg	AS:i:-59	XN:i:0	XM:i:4	XO:i:2	XG:i:9	NM:i:13	MD:Z:3A1A2T6G75	YS:i:0	YT:Z:DP")
      @l5l = BetterSam.new("FCC2HFRACXX:7:2314:9299:67450#TGACCAAT	355	Sb02g000720.1	1186	18	71M	=	1238	-150	CGTCATCTTCTCTCATATATTTGTATCACCCATCCATCCATCTGCCTTCGATATGCATCTCCACTCCGCCG	__^cc]^\`eegea`ffdfghhfd]eghhfffef``degfhf_^gdfhfg_fghhhfdhffdfhffbeWcW	AS:i:142	XN:i:0	XM:i:0	XO:i:0	XG:i:0	NM:i:0	MD:Z:71	YS:i:44	YT:Z:CP")
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

    should "parse the cigar string correctly" do
      @l3.parse_cigar
      assert @l3.cigar_list.size == 5
    end

    should "parse another cigar string correctly" do
      @l4l.parse_cigar
      assert @l4l.cigar_list.size == 7
    end

    should "mark a snp" do
      assert @l1.mark_snp(1572283)==7, "this is #{@l1.mark_snp(1572283)}, but i think it should be 7"
    end

    should "mark yet another snp" do
      assert @l4l.mark_snp(1572283)==17, "this is #{@l4l.mark_snp(1572283)}, but i think it should be 17"
    end

    should "transfer a snp from one object to another" do
      @l1.mark_snp(1572283)
      @l2.transfer_snp(@l1)
      assert @l2.snp == 7, "this is #{@l2.snp}, but i think it should be 7"
    end

    should "mark another snp" do
      assert @l2.mark_snp(1789386)==2, "this is #{@l2.mark_snp(1789386)}, but i think it should be 3"
    end

    should "mark a third snp" do
      assert @l3.mark_snp(1789386)==9, "this is #{@l3.mark_snp(1789386)}, but i think it should be 9"
    end

    should "find the location of a snp on the genome" do
      @l4l.mark_snp(1572283)
      @l4r.transfer_snp(@l4l)
      assert @l4r.put_snp==1789386, "this is #{@l4r.put_snp}, but I think it should be 1789386"
    end

    should "not be primary alignment" do
      assert !@l5l.primary_aln?
    end

    should "get the edit distance" do
      assert_equal 4, @l1.tags[:NM]
    end

  end
end

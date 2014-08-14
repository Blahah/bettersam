class BetterSam

  class SAMRecord < FFI::Struct

    # meanings of SAM flag components, with index i
    # being one more than the exponent 2 must be raised to to get the
    # value (i.e. value = 2^(i+1))
    $flags = [
      nil,
      0x1,    #  1. read paired
      0x2,    #  2. read mapped in proper pair (i.e. with acceptable insert size)
      0x4,    #  3. read unmapped
      0x8,    #  4. mate unmapped
      0x10,   #  5. read reverse strand
      0x20,   #  6. mate reverse strand
      0x40,   #  7. first in pair
      0x80,   #  8. second in pair
      0x100,  #  9. not primary alignment
      0x200,  #  10. read fails platform/vendor quality checks
      0x400   #  11. read is PCR or optical duplicate
    ]

    # NOTE: fields must be in the same order
    # here as they are in the struct definition
    # in bettersam.h
    layout :qname,    :pointer,
           :flag,     :int,
           :rname,    :pointer,
           :pos,      :int,
           :mapq,     :int,
           :cigar,    :pointer,
           :rnext,    :pointer,
           :pnext,    :int,
           :tlen,     :int,
           :seq,      :pointer,
           :qual,     :pointer,
           :tags,     :pointer,
           :filename, :pointer,
           :line,     :pointer,
           :file,     :pointer

    attr_accessor :insert, :length, :snp
    attr_reader :cigar_list

    def qname
      self[:qname].read_string
    end

    def name
      qname
    end

    def flag
      self[:flag]
    end

    def rname
      self[:rname].read_string
    end

    def chrome
      rname
    end

    def pos
      self[:pos]
    end

    def mapq
      self[:mapq]
    end

    def cigar
      self[:cigar].read_string
    end

    def rnext
      self[:rnext].read_string
    end

    def mchrom
      rnext
    end

    def pnext
      self[:pnext]
    end

    def mpos
      pnext
    end

    def tlen
      self[:tlen]
    end

    def seq
      self[:seq].read_string
    end

    def qual
      self[:qual].read_string
    end

    # returns a SAMTagSet object
    def tags
      if !@tags
        @tags = BetterSam::SAMTagSet.new(self[:tags])
      end
      @tags
    end

    # basic flag convenience methods

    def read_paired?
      flag & $flags[1] != 0
    end

    def read_properly_paired?
      flag & $flags[2] != 0
    end

    def read_unmapped?
      flag & $flags[3] != 0
    end

    def mate_unmapped?
      flag & $flags[4] != 0
    end

    def read_reverse_strand?
      flag & $flags[5] != 0
    end

    def mate_reverse_strand?
      flag & $flags[6] != 0
    end

    def first_in_pair?
      flag & $flags[7] != 0
    end

    def second_in_pair?
      flag & $flags[8] !=0
    end

    def primary_aln?
      (flag & $flags[9]) == 0
    end

    def quality_fail?
      flag & $flags[10] != 0
    end

    def pcr_duplicate?
      flag & $flags[11] != 0
    end

    # pair convenience methods

    def both_mapped?
      !(read_unmapped? && mate_unmapped?)
    end

    def pair_opposite_strands?
      (!read_reverse_strand? && mate_reverse_strand?) ||
        (read_reverse_strand? && !mate_reverse_strand?)
    end

    def pair_same_strand?
      !pair_opposite_strands?
    end

    def edit_distance
      tags.nm
    end

    def length
      @length = seq.length if !@length
      return @length
    end

    # cigar parsing methods

    def exact_match?
      tags.nm==0 && cigar=="#{seq.length}M"
    end

    def endpos
      if !@cigar_list
        parse_cigar
      end
      e = pos
      @cigar_list.each do |h|
        a = h.to_a
        bases = a[0][0]
        match = a[0][1]
        if match =~ /[MD]/
          e += bases
        end
      end
      e
    end

    def parse_cigar
      str = cigar
      l = str.length
      @cigar_list = []
      while str.length>0
        if str =~ /([0-9]+[MIDNSHPX=]+)/
          @cigar_list << {$1[0..-2].to_i => $1[-1]}
          str = str.slice($1.length, l)
        else
          puts str
        end
      end
    end

    def get_base_at p
      seq[p]
    end

  end

end

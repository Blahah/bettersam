class FasterSam

  class SAMRecord < FFI::Struct

    # NOTE: fields must be in the same order
    # here as they are in the struct definition
    # in fastersam.h
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

    def qname
      self[:qname].read_string
    end

    def flag
      self[:flag]
    end

    def rname
      self[:rname].read_string
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

    def pnext
      self[:pnext]
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
      @tags || FasterSam::SAMTagSet.new(self[:tags])
    end

  end

end

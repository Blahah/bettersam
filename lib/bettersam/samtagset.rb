class BetterSam

  class SAMTagSet < FFI::Struct

    # NOTE: fields must be in the same order
    # here as they are in the struct definition
    # in bettersam.h
    layout :xm, :int,
           :nm, :int

    # returns the number of mismatches in the alignment
    def xm
      self[:xm]
    end

    # returns the edit distance between query and target
    def nm
      self[:nm]
    end

  end

end

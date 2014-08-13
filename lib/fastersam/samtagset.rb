class FasterSam

  class SAMTagSet < FFI::Struct

    # NOTE: fields must be in the same order
    # here as they are in the struct definition
    # in fastersam.h
    layout :xm, :int,
           :nm, :int

    def xm
      self[:xm]
    end

    def nm
      self[:nm]
    end

  end

end

require 'fastersam/library'

class FasterSam

  extend FFI::Library
  ffi_lib Library.load

  attr_accessor :file

  class SAMRecord < FFI::Struct
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
  end

  attach_function :sam_iterator, [SAMRecord], :int

  def initialize file
    self.file = file
  end

  def each_record &block
    if !File.exist?(self.file)
      raise ArgumentError, "File #{self.file} does not exist"
    end
    record = SAMRecord.new
    record[:filename] = FFI::MemoryPointer.from_string self.file
    result = nil
    result = parse_sam(record, &block)
  end

  def parse_sam(record, &block)
    while (result = sam_iterator(record)) == 1
      yield record
    end
  end

end

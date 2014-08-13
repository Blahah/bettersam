require 'fastersam/library'
require 'fastersam/samtagset'
require 'fastersam/samrecord'

class FasterSam

  extend FFI::Library

  ffi_lib Library.load
  attach_function :sam_iterator, [SAMRecord], :int
  attr_accessor :file

  def initialize file
    self.file = file
  end

  def each_record &block
    if !File.exist?(self.file)
      raise ArgumentError, "File #{self.file} does not exist"
    end
    record = SAMRecord.new
    record[:filename] = FFI::MemoryPointer.from_string(self.file)
    result = nil
    result = parse_sam(record, &block)
  end

  def parse_sam(record, &block)
    while (result = FasterSam::sam_iterator(record)) == 1
      yield record
    end
  end

end

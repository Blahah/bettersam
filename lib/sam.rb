class Sam

  # meanings of SAM flag components, with index i
  # being one more than the exponent 2 must be raised to to get the
  # value (i.e. value = 2^(i+1))
  $flags = [
    nil,
    0x1,  #    1. read paired 
    0x2,  #    2. read mapped in proper pair (i.e. with acceptable insert size)
    0x4,  #    3. read unmapped
    0x8,  #    4. mate unmapped
    0x10,  #   5. read reverse strand
    0x20,  #   6. mate reverse strand
    0x40,  #   7. first in pair
    0x80,  #   8. second in pair
    0x100,  #  9. not primary alignment
    0x200,  #  10. read fails platform/vendor quality checks
    0x400]  #  11. read is PCR or optical duplicate

public
  attr_accessor :name, :flag, :chrom, :pos, :mapq, :cigar, :mchrom, :mpos, :insert, :seq, :qual, :tags

  def initialize(line=nil)
    @tags = {}
    parse_line(line) unless line.nil?
  end

  def parse_line(line)
    return false if line[0] == "@"
    
    f = line.chomp.split("\t", -1)
    raise "SAM lines must have at least 11 fields (had #{f.size})" if f.size < 11

    # colnames = %w(1:name 2:flag 3:chr 4:pos 5:mapq 6:cigar 7:mchr 8:mpos 9:insrt 10:seq 11:qual)

    @name = f[0]
    @flag = int_or_raw(f[1])
    @chrom = f[2]
    @pos = int_or_neg1(f[3])
    @mapq = int_or_neg1(f[4])
    @cigar = f[5]
    @mchrom = f[6]
    @mpos = int_or_neg1(f[7])
    @insert = int_or_raw(f[8])
    @seq = f[9]
    @qual = f[10]

    @tags = {}
    i = 11
    while i < f.size
      tag = f[i]
      i += 1
      colon_index = tag.rindex(':') 
      raise line if f.rindex == nil
      key = tag[0, colon_index]
      value = int_or_raw(tag[colon_index + 1, tag.size - colon_index] || "")
      @tags[key] = value
    end

    return true;
  end

  def read_paired?
    self.flag & $flags[1]
  end

  def read_properly_paired?
    self.flag & $flags[2]
  end

  def read_unmapped?
    self.flag & $flags[3]
  end

  def mate_unmapped?
    self.flag & $flags[4]
  end

  def read_reverse_strand?
    self.flag & $flags[5]
  end

  def mate_reverse_strand?
    self.flag & $flags[6]
  end

  def first_in_pair?
    self.flag & $flags[7]
  end

  def second_in_pair?
    self.flag & $flags[8]
  end

  def primary_aln?
    !(self.flag & $flags[9])
  end

  def quality_fail?
    self.flag & $flags[10]
  end

  def pcr_duplicate?
    self.flag & $flags[11]
  end

private

  def int_or_neg1(x)
    Integer(x) rescue -1
  end

  def int_or_raw(x)
    Integer(x) rescue x
  end

end

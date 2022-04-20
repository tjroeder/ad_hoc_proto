# Parse class, reads header checks for MPS7 magic string, and canonical information, to verify the count of created records.

class Parse
  Header = Struct.new(:magic_string, :version, :number_of_records)
  attr_accessor :binary, :header, :records
  
  def initialize(binary)
    @binary  = binary
    @header  = self.parse_mps7_header
    @records = self.create_records
  end
  
  def parse_mps7_header
    header_row = @binary.read(9).unpack('A4CN')
    raise 'Invalid MPS7 Header String Format' unless header_row.first == 'MPS7'
    Header.new(*header_row)
  end
  
  def create_records
    record_types = %i[credit debit start_autopay end_autopay]
    @records = []
    @header.number_of_records.times do
      unless @binary.eof?
        record_type = record_types.fetch(@binary.read(1).unpack('C').first)
        case record_type
        when :credit, :debit
          string = @binary.read(20).unpack('NQ>G')
        when :start_autopay, :end_autopay
          string = @binary.read(12).unpack('NQ>')
        end
        @records << Record.new(record_type, *string)
      end
    end

    unless @records.size == @header.number_of_records
      raise 'Record count does not match header count validation'
    end
  end
end

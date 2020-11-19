class RunFile < ActiveRecord::Base
  has_many :runs, dependent: :restrict_with_exception, primary_key: :digest, foreign_key: :run_file_digest

  validates :digest, presence: true, uniqueness: true
  validates :file, presence: true

  def self.for_file(file)
    if file.respond_to?(:read)
      begin
        fm = FileMagic.new(FileMagic::MAGIC_MIME)
        mime_type = fm.file(file.path())
      ensure
        fm.close
      end
      if mime_type == "application/octet-stream; charset=binary"
        RunFile.for_binary(file.read)
      else
        RunFile.for_text(file.read)
      end
    end
  end

  def self.for_text(file_text)
    digest = Digest::SHA256.hexdigest(file_text)
    where(digest: digest).first_or_create(file: file_text)
  end

  def self.for_binary(file_text)
    digest = Digest::SHA256.hexdigest(file_text)
    where(digest: digest).first_or_create(file: RunFile.unpack_binary(file_text))
  end

  def self.random
    RunFile.offset(rand(RunFile.count)).first
  end

  def self.unpack_binary(file_text)
    file_text.unpack("C*")
  end

  def self.pack_binary(character_array)
    character_array[1..-1].split(", ").map(&:to_i).pack("C*")
  end
end

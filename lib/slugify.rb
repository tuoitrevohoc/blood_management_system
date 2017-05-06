class Slugify
  class << self
    def create non_ascii_string
      non_ascii_string.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, "").downcase.to_s.parameterize
    end
  end
end

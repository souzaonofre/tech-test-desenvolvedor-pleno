require "mail"

module MailParser
  module Utils
    extend self

    def basic_record_parser(line, separator = ":")
      # check of line is valid and line have field record separator
      return nil if line.blank? or String(line).index(separator).nil?
      # split key and value side of record
      parts = String(line).chop.strip.split(separator, 2)
      # has valid parts of one record?
      return nil if parts.blank? or parts[0].blank? or parts[1].blank?
      key = String(parts[0]).downcase
      # normalize key name to valid identifier atom rule, like a slug
      key.tr!(" ", "_").tr!("-", "_") unless Mail::Utilities.atom_safe?(key)

      { "#{String(parts[0]).strip.downcase}": String(parts[1]).strip }
    end
  end
end

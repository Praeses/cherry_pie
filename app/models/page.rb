class Page < ActiveRecord::Base
  belongs_to :site
  has_many :fields

  def fields_hash
    Hash[*(fields.map{|f|[f.key.to_sym, f.value]}.flatten)]
  end

end

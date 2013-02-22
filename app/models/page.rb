class Page < ActiveRecord::Base
  belongs_to :site
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  has_many :field_objs, :class_name => 'Field'
  attr_accessible :fields


  def fields
    Hash[*(field_objs.map{|f|[f.key.to_sym, f.value]}.flatten)]
  end

  def fields= value
    fields = value.to_a.map do |pair|
      field = Field.find_or_create_by_page_id_and_key(self.id, pair[0])
      field.value = pair[1]
      field.save!
      field
    end
    self.field_objs = fields
    Field.destroy_all({:page_id => nil})
    value
  end

  def href
   read_attribute(:href) || ( self.name.blank? ? "/pages/#{id}" : "/pages/#{name}" )
  end

  scope :for_site, lambda {|x| where( :site_id => x.id ) }
  scope :for_root, lambda {|| where( :owner_id => nil ) }


end

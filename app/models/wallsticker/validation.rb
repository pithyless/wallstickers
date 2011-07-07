class Wallsticker
  validates :artist,    :presence => true
  validates :title,     :presence => true, :length => (2..50)
  validates :permalink, :presence => true, :uniqueness => true

  before_validation :strip_fields

  before_validation :set_permalink, :on => :create

  def strip_fields
    [:title].each { |v| self[v] = (self[v]||'').strip }
  end

  def set_permalink
    return if artist.blank? or title.blank?
    link = "#{artist.username}-#{title}".parameterize
    count = 1
    while Wallsticker.find_by_permalink(link)
      count += 1
      link = "#{artist.username}-#{title}".parameterize + "--#{count}"
    end
    self[:permalink] = link
  end
end


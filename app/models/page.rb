class Page < ActiveRecord::Base
  acts_as_tree

  extend FriendlyId
  friendly_id :name, :use => :scoped, :scope => :parent

  validates :name, :presence => true,
                   :format => {:with => /^[а-яА-ЯёЁa-zA-Z0-9_]+$/, :multiline => true}

  validates :title, :presence => true

  before_save :compute_path

  def compute_path
    self.path = "/" + ancestors.reverse.push(self).collect(&:name).join("/")
  end

  def all_children
    pages = []
    self.children.each do |page|
      pages << page
      root_children = page.all_children.flatten
      pages << root_children unless root_children.empty?
    end
    pages.flatten
  end

  def rename_children_paths(old_name)
    all_children.each do |item|
      item.path = item.path.gsub(old_name, self.name)
      item.save
    end
  end

  def parents
    if self.id
      Page.where("id != ?", self.id).order(:name)
    else
      Page.order(:name)	
    end
  end
end

class Project < ApplicationRecord
  validates :name, :description, presence: true
  has_many :colaborators, :dependent => :delete_all
  belongs_to :user
  has_many :users, through: :colaborators, :dependent => :delete_all
  has_many :mthreads, :dependent => :delete_all
  has_many :tasks, :dependent => :delete_all

  has_many_attached :uploads

  def badge_color
    case status
    when 'not-started'
      'secondary'
    when 'in-progress'
      'info'
    else
      'success'
    end
  end
  
  def status
    return 'not-started' if tasks.none?
    if tasks.all? { |task| task.complete? }
      'complete'
    elsif tasks.any? { |task| task.in_progress? || task.complete? }
      'in-progress'
    else
      'not-started'
    end
  end

  def percent_complete
    return 0 if tasks.none?
    ((total_complete.to_f / total_tasks) * 100).round
  end

  def total_complete 
    complete_task = tasks.select { |task| task.complete? }.count
  end

  def total_tasks
    tasks.count
  end
end

class Task < ApplicationRecord
  belongs_to :project
  validates :status, inclusion: {in: ['not-started', 'in-progress', 'complete'] } 
  validates :name, presence: true
  STATUS_OPTIONS = [
    ['Not started', 'not-started'], 
    ['In progress', 'in-progress'], 
    ['Complete', 'complete']
  ]

  def color_class
    case status
    when 'not-started'
      'secondary'
    when 'in-progress'
      'info'
    else
      'success'
    end
  end

  def readable_status
    case status
    when 'not-started'
      'Not Started'
    when 'in-progress'
      'In Progress'
    else
      'Complete'
    end
  end

  def complete?
    status == 'complete'
  end

  def in_progress?
    status == 'in-progress'
  end

  def not_started?
    status == 'not-started'
  end
end

# Method Object
#
# See also "Sprout Class" in Working Effectively with Legacy Code 

# Original:
class Obligation
  def send_task(task, job)
    not_processed, processed, copied, executed = []
    # ...150 lines of heavily commented code...
  end
end

# Refactored:

class TaskSender
  attr_accessor :obligation, :task, :job, :not_processed, :processed, 
                :copied, :executed

  def initialize(obligation, task, job)
    @obligation = obligation
    @task       = task
    @job        = job
  end

  # The Ruby convention for an "executable object" is to implement #call
  def call
    # ...150 lines of heavily commented code...
    #
    # (remembering to replace all instances of e.g. "copied =" with
    # "self.copied =")
  end
end

class Obligation
  def send_task(task, job)
    TaskSender.new(self, task, job).call
  end
end

# Or in Ruby 1.9:
class Obligation
  def send_task(task, job)
    TaskSender.new(self, task, job).()
  end
end

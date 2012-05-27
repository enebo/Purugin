require 'java'

module Purugin
  # Set of tasks for scheduling synchronous or asynchronous tasks.  Note, that most of
  # the underlying Bukkit API in which Purugin is based is not actually thread-safe.  Try
  # and use sync_task as much as possible but be aware that if you run a sync task too long
  # people will see the game lag out.
  #
  # In order to use the task methods your including class must have a _server_ and _plugin_
  # method defined.
  module Tasks
    TICKS_PER_SECOND = 20
    
    def sync_task(delay=0, repeat=-1, &block)
      delay, repeat = (delay.to_f * TICKS_PER_SECOND).to_i, (repeat.to_f * TICKS_PER_SECOND).to_i
      code = java.lang.Runnable.impl &block
      
      raise ArgumentError.new "delay must be a positive value" if delay < 0
      
      if repeat > -1
        raise ArgumentError.new "repeat must be positive value" if repeat <= 0
        task_id = server.scheduler.schedule_sync_repeating_task self, code, delay, repeat
      else
        task_id = server.scheduler.schedule_sync_delayed_task self, code, delay
      end
      
      raise Purugin::ScheduleFailedError.new if task_id == -1
      task_id
    end
    
    def async_task(delay=0, repeat=-1, &block)
      delay, repeat = (delay.to_f * TICKS_PER_SECOND).to_i, (repeat.to_f * TICKS_PER_SECOND).to_i
      code = java.lang.Runnable.impl &block
      
      raise ArgumentError.new "delay must be a positive value" if delay < 0
      
      if repeat > -1
        raise ArgumentError.new "repeat must be positive value" if repeat <= 0
        task_id = server.scheduler.schedule_async_repeating_task self, code, delay, repeat
      else
        task_id = server.scheduler.schedule_async_delayed_task self, code, delay
      end
      
      raise Purugin::ScheduleFailedError.new if task_id == -1
      task_id
    end
  end
end

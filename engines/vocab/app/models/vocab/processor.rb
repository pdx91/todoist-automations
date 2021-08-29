require_relative "../../../../vocab/lib/dictionary_api"

module Vocab
  class Processor
    attr_reader :user, :remote_task_id, :task

    def initialize(user, remote_task_id)
      @user = user
      @remote_task_id = remote_task_id
      @task = ::TodoistApi.new(user.todoist_access_token).task remote_task_id
    end

    def process(force: false)
      if task["description"].blank? || force
        word = task["content"].split.first
        responses = ::DictionaryApi.find_meaning word

        description = MeaningFormatter.new(responses).output

        TodoistApi.new(user.todoist_access_token).update_task task["id"], description: description
      end
    end

    class MeaningFormatter
      attr_accessor :output

      def initialize(responses)
        @responses = responses
      end

      def output
        ::ApplicationController.render(
          template: "dictionaries/meaning",
          layout: false,
          content_type: "text/plain",
          assigns: { responses: @responses }
        )
      end
    end
  end
end
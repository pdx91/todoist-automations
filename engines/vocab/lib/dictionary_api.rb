module DictionaryApi
  def self.find_meaning(word)
    HTTParty.get("https://api.dictionaryapi.dev/api/v2/entries/en_US/#{word}").parsed_response.map do |r|
      Response.new r
    end
  end

  class Response
    attr_accessor :response

    def initialize(response)
      @response = response
    end

    def word
      response["word"]
    end

    def meanings
      response["meanings"].map do |meaning|
        Meaning.new(meaning)
      end
    end

    class Meaning
      attr_accessor :meaning

      def initialize(meaning)
        @meaning = meaning
      end

      def part_of_speech
        meaning["partOfSpeech"]
      end

      def definitions
        meaning["definitions"].map do |definition|
          Definition.new(definition)
        end
      end
    end

    class Definition
      attr_accessor :definition

      def initialize(definition)
        @definition = definition
      end

      def word_definition
        definition["definition"]
      end

      def example
        definition["example"]
      end

      def synonyms
        definition["synonyms"]
      end

      def antonyms
        definition["antonyms"]
      end
    end
  end
end

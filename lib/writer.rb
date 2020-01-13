require './templates/g_file.rb'
require './templates/helper.rb'

module Writer
    include MakeGemfile
    include Helper

    def make_model(model_name)
        "class #{model_name} < ApplicationRecord

end"
    end

    def make_spec(model)
        "require 'rails_helper'

describe #{model} do
    it {  }
end"

    end
end

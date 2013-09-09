module Combine
  class Elevator


    def self.<<(_yield)
      Combine.config.elevator_callable.call(_yield)
    end
  end
end


#Combine.config.elevator_callable = ->(_yield){ HTTParty.post('http://endpoint', _yield) }
class Alien < ActiveRecord::Base
    has_many :visitations
    has_many :earthlings, through: :visitations

    def visit(earthling)
        puts "Greetings, #{earthling.full_name}!"
        if earthling.aliens.include? self
            puts "Remember me? #{self.earth_disguise_name}!"
        else
            puts "My name is #{self.earth_disguise_name}. Salutations."
        end
        Visitation.create!(date: Date.today, alien_id: self.id, earthling_id: earthling.id)
    end

    def count_visitations(earthling)
        self.visitations.where(earthling_id: earthling.id)
    end

    def total_light_years_traveled
        travel_time = self.light_years_to_home_planet * 2 * self.visitations.length
        puts "#{self.name} has traveled #{travel_time} light years."
        travel_time
    end

    def self.most_frequent_visitor
        self.all.max_by { |alien| alien.visitations.size }
    end

    def self.average_light_years_to_home_planet
        puts "#{self.all.sum do |alien| alien.light_years_to_home_planet end} div by #{self.all.size}"
        self.all.sum { |alien| alien.light_years_to_home_planet } / self.all.size.to_f
    end
end

require './lib/ride'
require './lib/biker'

RSpec.describe Biker do
    before(:each) do
        @biker = Biker.new("Kenny", 30)
        @biker2 = Biker.new("Athena", 15)

        expect(@biker = Biker.new("Kenny", 30)).to be_a(Biker)
        expect(@biker2 = Biker.new("Athena", 15)).to be_a(Biker)
    end

    describe '#initialize' do
        it "has attributes" do
            expect(@biker.name).to eq("Kenny")
            expect(@biker.max_distance).to eq(30)
            expect(@biker.rides).to eq({})
        end
    end

    describe '#learn_terrain!' do
        it "has a list of acceptable terrain and can learn new terrain" do
            expect(@biker.acceptable_terrain).to eq([])
            @biker.learn_terrain!(:gravel)
            @biker.learn_terrain!(:hills)
            expect(@biker.acceptable_terrain).to eq([:gravel, :hills])
        end
    end

    describe '#log_ride' do
        before(:each) do
            @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
            @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

            expect(@ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})).to be_a(Ride)
            expect(@ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})).to be_a(Ride)
        end

        it "can log a ride with a time" do
            @biker.log_ride(@ride1, 92.5)
            @biker.log_ride(@ride1, 91.1)
            @biker.log_ride(@ride2, 60.9)
            @biker.log_ride(@ride2, 61.6)
            expect(@biker.rides).to eq({{ name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills } => [92.5, 91.1],
                                        { name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel } => [60.9, 61.6]})
        end
    end

    describe '#personal_record(ride)' do
        before(:each) do
            @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
            @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

            expect(@ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})).to be_a(Ride)
            expect(@ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})).to be_a(Ride)
        end

        it "can report its personal record for a specific ride." do
            expect(@biker.personal_record(@ride1)).to eq(91.1)
            expect(@biker.personal_record(@ride2)).to eq(60.9)
        end

        it "will not log a ride if the ride's terrain does not match their acceptable terrain" do
            @biker2.log_ride(@ride1, 97.0) #biker2 doesn't know this terrain yet
            @biker2.log_ride(@ride2, 67.0) #biker2 doesn't know this terrain yet
            expect(@biker2.rides).to eq({})

            @biker2.learn_terrain!(:gravel)
            @biker2.learn_terrain!(:hills)
        end

        it "will not log a ride if the ride's total distance is greater than the Biker's max distance." do
            @biker2.log_ride(@ride1, 95.0) # biker2 can't bike this distance
            @biker2.log_ride(@ride2, 65.0) # biker2 knows this terrain and can bike this distance
            expect(@biker2.rides).to eq({@ride => [65.0]})

            expect(@biker2.personal_record(@ride2)).to eq(65.0)
            expect(@biker2.personal_record(@ride1)).to be(false)
        end
    end
end 
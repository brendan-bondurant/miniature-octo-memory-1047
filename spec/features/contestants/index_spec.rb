require "rails_helper"

RSpec.describe Contestant, type: :feature do
  before (:each) do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

    @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
    @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
    @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)


    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)
  end

  it 'shows a list of the contestants and the projects they have done' do
    # As a visitor,
    # When I visit the contestants index page ("/contestants")
    visit "/contestants"
    # I see a list of names of all the contestants
    expect(page).to have_content("Jay McCarroll")
    expect(page).to have_content("Gretchen Jones")
    expect(page).to have_content("Kentaro Kameyama")
    expect(page).to have_content("Erin Robertson")
    # And under each contestant's name I see a list of the projects (names) that they've been on
    expect(page).to have_content("News Chic", count: 2)
    expect(page).to have_content("Boardfit", count: 2)
    expect(page).to have_content("Upholstery Tuxedo")
    expect(page).to have_content("Boardfit")
    # save_and_open_page
  end

  xit 'shows a list of the contestants projects' do
    #I don't know how to write these tests, at least I can't think of it right now. 
    visit "/contestants"
    within("section#projects") do
      expect().to have_content("Jay McCarroll: News Chic")
      expect(page).to have_content("Gretchen Jones: News Chic, Upholstery Tuxedo")
      expect(page).to have_content("Kentaro Kameyama: Upholstery Tuxedo, Boardfit")
      expect(page).to have_content("Erin Robertson: Boardfit")
    end
  end

end

# (e.g.   Kentaro Kameyama
#         Projects: Litfit, Rug Tuxedo

#         Jay McCarroll
#         Projects: LeatherFeather)
# end
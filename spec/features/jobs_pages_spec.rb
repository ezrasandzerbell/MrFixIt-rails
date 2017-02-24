require 'rails_helper'

describe 'jobs path' do
  it 'will add a job' do
    worker = FactoryGirl.create(:worker)
    visit root_path
    click_on 'Log In as Worker'
    fill_in 'Email', :with => 'worker@test.com'
    fill_in 'Password', :with => '123123'
    click_on 'Log in'
    click_on 'Add Your Job'
    fill_in 'Title', :with => 'Tiler'
    fill_in 'Description', :with => 'Fix the floor'
    click_on 'Create Job'
    expect(page).to have_content('Tiler')
  end
end

describe 'jobs path' do
  it 'will claim a job', js: true do
    worker = FactoryGirl.create(:worker)
    job = FactoryGirl.create(:job)
    visit root_path
    click_on 'Log In as Worker'
    fill_in 'Email', :with => 'worker@test.com'
    fill_in 'Password', :with => '123123'
    click_on 'Log in'
    click_on 'See All Jobs'
    click_on 'Roof Tiling'
    click_on 'click here to claim it now'
    expect(page).to have_content('claimed jobs:')
  end
  it 'will test for not active and not complete', js: true do
    worker = FactoryGirl.create(:worker)
    job = FactoryGirl.create(:job)
    visit root_path
    click_on 'Log In as Worker'
    fill_in 'Email', :with => 'worker@test.com'
    fill_in 'Password', :with => '123123'
    click_on 'Log in'
    click_on 'See All Jobs'
    click_on 'Roof Tiling'
    click_on 'click here to claim it now'
    click_on 'Roof Tiling'
    click_on 'Update Job'
    expect(page).to have_content('You have claimed this project but are not currently working on it.')
  end
  it 'will test for active and not complete', js: true do
    worker = FactoryGirl.create(:worker)
    job = FactoryGirl.create(:job)
    visit root_path
    click_on 'Log In as Worker'
    fill_in 'Email', :with => 'worker@test.com'
    fill_in 'Password', :with => '123123'
    click_on 'Log in'
    click_on 'See All Jobs'
    click_on 'Roof Tiling'
    click_on 'click here to claim it now'
    click_on 'Roof Tiling'
    find(:css, "#active").set(true)
    click_on 'Update Job'
    expect(page).to have_content('You are currently working on this project.')
  end
  it 'will test for complete', js: true do
    worker = FactoryGirl.create(:worker)
    job = FactoryGirl.create(:job)
    visit root_path
    click_on 'Log In as Worker'
    fill_in 'Email', :with => 'worker@test.com'
    fill_in 'Password', :with => '123123'
    click_on 'Log in'
    click_on 'See All Jobs'
    click_on 'Roof Tiling'
    click_on 'click here to claim it now'
    click_on 'Roof Tiling'
    find(:css, "#completed").set(true)
    click_on 'Update Job'
    expect(page).to have_content('You have completed this project.')
  end
end

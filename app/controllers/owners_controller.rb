class OwnersController < ApplicationController
  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do
    @owner = Owner.create(params[:owner])
    @owner.pets << Pet.create(name: params['pet']['name']) unless params['pet']['name'].empty?
    redirect "owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do
    ####### bug fix
    params[:owner]['pet_ids'] = [] unless params[:owner].keys.include?('pet_ids')
    #######

    @owner = Owner.find(params[:id])
    @owner.update(params['owner'])
    @owner.pets << Pet.create(name: params['pet']['name']) unless params['pet']['name'].empty?
    redirect "owners/#{@owner.id}"
  end
end

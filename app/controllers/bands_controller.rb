class BandsController < ApplicationController
  # before_action :check_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    @bands = Band.alphabetical.to_a
  end

  def show
    @band = Band.find(params[:id])
  end

  def new
    @band = Band.new
    authorize! :new, @band
  end

  def edit
    @band = Band.find(params[:id])
  end

  def create
    params[:band][:genre_ids] ? genres = params[:band][:genre_ids] : genres = Array.new
    @band = Band.new(band_params) if Band.check_genres(genres)
    authorize! :new, @band

    if @band.save
      redirect_to(@band, :notice => 'Band was successfully created.')
    else
      params[:band][:genre_ids] = nil
      render :action => "new"
    end
  end

  def update
    @band = Band.find(params[:id])
    Band.check_genres(params[:band][:genre_ids])
    authorize! :update, @band

    if @band.update_attributes(band_params)
      redirect_to(@band, :notice => 'Band was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @band = Band.find(params[:id])
    authorize! :destroy, @band
    @band.destroy
  end

  private
  def band_params
    params.require(:band).permit(:name, :description, :playing_next, :when_playing_next, :photo, :song, :genre_ids => [])
  end

end

class SongsController < ApplicationController
  def index
    if params[:artist_id]
      #  What should I do if artist = nil
      # If artist_id = nil this should return a flash message saying Artist does not exist
      @artist = Artist.find_by_id(params[:artist_id])
      if @artist == nil
        flash[:message] = "Artist not found"
        redirect_to artists_path
      else
        @songs = @artist.songs
      end
    else
      # binding.pry
      @songs = Song.all
    end
  end

  def show
    if params[:id]
      @song = Song.find_by_id(params[:id])
      if @song == nil
        flash[:alert] = "Song not found"
        redirect_to artist_songs_path(params[:artist_id])
      else
        @song
      end
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

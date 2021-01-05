class SongsController < ApplicationController
  def index
    # @songs = Song.all
    if params[:artist_id]
      @artist = Artist.find_by_id(params[:artist_id])
      if @artist
        @songs = @artist.songs
      else
        redirect_to artists_path, alert: "Artist not found."
      end
    else
      @songs = Song.all
    end
  end
#   Update the songs_controller to allow the songs#index and songs#show actions to handle a valid song for the artist.
# In the songs#index action, if the artist can't be found, redirect to the index of artists, and set a flash[:alert] of "Artist not found."

  def show
    # @song = Song.find(params[:id])
    @song = Song.find_by_id(params[:id])
    if !@song
      redirect_to artist_songs_path(params[:artist_id]), alert: "Song not found."
    end
  end
  # In the songs#show action, if the song can't be found for a given artist, redirect to the index of the artist's songs and set a flash[:alert] of "Song not found."

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


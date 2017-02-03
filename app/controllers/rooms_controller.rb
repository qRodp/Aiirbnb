class RoomsController < ApplicationController
   
   before_action :set_room, only: [:show, :edit, :update, :destroy]
   before_action :authenticate_user!, except: [:show]
   before_action :require_same_user, only: [:edit, :update, :destroy]
   
   def index
      @rooms = current_user.rooms 
   end
   
   def show
       @photos = @room.photos
   end
   
   def new
       @room = current_user.rooms.build
   end
   
   def create
      @room = current_user.rooms.build(room_params)
      
      if @room.save
          
        if params[:images]
            params[:images].each do |i|
                @room.photos.create(image: i)
            end
        end
          
        @photos = @room.photos
        redirect_to edit_room_path(@room), notice:"Votre logement a été ajouté" 
         
      else
         render :new
      end
   end
   
   def edit
       @photos = @room.photos
   end
   
   def update
       if @room.update(room_params)
            if params[:images]
                params[:images].each do |i|
                    @room.photos.create(image: i)
                end
            end
           redirect_to edit_room_path(@room), notice:"Modification enregistrée..."
       else
           render :edit
       end
   end
   
   def destroy
       if @room.destroy
           flash[:success] = 'Le logement a été supprimé'
       end
       redirect_to rooms_path
   end
    
private
    def set_room
        @room = Room.find(params[:id])
    end
    
    def room_params
    params.require(:room).permit(:home_type, :room_type, :accommodate, :bed_room, :bath_room,
    :listing_name, :summary, :address, :is_wifi, :is_tv, :is_closet, :is_shampoo, :is_breakfast,
    :is_heating, :is_air, :price, :active)
    end
    
    def require_same_user
        if current_user.id != @room.user_id
            flash[:danger] = "Vous n'avez pas le droit de modifier cette page"
        redirect_to root_path
        end
    end
  
    
end
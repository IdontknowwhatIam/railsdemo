class EventsController < ApplicationController

	before_filter :find_event, :only => [ :show, :edit, :update, :destroy ]

	def index
		@events = Event.page(params[:page]).per(3)
	end

	def new 
		@event = Event.new
	end

	def create
		params.permit! 
		@event = Event.new(params[:event])
		
		if @event.save
			flash[:notice] = "event was successfully created"
			redirect_to events_url
		else 
			render :action => :new
		end
	end

	def show
		@page_title = @event.name
	end

#	alias :edit :show

	def edit
	end

	def update
		params.permit! 
		if @event.update_attributes(params[:event])
			flash[:notice] = "event was successfully update"
			redirect_to event_url(@event)
		else
			render :action => :edit
		end
	end

	def destroy
		@event.destroy
		flash[:notice] = "event was successfully destroy"
		redirect_to events_url
	end

	protected
	def find_event
		@event = Event.find(params[:id])
	end
end

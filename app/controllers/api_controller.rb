class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def respond
    rsvpCode = params[:rsvpCode]
    guest = Guest.find_by_rsvpCode(rsvpCode)
    if guest
      render json: {
        error: nil,
        data: {
          id: guest.id,
          name: guest.name,
          plusOnes: guest.plus_ones.map { |plusOne| {id: plusOne.id, name: plusOne.name, rsvped: plusOne.rsvped} },
          email: guest.email,
          comments: guest.comments
        }
      }
    else
      render status: 404, json: {
        error: "Could not find guest"
      }
  end

  def submit_form
    guestId = params[:guest_id]
    guestRsvped = params[:rsvped]
    guestEmail = params[:email]
    comments = params[:comments]
    plusOneRsvpIds = params[:plus_one_rsvps].split(",").map{ |plusOneId| plusOneId.to_i }

    guest = Guest.find(guestId)
    guest.rsvped = guestRsvped
    guest.email = guestEmail
    guest.comments = comments
    guest.responded = true
    if guestRsvped
      plusOnes = guest.plus_ones
      plusOnes.each do |plusOne|
        plusOne.rsvped = plusOneRsvpIds.include? plusOne.id
        plusOne.save!
      end
    end
    guest.save!

    render json: {
      error: nil,
      data: {
        id: guest.id,
        name: guest.name,
        plusOnes: guest.plus_ones.map { |plusOne| {id: plusOne.id, name: plusOne.name, rsvped: plusOne.rsvped} },
        email: guest.email,
        comments: guest.comments
      }
    }
  end
end
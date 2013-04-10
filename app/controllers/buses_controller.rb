class BusesController < ApplicationController
  before_filter :authenticate!

  def index
    search = AssignmentSearch.find(session[:contact_id])

    if search.errors.any?
      flash.now.alert = search.errors.full_messages.first
    end

    @assignments = search.assignments
  end

  private

  def authenticate!
    if Time.zone.now - signed_in_at > 4.hours
      session.delete(:contact_id)
      redirect_to :root, alert: 'Your session has expired.'
    elsif !session[:contact_id]
      redirect_to :root, alert: 'You need to sign in first.'
    end
  end

  def signed_in_at
    @signed_in_at ||= Time.zone.parse(session[:signed_in_at])
  end
end
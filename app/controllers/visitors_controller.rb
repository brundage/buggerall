class VisitorsController < ApplicationController
  def index
    @visitors = Visitor.all
  end
end

class BuggerController < ApplicationController

  respond_to :html, :js, :png

  def show
    respond_with do |f|
      f.html { }
      f.png { render text: BuggerallConfig.config.image.to_blob, status: 200 }
    end
  end

end

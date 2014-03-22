class ProposalsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :index, :destroy]

  def index
  end

  def new
    @proposal = Proposal.new
  end

  def create
    @proposal = current_user.proposals.build(proposal_params)
    if @proposal.save
      flash[:success] = "Proposta submetida."
      redirect_to @proposal
    else
      render 'new'
    end
  end

  def show
  end

  def destroy
  end


  private

    def proposal_params
      params.require(:proposal).permit(:title, :problem, :solution)
    end
end


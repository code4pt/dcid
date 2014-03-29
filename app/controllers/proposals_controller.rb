class ProposalsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :index, :destroy, :vote_for, :vote_against]
  before_action :correct_user,   only: :destroy

  def index
    @proposals = Proposal.paginate(page: params[:page])
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
    @proposal = Proposal.find(params[:id])
  end

  def destroy
    @proposal.destroy
    flash[:success] = "Proposta apagada."
    redirect_to user_path(current_user)
  end

  def vote_for
    begin
      current_user.vote_for(@proposal = Proposal.find(params[:id]))
      render Proposal.find(params[:id])
      # TODO show updated number to user
    rescue ActiveRecord::RecordInvalid
      render Proposal.find(params[:id])
    end
  end

  def vote_against
    begin
      current_user.vote_against(@proposal = Proposal.find(params[:id]))
      render :nothing => true, :status => 200
      # TODO show updated number to user
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end


  private

    def proposal_params
      params.require(:proposal).permit(:title, :problem, :solution)
    end

    def correct_user
      @proposal = current_user.proposals.find_by(id: params[:id])
      redirect_to root_url if @proposal.nil?
    end
end


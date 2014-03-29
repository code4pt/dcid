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
      flash[:success] = "Voto efectuado."
      # TODO show updated number to user AJAX
      if params[:id] != nil
        redirect_to @proposal
      else
        redirect_to proposals_path
      end
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Voto não efectuado: só pode votar uma vez e não pode alterá-lo."
      redirect_to proposals_path
    end
  end

  def vote_against
    begin
      current_user.vote_against(@proposal = Proposal.find(params[:id]))
      # TODO show updated number to user
      flash[:success] = "Voto efectuado."
      if params[:id] != nil
        redirect_to @proposal
      else
        redirect_to proposals_path
      end
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Voto não efectuado: só pode votar uma vez e não pode alterá-lo."
      redirect_to proposals_path
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


class NotesController < ApplicationController
  def create
    note = Note.new(note_params)
    note.track_id = params[:track_id]
    note.user_id = current_user.id

    if note.save
      flash[:notices] = ["Note submitted!"]
    else
      flash[:errors] = note.errors.full_messages
    end

    redirect_to track_url(params[:track_id])
  end

  def destroy
    note = Note.find_by_id(params[:id])

    unless note.user_id == current_user.id || is_admin?
      render status: 403
      render text: "You are not allowed"
      return
    end

    if note.nil?
      flash[:errors] = ["Note not in database"]
    else
      note.destroy!
      flash[:notices] = ["Note deleted"]
    end

    redirect_to track_url(note.track_id)
  end

  private

  def note_params
    params.require(:note).permit(:text)
  end
end

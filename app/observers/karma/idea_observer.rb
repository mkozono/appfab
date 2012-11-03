# encoding: UTF-8
class Karma::IdeaObserver < ActiveRecord::Observer
  observe :idea

  def after_create(record)
    record.author.change_karma! by:configatron.app_fab.karma.idea.created
  end

  def after_save(record)
    return unless record.state_changed?
    return unless %w(vetted picked live).include? record.state
    record.author.change_karma! by:configatron.app_fab.karma.idea.send(record.state.to_sym)
  end
end
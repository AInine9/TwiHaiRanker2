class SessionsController < ApplicationController
  include SessionsHelper

  def create
    unless request.env['omniauth.auth'][:uid]
      flash[:danger] = '連携に失敗しました'
      redirect_to root_url
    end
    user_data = request.env['omniauth.auth']
    user = User.find_by(uid: user_data[:uid])
    if user
      log_in user
      flash[:success] = 'ログインしました'

      refresh_rank(user)

      redirect_to root_url
    else
      new_user = User.new(
        uid: user_data[:uid],
        nickname: user_data[:info][:nickname],
        name: user_data[:info][:name],
        statuses_count: user_data[:extra][:raw_info][:statuses_count],
        registered_at: Date.parse(user_data[:extra][:raw_info][:created_at])
      )
      if new_user.save!
        log_in new_user
        flash[:success] = 'ユーザー登録成功'

        create_rank(new_user)
      else
        flash[:danger] = '予期せぬエラーが発生しました'
      end

      redirect_to root_url
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end

  private

  def create_rank(user)
    ranking = (user.statuses_count.to_f / (Date.today - user.registered_at.to_date)).round(2)
    new_rank = Ranking.new(
      uid: user.uid,
      tweetsperday: ranking.to_s
    )
    if new_rank.save!
      flash[:success] = 'ランキングを登録しました'
    else
      flash[:danger] = '予期せぬエラーが発生しました'
    end
  end

  def refresh_rank(user)
    ranking = (user.statuses_count.to_f / (Date.today - user.registered_at.to_date)).round(2)
    rank = Ranking.find_by(uid: user.uid)
    if rank
      if rank.update(tweetsperday: ranking)
        flash[:success] = 'ランキングを更新しました'
      else
        flash[:danger] = '予期せぬエラーが発生しました'
      end
    else
      flash[:danger] = '予期せぬエラーが発生しました'
    end
  end
end

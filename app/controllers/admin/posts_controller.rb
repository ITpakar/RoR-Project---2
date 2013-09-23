class Admin::PostsController < AdminController
  def index
    start_date, end_date = time_range_logic(params[:by]) if sort_by.eql?('likes_count')
    
    sort_str = "#{sort_by} DESC"

    posts = Post.order(sort_str).order('created_at DESC').page(params[:page]).per(20)

    if end_date.present? 
      posts = posts.where("created_at <= ?", end_date)
    end

    if start_date.present?
      posts = posts.where("created_at >= ?", start_date)
    end
    
    @posts = posts
  end

  def update
    post = Post.find(params[:id])
    if params[:pick].eql?('true')
      post.pick!
    else
      post.unpick!
    end

    redirect_to :back, page: params[:page], sort: params[:sort], by: params[:by]
  end

  def destroy
    post = Post.find(params[:id])
    user = post.user
    post.destroy
    Posts::Mailer.deleted_post(user.id).deliver

    redirect_to :back, page: params[:page], sort: params[:sort]
  end

  def flagged
    @posts = Post.flagged.order([sort_by.to_sym, :desc].join(' '), [:created_at, :desc].join(' ')).page(params[:page]).per(20)
  end

  private

    def sort_by
      %w(editors_pick likes_count flagged_count).include?(params[:sort]) ? params[:sort] : 'created_at'
    end
end
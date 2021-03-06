class Admin::QuotesController < AdminController
  def index
    respond_to do |format|
      format.html do
        @quotes = Quote.order('author_full_name ASC, id ASC').page(params[:page]).per(20)
        @db_count = Quote.count
        @solr_count = Quote.search.results.total_entries
      end
      format.csv { send_data Quote.order('author_full_name ASC, id ASC').to_csv }
    end
  end

  def new
    @quote_import = QuoteImport.new
  end

  def create
    @quote_import = QuoteImport.new(params[:quote_import])
    if @quote_import.save
      redirect_to admin_quotes_url, notice: "Imported quotes successfully."
    else
      render :new
    end
  end
end

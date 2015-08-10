class ReportController < ApplicationController
	def get_data
		@customers = Customer.order(:name)
	end

	def sale
		@sales = Sale
		.where("EXTRACT(MONTH FROM sales.transaction_date)=EXTRACT(MONTH FROM CURRENT_DATE) AND EXTRACT(YEAR FROM sales.transaction_date)=EXTRACT(YEAR FROM CURRENT_DATE) AND sales.status IN (1)")
    .order(:created_at).reverse_order
    .pagination(params[:page])

    get_data
	end

	def sale_filter
		@sales = Sale.filter_transaction_period(params[:transaction_start_date], params[:transaction_end_date])
    .filter_customer(params[:customer_id].to_i)
    .filter_status(params[:status])
    .sort_report(params[:sort])
    .pagination(params[:page])

    @sales_pdf = Sale.filter_transaction_period(params[:transaction_start_date], params[:transaction_end_date])
    .filter_customer(params[:customer_id].to_i)
    .filter_status(params[:status])
    .sort_report(params[:sort])

    @grand_total = @sales_pdf.sum(&:total_amount)

    if params[:transaction_start_date].present? && params[:transaction_end_date].blank?
      @period = ">= #{params[:transaction_start_date].to_date.strftime('%d-%m-%Y')}" 
    elsif params[:transaction_start_date].blank? && params[:transaction_end_date].present?
      @period = "<= #{params[:transaction_end_date].to_date.strftime('%d-%m-%Y')}" 
    elsif params[:transaction_start_date].present? && params[:transaction_end_date].present?
      @period = "#{params[:transaction_start_date].to_date.strftime('%d-%m-%Y')} s.d. #{params[:transaction_end_date].to_date.strftime('%d-%m-%Y')}" 
    else
      @period = "#{Date.today.strftime("%B %Y")}"
    end

    respond_to do |format|
      format.js
      format.pdf do
        pdf = SalePdf.new(@sales_pdf, view_context, ApplicationController.helpers.get_date_print, current_user.username, @period, ApplicationController.helpers.company_name, @grand_total)
        send_data pdf.render, filename: "#{I18n.t 'report.sale'}-#{Time.now.strftime("%Y%m%dT%H%M%S")}.pdf",
        type: "application/pdf", disposition: "inline"
      end
    end
	end
end
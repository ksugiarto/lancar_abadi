class SaleIndividualPdf < Prawn::Document
  def initialize(sale_id, view, company)
  # super(:page_layout => :landscape)
  super()
    @sale = Sale.find(sale_id)
    @view = view
    @company = company
    header
    content
    footer
  end

  def precision(num)
    @view.number_with_precision(num.to_f, :delimiter => ",", :separator => ".", :precision => 2)
  end

  def precision_zero(num)
    @view.number_with_precision(num.to_f, :delimiter => ",", :separator => ".", :precision => 0)
  end

  def delimiter(num)
    @view.number_with_delimiter(num.to_f, :delimiter => ",", :separator => ".")
  end

  def logo
    logopath =  "#{Rails.root}/public/assets/company_logo/logo.png"
    image logopath, :width => 110, :height => 60, :position => :center, :vposition => :top
  end

  def check_mark
    logopath =  "#{Rails.root}/app/assets/images/heavy_check_mark.png"
    image logopath, :width => 10, :height => 10, :position => :center, :vposition => :top
  end

  def header
    define_grid(:columns => 12, :rows =>6, :gutter => 10)
    # grid.show_all

    grid([0,0], [0,4]).bounding_box do
      font("Times-Roman") do
        text "#{@company.name}"
        text "Ponorogo, #{@sale.transaction_date.to_time.localtime.strftime('%d %B %Y')}"
        move_down 10
        text "No: #{@sale.si_id}"
        text "PEMBAYARAN 7 HARI"
      end
    end

    grid([0,5], [0,6]).bounding_box do
      font("Times-Roman") do
        text "INVOICE", :size => 16, :align => :center
      end
    end

    grid([0,7], [0,11]).bounding_box do
      move_down 10
      table customer_info, :cell_style => { :font => "Times-Roman", :size => 10, :height => 18 }, :width => 320 do
        self.column_widths = {0=>70, 1=>250}
        cells.borders = []
        columns(1).font_style = :bold
      end
    end
  end

  def customer_info
    [["Kepada Yth.:", (@sale.customer.try(:name)).upcase],
     ["", @sale.customer.try(:address)], 
     ["", "#{@sale.customer.try(:city).try(:name)}-#{@sale.customer.try(:province).try(:name)}"]]
  end

  def details
    @row_number=0
    [["#{I18n.t 'row_number'}", "#{I18n.t 'sale.detail.product'}", "#{I18n.t 'sale.detail.quantity'}", "#{I18n.t 'sale.detail.price_rp'}", 
      "#{I18n.t 'sale.detail.discount_%'}", "#{I18n.t 'sale.detail.added_discount_rp'}", "#{I18n.t 'sale.detail.amount_rp'}"]] +
    
    @sale.details.map do |detail|
      ["#{@row_number+=1}.", detail.product_detail_wo_code, precision_zero(detail.quantity), precision(detail.price), precision(detail.discount), precision(detail.added_discount), precision(detail.amount)]
    end +

    [[{:content => "PERHATIAN: APABILA ADA KEKELIRUAN DAN KERUSAKAN BARANG HARAP DIBERITAHUKAN DALAM WAKTU 7 HARI.", :rowspan => 3, :colspan => 3}, 
      {:content => "#{I18n.t 'sale.sub_amount'}", :colspan => 2}, "Rp", precision(@sale.sub_amount)], 
     [{:content => "#{I18n.t 'sale.discount'} (#{precision(@sale.discount)}%)", :colspan => 2}, "Rp", precision(@sale.discount_amount)], 
     # [{:content => "#{I18n.t 'sale.added_discount'}", :colspan => 2}, "Rp", precision(@sale.added_discount)],
     # [{:content => "#{I18n.t 'sale.tax'} (#{precision(10) if @sale.tax==true} #{precision(0) if @sale.tax==false}%)", :colspan => 2}, "Rp", precision(@sale.tax_amount)],
     [{:content => "#{I18n.t 'sale.total_amount'}", :colspan => 2}, "Rp", precision(@sale.total_amount)]]
  end

  def content
    sale=@sale

    # table details, :cell_style => { :font => "Times-Roman", :size => 10 }, :width => 720 do
    table details, :cell_style => { :font => "Times-Roman", :size => 10 }, :width => 540 do
      self.header = true
      cells.borders=[]
      # self.row_colors = ["FFFFFF", "F5F5F5"]
      self.column_widths = {0=>30, 1=>170, 2=>50, 3=>80, 4=>50, 5=>80, 6=>80}
      # row(0).background_color = "708DC6"
      # row(sale.details.count+1).column(0).background_color = "FFFFFF"

      column(0).align=:right
      columns(2..6).align=:right
      row(sale.details.count+1..sale.details.count+3).column(0..4).align=:left
      column(0).borders=[:left]
      column(6).borders=[:right]
      row(0).borders=[:top, :bottom]
      row(0).column(0).borders=[:top, :bottom, :left]
      row(0).column(6).borders=[:top, :bottom, :right]
      row(sale.details.count).borders=[:bottom]
      row(sale.details.count).column(0).borders=[:bottom, :left]
      row(sale.details.count).column(6).borders=[:bottom, :right]
      row(sale.details.count+3).borders=[:bottom]
      row(sale.details.count+1..sale.details.count+3).column(3).borders=[:left]
      row(sale.details.count+1..sale.details.count+3).column(6).borders=[:right]
      row(sale.details.count+1).column(0).borders=[:bottom, :left]
      row(sale.details.count+3).column(0).borders=[:bottom, :left]
      row(sale.details.count+3).column(3).borders=[:bottom, :left]
      row(sale.details.count+3).column(6).borders=[:bottom, :right]
    end
  end

  def authorization
    [["Dibuat oleh,", "Diperiksa oleh,", "Pengumpul", "Diterima oleh,


      
      "]]
  end

  def footer
    move_down 10

    # grid([5,0], [5,8]).bounding_box do
    table authorization, :cell_style => { :font => "Times-Roman", :size => 10 }, :width => 300 do
      row(0).align=:center
    end
    # end
  end
end
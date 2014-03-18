class ProductBarcodePdf < Prawn::Document
  def initialize(model)
  super()
    @model = model
    header
    content
    # footer
  end

  def precision(num)
    @view.number_with_precision(num, :delimiter => ",", :separator => ".", :precision => 2)
  end

  def delimiter(num)
    @view.number_with_delimiter(num, :delimiter => ",", :separator => ".")
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

  end

  def customer_info
    [["Kepada Yth.:", (@sale.customer.try(:name)).upcase],
     ["", (@sale.customer.try(:address)).upcase], 
     ["", "#{(@sale.customer.try(:city).try(:name)).upcase}-#{(@sale.customer.try(:province).try(:name)).upcase}"]]
  end

  def details
    @row_number=0
    [["#{I18n.t 'row_number'}", "#{I18n.t 'sale.detail.product'}", "#{I18n.t 'sale.detail.quantity'}", "#{I18n.t 'sale.detail.price_rp'}", 
      "#{I18n.t 'sale.detail.discount_%'}", "#{I18n.t 'sale.detail.added_discount_rp'}", "#{I18n.t 'sale.detail.amount_rp'}"]] +
    
    @sale.details.map do |detail|
      ["#{@row_number+=1}.", detail.product_detail_wo_code, detail.quantity, detail.price, detail.discount, detail.added_discount, detail.amount]
    end +

    [[{:content => "PERHATIAN: APABILA ADA KEKELIRUAN DAN KERUSAKAN BARANG HARAP DIBERITAHUKAN DALAM WAKTU 7 HARI.", :rowspan => 5, :colspan => 3}, 
      {:content => "#{I18n.t 'sale.sub_amount'}", :colspan => 2}, "Rp", @sale.sub_amount], 
     [{:content => "#{I18n.t 'sale.discount'} (#{@sale.discount}%)", :colspan => 2}, "Rp", @sale.discount_amount], 
     [{:content => "#{I18n.t 'sale.added_discount'}", :colspan => 2}, "Rp", @sale.added_discount],
     [{:content => "#{I18n.t 'sale.tax'} (#{'10' if @sale.tax==true} #{'0' if @sale.tax==false}%)", :colspan => 2}, "Rp", @sale.tax_amount],
     [{:content => "#{I18n.t 'sale.total_amount'}", :colspan => 2}, "Rp", @sale.total_amount]]
  end

  def barcode
    x=0
    y=665
    @model.details.each do |detail|
      barcode = Barby::Code39.new("#{detail.product.try(:barcode_id)}-097010114")
      # Barby::PrawnOutputter.new(barcode).to_pdf
      barcode.annotate_pdf(self, :x => x, :y => y)
      # text "#{detail.product.try(:barcode_id)}"
      number_pages "#{detail.product.try(:barcode_id)}-097010114", :at => [x, y-5]
      y-=100
    end
  end

  def content
    barcode

    # table details, :cell_style => { :font => "Times-Roman", :size => 10 }, :width => 720 do
    #   self.header = true
    #   cells.borders=[]
    #   self.row_colors = ["FFFFFF", "F5F5F5"]
    #   self.column_widths = {0=>30, 1=>350, 2=>50, 3=>80, 4=>50, 5=>80, 6=>80}
    #   row(0).background_color = "708DC6"
    #   row(sale.details.count+1).column(0).background_color = "FFFFFF"

    #   column(0).align=:right
    #   columns(2..6).align=:right
    #   row(sale.details.count+1..sale.details.count+5).column(0..4).align=:left
    #   column(0).borders=[:left]
    #   column(6).borders=[:right]
    #   row(0).borders=[:top, :bottom]
    #   row(0).column(0).borders=[:top, :bottom, :left]
    #   row(0).column(6).borders=[:top, :bottom, :right]
    #   row(sale.details.count).borders=[:bottom]
    #   row(sale.details.count).column(0).borders=[:bottom, :left]
    #   row(sale.details.count).column(6).borders=[:bottom, :right]
    #   row(sale.details.count+5).borders=[:bottom]
    #   row(sale.details.count+1..sale.details.count+5).column(3).borders=[:left]
    #   row(sale.details.count+1..sale.details.count+5).column(6).borders=[:right]
    #   row(sale.details.count+1).column(0).borders=[:bottom, :left]
    #   row(sale.details.count+5).column(0).borders=[:bottom, :left]
    #   row(sale.details.count+5).column(3).borders=[:bottom, :left]
    #   row(sale.details.count+5).column(6).borders=[:bottom, :right]
    # end
  end

  def authorization
    [["Dibuat oleh,", "Diperiksa oleh,", "Pengumpul", "Diterima oleh,



      "]]
  end

  def footer
    move_down 10

    grid([5,0], [5,8]).bounding_box do
    table authorization, :cell_style => { :font => "Times-Roman", :size => 10 }, :width => 500 do
      row(0).align=:center
    end
    end
  end
end
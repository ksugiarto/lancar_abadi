class ProductStickerPdf < Prawn::Document
  def initialize(model, view)
  super(:page_size => [498.5, 769.5], :page_layout => :landscape)
    @model = model
    @view = view
    content
  end

  def precision(num)
    @view.number_with_precision(num, :delimiter => ",", :separator => ".", :precision => 0)
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

  def barcode
    x=-15
    y=710
    @model.details.each do |detail| # looping all details
      (1..detail.quantity_print).each do |i| # looping as much the quantity print
        text_box "#{detail.product.try(:name)} #{detail.product.try(:product_type)} #{detail.product.try(:merk)}", :at => [x, y], :size => 6
        text_box "#{detail.product.try(:supplier).try(:supplier_code)}#{detail.product.try(:purchases).last.try(:barcode_id)}-#{precision(detail.product.try(:sales_price).to_f)}", :at => [x, y-6], :size => 6

        if x>=200
          x=-15
          y-=20
        elsif y<=30
          start_new_page
          x=-15
          y=710
        else
          x+=130
        end
      end # looping as much the quantity print
    end # looping all details
  end

  def content
    barcode
  end
end
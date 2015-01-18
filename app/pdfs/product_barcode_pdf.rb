class ProductBarcodePdf < Prawn::Document
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
    x=0
    # y=665
    y=680
    @model.details.each do |detail| # looping all details
      (1..detail.quantity_print).each do |i| # looping as much the quantity print
        barcode = Barby::Code128B.new("#{detail.product.try(:barcode_id)}-#{detail.product.try(:purchases).last.try(:barcode_id)}")

        # Barby::PrawnOutputter.new(barcode).to_pdf
        barcode.annotate_pdf(self, :x => x, :y => y, :height => 30)

        text_box "#{detail.product.try(:barcode_id)}-#{detail.product.try(:purchases).last.try(:barcode_id)} | #{detail.product.try(:name)} #{detail.product.try(:product_type)} #{detail.product.try(:merk)} | #{precision(detail.product.try(:sales_price).to_f)}", :at => [x, y-2], :size => 6

        if x>=100
          x=0
          y-=50
        elsif y<=50
          start_new_page
          x=0
          y=680
        else
          x+=190
        end
      end # looping as much the quantity print
    end # looping all details
  end

  def content
    barcode
  end
end
class SalePdf < Prawn::Document
  def initialize(models, view, date_print, employee, period, company_name)
  super()
    @models = models
    @view = view
    @date_print = date_print
    @employee = employee
    @period = period
    @company_name = company_name
    header
    content
    footer
  end

  def precision(num)
    @view.number_with_precision(num, :delimiter => ",", :separator => ".", :precision => 2)
  end

  def delimiter(num)
    @view.number_with_delimiter(num, :delimiter => ",", :separator => ".")
  end

  def currency(num)
    @view.number_to_currency(num, unit: "Rp ", :precision => 0)
  end

  def logo
    # logopath =  "#{Rails.root}/public/assets/company_logo/logo.png"
    # image logopath, :width => 110, :height => 60, :position => :center, :vposition => :top
  end

  def check_mark
    # logopath =  "#{Rails.root}/app/assets/images/heavy_check_mark.png"
    # image logopath, :width => 10, :height => 10, :position => :center, :vposition => :top
  end

  def header
    define_grid(:columns => 5, :rows => 8, :gutter => 10)
    grid(0,0).bounding_box do
      logo
    end

    grid([0,1], [0,3]).bounding_box do
      font("Times-Roman") do
        text "#{@company_name}", :align => :center, :size => 15, :style => :bold
        text "#{I18n.t 'report.sale'}", :align => :center, :size => 13, :style => :bold
        text "#{I18n.t 'report.period'}: #{@period}", :align => :center, :size => 12
      end
    end

    grid(0,4).bounding_box do
    end

    stroke do
      self.line_width = 2
      horizontal_line 0, 540, :at => 650
    end
  end

  def model_item_rows
    @number=0

    [["#{I18n.t 'row_number'}", "#{I18n.t 'sale.si_id'}",
      "#{I18n.t 'sale.transaction_date'}", "#{I18n.t 'sale.customer'}", 
      "#{I18n.t 'sale.customer_group'}", "#{I18n.t 'sale.total_amount'}" ]] +
    @models.map do |model|
      [ "#{@number+=1}.", "#{model.si_id}",
        "#{ApplicationController.helpers.date(model.try(:transaction_date))}",
        "#{model.customer_name}", "#{model.customer_group_name}",
        "#{ApplicationController.helpers.precision(model.total_amount)}" ]
    end
  end

  def content
    table model_item_rows, :cell_style => { :font => "Times-Roman", :size => 9 }, :width => 540 do
      self.header = true
      self.row_colors = ["FFFFFF", "F5F5F5"]
      self.column_widths = {0=>30, 1=>75, 2=>100, 3=>190, 4=>60, 5=>85}
      # cells.borders = []
      # rows(0).borders = [:bottom]
      row(0).font_style = :bold
      row(0).background_color = "708DC6"
      column(0).align=:right
      columns(5..6).align=:right
    end
  end

  def footer
    move_down 10

    repeat(:all) do
      stroke do
        horizontal_line 0, 540, :at => 2
      end

      number_pages "[#{I18n.t 'report.sale'} - #{I18n.t 'report.date_print'}: #{@date_print} - #{I18n.t 'report.print_by'}: #{@employee}]", :size => 9, :at => [0, 0]
    end
    number_pages "(<page>/<total>)", :size => 9, :at => [500, 0]
  end
end
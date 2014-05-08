class EmpMonthsController < ApplicationController
  # GET /emp_months
  # GET /emp_months.json
  def index
    @emp_months = EmpMonth.order(:year, :month_order)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @emp_months }
    end
  end

  # GET /emp_months/1
  # GET /emp_months/1.json
  def show
    @emp_month = EmpMonth.find(params[:id])
    @employees = Employee.where("grade IN (1,2)").order(:name)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @emp_month }
    end
  end

  # GET /emp_months/new
  # GET /emp_months/new.json
  def new
    max_each_person = 3
    max_day_persons = 1
    min_day_persons = 2
    last_leave_day = 6

    if Date.today.strftime("%m").to_i==12
      year = Date.today.strftime("%Y")+1
    else
      year = Date.today.strftime("%Y")
    end
    @emp_month = EmpMonth.create(:year => year, :month_order => Date.today.strftime("%m").to_i+1)

    # RESET ALL EMPLOYEES LEAVE DAY COUNTER
    Employee.where("grade IN (1,2)").each do |emp|
      emp.update_attributes(:last_leave_day => last_leave_day*(-1), :total_leave_day => 0)
    end
    # RESET ALL EMPLOYEES LEAVE DAY COUNTER

    (1..(1.month.from_now.end_of_month.strftime("%d")).to_i).each do |date| # looping all next month's days
      @emp_date = @emp_month.dates.create(:date_order => date.to_i)
      Employee.where("grade IN (1,2,0)").order("RANDOM()").each do |emp| # looping all employees in random order

        if "#{Date.today.strftime('%Y')}-#{1.month.from_now.strftime("%m")}-#{date}".to_date.monday? || "#{Date.today.strftime('%Y')}-#{1.month.from_now.strftime("%m")}-#{date}".to_date.tuesday? # checking day
          if emp.grade.to_i==1 && emp.total_leave_day.to_i<max_each_person && @emp_date.total_top_grade.to_i==0 && @emp_date.total_emp.to_i<max_day_persons && date.to_i-emp.last_leave_day.to_i>last_leave_day
            if emp.gender.to_i==2 && @emp_date.female_emp.to_i==0
              @emp_date.update_attributes(:total_top_grade => @emp_date.total_top_grade.to_i+1, :female_emp => @emp_date.female_emp.to_i+1, :total_emp => @emp_date.total_emp.to_i+1)
              @emp_date.details.create(:employee_id => emp.id)
              emp.update_attributes(:last_leave_day => date, :total_leave_day => emp.total_leave_day.to_i+1)
            elsif emp.gender.to_i==1
              @emp_date.update_attributes(:total_top_grade => @emp_date.total_top_grade.to_i+1, :total_emp => @emp_date.total_emp.to_i+1)
              @emp_date.details.create(:employee_id => emp.id)
              emp.update_attributes(:last_leave_day => date, :total_leave_day => emp.total_leave_day.to_i+1)
            end
          elsif emp.grade.to_i==2 && emp.total_leave_day.to_i<max_each_person && @emp_date.total_emp.to_i<max_day_persons && date.to_i-emp.last_leave_day.to_i>last_leave_day
            if emp.gender.to_i==2 && @emp_date.female_emp.to_i==0
              @emp_date.update_attributes(:female_emp => @emp_date.female_emp.to_i+1, :total_emp => @emp_date.total_emp.to_i+1)
              @emp_date.details.create(:employee_id => emp.id)
              emp.update_attributes(:last_leave_day => date, :total_leave_day => emp.total_leave_day.to_i+1)
            elsif emp.gender.to_i==1
              @emp_date.update_attributes(:total_emp => @emp_date.total_emp.to_i+1)
              @emp_date.details.create(:employee_id => emp.id)
              emp.update_attributes(:last_leave_day => date, :total_leave_day => emp.total_leave_day.to_i+1)
            end
          else
          end
        else # checking day
          if emp.grade.to_i==1 && emp.total_leave_day.to_i<max_each_person && @emp_date.total_top_grade.to_i==0 && @emp_date.total_emp.to_i<min_day_persons && date.to_i-emp.last_leave_day.to_i>last_leave_day
            if emp.gender.to_i==2 && @emp_date.female_emp.to_i==0
              @emp_date.update_attributes(:total_top_grade => @emp_date.total_top_grade.to_i+1, :female_emp => @emp_date.female_emp.to_i+1, :total_emp => @emp_date.total_emp.to_i+1)
              @emp_date.details.create(:employee_id => emp.id)
              emp.update_attributes(:last_leave_day => date, :total_leave_day => emp.total_leave_day.to_i+1)
            elsif emp.gender.to_i==1
              @emp_date.update_attributes(:total_top_grade => @emp_date.total_top_grade.to_i+1, :total_emp => @emp_date.total_emp.to_i+1)
              @emp_date.details.create(:employee_id => emp.id)
              emp.update_attributes(:last_leave_day => date, :total_leave_day => emp.total_leave_day.to_i+1)
            end
          elsif emp.grade.to_i==2 && emp.total_leave_day.to_i<max_each_person && @emp_date.total_emp.to_i<min_day_persons && date.to_i-emp.last_leave_day.to_i>last_leave_day
            if emp.gender.to_i==2 && @emp_date.female_emp.to_i==0
              @emp_date.update_attributes(:female_emp => @emp_date.female_emp.to_i+1, :total_emp => @emp_date.total_emp.to_i+1)
              @emp_date.details.create(:employee_id => emp.id)
              emp.update_attributes(:last_leave_day => date, :total_leave_day => emp.total_leave_day.to_i+1)
            elsif emp.gender.to_i==1
              @emp_date.update_attributes(:total_emp => @emp_date.total_emp.to_i+1)
              @emp_date.details.create(:employee_id => emp.id)
              emp.update_attributes(:last_leave_day => date, :total_leave_day => emp.total_leave_day.to_i+1)
            end
          else
          end
        end # checking day
      end # looping all employees in random order
    end # looping all next month's days

    respond_to do |format|
      format.html { redirect_to @emp_month, notice: 'Jadwal libur pegawai berhasil dibuat.' }
      format.json { render json: @emp_month }
    end
  end

  # DELETE /emp_months/1
  # DELETE /emp_months/1.json
  def destroy
    @emp_month = EmpMonth.find(params[:id])
    @emp_month.destroy

    respond_to do |format|
      format.html { redirect_to emp_months_url }
      format.json { head :no_content }
    end
  end
end

class MealPlanEntriesController < ApplicationController
  def create
    @meal_plan = find_or_create_meal_plan
    @meal_plan_entry = @meal_plan.meal_plan_entries.new(meal_plan_entry_params)

    if @meal_plan_entry.save
      redirect_to meal_plan_path(week: @meal_plan.starts_on), notice: "Meal added to the plan."
    else
      @starts_on = @meal_plan.starts_on
      @entries = @meal_plan.meal_plan_entries.includes(:recipe).order(:planned_on, :created_at)
      @entries_by_day = @entries.group_by(&:planned_on)
      @recipes = Current.user.recipes.order(:name)
      @week_days = (@starts_on..(@starts_on + 6.days)).to_a
      flash.now[:alert] = "Meal could not be added."
      render "meal_plans/show", status: :unprocessable_entity
    end
  end

  def destroy
    @meal_plan_entry = Current.user.meal_plan_entries.find(params.expect(:id))
    meal_plan = @meal_plan_entry.meal_plan
    @meal_plan_entry.destroy!
    redirect_to meal_plan_path(week: meal_plan.starts_on), notice: "Meal removed from the plan.", status: :see_other
  end

  private
    def meal_plan_entry_params
      params.expect(meal_plan_entry: [ :recipe_id, :planned_on ])
    end

    def find_or_create_meal_plan
      return Current.user.meal_plans.find(params.expect(:meal_plan_id)) if params[:meal_plan_id].present?

      planned_on = meal_plan_entry_params[:planned_on]
      starts_on = planned_on.present? ? Date.parse(planned_on).beginning_of_week(:monday) : Date.current.beginning_of_week(:monday)
      Current.user.meal_plans.find_or_create_by!(starts_on: starts_on)
    rescue ArgumentError
      Current.user.meal_plans.find_or_create_by!(starts_on: Date.current.beginning_of_week(:monday))
    end
end

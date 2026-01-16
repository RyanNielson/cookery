class MealPlansController < ApplicationController
  # TODO: Should this be idempotent or not create data because it's a GET.
  def show
    @starts_on = week_start
    @meal_plan = Current.user.meal_plans.find_by(starts_on: @starts_on)
    @meal_plan_entry = MealPlanEntry.new
    @entries = @meal_plan ? @meal_plan.meal_plan_entries.includes(:recipe).order(:planned_on, :created_at) : []
    @entries_by_day = @entries.group_by(&:planned_on)
    @recipes = Current.user.recipes.order(:name)
    @week_days = (@starts_on..(@starts_on + 6.days)).to_a
  end

  private
    def week_start
      if params[:week].present?
        Date.parse(params[:week]).beginning_of_week(:monday)
      else
        Date.current.beginning_of_week(:monday)
      end
    rescue ArgumentError
      Date.current.beginning_of_week(:monday)
    end
end

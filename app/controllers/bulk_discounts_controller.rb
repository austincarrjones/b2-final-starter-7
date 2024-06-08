class BulkDiscountsController < ApplicationController
  # before_action :find_bulk_discount_and_merchant, only: [:show, :update]
  # before_action :find_merchant, only: [:index]
  
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.create!(percentage_discount: params[:percentage_discount], 
                        quantity_threshold: params[:quantity_threshold],
                        merchant: @merchant)
    # if @bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant), notice: 'Bulk discount was successfully created.'
    # else
    #   render :new
    # end
  end

  # private - this was not working correctly and was not covered.
  # def bulk_discount_params
  #   params.require(:bulk_discount).permit(:percentage_discount, :quantity_threshold)
  # end

  # def find_bulk_discount_and_merchant
  #   @bulk_discount = BulkDiscount.find(params[:id])
  #   @merchant = Merchant.find(params[:merchant_id])
  # end

  # def find_merchant
  #   @merchant = Merchant.find(params[:merchant_id])
  # end

end
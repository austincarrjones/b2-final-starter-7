class BulkDiscountsController < ApplicationController
  # before_action :find_bulk_discount_and_merchant, only: [:show, :update]
  # before_action :find_merchant, only: [:index]
  
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
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

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    if @bulk_discount.update(percentage_discount: params[:percentage_discount], quantity_threshold: params[:quantity_threshold])
      flash.notice = "Succesfully Updated Discount Info!"
      redirect_to merchant_bulk_discount_path(@merchant, @bulk_discount)
    else
      flash.notice = "All fields must be completed, get your act together."
      redirect_to edit_merchant_bulk_discount_path(@merchant, @bulk_discount)
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(@merchant), notice: 'Bulk discount was successfully deleted.'
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
class InvoicesController < ApplicationController
  def show
    render json: Invoice.find(params[:id])
  end

  def create
    @invoice_code = Lightning.new.create_invoice(invoice_params[:amount], "Pay #{invoice_params[:amount]} to play")
    @invoice = Invoice.new(user_id: invoice_params[:user_id], amount: invoice_params[:amount], invoice_code: @invoice_code)
    @invoice.save
    render json: @invoice, status: 201
  end

  def update
    @invoice = Invoice.find(params[:id])
    @status = Lightning.new.get_invoice_status(@invoice.invoice_code)["settled"]
    @invoice.update(paid:  @status == 1)

    if @invoice.paid
      Bet.create(user_id: @invoice.user_id, amount: @invoice.amount)
    end
    render json: @invoice, status: 200
  end

  def pay_invoice
    render json: Invoice.pay_winner, status: 200
  end

  private

  def invoice_params
    params.permit(:user_id, :amount, :paid, :invoice_to_pay)
  end
end
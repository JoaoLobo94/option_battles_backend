class InvoicesController < ApplicationController
  def show
    render json: Invoice.find(params[:id])
  end

  def create
    @invoice_code = Lightning.new.create_invoice(invoice_params[:amount].to_i)
    @invoice = Invoice.new(user_id: current_user.id, amount: invoice_params[:amount], invoice_code: @invoice_code)
    @invoice.save
    render json: { id: JSON.parse(@invoice.id.to_s), :payment_request => JSON.parse(@invoice.invoice_code)['payment_request'], payment_hash: JSON.parse(@invoice.invoice_code)['payment_hash']}, status: 201
  end

  def update
    @status = Lightning.new.get_invoice_status(invoice_params[:payment_hash])["settled"]
    return  render json: @invoice, status: 402 unless @status

    @invoice = Invoice.find(invoice_params[:id])

    if @status
      @invoice.update(paid:  @status)
    end

    if @invoice.paid
      @invoice.user.update(balance: @invoice.user.balance + @invoice.amount)
      render json: @invoice, status: 200
    end
  end

  private

  def invoice_params
    params.permit(:id, :user_id, :amount, :paid, :payment_hash, :direction)
  end
end
class QrcodesController < ApplicationController
  before_action :set_qrcode, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /qrcodes
  # GET /qrcodes.json
  def index
    @qrcodes=current_user.qrcodes
    #@qrcodes = Qrcode.all
  end

  # GET /qrcodes/1
  # GET /qrcodes/1.json
  def show
    if Qrcode.find(params[:id]).user_id == current_user.id
      @q = RQRCode::QRCode.new(Qrcode.find(params[:id]).link).to_img.resize(200, 200).to_data_url
    else
        render 'otheruser'
        #render :text => "You are not allowed to view this"
    end
  end

  # GET /qrcodes/new
  def new
    @qrcode = Qrcode.new

  end

  # GET /qrcodes/1/edit
  def edit
  end

  # POST /qrcodes
  # POST /qrcodes.json
  def create
    @qrcode = Qrcode.new(qrcode_params)
    @qrcode.user_id = current_user.id
    respond_to do |format|
      if @qrcode.save
        format.html { redirect_to @qrcode, notice: 'Qrcode was successfully created.' }
        format.json { render :show, status: :created, location: @qrcode }
      else
        format.html { render :new }
        format.json { render json: @qrcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qrcodes/1
  # PATCH/PUT /qrcodes/1.json
  def update
    respond_to do |format|
      if @qrcode.update(qrcode_params)
        format.html { redirect_to @qrcode, notice: 'Qrcode was successfully updated.' }
        format.json { render :show, status: :ok, location: @qrcode }
      else
        format.html { render :edit }
        format.json { render json: @qrcode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qrcodes/1
  # DELETE /qrcodes/1.json
  def destroy
    @qrcode.destroy
    respond_to do |format|
      format.html { redirect_to qrcodes_url, notice: 'Qrcode was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qrcode
      @qrcode = Qrcode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qrcode_params
      params.require(:qrcode).permit(:link)
    end
end

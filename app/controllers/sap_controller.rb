# -*- encoding : utf-8 -*-

require 'rs'
require 'telasi-ruby'

class SapController < ApplicationController

  def index
    @title = 'SAP'
  end

  def waybill
    @title = 'სასაქონლო ზედნადები'
    if request.post?
      doc = Telasi::SAP::MaterialDocumentHeader.where(:mblnr => params[:number]).first
      @waybill = Telasi::SAP.material_doc_to_waybill(doc)
    end
  end

  def send_waybill
    doc = Telasi::SAP::MaterialDocumentHeader.where(:mblnr => params[:number]).first
    waybill = Telasi::SAP.material_doc_to_waybill(doc)
    waybill.status = RS::Waybill::STATUS_SAVED
    # სატესტოზე გაგზავნა!!!
    waybill.seller_id = 731937
    waybill.seller_tin = '206322102'
    waybill.seller_name = 'სატესტო კოდი'
    waybill.buyer_tin = '206322102'
    waybill.buyer_name = 'სატესტო კოდი'
    waybill.car_number = 'WDW842'
    # waybill.items.pop
    # გაგაზავნა
    RS.save_waybill(waybill, {'su' => 'dimitri1979', 'sp' => '123456'})
    render :text => "#{waybill.id} -- #{waybill.error_code}"
  end

end

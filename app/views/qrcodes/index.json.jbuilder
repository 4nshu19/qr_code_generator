json.array!(@qrcodes) do |qrcode|
  json.extract! qrcode, :id, :link
  json.url qrcode_url(qrcode, format: :json)
end

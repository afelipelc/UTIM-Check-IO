class DevicesDatatable
  delegate :params, :link_to, to: :@view

  def initialize(view)
    @view = view
    #puts "BUSCAR>>>> " + params[:sSearch]
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Device.count,
      iTotalDisplayRecords: devices.total_entries,
      aaData: data
    }
  end

private

  def data
    devices.map do |device|
      [
        link_to(device.devicetoken, @view.search_devices_path(:id => device.devicetoken)),
        device.tipo,
        device.noserie,
        device.owner.nombre,
        device.ultimavez.strftime("%d %b %y %H:%M:%S"),
        link_to("Editar", @view.search_devices_path(:id => device.devicetoken)) + "  " +
        link_to("Registros", @view.logs_entries_path(:id => device.id),:remote=> "true")
        #link_to(device.id)
      ]
    end
  end

  def devices
    @devices ||= fetch_devices
  end

  def fetch_devices
    devices = Device.order("#{sort_column} #{sort_direction}")
    devices = devices.page(page).per_page(per_page)
    
    if params[:sSearch].present?
      #devices = devices.where("noserie like :search or marca like :search", search: "%#{params[:sSearch]}%")
      devices = devices.joins(:owner).where("noserie like :search or marca like :search or nombre like :search", search: "%#{params[:sSearch]}%")
    end
    devices
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[id tipo noserie owner_id ultimavez]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
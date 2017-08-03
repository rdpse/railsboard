module Monitoramento
  extend ActiveSupport::Concern

  def actualizar_hdd
    storage = self.run('df -B1 | (read -r; printf "%s\n" "$REPLY"; sort -k2 -rn)').split("\n")
    header = storage.shift.split(' ',6)
    storage = storage.map {|line| line.split}
    report = Ruport::Data::Table.new data: storage, column_names: header

    # Account for different OS languages and partitions
    blocks_name = header[1]
    used_name = header[2]

    total = report.column(blocks_name)[0]
    usado = report.column(used_name)[0]
     
    update_columns(hdd_utilizado: usado, hdd_total: total)
  end

  def actualizar_ram
    memory = self.run('free -mb').split("\n")

    memory.delete_at(0)
    memory = memory[0].split

    total = memory[1]
    usado = memory[2]

    update_columns(ram_utilizado: usado, ram_total: total)
  end

  def actualizar_trafego
    trafego = self.run 'ifconfig eth0 | grep "RX bytes"'

    trafego = trafego.gsub(':',' ').split
    usado = trafego[2].to_i + trafego[7].to_i   ## [2] = RX | [7] = TX

    update_attribute :trafego_usado, usado
  end

end

defmodule GenReport.ReportMap do
  @people [
    "Daniele",
    "Mayk",
    "Giuliano",
    "Cleiton",
    "Jakeliny",
    "Joseph",
    "Diego",
    "Danilo",
    "Rafael",
    "Vinicius"
  ]

  @months {
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro"
  }

  @years ["2016", "2017", "2018", "2019", "2020"]

  def create_map() do
    %{
      "all_hours" => create_hours(),
      "hours_per_month" => create_hours_per_month(),
      "hours_per_year" => create_hours_per_year()
    }
  end

  defp create_hours() do
    Enum.into(@people, %{}, &{&1, 0})
  end

  defp create_hours_per_month() do
    months = Enum.into(Tuple.to_list(@months), %{}, &{&1, 0})
    Enum.into(@people, %{}, &{&1, months})
  end

  defp create_hours_per_year() do
    years = Enum.into(@years, %{}, &{&1, 0})
    Enum.into(@people, %{}, &{&1, years})
  end

  def month_tuple() do
    @months
  end
end

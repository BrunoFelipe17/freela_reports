defmodule GenReport do
  alias GenReport.Parser

  def build(file_name) do
    file_name
    |> Parser.parse_file()
    |> Enum.reduce(create_map(%{}, %{}, %{}), fn line, report -> sum_values(line, report) end)
  end

  defp sum_values(
         [name, hours, _day, month, year],
         %{
           "all_hours" => all_hours,
           "hours_per_month" => hours_per_month,
           "hours_per_year" => hours_per_year
         }
       ) do
    all_hours = merge_maps(all_hours, %{name => hours})
    hours_per_month = merge_multi_maps(hours_per_month, %{name => %{month => hours}})
    hours_per_year = merge_multi_maps(hours_per_year, %{name => %{year => hours}})

    create_map(all_hours, hours_per_month, hours_per_year)
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, v1, v2 -> v1 + v2 end)
  end

  defp merge_multi_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, v1, v2 ->
      merge_maps(v1, v2)
    end)
  end

  def create_map(all_hours, hours_per_month, hours_per_year) do
    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end
end

defmodule GenReport.Parser do
  def parse_csv(file_name) do
    "report/#{file_name}"
    |> File.stream!()
    |> Enum.map(&parse_line(&1))
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
  end
end

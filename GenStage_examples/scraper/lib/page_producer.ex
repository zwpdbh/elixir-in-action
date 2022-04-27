# pages = 1..17 |> Enum.to_list
# PageProducer.scrape_pages(pages)
defmodule PageProducer do
  use GenStage

  require Logger

  def start_link(_args) do
    initial_state = []
    GenStage.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def init(initial_state) do
    Logger.info("PageProducer init")
    {:producer, initial_state}
  end

  # Got called when the producer receive demand from a consumer.
  # It is useful when we want to respond to the consumer demand immediately and keep consumer busy.
  def handle_demand(demand, state) do
    Logger.info("Received demand for #{demand} pages")
    events = []
    {:noreply, events, state}
  end

  def scrape_pages(pages) when is_list(pages) do
    GenStage.cast(__MODULE__, {:pages, pages})
  end

  # Here, in handle_cast callback, we update the events needed to be processed as our pages.
  def handle_cast({:pages, pages}, state) do
    # {:noreply, [event], new_state}
    {:noreply, pages, state}
  end
  
end

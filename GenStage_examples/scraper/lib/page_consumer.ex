defmodule PageConsumer do
  use GenStage
  require Logger

  # def start_link(_args) do
  #   initial_state = []
  #   GenStage.start_link(__MODULE__, initial_state)
  # end

  # def init(initial_state) do
  #   Logger.info("PageConsumer init")
  #   sub_opts = [{PageProducer, min_demand: 0, max_demand: 1}]
  #   {:consumer, initial_state, subscribe_to: sub_opts} # this is how stage are lnked together
  # end

  # # speciall call backes for :consumer and :producer_consumer
  # def handle_events(events, _from, state) do
  #   Logger.info("PageConsumer received #{inspect(events)}")

  #   events
  #   |> Enum.each(fn _page -> Scraper.work() end)

  #   {:noreply, [], state}
  # end

  # We don't need above code because now the responsibility to handle event is transfered
  # to PageConsumerSupervisor. But it only messages demand, receives events and starts new process.
  # It doesn't do any work, so we do actual work here. (see page 77)
  def start_link(event) do
    Logger.info("PageConsumer received #{event}")

    Task.start_link(fn -> Scraper.work() end)
  end
end

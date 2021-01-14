defmodule GenCounter.Consumer do
    use GenStage
    def start_link(_) do
        GenStage.start_link(__MODULE__, :state)
    end

    @impl true
    def init(state) do
        {:consumer, state, subscribe_to: [GenCounter.ProducerConsumer]}
    end

    @impl true
    def handle_events(events, _from, state) do
        for event <- events do
            IO.inspect {self(), event, state}
        end
        {:noreply, [], state}
    end
end

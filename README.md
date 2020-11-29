# 2-state-stochastic-neuron-model
I tried to model a neuron firing as a 2-state Markov process. 

I have taken a fixed time interval and a constant input. The input varies in this model but the interval is predecided.

The hidden states are armed and refractory. The observable states are firing and not-firing.

The neuron fires at a constant rate(on average as the firing is probabilistic) in the absence of an input(when input is zero).
When the input is non-zero (only positive input is considered in this model), the model crudely transforms the input into a probability.

The process is in continuous time where the hidden states change depending on the current state and the value of the input. 
If armed, the state transition occurs after an exponentially distributed amount of time that depends on the input value such that higher the input the higher is the rate of firing. On trasition from the armed state the neuron either stays armed or fires (with a probability dependant on the input value) and switches state to refractory.
If in refractory stste, the state transition occurs after an exponentially distributed amount of time that has a constant rate of recovery ie the probability of transition after time t in refractory state is the same as the probability of an exponential random variable with a certain rate of events occuring. On transition, it necessarily changes state to armed.

Final output is a sequence of firings that depend on the input value. 


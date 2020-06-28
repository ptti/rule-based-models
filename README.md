# Scaling up epidemiological models with rule-based modelling

This is a collection of models as described in our paper,
[Scaling up epidemiological models with rule-based modelling].
They are written in the [Kappa language] and the models themselves
can be found in the [models/ subdirectory] of the repository on
the Github. It is also possible to simulate them in your web
browser with the links below:

* [Masks]
* [Fomites and hand-washing]
* [Vector-borne disease]
* [Testing]
* [Testing and contact tracing]
* [Schools as accelerants]
* [Gathering and superspreading]

The models may be run in the [Kappa language] app for inspection
and experimentation. To reproduce the data used in the paper, a
UNIX-like system is needed with the following installed and in
your PATH:

* KaSim, the [Kappa language] simulator
* [GNU parallel] to sample trajectories using all CPUs
* [GNU make] to orchestrate the simulations
* [Python 3] with [NumPy] and [SciPy] to collate the results

Only KaSim is truly necessary to work with these models, the rest
is just convenient [lazy plumbing]. Once those things are installed,
simply typing,

    make

in the top level directory should be enough to generate all of the
data. It may take anywhere from 10 minutes to a couple of hours
depending on how fast your system is and how many CPU cores it has.

To sample a single trajectory, perhaps for debugging, a command
such as,

    KaSim -l 365 -o output.csv models/masks.ka

will do. Combining models, or model fragments just means adding more
files on the command line, as is done with the [Vector-borne disease]
example to include habitat destruction:

    KaSim -l 365 models/mosquitoes.ka models/mosquito-habitat.ka

For more complete information on how to use KaSim, see the
[Kappa language] documentation.

[Masks]: https://ptti.github.io/kasim/?model=https%3A//raw.githubusercontent.com/ptti/rule-based-models/master/models/masks.ka
[Fomites and hand-washing]: https://ptti.github.io/kasim/?model=https%3A//raw.githubusercontent.com/ptti/rule-based-models/master/models/fomites.ka
[Vector-borne disease]: https://ptti.github.io/kasim/?model=https%3A//raw.githubusercontent.com/ptti/rule-based-models/master/models/mosquitoes.ka
[Testing]: https://ptti.github.io/kasim/?model=https%3A//raw.githubusercontent.com/ptti/rule-based-models/master/models/testing.ka
[Testing and contact tracing]: https://ptti.github.io/kasim/?model=https%3A//raw.githubusercontent.com/ptti/rule-based-models/master/models/tracing.ka
[Schools as accelerants]: https://ptti.github.io/kasim/?model=https%3A//raw.githubusercontent.com/ptti/rule-based-models/master/models/school.ka
[Gathering and superspreading]: https://ptti.github.io/kasim/?model=https%3A//raw.githubusercontent.com/ptti/rule-based-models/master/models/super.ka
[Kappa language]: https://kappalanguage.org/
[models/ subdirectory]: https://github.com/ptti/rule-based-models/tree/master/models
[GNU parallel]: https://www.gnu.org/software/parallel/
[GNU make]: https://www.gnu.org/software/make/
[Python 3]: https://python.org/
[NumPy]: https://numpy.org/
[SciPy]: https://scipy.org/
[lazy plumbing]: http://blogoscoped.com/archive/2005-08-24-n14.html

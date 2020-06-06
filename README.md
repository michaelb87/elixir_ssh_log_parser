# SshParser

Parses SSH syslog messages.
See tests on how to use.

Currently supported:
  - Success
  - User Fail
  - Disconnect
  - Session Close
  - Connection Close

## Benchmarks

`mix run lib/benchmark.exs`

```Operating System: Linux
CPU Information: Intel(R) Core(TM) i5-4300U CPU @ 1.90GHz
Number of Available Cores: 4
Available memory: 11.43 GB
Elixir 1.10.3
Erlang 23.0.2

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
parallel: 1
inputs: none specified
Estimated total run time: 35 s

Benchmarking accepted...
Benchmarking disconnect...
Benchmarking received_disconnect...
Benchmarking session_close...
Benchmarking user_fail...

Name                          ips        average  deviation         median         99th %
session_close            898.66 K        1.11 μs  ±2777.60%        0.86 μs        1.70 μs
disconnect               811.46 K        1.23 μs  ±2485.94%        1.03 μs        2.42 μs
received_disconnect      163.87 K        6.10 μs   ±277.37%        5.13 μs       14.94 μs
user_fail                118.91 K        8.41 μs   ±198.29%        7.31 μs       22.64 μs
accepted                  78.89 K       12.68 μs    ±66.21%       11.44 μs       31.47 μs```

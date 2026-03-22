# Minutes-to-Days Feedback: Observability

Tests and CI answer the question "is the code correct?" But there is a class of questions they cannot answer: how does the code behave once it is actually running in a real environment?

A recommendation system passes all tests, CI is green across the board, deployment goes smoothly. But after launch, it recommends the same product every time. From an IT perspective, everything is fine: fast response times, no errors, correct database reads and writes. From a business perspective, it is a complete failure. This kind of problem only surfaces at runtime, because it is not a logic error in the code — it is a gap between the code's behaviour and business expectations.

Observability provides feedback at this level. Logs, metrics, and distributed traces form the three pillars of runtime signals. Logs record discrete events (what happened), metrics record aggregate trends (how is the system's state changing), and traces record causal relationships (which services did a request pass through, and where did it slow down).

For Agent-driven development, observability carries two particular significances.

First, it fills the gap in the feedback spectrum that tests cannot cover. Static analysis handles millisecond-level syntax issues, tests handle second-level logic issues, CI handles minute-level integration issues. Observability handles hour-to-day-level runtime issues: is memory slowly leaking? Is the error rate climbing? Is P99 latency for a particular endpoint degrading? These signals have the longest delay, but they also cover the widest problem domain.

Second, observability provides Agents with feedback dimensions beyond "pass or fail". Test results are binary — green or red. Observability signals are continuous: latency rising from 50ms to 200ms is not a "failure", but it is worth noting. Error rate climbing from 0.1% to 0.5% has not triggered an alert, but the trend is wrong. This kind of continuous signal demands more sophisticated course-correction from Agents, while also offering richer room for improvement.

In practice, having Agents directly consume observability data presents challenges. Logs are often unstructured text — meaningful to humans but noise to Agents. Massive volumes of metric data need to be aggregated and filtered first, or the Agent's context window will be flooded with irrelevant information. The effective approach is to build a "summary layer" for observability: processing raw signals into structured, actionable feedback. Not dumping a million log lines on the Agent, but telling it "over the past hour, 5xx error rate for `payment-service` increased by 300%, here are five representative error logs."

There is also an easily overlooked problem: static code analysis cannot capture runtime topology changes. Virtual machine migration to containers, single-datacentre to multi-active architecture — these changes are not reflected in code but profoundly affect runtime behaviour. Observability is the only means of perceiving such changes.

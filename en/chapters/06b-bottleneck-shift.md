# Bottleneck Shift: From Code to Organization

The traditional software team's bottleneck is at the execution layer: code is not written fast enough, not enough features are delivered. The solution is to add people. Each new engineer brings incremental coding capacity, and team output grows with headcount.

Agents make execution cheap. One engineer plus Agents can increase coding output by an order of magnitude. But the cost of directing and verifying has not decreased in sync. Defining requirements still requires humans to understand the business. Designing architecture still requires human engineering judgment. Verifying that output matches intent still requires human review. These tasks cannot simply be handed off to Agents.

The bottleneck has shifted from "writing code" to "organizing humans." The team's limiting factor is no longer how many people are writing code, but how humans organize themselves to direct and verify Agent output.

PingCAP CTO 黄东旭 observed a deeper phenomenon in practice. The workflows and best practices of top vibe coders are not the same. Each person has developed their own way of directing Agents: different prompt strategies, different verification workflows, different tool combinations. Two top vibe coders struggle to collaborate within the same module; "the same territory cannot easily accommodate two alpha wolves, resulting in 1+1 < 2."

This means the traditional linear scaling model of "more people equals more output" has completely broken down. Not just because Agents changed output speed, but because the way humans direct Agents is highly personalized and difficult to standardize and compose.

The organizational design challenge thus becomes: how to let multiple humans each efficiently command their own Agent fleets while ensuring their outputs integrate into a coherent system?

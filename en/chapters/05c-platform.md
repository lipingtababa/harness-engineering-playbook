# Build the Runway Before Launching the Planes: Platform Engineering First

You start building isolation mechanisms, writing API Contracts, and configuring integration tests. You realise: before multiple Agents start writing business code, a significant amount of infrastructure needs to be in place first.

Building this infrastructure is a project in itself. If you try to retrofit it after Agents have already started working in parallel, you will find yourself fighting fires while paving the road at the same time. Platform engineering must exist before business code. Before launching the first parallel Agent, the runway must be paved.

But what exactly does "the runway" include? In earlier chapters, testing was the primary channel through which Agents received feedback: write a test, run it, red or green, decide what to do next. That channel is essential, but it is only part of the Agent's sensory system. Human engineers receive far more feedback than test results while writing code: red squiggly lines in the editor, CI pipeline build status, exception stack traces in logs, monitoring metrics after deployment. These signals span timescales from milliseconds to days, forming a multi-layered feedback system.

Agents need this system too. If their only signal source is "tests pass or fail", many problems will be discovered far too late. Type errors wait until test execution to surface. Environment discrepancies wait until deployment to appear. Performance regressions wait until user complaints to become known. Each missing layer of feedback means longer survival times for deviations and higher costs to fix them.

The core task of platform engineering is to build this sensory system layer by layer, from shortest to longest feedback delay.

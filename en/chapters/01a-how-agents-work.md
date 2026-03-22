# How Agents Work

To understand the structural characteristics of Agents, you first need to understand their technical foundation. This section introduces four core concepts: large language models, the context window, the agentic loop, and the session model.

## Large Language Models: Probabilistic Generation Based on All Input Content

At the core of an AI Agent is a large language model (LLM). The way an LLM works can be summarized in one sentence: given all input content, it generates the most probable next token, one at a time.

The key to this process is the attention mechanism. Each time a token is generated, the model looks back at all input content, calculates a relevance weight for each part, and synthesizes this information to make a decision. This means two things. First, the output is entirely determined by the input. The same input produces the same output in the vast majority of cases. Second, as the input content grows, pieces of information compete with each other for attention. A critical business rule may be drowned out by a large volume of context, causing its influence on the output to be diluted.

This is the technical root cause of Agents being "forgetful" in long contexts: the more information there is, the more diffuse the attention given to each piece becomes.

## Context Window: The Agent's Entire Working Memory

The context window is the total information an LLM can process in a single interaction. It includes system instructions, user input, conversation history, code files, and tool call results, all concatenated into a single token sequence and fed into the model.

The window has a hard upper limit. Information exceeding this limit is truncated and, as far as the model is concerned, simply does not exist. More importantly, effective capacity is significantly less than the nominal capacity. Research shows that even within the token limit, the model's recall of information in the middle of the window is significantly lower than at the beginning and end. A window nominally rated at 128K tokens may only effectively use about half of that.

Everything outside the window, as far as the Agent is concerned, has never existed.

## Agentic Loop: The Perceive-Think-Act Cycle

A standalone LLM can only do one thing: take text in, produce text out. An Agent adds the ability to interact with the external world on top of this, forming a loop: receive instructions, reason about the next action, call tools (read files, execute commands, call APIs), observe the results returned by tools, reason again, act again. This loop continues until the task is complete or a termination condition is reached.

The results of each loop iteration are appended to the context window. This means that as the number of iterations increases, the content in the window grows. Early reasoning and decisions gradually get pushed toward the far end of the window, receiving decreasing attention weights. An architectural decision made in iteration 5 may be effectively forgotten by iteration 50. The Agent may contradict itself within the same session: a design pattern adopted in the first half is silently abandoned in the second half.

## Sessions and Instances

Agents work in units of sessions. A session starts when the user issues an instruction and ends when the task is complete or the session is closed. After a session ends, all information in the context window is cleared. The next session starts from a blank context.

At the same time, Agents can be trivially parallelized. The cost of launching a second, tenth, or hundredth Agent instance approaches zero. This stands in stark contrast to human teams: adding one human team member comes with nonlinear growth in hiring, training, and coordination costs.

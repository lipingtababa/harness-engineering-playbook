# Define Boundaries Before Deploying Agents: Conway's Law Still Applies

Conway's Law says: the architecture of a system mirrors the organizational structure of the team that built it. A compiler built by four groups will end up being a four-pass compiler. This law still holds in the Agent era, and is in fact even more important.

黄东旭 found in practice that when a single module's complexity exceeds roughly fifty thousand lines of code, Agents struggle to resolve issues in a single interaction. Moreover, Agents typically do not proactively govern project structure and module boundaries; they tend to write everything into a few large files. In the short term this appears fast; in the long term it is a debt explosion.

This means module boundaries must be designed by humans in advance. The role of the architect in the Agent era does not become less important; it becomes more important. The architect needs to pre-partition the system into modules that Agents can handle, define the interface contracts between modules, and ensure each module's scale and complexity falls within the Agent's effective processing range.

Module boundaries simultaneously serve as organizational boundaries and Agent work fences. In the alpha wolf model, module boundaries are territorial boundaries, with each alpha wolf working within their own territory. In the PTO model, module boundaries determine the scope a three-person group is responsible for. In multi-Agent parallel development (Chapter 5), module boundaries determine each Agent's isolation space.

Design the organizational structure and module boundaries first, then let Agents work within that structure. Do it the other way around, letting Agents write code first and organizing structure later, and you get the situation 黄东旭 describes: files with tens of thousands of lines, requiring a full stop for manual refactoring.

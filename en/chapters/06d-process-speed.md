# Making Processes Match Agent Speed

Regardless of which organizational model you choose, there is a common problem to face: existing processes are too slow.

An Agent-driven team should be able to complete a user story in a day. What does this speed mean? Define requirements and acceptance criteria in the morning, finish design and test framework setup before lunch, have the Agent complete implementation and testing in the afternoon, and accept, merge, and ship by evening. The Claude Code team's release cadence is 10 versions in 10 days, with some days releasing two to three versions.

At this speed, every manual waiting step in traditional processes becomes a bottleneck.

Four-eyes code review requires two people to review every piece of code. When the Agent finishes a feature in a day, scheduling two reviewers takes three days. The change approval board meets once a week; an Agent can deploy ten times a day. The manual deployment process requires scheduling operations staff, with slots available only once a week.

These processes were reasonable at human execution speed: they provided quality assurance and risk control. But at Agent speed, the assurance they provide is offset by the waiting cost. The waiting itself is a risk: code sits for three days before review, and by then the reviewer's context has faded, actually lowering review quality.

Every process step needs to be re-evaluated. What can be automated, automate: CI/CD pipelines replace manual deployment, automated tests replace manual testing, adversarial Agent review replaces some human review. What cannot be automated, speed up: Owners sit together and make decisions in real time, discussing issues as they arise without scheduling meetings. The daily standup cadence is already too slow at Agent speed; decisions need to happen in real time.

A practical benchmark: if a user story is not done within a day, either the story is too large and needs to be split, or some process step is holding things up.

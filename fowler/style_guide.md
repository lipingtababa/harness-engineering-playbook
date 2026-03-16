# Writing Style Guide - fowler

Voice for the scientist project's articles. Named after Martin Fowler — observes real practices, names them, shows when they apply and when they don't.

**Language rule: write in English first, then translate to Chinese.** The English draft is the source of truth. This prevents Chinese AI slop patterns from creeping in — English-first thinking produces tighter sentence structure even after translation.

---

## What this voice sounds like

Read these two paragraphs from yage.ai and notice what makes them work:

> 先看事实。2026年2月13日，Cloudflare工程师James Anderson开始用Claude AI重新实现Next.js。当天晚上，Pages Router和App Router的基本SSR就跑通了。三天后，应用已经部署到Cloudflare Workers，实现了完整的客户端水合。

> 94%的API覆盖率听起来很高，但需要仔细拆解。vinext完整支持了App Router、Pages Router、React Server Components、Middleware、Server Actions、ISR等核心功能。尚未支持的包括：构建时静态预渲染、完整的图片优化（仅运行时支持，没有构建时优化）、基于域名的i18n路由，以及所有Vercel特定功能。

What works: facts first, then analysis. Specific numbers. Short sentences for facts, longer ones for unpacking. No throat-clearing ("在当今AI时代..."). No hedging filler ("值得注意的是..."). Just: here's what happened, here's what it means.

---

## Core rules

**1. Facts before opinions.** Start sections with what happened, who did it, what the numbers are. Then say what you think it means. Not the other way around.

**2. Specific > vague.** "三个团队" not "很多团队". "40,500行代码" not "大量代码". "下降17%" not "显著下降". If you don't have a number, say "I don't have data on this" instead of faking precision with weasel words.

**3. Let sources speak.** Use `>` blockquotes for other people's words. Then comment on what they said. Don't paraphrase everything into your own voice — direct quotes have more texture and credibility.

**4. One idea per paragraph.** If a paragraph makes two points, split it. Short paragraphs are fine. One-sentence paragraphs are fine.

**5. Transitions carry content.** "这就引出了一个更深的问题" works because it tells you what's coming. "接下来我们来探讨" is empty — it says nothing about what follows. Every transition sentence should contain information.

**6. Name the pattern, then define it, then show the boundary.** For every concept: what is it (one sentence), what does it look like in practice (example), when does it NOT apply (boundary). A pattern without boundaries is just a slogan.

**7. Three-instance rule.** Don't call something a pattern unless you've seen it independently in at least three places. Below that threshold: "an approach I've seen in [specific place]".

---

## Sentence-level patterns to use

These are drawn from real yage.ai articles that don't read like AI:

- "先看事实。" / "先说结论。" — just start
- "X听起来很高，但需要仔细拆解。" — qualified claim, then breakdown
- "换言之，..." — restatement for clarity, not repetition for emphasis
- "这就引出了X命题的根本弱点：..." — transition that carries an argument
- "更值得注意的是，..." — only when you're actually escalating importance, not as a filler opener
- "所以X真正证明的是：..." — reframing after evidence
- "和Y一个道理：..." — analogy introduced plainly, no fanfare
- "这个数字隐藏了大量前提条件。" — unpacking a stat everyone else takes at face value
- "回头看数据，这个策略确实有效：..." — connecting back to earlier evidence with a verdict
- "对于实际使用者来说，关键的几个takeaway：" — no ceremony, just utility
Section headings should carry an argument, not label a topic:
- Good: "拆解'无敌'假象：GPT-5.2 的 256K 边界"
- Bad: "关于GPT-5.2的分析"

---

## Sentence-level patterns to kill

These are the tells. If you see them in a draft, rewrite:

| Pattern | Why it's bad | Fix |
|---------|-------------|-----|
| "不仅...更..." / "不仅仅是...而是..." / "不是...而是..." | Classic AI pivot structure | Just state the second thing directly |
| "值得注意的是" as paragraph opener | Empty filler | Delete it, start with the actual point |
| "在这个背景下" / "在此基础上" | Fake connector | Either the connection is obvious (delete) or it's not (explain it) |
| "让我们来看看" / "接下来我们来探讨" | Conference MC voice | Just start the next section |
| "X——但更重要的是Y" | Manufactured emphasis | If Y is more important, lead with Y |
| Stacking short sentences for rhythm: "三个人。两天。一个结论。" | TED talk energy | Write a normal sentence |
| "从X的角度来看" repeated as a crutch | Lazy framing | State the insight directly |
| "这不是一个人的观点，而是一群..." | Grandiose collective voice | Just say who contributed |
| Parallel structures designed to sound clever | Feels written by committee | Say it plain |
| Any sentence that could appear in any article about any topic | Generic = AI smell | Rewrite with specifics from THIS article |
| "这让我意识到一个问题" | AI pretending to think out loud | State the point directly. Don't narrate your thought process |
| Chinese em dash `——` used as glue | Overused, lazy connector | Replace with `。` `，` or `：` |
| Explaining "why" after every observation | 教师爷 (lecturer) voice | Show the pattern, let readers connect the dots. Write for peers, not students |
| Dumping source material as bullet lists | Lazy, undigested | Distill to 1-2 points that serve YOUR argument, summarise in prose |
| Choppy bullet lists for explanatory content | Scattered thoughts | Convert to flowing sentences unless it's a genuine step-by-step or comparison |

Two more from published article feedback:

**教师爷 voice** — the biggest non-obvious AI tell. Instead of explaining why something is wrong, show the pattern and let smart readers see the contradiction:
- Bad: "为什么？因为他的控制点在'资源申请'这个后期环节，而开发团队可以在'项目设计'这个前期环节绕过他。"
- Good: "管理员有完整的批核权。开发改名重新申请机器。管理员的权力形同虚设。"

**Quotes must serve your argument** — don't dump source material. Read the source → identify 1-2 points that matter for YOUR thesis → summarise in your own words → only blockquote the single most impactful line.

---

## Structure

**Title:** Names the subject directly. Can use colon for context. Not clickbait, not academic, not manifesto.

Good: "Harness Engineering：当需求文档变成AI的操作手册"
Bad: "AI时代，你还在写需求文档吗？"

**Opening:** Facts or a concrete observation. No "在当今..." preamble. Get into the subject in the first sentence.

**Body:** Numbered sections with thesis in the heading. Each section: facts → analysis → implications. Use tables for comparisons. Use blockquotes for sources.

**Closing:** What we know, what we don't, what to watch. No rallying cry. No "让我们一起..." No "未来已来". Just: here's where things stand.

---

## English-first workflow

1. Draft the article in English
2. The English draft follows Martin Fowler's actual writing style — patient, precise, building from concrete to abstract
3. Translate to Chinese
4. Review Chinese for AI patterns that crept in during translation — they always do
5. The English version stays as the source file; Chinese is the published version

Why English first: Chinese AI output has a specific flavour of formality and parallel structure that's very hard to avoid when drafting directly in Chinese. Starting in English and translating produces more natural Chinese because the sentence structure is already set.

---

## What this persona is NOT

- NOT the hushi persona (hushi is a visionary engineer who sees where things are heading; fowler catalogues what's already happening)
- NOT an academic paper
- NOT a WeChat公众号 article (no emotional hooks, no "关注转发")
- NOT a conference keynote transcript
- IS: a senior colleague writing up what they observed, with enough detail that you could try it yourself

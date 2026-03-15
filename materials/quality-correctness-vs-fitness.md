# Quality Dual Dimensions: Correctness vs Fitness
**Source:** brainstorm.md (2026-03-12), lines 1168-1243

## 核心概念：质量的双维度分类

### Correctness vs Fitness（正确性 vs 适用性）

社区问题反复暴露一个混淆：测试通过了但产品不对。这是因为"质量"实际上有两个维度：

#### Dimension 1: Correctness（正确性）— "代码能不能跑？"
**关注点**：代码是否按spec工作
**验证方式**：
- 单元测试：函数是否返回正确结果
- 集成测试：模块之间是否正确协作
- 端到端测试：完整流程是否跑通
- 静态分析：代码风格、类型安全、安全漏洞
- 回归测试：新变更是否破坏已有功能

**特点**：
- **可完全自动化**——机器可以判断对错
- 是AI agent最擅长的部分
- 对应传统QA中的"验证"(Verification)——"我们是否正确地构建了产品？"
- 有ground truth——测试要么通过要么不通过

#### Dimension 2: Fitness（适用性）— "产品对不对？"
**关注点**：产品是否满足用户/业务需求
**验证方式**：
- 验收测试：是否满足验收标准（需要人类判断标准是否正确）
- 用户测试：用户是否真的能用、愿意用
- Benchmark：算法/业务效果是否达标（如推荐系统的推荐质量）
- A/B测试：新版本是否比旧版本更好
- Product-Market Fit：市场是否接受

**特点**：
- **不能完全自动化**——需要人类判断（至少在定义标准时）
- 是AI agent最薄弱的部分（AI不知道用户想要什么）
- 对应传统QA中的"确认"(Validation)——"我们是否构建了正确的产品？"
- 没有明确的ground truth——"好不好"是主观的、上下文依赖的

### 为什么这个区分至关重要

**Verification Debt的本质**：代码通过了所有Correctness测试（绿灯），但在Fitness维度上积累了大量未验证的假设。"代码库看起来干净、测试全绿，但几个月后你发现你精确地构建了spec描述的东西，却不是客户真正想要的。"

**AI agent的不对称能力**：
- Correctness：AI非常擅长——给它测试，它能写通过测试的代码
- Fitness：AI非常不擅长——它不知道测试本身是否在测试正确的东西

**Ground Truth Problem的重新定义**：
- AI写代码 + AI写Correctness测试 = 共谋（AI验证自己的实现）
- 但即使人写Correctness测试 + AI写代码 = 仍然可能有Fitness问题（人写的测试是否反映了真正的用户需求？）
- Fitness验证的终止点只能是现实世界的反馈（产品上线后用户是否买单）

### 与马工在群里的质量分层的映射

马工在supplement中提出的三层质量：
1. **代码质量** — 能否运行、有无bug → **Correctness**
2. **算法/业务质量** — 效果是否达标 → **Fitness**
3. **交付时间** — 速度本身也是质量 → 这是一个**约束条件**，不是质量维度

### 与五层模型的关系

| 质量维度 | 对应Layer | 反馈循环 | 自动化程度 |
|---------|----------|---------|----------|
| Correctness | Layer 2（质量控制） | Inner loop（秒-分钟） | 高（全自动） |
| Fitness | Layer 1（需求）+ Layer 4（验证） | Outer loop（周-月） | 低（需要人类判断） |

**Platform Engineering First主要服务于Correctness维度的自动化。Fitness维度的反馈循环更慢、更昂贵、更依赖人类——这是human in the loop不可替代的真正原因。**

### 理论支撑

**Verification vs Validation (V&V)**——IEEE标准中的经典区分：
- Verification: "Are we building the product right?" → Correctness
- Validation: "Are we building the right product?" → Fitness

**Peter Drucker**："Efficiency is doing things right; effectiveness is doing the right thing."
- Correctness = Efficiency（做对事情）
- Fitness = Effectiveness（做正确的事情）

**这个区分解释了为什么93%的AI采纳率只带来10%的生产力提升——AI极大地提升了Correctness效率，但对Fitness效能几乎没有贡献。瓶颈在Fitness，不在Correctness。**

# LLM Quality Dimension Mapping Framework

## Overview

This framework provides a comprehensive mapping of quality dimensions for LLM generative tasks, with specific considerations for different model types, deployment contexts, and evaluation approaches. Each dimension includes measurement strategies, target benchmarks, and implementation priorities.

**🔗 Related Resources**: [Decision Trees](../decision-trees/metric-selection-by-task.md) | [Implementation Guides](../implementation-guides/evaluation-approaches.md) | [Evaluation Wizard](../getting-started/evaluation-selection-wizard.md) | [Tool Matrix](../implementation-guides/tool-comparison-matrix.md)

## Core Quality Dimensions

### 1. Accuracy & Factualness

**Definition**: Correctness of information and absence of hallucinations or false claims.

**LLM-Specific Considerations**:

- **Knowledge Cutoff Impact**: Models may lack recent information
- **Confidence Calibration**: Models may express certainty about incorrect information
- **Source Attribution**: Difficulty tracing factual claims to training data
- **Domain Expertise**: Accuracy varies significantly across knowledge domains

**Measurement Strategies**:

| Approach                      | Method                                       | Cost   | Reliability | Use Case              |
| ----------------------------- | -------------------------------------------- | ------ | ----------- | --------------------- |
| **Fact-Checking Databases**   | Cross-reference claims with verified sources | Low    | High        | Factual Q&A, News     |
| **LLM-as-Judge Verification** | Use stronger model to verify claims          | Medium | Medium-High | General content       |
| **Human Expert Review**       | Domain experts validate accuracy             | High   | Highest     | Critical applications |
| **Automated Knowledge Base**  | Compare against structured knowledge         | Low    | Medium      | Specific domains      |

**Target Benchmarks**:

- **High-Stakes (Medical/Legal)**: >98% accuracy
- **Business Applications**: >95% accuracy
- **General Use**: >90% accuracy
- **Creative Content**: Context-dependent

**Implementation Priority**: **Critical** for all applications except purely creative tasks.

**Measurement Examples**:

```
Metric: Factual_Accuracy_Score
Formula: (Verified_Correct_Claims / Total_Factual_Claims) * 100
Target: Domain-specific (see benchmarks above)
Frequency: Per response for critical apps, sampled for others
```

### 2. Relevance & Helpfulness

**Definition**: How well the output addresses the user's intent and provides useful information.

**LLM-Specific Considerations**:

- **Intent Interpretation**: Models may misunderstand ambiguous queries
- **Context Window Limitations**: May lose track of conversation context
- **Over-Generalization**: Tendency to provide generic rather than specific help
- **Task Decomposition**: Difficulty breaking down complex requests

**Measurement Strategies**:

| Approach                     | Method                              | Cost   | Reliability | Use Case            |
| ---------------------------- | ----------------------------------- | ------ | ----------- | ------------------- |
| **Task Completion Rate**     | Track successful task completion    | Low    | High        | Goal-oriented tasks |
| **User Satisfaction Scores** | Direct user feedback ratings        | Medium | High        | All applications    |
| **Semantic Similarity**      | Compare intent vs. response vectors | Low    | Medium      | Automated screening |
| **A/B Testing**              | Compare response variants           | Medium | High        | System optimization |

**Target Benchmarks**:

- **Task Completion**: >85% for structured tasks
- **User Satisfaction**: >4.0/5.0 helpfulness rating
- **Semantic Alignment**: >0.8 cosine similarity
- **Intent Recognition**: >90% for clear queries

**Implementation Priority**: **Critical** - fundamental to user experience.

**Measurement Examples**:

```
Metric: Intent_Alignment_Score
Components:
  - Query understanding (0-1)
  - Response relevance (0-1)
  - Actionability (0-1)
Average: (Components_Sum / 3)
Target: >0.85
```

### 3. Safety & Harmlessness

**Definition**: Prevention of harmful, biased, toxic, or inappropriate content generation.

**LLM-Specific Considerations**:

- **Training Data Bias**: Inherited biases from training datasets
- **Adversarial Prompting**: Vulnerability to prompt injection attacks
- **Context-Dependent Harm**: Content appropriate in some contexts but not others
- **Evolving Safety Standards**: Standards change over time and across cultures

**Measurement Strategies**:

| Approach                 | Method                              | Cost   | Reliability | Use Case            |
| ------------------------ | ----------------------------------- | ------ | ----------- | ------------------- |
| **Toxicity Classifiers** | Automated harmful content detection | Low    | Medium      | Real-time filtering |
| **Bias Detection Tools** | Systematic bias measurement         | Medium | Medium-High | Fairness auditing   |
| **Red Team Testing**     | Adversarial testing by experts      | High   | Highest     | Security assessment |
| **User Reporting**       | Community-driven safety monitoring  | Low    | Variable    | Ongoing monitoring  |

**Target Benchmarks**:

- **Toxicity Rate**: <0.1% for public applications
- **Bias Metrics**: <10% differential across demographic groups
- **Safety Violations**: Zero tolerance for harmful content
- **False Positive Rate**: <5% for safety filters

**Implementation Priority**: **Critical** - non-negotiable for production systems.

**Measurement Examples**:

```
Metric: Safety_Compliance_Score
Components:
  - Toxicity absence (0-1)
  - Bias mitigation (0-1)
  - Inappropriate content (0-1)
Formula: MIN(Components) * 100
Target: >95% (all components >0.95)
```

### 4. Style & Coherence

**Definition**: Quality of writing, logical consistency, and appropriate tone/style.

**LLM-Specific Considerations**:

- **Style Transfer Capability**: Ability to adapt to requested styles
- **Consistency Maintenance**: Keeping consistent voice across long content
- **Genre Appropriateness**: Understanding context-specific style requirements
- **Coherence Across Context**: Maintaining logical flow with long inputs

**Measurement Strategies**:

| Approach                       | Method                             | Cost   | Reliability | Use Case              |
| ------------------------------ | ---------------------------------- | ------ | ----------- | --------------------- |
| **Style Consistency Analysis** | Automated style pattern detection  | Low    | Medium      | Content creation      |
| **Coherence Scoring**          | Logical flow assessment            | Medium | Medium-High | Long-form content     |
| **Human Style Evaluation**     | Expert assessment of style quality | High   | Highest     | Creative applications |
| **Readability Metrics**        | Automated readability scoring      | Low    | Medium      | General content       |

**Target Benchmarks**:

- **Style Consistency**: >90% style adherence
- **Coherence Score**: >4.0/5.0 for human evaluation
- **Readability**: Appropriate for target audience level
- **Tone Appropriateness**: >85% alignment with requested tone

**Implementation Priority**: **High** for content creation, **Medium** for functional tasks.

**Measurement Examples**:

```
Metric: Writing_Quality_Score
Components:
  - Grammar/syntax (0-1)
  - Style consistency (0-1)
  - Logical coherence (0-1)
  - Tone appropriateness (0-1)
Average: (Components_Sum / 4)
Target: >0.8 for content applications
```

### 5. Instruction Following

**Definition**: Adherence to explicit and implicit instructions, constraints, and format requirements.

**LLM-Specific Considerations**:

- **Complex Constraint Handling**: Difficulty with multiple simultaneous constraints
- **Implicit Instruction Understanding**: May miss subtle requirements
- **Format Compliance**: Structured output generation challenges
- **Constraint Prioritization**: Which instructions to follow when they conflict

**Measurement Strategies**:

| Approach                     | Method                                     | Cost | Reliability | Use Case             |
| ---------------------------- | ------------------------------------------ | ---- | ----------- | -------------------- |
| **Constraint Checking**      | Automated rule compliance verification     | Low  | High        | Structured tasks     |
| **Format Validation**        | Output format verification                 | Low  | High        | Data generation      |
| **Human Instruction Review** | Manual assessment of instruction following | High | Highest     | Complex instructions |
| **Template Matching**        | Compare output to expected patterns        | Low  | Medium      | Standardized tasks   |

**Target Benchmarks**:

- **Format Compliance**: >95% for structured outputs
- **Constraint Adherence**: >90% for explicit constraints
- **Instruction Completeness**: >85% of all instructions followed
- **Complex Task Success**: >80% for multi-step instructions

**Implementation Priority**: **High** for structured applications, **Medium** for creative tasks.

**Measurement Examples**:

```
Metric: Instruction_Compliance_Score
Components:
  - Format adherence (0-1)
  - Constraint following (0-1)
  - Completeness (0-1)
Formula: (Components_Sum / 3) * 100
Target: >90% for structured tasks
```

## RAG-Specific Quality Dimensions

### 6. Context Precision & Recall

**Definition**: Quality and completeness of retrieved information for generation.

**RAG-Specific Considerations**:

- **Retrieval Ranking**: Quality of document ranking algorithms
- **Chunk Granularity**: Optimal size for retrieved text chunks
- **Multi-Source Integration**: Combining information from multiple sources
- **Semantic vs. Lexical Matching**: Balancing different retrieval approaches

**Measurement Strategies**:

| Metric                         | Calculation                          | Target | Usage                |
| ------------------------------ | ------------------------------------ | ------ | -------------------- |
| **Context Precision**          | Relevant_Retrieved / Total_Retrieved | >0.8   | Retrieval quality    |
| **Context Recall**             | Relevant_Retrieved / Total_Relevant  | >0.85  | Coverage assessment  |
| **nDCG@k**                     | Normalized DCG at rank k             | >0.7   | Ranking quality      |
| **MRR (Mean Reciprocal Rank)** | Average 1/rank of first relevant     | >0.6   | First result quality |

**nDCG@k (Normalized Discounted Cumulative Gain at rank k)**:

nDCG@k is a ranking quality metric that evaluates how well a retrieval system orders results by relevance, with particular emphasis on highly relevant items appearing early in the ranking. This metric is crucial for RAG systems where the order of retrieved documents significantly impacts generation quality.

- **How it works**: DCG calculates a cumulative score where each relevant item contributes to the total based on its relevance score, discounted by its position (items lower in ranking contribute less). The normalization (nDCG) ensures scores are comparable across different queries by dividing by the ideal DCG possible for that query.
- **Formula**: `nDCG@k = DCG@k / IDCG@k` where DCG@k = Σ(i=1 to k) [(2^rel_i - 1) / log₂(i + 1)]
- **Practical significance**: Higher nDCG@k values indicate that highly relevant documents consistently appear near the top of search results. For RAG systems, this directly correlates with generation quality since LLMs typically give more weight to earlier context.
- **Target thresholds**: >0.7 indicates good ranking quality, >0.8 represents excellent performance. Values below 0.5 suggest significant ranking issues that will impact downstream generation.
- **Implementation considerations**: Requires graded relevance labels (not just binary relevant/irrelevant), making evaluation more nuanced but also more resource-intensive than simple precision/recall metrics.

**MRR (Mean Reciprocal Rank)**:

MRR measures the quality of a ranking system by focusing specifically on the position of the first relevant result, making it particularly valuable for scenarios where users primarily care about finding at least one good answer quickly.

- **How it works**: For each query, MRR calculates the reciprocal of the rank position of the first relevant item (1/rank), then averages across all queries. If the first relevant item is at position 1, the reciprocal rank is 1.0; at position 2, it's 0.5; at position 3, it's 0.33, and so forth.
- **Formula**: `MRR = (1/|Q|) * Σ(i=1 to |Q|) (1/rank_i)` where rank_i is the position of the first relevant document for query i
- **Practical significance**: MRR is especially relevant for RAG systems where having at least one highly relevant document in the top positions can significantly improve response quality. It's less concerned with the overall ranking quality and more focused on immediate utility.
- **Target thresholds**: >0.6 indicates good first-result performance, >0.8 represents excellent quick-answer capability. Values below 0.3 suggest users frequently encounter irrelevant results in top positions.
- **Use cases**: Particularly valuable for question-answering systems, customer support applications, and any scenario where users expect immediate relevant results rather than browsing through multiple documents.
- **Limitations**: MRR doesn't account for the presence of additional relevant documents beyond the first one, making it less suitable for comprehensive research or analysis tasks where multiple relevant sources are needed.

### 7. Answer Faithfulness

**Definition**: Degree to which generated answers are supported by retrieved context.

**RAG-Specific Considerations**:

- **Hallucination Prevention**: Avoiding generation beyond context
- **Context Utilization**: Effectively using all relevant retrieved information
- **Source Attribution**: Linking claims to specific context sources
- **Conflict Resolution**: Handling contradictory information in context

**Measurement Strategies**:

```
Faithfulness Score = Supported_Claims / Total_Claims
Where:
- Supported_Claims: Statements verifiable in context
- Total_Claims: All factual statements in response
Target: >0.95 for factual applications
```

## Performance & Efficiency Dimensions

### 8. Latency & Throughput

**Definition**: Response speed and system capacity metrics.

**LLM-Specific Considerations**:

- **Model Size Impact**: Larger models typically slower
- **Context Length Scaling**: Performance degrades with longer inputs
- **Batch Processing**: Efficiency gains with batched requests
- **Caching Strategies**: Reducing redundant computation

**Target Benchmarks**:

- **Interactive Applications**: <2s p95 latency
- **Batch Processing**: >100 requests/minute
- **Real-time Systems**: <500ms p50 latency
- **Background Tasks**: Throughput > latency priority

### 9. Cost Efficiency

**Definition**: Resource utilization and cost-effectiveness of model usage.

**Measurement Approaches**:

- **Cost per Request**: Total cost / number of requests
- **Quality-Adjusted Cost**: Cost / (Quality_Score \* Requests)
- **Resource Utilization**: Compute efficiency metrics
- **ROI Measurement**: Business value / total cost

## Quality Dimension Interaction Matrix

| Primary Dimension                   | Potential Conflicts                       | Optimization Strategy      |
| ----------------------------------- | ----------------------------------------- | -------------------------- |
| **Accuracy** vs **Creativity**      | High accuracy may reduce creative freedom | Domain-specific thresholds |
| **Safety** vs **Helpfulness**       | Over-filtering may reduce utility         | Graduated safety measures  |
| **Latency** vs **Quality**          | Faster responses may sacrifice quality    | Tiered service levels      |
| **Faithfulness** vs **Coherence**   | Strict context adherence may hurt flow    | Balanced weighting         |
| **Completeness** vs **Conciseness** | Thorough answers may be too long          | Task-specific optimization |

## Implementation Roadmap

For detailed implementation guidance including timelines, budgets, and success criteria, see the [Master Implementation Roadmap](../implementation-guides/master-roadmap.md).

## Quality Dimension Weighting Guidelines

For comprehensive metric selection and weighting guidance tailored to specific tasks and contexts, see the [Metric Selection Decision Trees](../decision-trees/metric-selection-by-task.md) which provides:

- **Task-specific metric prioritization** for Q&A, RAG, content generation, code generation, and specialized tasks
- **Budget allocation guidelines** by application type and risk level  
- **Implementation decision frameworks** with specific weighting recommendations
- **Quick reference tables** for common use cases

### Quick Reference by Application Type

| Application Type | Primary Authority | Key Focus Areas |
|------------------|-------------------|-----------------|
| **Customer Support** | [Q&A Metrics Path](../decision-trees/metric-selection-by-task.md#qa-systems-metrics-path) | Accuracy, Relevance, Safety |
| **Content Creation** | [Creative Metrics Path](../decision-trees/metric-selection-by-task.md#creative-writing-metrics-path) | Creativity, Style, Coherence |
| **Document Q&A (RAG)** | [RAG Metrics Path](../decision-trees/metric-selection-by-task.md#rag-metrics-path) | Faithfulness, Accuracy, Context Quality |
| **Code Generation** | [Code Metrics Path](../decision-trees/metric-selection-by-task.md#code-generation-metrics-path) | Correctness, Security, Efficiency |

## 📖 Related Framework Resources

### **Metric Selection & Implementation**
- **[Decision Trees](../decision-trees/metric-selection-by-task.md)**: Task-specific metric selection with budget allocation *(Primary Authority)*
- **[Implementation Guides](../implementation-guides/evaluation-approaches.md)**: Step-by-step setup instructions for each evaluation approach
- **[Tool Comparison Matrix](../implementation-guides/tool-comparison-matrix.md)**: Detailed tool selection and vendor guidance

### **Getting Started & Planning**
- **[Evaluation Selection Wizard](../getting-started/evaluation-selection-wizard.md)**: Interactive guidance for selecting approaches
- **[Quick Assessment Tool](../getting-started/quick-assessment-tool.md)**: 2-minute evaluation readiness check
- **[Master Roadmap](../implementation-guides/master-roadmap.md)**: Strategic planning with specialized templates

### **Practical Implementation**
- **[Starter Evaluation Toolkit](../getting-started/starter-evaluation-toolkit.md)**: Day 1 implementation with code examples
- **[Cost-Benefit Calculator](../getting-started/cost-benefit-calculator.md)**: ROI analysis and budget optimization
- **[Human Evaluation Guidelines](../annotation-templates/human-evaluation-guidelines.md)**: Standardized annotation templates

This quality dimension mapping provides a comprehensive framework for understanding, measuring, and optimizing LLM performance across diverse applications and contexts.

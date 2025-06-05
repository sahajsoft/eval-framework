# Decision Trees for LLM Evaluation Metric Selection by Task Type

## Overview

This decision tree framework helps teams systematically select appropriate evaluation metrics based on task type, balancing business objectives with evaluation effectiveness. Each path prioritizes metrics that directly impact user satisfaction and system performance.

## Primary Task Classification Decision Tree

```
START: What is your primary generative task?
│
├── Text Generation & Completion
│   ├── Q&A Systems → [Q&A Metrics Path]
│   ├── Creative Writing → [Creative Metrics Path]
│   ├── Technical Documentation → [Technical Metrics Path]
│   └── General Text Completion → [General Text Metrics Path]
│
├── Knowledge-Based Generation (RAG)
│   ├── Simple RAG → [RAG Metrics Path]
│   ├── Graph RAG → [Graph RAG Metrics Path]
│   └── Multi-Source RAG → [Multi-Source RAG Metrics Path]
│
├── Code Generation
│   ├── Code Completion → [Code Completion Metrics Path]
│   ├── Full Function/Class Generation → [Code Generation Metrics Path]
│   └── Code Explanation/Documentation → [Code Documentation Metrics Path]
│
└── Specialized Tasks
    ├── Summarization → [Summarization Metrics Path]
    ├── Translation → [Translation Metrics Path]
    └── Reasoning Tasks → [Reasoning Metrics Path]
```

## Detailed Metric Selection Paths

### Q&A Systems Metrics Path

**Priority 1 (Core Metrics - 40-50% of evaluation budget)**

- **Answer Accuracy** (Weight: 25%)
  - Measurement: LLM-as-judge with verification prompts
  - Target: >90% accuracy for factual questions
- **Relevance to Query** (Weight: 15%)
  - Measurement: Semantic similarity + human validation
  - Target: >85% relevance score
- **Completeness** (Weight: 10%)
  - Measurement: Information coverage analysis
  - Target: >80% of required information included

**Priority 2 (User Experience - 30-40% of evaluation budget)**

- **Response Time** (Weight: 10%)
  - Measurement: End-to-end latency tracking
  - Target: <2 seconds p95
- **Clarity & Readability** (Weight: 10%)
  - Measurement: Flesch-Kincaid + human assessment
  - Target: Grade 8-12 reading level
- **Citation Quality** (Weight: 10%)
  - Measurement: Reference accuracy verification
  - Target: >95% accurate citations

**Priority 3 (Enhancement - 10-20% of evaluation budget)**

- **Conciseness** (Weight: 5%)
- **Helpfulness** (Weight: 5%)

### RAG Metrics Path

**Priority 1 (Foundation - 50% of evaluation budget)**

- **Context Precision** (Weight: 20%)
  - Measurement: Ragas Context Precision metric
  - Target: >0.8 precision score
- **Context Recall** (Weight: 15%)
  - Measurement: Ragas Context Recall metric
  - Target: >0.85 recall score
- **Answer Faithfulness** (Weight: 15%)
  - Measurement: Ragas Faithfulness + LLM verification
  - Target: >95% faithfulness score

**Priority 2 (Quality - 35% of evaluation budget)**

- **Answer Relevancy** (Weight: 15%)
  - Measurement: Ragas Answer Relevancy
  - Target: >0.8 relevancy score
- **Retrieval Relevance** (Weight: 10%)
  - Measurement: nDCG@10, MRR
  - Target: nDCG@10 > 0.7
- **Response Coherence** (Weight: 10%)
  - Measurement: BERTScore + human evaluation
  - Target: >0.85 coherence score

**Priority 3 (Optimization - 15% of evaluation budget)**

- **Context Utilization** (Weight: 8%)
- **Reference Quality** (Weight: 7%)

### Creative Writing Metrics Path

**Priority 1 (Core Creative Quality - 45% of evaluation budget)**

- **Creativity & Originality** (Weight: 20%)
  - Measurement: Human evaluation + diversity metrics
  - Target: >4.0/5.0 human creativity rating
- **Coherence & Flow** (Weight: 15%)
  - Measurement: Human assessment + automated coherence
  - Target: >4.2/5.0 coherence rating
- **Style Appropriateness** (Weight: 10%)
  - Measurement: Style consistency analysis
  - Target: >85% style adherence

**Priority 2 (Technical Quality - 35% of evaluation budget)**

- **Grammar & Language Quality** (Weight: 15%)
  - Measurement: LanguageTool + human review
  - Target: <2 errors per 100 words
- **Instruction Following** (Weight: 10%)
  - Measurement: Constraint adherence checking
  - Target: >90% instruction compliance
- **Engagement** (Weight: 10%)
  - Measurement: Human engagement ratings
  - Target: >4.0/5.0 engagement score

**Priority 3 (Safety & Polish - 20% of evaluation budget)**

- **Safety & Appropriateness** (Weight: 15%)
- **Length Appropriateness** (Weight: 5%)

### Code Generation Metrics Path

**Priority 1 (Functional Correctness - 60% of evaluation budget)**

- **Execution Success** (Weight: 30%)
  - Measurement: Automated test execution
  - Target: >95% successful execution
- **Correctness** (Weight: 20%)
  - Measurement: Unit test pass rate + manual review
  - Target: >90% correctness score
- **Security** (Weight: 10%)
  - Measurement: Security scanning tools
  - Target: Zero high/critical vulnerabilities

**Priority 2 (Code Quality - 25% of evaluation budget)**

- **Code Style & Best Practices** (Weight: 10%)
  - Measurement: Linting tools + style checkers
  - Target: >90% style compliance
- **Efficiency** (Weight: 8%)
  - Measurement: Performance benchmarking
  - Target: Within 20% of optimal performance
- **Readability** (Weight: 7%)
  - Measurement: Cyclomatic complexity + human review
  - Target: Low complexity scores

**Priority 3 (Documentation & Maintenance - 15% of evaluation budget)**

- **Documentation Quality** (Weight: 8%)
- **Maintainability** (Weight: 7%)

### Summarization Metrics Path

**Priority 1 (Content Quality - 50% of evaluation budget)**

- **Faithfulness to Source** (Weight: 25%)
  - Measurement: Factual consistency checking
  - Target: >95% factual accuracy
- **Coverage of Key Points** (Weight: 15%)
  - Measurement: Key concept extraction + coverage analysis
  - Target: >85% key point coverage
- **Conciseness** (Weight: 10%)
  - Measurement: Compression ratio + redundancy analysis
  - Target: 20-30% of original length

**Priority 2 (Structural Quality - 30% of evaluation budget)**

- **Coherence** (Weight: 15%)
  - Measurement: Logical flow assessment
  - Target: >4.0/5.0 coherence rating
- **Readability** (Weight: 15%)
  - Measurement: Reading ease scores
  - Target: Appropriate for target audience

**Priority 3 (User Experience - 20% of evaluation budget)**

- **Relevance to Purpose** (Weight: 10%)
- **Abstractiveness** (Weight: 10%)

## Evaluation Approach Selection Decision Tree

```
What is your evaluation context?
│
├── Development Phase
│   ├── Rapid Iteration Needed → Automated Metrics (80%) + LLM-as-Judge (20%)
│   ├── Quality Validation → LLM-as-Judge (60%) + Human Evaluation (40%)
│   └── Final Validation → Human Evaluation (60%) + Automated Metrics (40%)
│
├── Production Monitoring
│   ├── Real-time Quality → Automated Metrics (90%) + Sampling (10%)
│   ├── Periodic Assessment → LLM-as-Judge (70%) + Human Validation (30%)
│   └── Quality Assurance → Human Evaluation (50%) + Automated (50%)
│
└── Research & Benchmarking
    ├── Academic Research → Human Evaluation (70%) + Benchmark Metrics (30%)
    ├── Model Comparison → LLM-as-Judge (60%) + Human Evaluation (40%)
    └── Performance Optimization → Automated Metrics (80%) + Targeted Human (20%)
```

## Budget Allocation Guidelines

### High-Stakes Applications (Medical, Legal, Financial)

- **Human Evaluation**: 60-70%
- **LLM-as-Judge**: 20-30%
- **Automated Metrics**: 10-20%

### Standard Business Applications

- **Human Evaluation**: 30-40%
- **LLM-as-Judge**: 40-50%
- **Automated Metrics**: 20-30%

### High-Volume/Low-Risk Applications

- **Human Evaluation**: 10-20%
- **LLM-as-Judge**: 30-40%
- **Automated Metrics**: 50-60%

## Implementation Decision Framework

### Metric Selection Checklist

1. **Business Impact Assessment**

   - [ ] Does improving this metric directly impact user satisfaction?
   - [ ] Is this metric actionable for system improvement?
   - [ ] Does this metric align with business objectives?

2. **Technical Feasibility**

   - [ ] Can this metric be measured reliably?
   - [ ] Is the measurement cost justified by the value?
   - [ ] Are the required tools and resources available?

3. **Evaluation Effectiveness**
   - [ ] Does this metric correlate with real-world performance?
   - [ ] Is the metric sensitive to meaningful quality differences?
   - [ ] Can the metric detect both improvements and regressions?

### Customization Guidelines

**For Domain-Specific Applications:**

- Add domain-specific accuracy metrics (e.g., clinical accuracy for medical AI)
- Include regulatory compliance measures where applicable
- Weight safety metrics higher for critical applications

**For Multi-Language Applications:**

- Include language-specific quality metrics
- Consider cultural appropriateness measures
- Add translation quality metrics for cross-language tasks

**For Real-Time Applications:**

- Prioritize latency and throughput metrics
- Include system reliability measures
- Consider degraded performance scenarios

## Quick Reference: Metric Prioritization by Use Case

| Use Case         | Top 3 Metrics                     | Evaluation Mix                          |
| ---------------- | --------------------------------- | --------------------------------------- |
| Customer Support | Accuracy, Relevance, Safety       | 40% Human, 40% LLM-Judge, 20% Automated |
| Content Creation | Creativity, Coherence, Style      | 60% Human, 30% LLM-Judge, 10% Automated |
| Code Assistant   | Execution, Correctness, Security  | 30% Human, 30% LLM-Judge, 40% Automated |
| Document Q&A     | Faithfulness, Accuracy, Citations | 35% Human, 45% LLM-Judge, 20% Automated |
| General Chat     | Helpfulness, Safety, Coherence    | 50% Human, 35% LLM-Judge, 15% Automated |

This decision tree framework provides systematic guidance for selecting appropriate metrics while maintaining focus on business objectives and evaluation effectiveness.

# Metrics Selection Reference Guide

## How to Use This Guide

This reference guide provides a comprehensive catalog of evaluation metrics and selection frameworks. Use this guide to:

- **Browse available metrics** by quality dimension and implementation difficulty
- **Understand measurement approaches** for each metric type
- **Apply selection frameworks** to choose focused metric sets
- **Avoid common anti-patterns** in evaluation design

> 🧭 **Need help choosing an approach?** Start with the [Evaluation Selection Wizard](evaluation-selection-wizard.md) for interactive guidance.

## Metric Bundles by Use Case

| Use Case                     | Essential Metrics                                                 | Additional Metrics                                               | When You Have More Resources                                |
| ---------------------------- | ----------------------------------------------------------------- | ---------------------------------------------------------------- | ----------------------------------------------------------- |
| **RAG/Knowledge Systems**    | • Context Precision<br>• Faithfulness Score<br>• Answer Relevance | • Context Recall<br>• Citation Accuracy<br>• Factual Correctness | • Human expert validation<br>• Domain-specific accuracy     |
| **Customer Service**         | • Task Success Rate<br>• User Satisfaction<br>• Response Time     | • Intent Classification<br>• Toxicity Score<br>• Consistency     | • Multi-turn conversation quality<br>• Bias detection       |
| **Creative Content**         | • Coherence Score<br>• Creativity Rating<br>• Safety Score        | • Semantic Diversity<br>• Originality<br>• Readability           | • Human aesthetic evaluation<br>• Brand alignment           |
| **Analysis & Summarization** | • Factual Correctness<br>• Information Coverage<br>• Conciseness  | • Source Attribution<br>• Readability<br>• Coherence             | • Expert domain validation<br>• Comprehensive fact-checking |
| **Code Generation**          | • Task Completion<br>• Correctness<br>• Safety (security)         | • Code Quality<br>• Efficiency<br>• Documentation                | • Expert review<br>• Performance testing                    |

> 💡 **Implementation guidance:** See the [Evaluation Selection Wizard](evaluation-selection-wizard.md) for detailed setup instructions and budget estimates.

## Complete Metrics Catalog

### Core Quality Metrics (Start Here)

| Quality Dimension    | Metric              | When to Use                                                    | Measurement Approach                                                                   | Implementation Difficulty |
| -------------------- | ------------------- | -------------------------------------------------------------- | -------------------------------------------------------------------------------------- | ------------------------- |
| **Task Completion**  | Task Success Rate   | All applications - measures if the system does what users want | • Binary success/failure assessment<br>• Task-specific criteria<br>• User confirmation | 🟢 Easy                   |
| **Factual Accuracy** | Factual Correctness | When accuracy matters (not pure creative tasks)                | • Automated fact-checking<br>• LLM-as-judge verification<br>• Human validation         | 🟡 Medium                 |
| **Safety**           | Safety & Toxicity   | All user-facing applications                                   | • Automated toxicity classifiers<br>• Content filtering<br>• Human safety review       | 🟢 Easy                   |
| **Performance**      | Response Time       | All interactive applications                                   | • Performance monitoring<br>• Latency tracking<br>• SLA measurement                    | 🟢 Easy                   |

### RAG-Specific Metrics

| Quality Dimension      | Metric             | When to Use                                            | Measurement Approach                                                             | Implementation Difficulty |
| ---------------------- | ------------------ | ------------------------------------------------------ | -------------------------------------------------------------------------------- | ------------------------- |
| **Retrieval Quality**  | Context Precision  | RAG systems - measures retrieval signal-to-noise ratio | • RAGAS framework<br>• Relevance scoring<br>• Human annotation                   | 🟡 Medium                 |
| **Answer Grounding**   | Faithfulness Score | RAG systems - prevents hallucination beyond context    | • RAGAS metric<br>• LLM-as-judge verification<br>• Entailment checking           | 🟡 Medium                 |
| **Task Completion**    | Answer Relevance   | RAG systems - ensures responses address queries        | • Query-answer similarity<br>• LLM-based relevance scoring<br>• Human evaluation | 🟡 Medium                 |
| **Retrieval Quality**  | Context Recall     | When comprehensive retrieval is critical               | • Coverage analysis<br>• Missing information detection<br>• Expert evaluation    | 🔴 Hard                   |
| **Source Attribution** | Citation Accuracy  | When source attribution is important                   | • Link verification<br>• Source-claim mapping<br>• Human validation              | 🟡 Medium                 |

### User Experience Metrics

| Quality Dimension   | Metric            | When to Use                                        | Measurement Approach                                                             | Implementation Difficulty |
| ------------------- | ----------------- | -------------------------------------------------- | -------------------------------------------------------------------------------- | ------------------------- |
| **Content Quality** | Coherence Score   | When logical flow matters (all content generation) | • Automated coherence algorithms<br>• LLM-based assessment<br>• Human evaluation | 🟡 Medium                 |
| **Content Quality** | Readability       | Content consumed by humans                         | • Flesch-Kincaid score<br>• Gunning Fog Index<br>• Automated readability tools   | 🟢 Easy                   |
| **User Experience** | User Satisfaction | User-facing applications                           | • Rating scales<br>• Thumbs up/down<br>• Survey feedback                         | 🟢 Easy                   |
| **Reliability**     | Consistency       | When predictable behavior is important             | • Response variance analysis<br>• A/B testing<br>• Stability monitoring          | 🟡 Medium                 |

### Advanced/Specialized Metrics

| Quality Dimension        | Metric                 | When to Use                               | Measurement Approach                                                                    | Implementation Difficulty |
| ------------------------ | ---------------------- | ----------------------------------------- | --------------------------------------------------------------------------------------- | ------------------------- |
| **Creative Quality**     | Creativity/Originality | Creative content generation               | • Novelty detection<br>• Human creativity evaluation<br>• Diversity analysis            | 🔴 Hard                   |
| **Domain Accuracy**      | Domain Expertise       | Specialized fields (medical, legal, etc.) | • Expert validation<br>• Domain-specific benchmarks<br>• Compliance checking            | 🔴 Hard                   |
| **Conversation Quality** | Multi-turn Quality     | Conversational applications               | • Conversation flow analysis<br>• Context retention tracking<br>• Turn completion rates | 🔴 Hard                   |
| **Fairness**             | Bias Detection         | When fairness is critical                 | • Bias detection algorithms<br>• Demographic analysis<br>• Fairness metrics             | 🟡 Medium                 |

## Quality Dimension Coverage Checklist

Use this checklist to ensure comprehensive evaluation coverage for your application:

| Quality Dimension        | Why It Matters                                           | Check If Relevant                  |
| ------------------------ | -------------------------------------------------------- | ---------------------------------- |
| **Task Completion**      | Core functionality - does the system do what users want? | ✅ Always relevant                 |
| **Factual Accuracy**     | Trust and reliability - is the information correct?      | ✅ Critical unless purely creative |
| **Safety**               | Risk mitigation - prevents harmful outputs               | ✅ Always relevant                 |
| **Performance**          | User experience - acceptable response times              | ✅ Always relevant                 |
| **Retrieval Quality**    | RAG foundation - good inputs enable good outputs         | ☑️ RAG systems only                |
| **Answer Grounding**     | RAG reliability - responses based on provided context    | ☑️ RAG systems only                |
| **Source Attribution**   | Transparency - users can verify information sources      | ☑️ When citations matter           |
| **Content Quality**      | Readability and coherence of generated text              | ☑️ When humans consume content     |
| **User Experience**      | Satisfaction and usability                               | ☑️ User-facing applications        |
| **Reliability**          | Consistent behavior across interactions                  | ☑️ When predictability matters     |
| **Creative Quality**     | Originality and innovation in content                    | ☑️ Creative applications only      |
| **Domain Accuracy**      | Specialized knowledge and compliance                     | ☑️ Domain-specific applications    |
| **Conversation Quality** | Multi-turn dialogue effectiveness                        | ☑️ Conversational applications     |
| **Fairness**             | Bias prevention and equitable treatment                  | ☑️ When serving diverse users      |

## Metric Selection Framework

### Step 1: Identify Your Critical Requirements

- [ ] **Safety-critical?** → Prioritize safety, toxicity, bias metrics
- [ ] **Accuracy-critical?** → Focus on factual correctness, domain validation
- [ ] **User experience-critical?** → Emphasize satisfaction, coherence, response time
- [ ] **Compliance-required?** → Include domain-specific and bias metrics

### Step 2: Consider Your Resources

- **Limited resources:** Start with 3-5 automated metrics
- **Medium resources:** Add LLM-as-judge evaluation
- **High resources:** Include human evaluation for subjective metrics

### Step 3: Select Your Metric Set

1. **Choose 2-3 core metrics** from the quality dimensions table
2. **Add 1-2 use case-specific metrics** from the bundles above
3. **Include 1 safety metric** (always recommended)
4. **Plan for 1 user feedback metric** (essential for improvement)

### Step 4: Validate Your Selection

- [ ] **Coverage check:** Use the Quality Dimension Checklist below
- [ ] **Resource check:** Ensure implementation difficulty fits your capacity
- [ ] **Business alignment:** Metrics directly support your success criteria

## Anti-Patterns to Avoid

- ❌ **Measuring everything** - Focus on 5-7 metrics maximum initially
- ❌ **Only automated metrics** - Include some human feedback loop
- ❌ **Ignoring safety** - Always include basic safety/toxicity checks
- ❌ **No baseline** - Establish initial measurements before optimizing

## Implementation Resources

### Recommended Tools by Measurement Approach

**Automated Metrics:**

- **RAGAS**: RAG-specific metrics (faithfulness, context precision/recall)
- **BERTScore**: Semantic similarity and content quality
- **TruthfulQA**: Factual correctness benchmarks
- **Toxicity Classifiers**: Perspective API, OpenAI Moderation API

**LLM-as-Judge:**

- **GPT-4/Claude**: For complex criteria evaluation (cost: ~$3-15 per 100 evaluations)
- **G-Eval Framework**: Structured LLM evaluation with chain-of-thought
- **Custom Rubrics**: Tailored evaluation prompts for specific use cases

**Human Evaluation Platforms:**

- **Labelbox, Scale AI**: Professional annotation services
- **Internal Reviews**: Subject matter expert panels
- **User Feedback**: Built-in rating systems, surveys

## 📖 Related Resources

- **[Evaluation Selection Wizard](evaluation-selection-wizard.md)**: Interactive approach selection with detailed implementation plans
- **[LLM Quality Mapping](../quality-dimensions/llm-quality-mapping.md)**: Comprehensive metric definitions and thresholds
- **[Red Flag Checklist](red-flag-checklist.md)**: Common evaluation mistakes to avoid
- **[Quick Assessment Tool](quick-assessment-tool.md)**: Rapid evaluation readiness check

This reference guide provides the foundational knowledge to select metrics strategically rather than comprehensively.

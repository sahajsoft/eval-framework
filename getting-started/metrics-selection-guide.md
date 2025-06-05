# LLM Evaluation Metrics Selection Guide

## How to Use This Guide

This guide helps you select the right evaluation metrics for your LLM application. Rather than using every metric, choose a focused set based on your:

- **Application type** (RAG, creative writing, customer service, etc.)
- **Risk tolerance** (safety-critical vs experimental)
- **Resources** (automated vs human evaluation capacity)
- **Stakeholder priorities** (user experience vs performance vs compliance)

## Quick Start: Metric Bundles by Use Case

| Use Case                     | Essential Metrics                                                 | Additional Metrics                                               | When You Have More Resources                                |
| ---------------------------- | ----------------------------------------------------------------- | ---------------------------------------------------------------- | ----------------------------------------------------------- |
| **RAG/Knowledge Systems**    | • Context Precision<br>• Faithfulness Score<br>• Answer Relevance | • Context Recall<br>• Citation Accuracy<br>• Factual Correctness | • Human expert validation<br>• Domain-specific accuracy     |
| **Customer Service**         | • Task Success Rate<br>• User Satisfaction<br>• Response Time     | • Intent Classification<br>• Toxicity Score<br>• Consistency     | • Multi-turn conversation quality<br>• Bias detection       |
| **Creative Content**         | • Coherence Score<br>• Creativity Rating<br>• Safety Score        | • Semantic Diversity<br>• Originality<br>• Readability           | • Human aesthetic evaluation<br>• Brand alignment           |
| **Analysis & Summarization** | • Factual Correctness<br>• Information Coverage<br>• Conciseness  | • Source Attribution<br>• Readability<br>• Coherence             | • Expert domain validation<br>• Comprehensive fact-checking |
| **Code Generation**          | • Task Completion<br>• Correctness<br>• Safety (security)         | • Code Quality<br>• Efficiency<br>• Documentation                | • Expert review<br>• Performance testing                    |

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

### Step 3: Plan Your Implementation

1. **Week 1-2:** Implement basic automated metrics (task success, response time, safety)
2. **Week 3-4:** Add core quality metrics (factual correctness, coherence)
3. **Month 2:** Add specialized metrics based on your use case
4. **Month 3+:** Refine with human evaluation and advanced metrics

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

### Quick Implementation Checklist

**Week 1 Setup:**

- [ ] Define success criteria for your primary use case
- [ ] Implement basic automated metrics (response time, safety)
- [ ] Set up user feedback collection (thumbs up/down)
- [ ] Establish baseline measurements

**Month 1 Expansion:**

- [ ] Add LLM-as-judge evaluation for key quality dimensions
- [ ] Implement use case-specific metrics from the bundles above
- [ ] Create evaluation dashboard for monitoring
- [ ] Set up A/B testing framework for improvements

This guide transforms evaluation from a compliance exercise into a strategic tool for continuous improvement.

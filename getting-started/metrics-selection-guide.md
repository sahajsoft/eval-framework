# Metrics Selection Reference Guide

## Primary Resources

For comprehensive metric selection guidance, use these primary resources:

### 🎯 **[Decision Trees for Metric Selection](../decision-trees/metric-selection-by-task.md)** (Primary Authority)
Task-specific metric selection paths with budget allocation and implementation priorities:
- Q&A Systems, RAG, Content Generation, Code Generation, and Specialized Tasks
- Budget allocation guidelines by risk level
- Implementation decision frameworks

### 🧭 **[Evaluation Selection Wizard](evaluation-selection-wizard.md)**
Interactive guidance for selecting evaluation approaches with specific implementation plans

### 📊 **[Quality Dimensions Mapping](../quality-dimensions/llm-quality-mapping.md)**
Comprehensive framework for understanding and measuring LLM quality dimensions

## Quick Reference

### Quick Task-to-Metrics Mapping

| Use Case | Primary Authority | Essential Metrics |
|----------|-------------------|-------------------|
| **Document Q&A (RAG)** | [RAG Metrics Path](../decision-trees/metric-selection-by-task.md#rag-metrics-path) | Context Precision, Faithfulness, Answer Relevance |
| **Customer Support** | [Q&A Metrics Path](../decision-trees/metric-selection-by-task.md#qa-systems-metrics-path) | Accuracy, Relevance, Safety |
| **Content Creation** | [Creative Metrics Path](../decision-trees/metric-selection-by-task.md#creative-writing-metrics-path) | Creativity, Coherence, Style |
| **Code Generation** | [Code Metrics Path](../decision-trees/metric-selection-by-task.md#code-generation-metrics-path) | Execution, Correctness, Security |

> 💡 **For detailed guidance:** Each link above provides specific implementation priorities, budget allocation, and success criteria.

## Essential Metrics Starter Kit

### Day 1 Metrics (Implement First)

| Metric | Purpose | Implementation | Cost |
|--------|---------|----------------|------|
| **Safety Check** | Prevent harmful outputs | HuggingFace toxicity models | ~$0.01/eval |
| **Response Time** | User experience baseline | Built-in timing | Free |
| **Basic Relevance** | Task completion check | Semantic similarity | ~$0.02/eval |

### Week 1 Additions

| Metric | Purpose | Implementation | Cost |
|--------|---------|----------------|------|
| **User Feedback** | Direct quality signal | Simple rating system | Free |
| **Length Check** | Catch obvious failures | Word count validation | Free |
| **Basic Coherence** | Content quality | Simple heuristics | Free |

> **📋 For comprehensive metric catalogs and selection frameworks**, see the [Quality Dimensions Mapping](../quality-dimensions/llm-quality-mapping.md).

## Quick Selection Framework

### Step 1: Choose Your Starting Point
- **New to evaluation?** → Start with [Starter Evaluation Toolkit](starter-evaluation-toolkit.md)
- **Know your task type?** → Use [Decision Trees](../decision-trees/metric-selection-by-task.md) for specific guidance
- **Need ROI justification?** → See [Cost-Benefit Calculator](cost-benefit-calculator.md)

### Step 2: Avoid Common Mistakes
- ❌ **Measuring everything** - Start with 3-5 essential metrics
- ❌ **Ignoring safety** - Always include basic safety checks  
- ❌ **No user feedback** - Include at least thumbs up/down
- ❌ **Perfect metrics** - 80% accuracy quickly beats 99% accuracy slowly

### Implementation Tools Quick Reference

| Tool Category | Recommended Options | Cost Range |
|---------------|-------------------|------------|
| **Safety** | HuggingFace models, OpenAI Moderation | $0.01-0.05/eval |
| **Automated Quality** | RAGAS, BERTScore, Semantic similarity | $0.02-0.10/eval |
| **LLM-as-Judge** | GPT-4, Claude, Local models | $0.01-0.15/eval |
| **Human Review** | Built-in feedback, Scale AI, Expert panels | $0.50-15.00/eval |

## 📖 Related Framework Resources

### **Primary Authorities**
- **[Decision Trees](../decision-trees/metric-selection-by-task.md)**: Task-specific metric selection with detailed guidance *(Primary Authority)*
- **[Quality Dimensions](../quality-dimensions/llm-quality-mapping.md)**: Comprehensive metric definitions and measurement strategies

### **Implementation & Tools**
- **[Starter Evaluation Toolkit](starter-evaluation-toolkit.md)**: Day 1 implementation guide with code examples
- **[Tool Comparison Matrix](../implementation-guides/tool-comparison-matrix.md)**: Platform and vendor selection *(Definitive Source)*
- **[Implementation Guides](../implementation-guides/evaluation-approaches.md)**: Technical setup instructions

### **Planning & Selection**
- **[Evaluation Selection Wizard](evaluation-selection-wizard.md)**: Interactive approach selection
- **[Quick Assessment Tool](quick-assessment-tool.md)**: 2-minute evaluation readiness check
- **[Cost-Benefit Calculator](cost-benefit-calculator.md)**: Budget planning and ROI analysis
- **[Master Roadmap](../implementation-guides/master-roadmap.md)**: Strategic planning with specialized templates

This guide provides quick access to metric selection resources with clear navigation to detailed implementation guidance.

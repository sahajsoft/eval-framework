# Starter Evaluation Toolkit for New AI Projects

## Overview

This toolkit provides practical guidance for teams starting AI projects to establish effective evaluation from day one. It focuses on the most valuable evaluations to implement first, with a clear path for building comprehensive evaluation capabilities over time.

## 🚀 Day 1 Essential Evaluations

### The "Big 3" Starter Metrics

These three metrics provide maximum value with minimal setup cost and should be implemented before any AI system goes to users:

#### 1. **Safety & Toxicity Detection**

**Why Critical**: Non-negotiable for user-facing systems
**Implementation Time**: 2-4 hours
**Cost**: ~$0.01 per evaluation

```python
# Quick implementation using HuggingFace
from transformers import pipeline

toxicity_classifier = pipeline(
    "text-classification",
    model="unitary/toxic-bert"
)

def safety_check(text):
    result = toxicity_classifier(text)
    toxicity_score = result[0]['score'] if result[0]['label'] == 'TOXIC' else 0
    return {
        'is_safe': toxicity_score < 0.3,
        'toxicity_score': toxicity_score,
        'action': 'block' if toxicity_score > 0.7 else 'review' if toxicity_score > 0.3 else 'pass'
    }
```

#### 2. **Basic Relevance Check**

**Why Critical**: Ensures system addresses user intent
**Implementation Time**: 1-2 hours  
**Cost**: ~$0.02 per evaluation

```python
from sentence_transformers import SentenceTransformer
import numpy as np

model = SentenceTransformer('all-MiniLM-L6-v2')

def relevance_check(prompt, response):
    embeddings = model.encode([prompt, response])
    similarity = np.dot(embeddings[0], embeddings[1])

    return {
        'relevance_score': float(similarity),
        'is_relevant': similarity > 0.5,
        'confidence': 'high' if abs(similarity - 0.5) > 0.3 else 'medium'
    }
```

#### 3. **Length Appropriateness**

**Why Critical**: Catches obvious generation failures
**Implementation Time**: 30 minutes
**Cost**: Negligible

```python
def length_check(response, expected_range=None):
    word_count = len(response.split())

    # Default ranges by use case
    if not expected_range:
        if word_count < 5:
            return {'appropriate': False, 'issue': 'too_short'}
        elif word_count > 500:
            return {'appropriate': False, 'issue': 'too_long'}

    return {
        'appropriate': True,
        'word_count': word_count,
        'category': 'short' if word_count < 50 else 'medium' if word_count < 200 else 'long'
    }
```

### Day 1 Implementation Checklist

- [ ] Set up basic logging for all AI interactions
- [ ] Implement safety/toxicity checking
- [ ] Add relevance scoring
- [ ] Create length validation
- [ ] Set up alert thresholds (safety < 95%, relevance < 70%)
- [ ] Configure basic monitoring dashboard
- [ ] Test with sample data

**Total Setup Time**: 4-8 hours
**Monthly Cost**: $10-50 for 1K evaluations

## 📈 Week 1-2: Add User Experience Metrics

### Essential UX Metrics

#### 4. **Response Time Tracking**

```python
import time
from contextlib import contextmanager

@contextmanager
def timing_context():
    start = time.time()
    yield
    end = time.time()
    return end - start

# Usage
with timing_context() as timer:
    response = ai_model.generate(prompt)

metrics = {
    'response_time': timer,
    'meets_sla': timer < 3.0,  # 3 second SLA
    'user_experience': 'excellent' if timer < 1 else 'good' if timer < 3 else 'poor'
}
```

#### 5. **Basic Coherence Check**

```python
def coherence_check(text):
    sentences = text.split('.')

    # Simple heuristics
    score = 1.0

    # Check repetition
    if len(sentences) > 1:
        unique_ratio = len(set(sentences)) / len(sentences)
        score *= unique_ratio

    # Check for obvious issues
    issues = []
    if text.count('?') > 3:
        issues.append('too_many_questions')
    if any(word * 3 in text.lower() for word in ['the', 'and', 'but']):
        issues.append('repetitive_words')

    return {
        'coherence_score': score,
        'is_coherent': score > 0.7 and len(issues) == 0,
        'issues': issues
    }
```

#### 6. **User Feedback Collection**

```python
# Simple feedback system
def collect_feedback(response_id, user_feedback):
    """
    user_feedback: {'helpful': bool, 'accurate': bool, 'rating': 1-5}
    """
    store_feedback(response_id, {
        'timestamp': datetime.now(),
        'helpful': user_feedback.get('helpful'),
        'accurate': user_feedback.get('accurate'),
        'rating': user_feedback.get('rating'),
        'comments': user_feedback.get('comments', '')
    })
```

## 🔄 Month 1: Build Evaluation Momentum

### The "First Month" Evaluation Suite

#### 7. **Automated Fact-Checking (if applicable)**

For factual content, add basic fact verification:

```python
# Simple fact-checking using web search
import requests

def basic_fact_check(claim):
    # Use fact-checking APIs or search
    search_results = search_web(claim)

    return {
        'verification_confidence': calculate_confidence(search_results),
        'supporting_sources': len([r for r in search_results if supports_claim(r, claim)]),
        'contradicting_sources': len([r for r in search_results if contradicts_claim(r, claim)])
    }
```

#### 8. **Task-Specific Success Metrics**

Define success based on your specific use case:

```python
# Example for Q&A system
def task_success_check(prompt, response, task_type):
    if task_type == 'question_answering':
        return {
            'answers_question': '?' in prompt and response.strip().endswith('.'),
            'provides_specific_info': len(response.split()) > 10,
            'avoids_hedging': count_hedge_words(response) < 3
        }

    elif task_type == 'summarization':
        return {
            'is_concise': len(response) < len(prompt) * 0.3,
            'covers_main_points': check_key_topics(prompt, response),
            'maintains_key_facts': verify_fact_preservation(prompt, response)
        }
```

### Month 1 Metrics Dashboard

Create a simple dashboard tracking:

- **Safety Rate**: % of responses that pass safety checks
- **User Satisfaction**: Average rating from user feedback
- **Response Quality**: Combination of relevance, coherence, and task success
- **System Performance**: Response times and error rates
- **Cost Efficiency**: Cost per successful interaction

## 📊 Evaluation Maturity Progression

### Stage 1: Safety & Basic Quality (Day 1)

**Focus**: Don't break things, basic functionality
**Metrics**: Safety, relevance, length, response time
**Effort**: 4-8 hours setup
**Cost**: $10-50/month

### Stage 2: User Experience (Week 1-2)

**Focus**: User satisfaction and system reliability
**Metrics**: Add coherence, user feedback, task success
**Effort**: 8-16 hours additional
**Cost**: $25-100/month

### Stage 3: Content Quality (Month 1)

**Focus**: Output quality and accuracy
**Metrics**: Add fact-checking, style consistency, instruction following
**Effort**: 16-40 hours additional
**Cost**: $50-200/month

### Stage 4: Advanced Analytics (Month 2-3)

**Focus**: Optimization and insights
**Metrics**: Add LLM-as-judge, human evaluation sampling, A/B testing
**Effort**: 40-80 hours additional
**Cost**: $200-500/month

### Stage 5: Production Excellence (Month 3+)

**Focus**: Continuous improvement and competitive advantage
**Metrics**: Full evaluation suite, real-time monitoring, predictive analytics
**Effort**: Ongoing investment
**Cost**: $500-2000/month

## 🎯 Use Case Specific Quick Starts

### Customer Support Chatbot

**Day 1 Priority**:

1. Safety checking (prevent harmful responses)
2. Intent recognition (understanding customer needs)
3. Escalation triggers (knowing when to hand off to human)

```python
def customer_support_essentials(query, response):
    return {
        'safety': safety_check(response),
        'intent_understood': classify_customer_intent(query),
        'needs_escalation': check_escalation_triggers(query, response),
        'sentiment': analyze_response_sentiment(response)
    }
```

### Content Generation System

**Day 1 Priority**:

1. Safety and brand compliance
2. Style consistency
3. Originality checking

```python
def content_generation_essentials(prompt, content):
    return {
        'safety': safety_check(content),
        'style_match': check_brand_voice(content),
        'originality': plagiarism_check(content),
        'length_appropriate': check_content_length(content, prompt)
    }
```

### Document Q&A (RAG)

**Day 1 Priority**:

1. Answer faithfulness to source
2. Citation accuracy
3. Completeness check

```python
def rag_essentials(query, answer, context):
    return {
        'faithfulness': check_answer_grounding(answer, context),
        'citation_accuracy': verify_citations(answer, context),
        'completeness': assess_answer_completeness(query, answer),
        'context_relevance': evaluate_context_quality(query, context)
    }
```

### Code Generation Assistant

**Day 1 Priority**:

1. Syntax validation
2. Security scanning
3. Functionality testing

```python
def code_generation_essentials(prompt, code):
    return {
        'syntax_valid': validate_syntax(code),
        'security_check': scan_for_vulnerabilities(code),
        'meets_requirements': test_functionality(code, prompt),
        'follows_conventions': check_coding_standards(code)
    }
```

## 🛠️ Implementation Tools and Resources

### Essential Libraries

```python
# Core evaluation toolkit
pip install evaluate transformers sentence-transformers
pip install textstat language-tool-python  # Language quality
pip install ragas  # RAG evaluation
pip install openai anthropic  # LLM-as-judge
```

### Monitoring Setup

```python
# Basic monitoring with Prometheus-style metrics
from prometheus_client import Counter, Histogram, Gauge

# Define metrics
evaluation_counter = Counter('ai_evaluations_total', 'Total evaluations', ['metric_type', 'result'])
response_time = Histogram('ai_response_time_seconds', 'Response time')
quality_score = Gauge('ai_quality_score', 'Current quality score')

# Usage in your evaluation function
def evaluate_with_monitoring(prompt, response):
    with response_time.time():
        results = run_evaluations(prompt, response)

    # Record results
    for metric, result in results.items():
        evaluation_counter.labels(metric=metric, result='pass' if result['passed'] else 'fail').inc()

    quality_score.set(calculate_overall_score(results))
    return results
```

### Configuration Template

```yaml
# starter_config.yaml
evaluation:
  stage: "starter" # starter, basic, advanced, production

  required_metrics:
    - safety_check
    - relevance_check
    - length_check

  optional_metrics:
    - coherence_check
    - user_feedback

  thresholds:
    safety_minimum: 0.95
    relevance_minimum: 0.70
    response_time_max: 3.0

  monitoring:
    alert_on_failure: true
    dashboard_update_interval: 300 # 5 minutes

  budget:
    max_monthly_cost: 100 # USD
    cost_per_evaluation_target: 0.05
```

## 📋 Quick Start Checklist

### Before You Begin (1 hour)

- [ ] Define your AI system's primary use case
- [ ] Identify your most critical quality requirements
- [ ] Set up basic logging infrastructure
- [ ] Determine your evaluation budget

### Day 1 Implementation (4-8 hours)

- [ ] Implement safety/toxicity checking
- [ ] Add basic relevance scoring
- [ ] Set up length validation
- [ ] Configure response time tracking
- [ ] Create simple monitoring dashboard
- [ ] Test with sample data
- [ ] Set up alerting for critical failures

### Week 1 Enhancement (8-16 hours)

- [ ] Add coherence checking
- [ ] Implement user feedback collection
- [ ] Create task-specific success metrics
- [ ] Set up weekly reporting
- [ ] Begin collecting baseline metrics

### Month 1 Expansion (16-40 hours)

- [ ] Add fact-checking capabilities (if applicable)
- [ ] Implement automated quality scoring
- [ ] Set up A/B testing framework
- [ ] Create evaluation result analysis
- [ ] Plan for next stage of evaluation maturity

## 🚀 Next Steps

**Ready to advance your evaluation system?**

1. **[Master Implementation Roadmap](../implementation-guides/master-roadmap.md)**: Plan your long-term evaluation strategy
2. **[Implementation Guides](../implementation-guides/evaluation-approaches.md)**: Advanced evaluation techniques and patterns
3. **[Quality Dimensions](../quality-dimensions/llm-quality-mapping.md)**: Comprehensive quality framework for optimization

## 📖 Related Framework Resources

### **Advanced Planning & Strategy**
- **[Master Implementation Roadmap](../implementation-guides/master-roadmap.md)**: Long-term evaluation strategy and specialized templates
- **[Decision Trees](../decision-trees/metric-selection-by-task.md)**: Task-specific advanced metric selection *(Primary Authority)*
- **[Quality Dimensions](../quality-dimensions/llm-quality-mapping.md)**: Comprehensive framework for optimization

### **Implementation & Scaling**
- **[Implementation Guides](../implementation-guides/evaluation-approaches.md)**: Advanced evaluation techniques and patterns
- **[Tool Comparison Matrix](../implementation-guides/tool-comparison-matrix.md)**: Vendor selection for scaling *(Definitive Source)*
- **[Automation Templates](../automation-templates/pipeline-templates.md)**: Production deployment configurations

### **Assessment & Selection**
- **[Quick Assessment Tool](quick-assessment-tool.md)**: Reassess your needs as you mature (2 minutes)
- **[Evaluation Selection Wizard](evaluation-selection-wizard.md)**: Select advanced metrics and approaches
- **[Cost-Benefit Calculator](cost-benefit-calculator.md)**: Track ROI and optimize budget allocation

This starter toolkit ensures teams can begin with high-impact, low-effort evaluations and build toward comprehensive evaluation systems that drive real business value.

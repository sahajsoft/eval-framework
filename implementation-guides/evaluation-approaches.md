# Implementation Guides for LLM Evaluation Approaches

## Overview

This guide provides step-by-step implementation instructions for different LLM evaluation approaches, from automated metrics to hybrid evaluation systems. Each approach includes setup instructions, code examples, cost analysis, and best practices.

## 1. Automated Evaluation Implementation

### 1.1 Basic Automated Metrics Setup

**Prerequisites**:

- Python 3.8+
- Access to evaluation datasets
- Model API endpoints

**Core Dependencies**:

```bash
pip install transformers datasets evaluate bert-score rouge-score
pip install ragas langchain openai anthropic
```

**Implementation Structure**:

```
automated_evaluation/
├── metrics/
│   ├── semantic_metrics.py
│   ├── linguistic_metrics.py
│   └── task_specific_metrics.py
├── pipelines/
│   ├── batch_evaluator.py
│   └── streaming_evaluator.py
├── config/
│   └── evaluation_config.yaml
└── utils/
    ├── data_loader.py
    └── result_aggregator.py
```

**Core Implementation**:

```python
# metrics/semantic_metrics.py
from bert_score import score
from sentence_transformers import SentenceTransformer
import numpy as np

class SemanticMetrics:
    def __init__(self):
        self.sentence_model = SentenceTransformer('all-MiniLM-L6-v2')

    def bert_score(self, predictions, references):
        """Calculate BERTScore for semantic similarity"""
        P, R, F1 = score(predictions, references, lang='en', verbose=False)
        return {
            'bert_precision': P.mean().item(),
            'bert_recall': R.mean().item(),
            'bert_f1': F1.mean().item()
        }

    def semantic_similarity(self, text1, text2):
        """Calculate cosine similarity between embeddings"""
        embeddings1 = self.sentence_model.encode([text1])
        embeddings2 = self.sentence_model.encode([text2])
        similarity = np.dot(embeddings1, embeddings2.T)[0][0]
        return float(similarity)

# pipelines/batch_evaluator.py
class BatchEvaluator:
    def __init__(self, config_path):
        self.config = self.load_config(config_path)
        self.metrics = self.initialize_metrics()

    def evaluate_batch(self, predictions, references, metadata=None):
        """Evaluate a batch of predictions"""
        results = {}

        # Semantic metrics
        if 'semantic' in self.config['metric_types']:
            semantic_results = self.metrics['semantic'].evaluate_batch(
                predictions, references
            )
            results.update(semantic_results)

        # Linguistic metrics
        if 'linguistic' in self.config['metric_types']:
            linguistic_results = self.metrics['linguistic'].evaluate_batch(
                predictions
            )
            results.update(linguistic_results)

        # Aggregate results
        return self.aggregate_results(results, metadata)
```

**Configuration Example**:

```yaml
# config/evaluation_config.yaml
metric_types:
  - semantic
  - linguistic
  - task_specific

semantic_metrics:
  - bert_score
  - semantic_similarity

linguistic_metrics:
  - readability
  - grammar_check
  - length_stats

thresholds:
  bert_f1: 0.8
  semantic_similarity: 0.7
  readability_score: 60

batch_size: 32
output_format: json
```

### 1.2 Cost Analysis for Automated Evaluation

| Metric Type         | Cost per 1000 evaluations | Latency | Accuracy |
| ------------------- | ------------------------- | ------- | -------- |
| BLEU/ROUGE          | $0.01                     | <1s     | Medium   |
| BERTScore           | $0.05                     | 2-5s    | High     |
| Semantic Similarity | $0.03                     | 1-3s    | High     |
| Grammar Checking    | $0.02                     | <1s     | Medium   |

**Monthly Cost Estimate** (10K evaluations):

- Basic metrics: $50-100
- Advanced semantic metrics: $200-500
- Complete automated suite: $300-800

## 2. LLM-as-Judge Implementation

### 2.1 LLM Judge Framework

**Architecture Overview**:

```
llm_judge/
├── judges/
│   ├── openai_judge.py
│   ├── anthropic_judge.py
│   └── local_judge.py
├── prompts/
│   ├── evaluation_prompts.py
│   └── scoring_rubrics.py
├── orchestrator/
│   ├── judge_manager.py
│   └── consensus_builder.py
└── validation/
    ├── calibration.py
    └── reliability_checker.py
```

**Core Implementation**:

```python
# judges/base_judge.py
from abc import ABC, abstractmethod
from typing import Dict, List, Any

class BaseJudge(ABC):
    def __init__(self, model_name: str, temperature: float = 0.1):
        self.model_name = model_name
        self.temperature = temperature

    @abstractmethod
    def evaluate(self, prompt: str, response: str, criteria: Dict) -> Dict:
        pass

    def format_evaluation_prompt(self, task_prompt: str, response: str,
                                criteria: Dict) -> str:
        """Format evaluation prompt for LLM judge"""
        return f"""
You are an expert evaluator. Please assess the following response based on the given criteria.

Original Prompt: {task_prompt}

Response to Evaluate: {response}

Evaluation Criteria:
{self._format_criteria(criteria)}

Please provide:
1. A score for each criterion (1-5 scale)
2. Brief justification for each score
3. Overall assessment

Format your response as JSON:
{{
    "scores": {{"criterion1": score, "criterion2": score}},
    "justifications": {{"criterion1": "reasoning", "criterion2": "reasoning"}},
    "overall_score": average_score,
    "summary": "brief_overall_assessment"
}}
"""

# judges/openai_judge.py
import openai
from .base_judge import BaseJudge

class OpenAIJudge(BaseJudge):
    def __init__(self, model_name="gpt-4-turbo", temperature=0.1):
        super().__init__(model_name, temperature)
        self.client = openai.OpenAI()

    def evaluate(self, prompt: str, response: str, criteria: Dict) -> Dict:
        """Evaluate using OpenAI models"""
        evaluation_prompt = self.format_evaluation_prompt(prompt, response, criteria)

        try:
            completion = self.client.chat.completions.create(
                model=self.model_name,
                messages=[
                    {"role": "system", "content": "You are an expert evaluator."},
                    {"role": "user", "content": evaluation_prompt}
                ],
                temperature=self.temperature,
                response_format={"type": "json_object"}
            )

            return self._parse_evaluation_response(completion.choices[0].message.content)

        except Exception as e:
            return {"error": str(e), "scores": {}, "overall_score": 0}

# orchestrator/judge_manager.py
class JudgeManager:
    def __init__(self, judges: List[BaseJudge]):
        self.judges = judges

    def multi_judge_evaluation(self, prompt: str, response: str,
                             criteria: Dict) -> Dict:
        """Get evaluations from multiple judges"""
        evaluations = []

        for judge in self.judges:
            evaluation = judge.evaluate(prompt, response, criteria)
            evaluations.append(evaluation)

        # Calculate consensus
        consensus = self._calculate_consensus(evaluations)
        return {
            "individual_evaluations": evaluations,
            "consensus": consensus,
            "agreement_score": self._calculate_agreement(evaluations)
        }

    def _calculate_consensus(self, evaluations: List[Dict]) -> Dict:
        """Calculate consensus scores across judges"""
        if not evaluations or all('error' in eval for eval in evaluations):
            return {"error": "No valid evaluations"}

        valid_evaluations = [eval for eval in evaluations if 'error' not in eval]

        # Average scores across judges
        consensus_scores = {}
        for criterion in valid_evaluations[0]['scores']:
            scores = [eval['scores'][criterion] for eval in valid_evaluations]
            consensus_scores[criterion] = sum(scores) / len(scores)

        overall_score = sum(consensus_scores.values()) / len(consensus_scores)

        return {
            "scores": consensus_scores,
            "overall_score": overall_score,
            "num_judges": len(valid_evaluations)
        }
```

**Evaluation Criteria Templates**:

```python
# prompts/scoring_rubrics.py
QUALITY_CRITERIA = {
    "factual_accuracy": {
        "description": "Correctness of factual information",
        "scale": {
            5: "All facts are accurate and verifiable",
            4: "Mostly accurate with minor errors",
            3: "Generally accurate with some mistakes",
            2: "Several factual errors present",
            1: "Major factual inaccuracies"
        }
    },
    "relevance": {
        "description": "How well the response addresses the prompt",
        "scale": {
            5: "Directly and completely addresses the query",
            4: "Addresses most aspects of the query well",
            3: "Generally relevant with some off-topic content",
            2: "Partially relevant but misses key points",
            1: "Largely irrelevant to the query"
        }
    },
    "coherence": {
        "description": "Logical flow and consistency of ideas",
        "scale": {
            5: "Perfectly logical and well-structured",
            4: "Clear structure with good flow",
            3: "Generally coherent with minor issues",
            2: "Some logical inconsistencies",
            1: "Confusing or contradictory"
        }
    }
}

RAG_SPECIFIC_CRITERIA = {
    "faithfulness": {
        "description": "How well the response is grounded in provided context",
        "scale": {
            5: "All claims supported by context",
            4: "Most claims supported, minimal unsupported content",
            3: "Generally faithful with some unsupported claims",
            2: "Several unsupported or contradictory claims",
            1: "Largely unfaithful to context"
        }
    },
    "context_utilization": {
        "description": "Effective use of retrieved information",
        "scale": {
            5: "Excellent synthesis of all relevant context",
            4: "Good use of most relevant information",
            3: "Adequate use of some context",
            2: "Poor utilization of available context",
            1: "Ignores or misuses context"
        }
    }
}
```

### 2.2 Cost Analysis for LLM-as-Judge

| Model             | Cost per evaluation | Quality | Speed    |
| ----------------- | ------------------- | ------- | -------- |
| GPT-4 Turbo       | $0.03-0.05          | Highest | Medium   |
| GPT-3.5 Turbo     | $0.01-0.02          | High    | Fast     |
| Claude 3 Opus     | $0.04-0.06          | Highest | Medium   |
| Claude 3 Sonnet   | $0.02-0.03          | High    | Fast     |
| Local Models (7B) | $0.001-0.005        | Medium  | Variable |

**Monthly Cost Estimates** (10K evaluations):

- GPT-3.5 based: $100-200
- GPT-4 based: $300-500
- Multi-judge consensus: $400-800
- Hybrid approach: $200-400

## 3. Human Evaluation Implementation

### 3.1 Human Annotation Platform Setup

**Platform Architecture**:

```
human_evaluation/
├── annotation_platform/
│   ├── web_interface/
│   ├── task_management/
│   └── quality_control/
├── guidelines/
│   ├── annotation_instructions.md
│   ├── training_materials/
│   └── quality_rubrics.py
├── data_management/
│   ├── task_distribution.py
│   ├── progress_tracking.py
│   └── result_aggregation.py
└── quality_assurance/
    ├── inter_rater_reliability.py
    ├── golden_standard_validation.py
    └── annotator_performance.py
```

**Annotation Interface Design**:

```python
# annotation_platform/task_interface.py
from dataclasses import dataclass
from typing import List, Dict, Optional

@dataclass
class AnnotationTask:
    task_id: str
    prompt: str
    response: str
    context: Optional[str] = None
    criteria: Dict = None
    metadata: Dict = None

class AnnotationInterface:
    def __init__(self, task_config: Dict):
        self.config = task_config
        self.current_task = None

    def display_task(self, task: AnnotationTask) -> Dict:
        """Display annotation task to human evaluator"""
        return {
            "task_id": task.task_id,
            "instructions": self.config["instructions"],
            "prompt": task.prompt,
            "response": task.response,
            "context": task.context,
            "criteria": self._format_criteria(task.criteria),
            "annotation_form": self._generate_form(task.criteria)
        }

    def _generate_form(self, criteria: Dict) -> Dict:
        """Generate annotation form based on criteria"""
        form_fields = {}

        for criterion, details in criteria.items():
            form_fields[criterion] = {
                "type": "likert_scale",
                "scale": details.get("scale", 5),
                "description": details["description"],
                "required": True
            }

        # Add comment field
        form_fields["comments"] = {
            "type": "text_area",
            "description": "Additional comments or justification",
            "required": False
        }

        return form_fields

# quality_assurance/inter_rater_reliability.py
import numpy as np
from scipy.stats import pearsonr
from sklearn.metrics import cohen_kappa_score

class InterRaterReliability:
    def __init__(self):
        self.annotations = []

    def add_annotations(self, task_id: str, annotator_scores: Dict):
        """Add annotations for reliability calculation"""
        self.annotations.append({
            "task_id": task_id,
            "scores": annotator_scores
        })

    def calculate_agreement(self) -> Dict:
        """Calculate inter-rater agreement metrics"""
        if len(self.annotations) < 2:
            return {"error": "Need at least 2 annotators"}

        # Extract scores by criterion
        criteria = list(self.annotations[0]["scores"].keys())
        annotators = list(self.annotations[0]["scores"][criteria[0]].keys())

        results = {}

        for criterion in criteria:
            scores_by_annotator = {}
            for annotator in annotators:
                scores_by_annotator[annotator] = [
                    ann["scores"][criterion][annotator]
                    for ann in self.annotations
                ]

            # Calculate pairwise correlations
            correlations = self._calculate_pairwise_correlations(scores_by_annotator)

            # Calculate Krippendorff's alpha or Cohen's kappa
            kappa = self._calculate_kappa(scores_by_annotator)

            results[criterion] = {
                "correlations": correlations,
                "kappa": kappa,
                "agreement_level": self._interpret_agreement(kappa)
            }

        return results

    def _interpret_agreement(self, kappa: float) -> str:
        """Interpret agreement level based on kappa score"""
        if kappa >= 0.8:
            return "Excellent"
        elif kappa >= 0.6:
            return "Good"
        elif kappa >= 0.4:
            return "Moderate"
        elif kappa >= 0.2:
            return "Fair"
        else:
            return "Poor"
```

**Annotation Guidelines Template**:

```markdown
# Human Evaluation Guidelines

## Overview

You will evaluate LLM responses based on specific quality criteria. Each response should be scored on a 1-5 scale for each criterion.

## Scoring Scale

- **5 - Excellent**: Exceeds expectations, highest quality
- **4 - Good**: Meets expectations with minor issues
- **3 - Satisfactory**: Acceptable quality with some problems
- **2 - Poor**: Below expectations, significant issues
- **1 - Very Poor**: Major problems, unacceptable quality

## Evaluation Criteria

### Factual Accuracy

**Question**: How accurate is the factual information in the response?

- Check claims against your knowledge
- Note any contradictions or impossible facts
- Consider currency of information

### Relevance

**Question**: How well does the response address the original prompt?

- Evaluate completeness of answer
- Check for off-topic content
- Assess whether user's intent is met

### Coherence

**Question**: How logical and well-structured is the response?

- Evaluate flow of ideas
- Check for contradictions
- Assess clarity of communication

## Common Pitfalls to Avoid

- Personal bias affecting scores
- Inconsistent application of criteria
- Conflating different criteria
- Being too lenient or too harsh
```

### 3.2 Cost Analysis for Human Evaluation

| Annotation Type    | Cost per evaluation | Time per task | Quality     |
| ------------------ | ------------------- | ------------- | ----------- |
| Expert Evaluation  | $5-15               | 10-30 min     | Highest     |
| Trained Annotators | $2-5                | 5-15 min      | High        |
| Crowd Workers      | $0.50-2             | 2-8 min       | Medium      |
| Student Annotators | $1-3                | 8-20 min      | Medium-High |

**Quality Control Costs** (additional):

- Training materials: $1000-5000 one-time
- Quality monitoring: 10-20% of annotation budget
- Inter-rater reliability testing: $500-2000

**Monthly Cost Estimates** (1K evaluations):

- Expert evaluation: $5,000-15,000
- Professional annotators: $2,000-5,000
- Crowd sourcing: $500-2,000
- Student workers: $1,000-3,000

## 4. Hybrid Evaluation Implementation

### 4.1 Multi-Stage Evaluation Pipeline

```python
# hybrid_evaluation/pipeline.py
class HybridEvaluationPipeline:
    def __init__(self, config):
        self.config = config
        self.automated_evaluator = AutomatedEvaluator(config['automated'])
        self.llm_judge = LLMJudgeManager(config['llm_judges'])
        self.human_evaluator = HumanEvaluationManager(config['human'])

    def evaluate_response(self, prompt: str, response: str,
                         context: str = None) -> Dict:
        """Multi-stage evaluation pipeline"""
        results = {
            "response_id": self._generate_id(),
            "stages": {}
        }

        # Stage 1: Automated screening
        automated_results = self.automated_evaluator.evaluate(
            prompt, response, context
        )
        results["stages"]["automated"] = automated_results

        # Decision: Should proceed to LLM judge?
        if self._should_proceed_to_llm_judge(automated_results):
            llm_results = self.llm_judge.evaluate(
                prompt, response, context
            )
            results["stages"]["llm_judge"] = llm_results

            # Decision: Should proceed to human evaluation?
            if self._should_proceed_to_human(llm_results, automated_results):
                human_results = self.human_evaluator.evaluate(
                    prompt, response, context
                )
                results["stages"]["human"] = human_results

        # Aggregate final scores
        results["final_scores"] = self._aggregate_scores(results["stages"])

        return results

    def _should_proceed_to_llm_judge(self, automated_results: Dict) -> bool:
        """Determine if response needs LLM judge evaluation"""
        # Proceed if automated metrics are uncertain or edge cases
        return (
            automated_results.get("overall_score", 0) < self.config["thresholds"]["llm_judge"] or
            automated_results.get("uncertainty", 0) > self.config["thresholds"]["uncertainty"]
        )

    def _should_proceed_to_human(self, llm_results: Dict,
                                automated_results: Dict) -> bool:
        """Determine if response needs human evaluation"""
        # Proceed for high-stakes decisions or disagreement between automated and LLM
        score_difference = abs(
            llm_results.get("overall_score", 0) -
            automated_results.get("overall_score", 0)
        )

        return (
            score_difference > self.config["thresholds"]["score_disagreement"] or
            llm_results.get("overall_score", 0) < self.config["thresholds"]["human_review"] or
            automated_results.get("high_stakes", False)
        )
```

### 4.2 Adaptive Evaluation Strategy

```python
# hybrid_evaluation/adaptive_strategy.py
class AdaptiveEvaluationStrategy:
    def __init__(self, budget_manager, quality_tracker):
        self.budget_manager = budget_manager
        self.quality_tracker = quality_tracker
        self.evaluation_history = []

    def select_evaluation_method(self, task_metadata: Dict) -> Dict:
        """Dynamically select evaluation approach based on context"""

        # Consider task importance
        importance = task_metadata.get("importance", "medium")

        # Consider available budget
        remaining_budget = self.budget_manager.get_remaining_budget()

        # Consider quality requirements
        required_quality = task_metadata.get("quality_threshold", 0.8)

        # Analyze historical performance
        method_performance = self._analyze_method_performance()

        # Make decision
        if importance == "critical" and remaining_budget > 0.7:
            return self._configure_premium_evaluation()
        elif remaining_budget < 0.3:
            return self._configure_budget_evaluation()
        else:
            return self._configure_balanced_evaluation(
                required_quality, method_performance
            )

    def _configure_premium_evaluation(self) -> Dict:
        """High-quality, high-cost evaluation"""
        return {
            "automated": {"enabled": True, "weight": 0.2},
            "llm_judge": {"enabled": True, "weight": 0.3, "multi_judge": True},
            "human": {"enabled": True, "weight": 0.5, "expert_level": True}
        }

    def _configure_budget_evaluation(self) -> Dict:
        """Cost-effective evaluation"""
        return {
            "automated": {"enabled": True, "weight": 0.7},
            "llm_judge": {"enabled": True, "weight": 0.3, "fast_model": True},
            "human": {"enabled": False}
        }
```

## 5. Production Monitoring Implementation

### 5.1 Real-Time Quality Monitoring

```python
# monitoring/quality_monitor.py
import asyncio
from dataclasses import dataclass
from typing import AsyncGenerator
import logging

@dataclass
class QualityAlert:
    severity: str
    metric: str
    current_value: float
    threshold: float
    timestamp: str
    response_id: str

class RealTimeQualityMonitor:
    def __init__(self, config):
        self.config = config
        self.alert_thresholds = config["alert_thresholds"]
        self.metrics_buffer = []
        self.logger = logging.getLogger(__name__)

    async def monitor_response_quality(self, response_data: Dict):
        """Monitor individual response quality"""
        quality_scores = await self._calculate_quality_scores(response_data)

        # Check for immediate alerts
        alerts = self._check_alert_conditions(quality_scores, response_data)

        if alerts:
            await self._send_alerts(alerts)

        # Update running statistics
        self._update_metrics_buffer(quality_scores)

        # Periodic aggregate analysis
        if len(self.metrics_buffer) >= self.config["batch_size"]:
            await self._analyze_batch_trends()

    async def _calculate_quality_scores(self, response_data: Dict) -> Dict:
        """Calculate quality scores for monitoring"""
        # Fast, lightweight metrics for real-time monitoring
        scores = {}

        # Toxicity check
        scores["toxicity"] = await self._check_toxicity(response_data["response"])

        # Length check
        scores["length_appropriateness"] = self._check_length(
            response_data["response"], response_data["expected_length"]
        )

        # Basic coherence (fast heuristics)
        scores["basic_coherence"] = self._basic_coherence_check(
            response_data["response"]
        )

        return scores

    def _check_alert_conditions(self, scores: Dict, response_data: Dict) -> List[QualityAlert]:
        """Check if any metrics trigger alerts"""
        alerts = []

        for metric, score in scores.items():
            if metric in self.alert_thresholds:
                threshold = self.alert_thresholds[metric]

                if score < threshold["min"] or score > threshold["max"]:
                    severity = "critical" if abs(score - threshold["target"]) > threshold["critical_diff"] else "warning"

                    alerts.append(QualityAlert(
                        severity=severity,
                        metric=metric,
                        current_value=score,
                        threshold=threshold["target"],
                        timestamp=datetime.now().isoformat(),
                        response_id=response_data["id"]
                    ))

        return alerts
```

### 5.2 Evaluation Performance Dashboard

```python
# monitoring/dashboard.py
class EvaluationDashboard:
    def __init__(self, data_source):
        self.data_source = data_source

    def generate_quality_report(self, time_period: str) -> Dict:
        """Generate comprehensive quality report"""
        metrics = self.data_source.get_metrics(time_period)

        return {
            "summary": self._generate_summary(metrics),
            "trends": self._analyze_trends(metrics),
            "quality_distribution": self._analyze_distribution(metrics),
            "cost_efficiency": self._analyze_cost_efficiency(metrics),
            "recommendations": self._generate_recommendations(metrics)
        }

    def _generate_summary(self, metrics: List[Dict]) -> Dict:
        """Generate high-level summary statistics"""
        if not metrics:
            return {"error": "No data available"}

        total_evaluations = len(metrics)
        avg_quality = sum(m["overall_score"] for m in metrics) / total_evaluations

        # Quality breakdown by method
        method_breakdown = {}
        for method in ["automated", "llm_judge", "human"]:
            method_metrics = [m for m in metrics if method in m.get("methods_used", [])]
            if method_metrics:
                method_breakdown[method] = {
                    "count": len(method_metrics),
                    "avg_quality": sum(m["overall_score"] for m in method_metrics) / len(method_metrics),
                    "avg_cost": sum(m.get("cost", 0) for m in method_metrics) / len(method_metrics)
                }

        return {
            "total_evaluations": total_evaluations,
            "average_quality": avg_quality,
            "method_breakdown": method_breakdown,
            "period": metrics[0]["timestamp"] + " to " + metrics[-1]["timestamp"]
        }
```

## 6. Integration and Deployment

### 6.1 API Integration Example

```python
# api/evaluation_service.py
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Optional, Dict, List

app = FastAPI(title="LLM Evaluation Service")

class EvaluationRequest(BaseModel):
    prompt: str
    response: str
    context: Optional[str] = None
    task_type: str
    evaluation_method: str = "hybrid"
    priority: str = "medium"

class EvaluationResponse(BaseModel):
    evaluation_id: str
    scores: Dict[str, float]
    method_used: str
    cost: float
    processing_time: float
    recommendations: Optional[List[str]] = None

@app.post("/evaluate", response_model=EvaluationResponse)
async def evaluate_response(request: EvaluationRequest):
    """Evaluate LLM response using specified method"""
    try:
        # Route to appropriate evaluation pipeline
        evaluator = EvaluationRouter.get_evaluator(
            request.evaluation_method,
            request.task_type
        )

        # Perform evaluation
        result = await evaluator.evaluate(
            prompt=request.prompt,
            response=request.response,
            context=request.context,
            priority=request.priority
        )

        return EvaluationResponse(**result)

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/evaluation/{evaluation_id}")
async def get_evaluation_result(evaluation_id: str):
    """Retrieve evaluation result by ID"""
    # Implementation for retrieving stored results
    pass
```

This comprehensive implementation guide provides the foundation for building robust LLM evaluation systems across different approaches, from fully automated to human-in-the-loop evaluation.

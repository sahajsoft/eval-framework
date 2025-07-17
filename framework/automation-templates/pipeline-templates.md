# Automated Evaluation Pipeline Templates

## Overview

This document provides production-ready templates for automated LLM evaluation pipelines, including configuration files, code templates, deployment scripts, and monitoring setups. These templates enable rapid deployment of evaluation systems across different environments and use cases.

**🔗 Related Resources**: [Implementation Guides](../implementation-guides/evaluation-approaches.md) | [Tool Matrix](../implementation-guides/tool-comparison-matrix.md) | [Master Roadmap](../implementation-guides/master-roadmap.md) | [Decision Trees](../decision-trees/metric-selection-by-task.md)

## 1. Pipeline Architecture Templates

### 1.1 Basic Evaluation Pipeline

**Use Case**: Simple text generation evaluation with standard metrics
**Components**: Input validation, metric calculation, result aggregation
**Deployment**: Single server or container

```yaml
# config/basic_pipeline.yaml
pipeline:
  name: "basic_text_evaluation"
  version: "1.0.0"

input:
  validation:
    required_fields: ["prompt", "response"]
    optional_fields: ["context", "metadata"]
    max_length: 10000

processing:
  batch_size: 32
  timeout_seconds: 300
  retry_attempts: 3

metrics:
  semantic:
    - name: "bert_score"
      weight: 0.3
      config:
        model: "microsoft/deberta-xlarge-mnli"
    - name: "semantic_similarity"
      weight: 0.2
      config:
        model: "all-MiniLM-L6-v2"

  linguistic:
    - name: "readability"
      weight: 0.2
      config:
        metrics: ["flesch_kincaid", "gunning_fog"]
    - name: "grammar_check"
      weight: 0.15
      config:
        tool: "languagetool"

  task_specific:
    - name: "rouge_score"
      weight: 0.15
      config:
        rouge_types: ["rouge1", "rouge2", "rougeL"]

output:
  format: "json"
  include_details: true
  store_results: true

monitoring:
  metrics: ["latency", "throughput", "error_rate"]
  alerts:
    error_rate_threshold: 0.05
    latency_p95_threshold: 5000
```

```python
# pipelines/basic_evaluator.py
import asyncio
from typing import Dict, List, Optional
from dataclasses import dataclass
import logging
from datetime import datetime

@dataclass
class EvaluationRequest:
    prompt: str
    response: str
    context: Optional[str] = None
    metadata: Optional[Dict] = None
    task_id: Optional[str] = None

@dataclass
class EvaluationResult:
    task_id: str
    scores: Dict[str, float]
    detailed_metrics: Dict[str, Dict]
    overall_score: float
    processing_time: float
    timestamp: str
    metadata: Dict

class BasicEvaluationPipeline:
    def __init__(self, config_path: str):
        self.config = self._load_config(config_path)
        self.metrics = self._initialize_metrics()
        self.logger = logging.getLogger(__name__)

    async def evaluate(self, request: EvaluationRequest) -> EvaluationResult:
        """Main evaluation method"""
        start_time = datetime.now()

        try:
            # Input validation
            self._validate_input(request)

            # Calculate metrics
            scores = await self._calculate_metrics(request)

            # Aggregate results
            overall_score = self._calculate_overall_score(scores)

            # Create result
            result = EvaluationResult(
                task_id=request.task_id or self._generate_task_id(),
                scores=scores,
                detailed_metrics=self._get_detailed_metrics(),
                overall_score=overall_score,
                processing_time=(datetime.now() - start_time).total_seconds(),
                timestamp=datetime.now().isoformat(),
                metadata=request.metadata or {}
            )

            # Store results if configured
            if self.config["output"]["store_results"]:
                await self._store_result(result)

            return result

        except Exception as e:
            self.logger.error(f"Evaluation failed: {str(e)}")
            raise

    async def evaluate_batch(self, requests: List[EvaluationRequest]) -> List[EvaluationResult]:
        """Batch evaluation with concurrency control"""
        batch_size = self.config["processing"]["batch_size"]
        results = []

        for i in range(0, len(requests), batch_size):
            batch = requests[i:i + batch_size]
            batch_results = await asyncio.gather(
                *[self.evaluate(req) for req in batch],
                return_exceptions=True
            )
            results.extend(batch_results)

        return results

    async def _calculate_metrics(self, request: EvaluationRequest) -> Dict[str, float]:
        """Calculate all configured metrics"""
        metric_tasks = []

        for metric_category in self.config["metrics"]:
            for metric_config in self.config["metrics"][metric_category]:
                metric_name = metric_config["name"]
                metric_func = self.metrics[metric_name]

                task = asyncio.create_task(
                    metric_func.calculate(request)
                )
                metric_tasks.append((metric_name, metric_config["weight"], task))

        # Execute all metrics concurrently
        scores = {}
        for metric_name, weight, task in metric_tasks:
            try:
                score = await task
                scores[metric_name] = score
            except Exception as e:
                self.logger.warning(f"Metric {metric_name} failed: {str(e)}")
                scores[metric_name] = 0.0

        return scores
```

### 1.2 RAG Evaluation Pipeline

**Use Case**: Retrieval-Augmented Generation evaluation
**Components**: Context analysis, faithfulness checking, retrieval quality assessment

```yaml
# config/rag_pipeline.yaml
pipeline:
  name: "rag_evaluation"
  version: "1.0.0"

input:
  validation:
    required_fields: ["query", "response", "context"]
    context_format: "list" # list of documents or single string
    max_context_length: 50000

processing:
  context_processing:
    chunk_size: 512
    overlap: 50
    embedding_model: "text-embedding-ada-002"

  evaluation_strategy: "comprehensive" # basic, comprehensive, expert

metrics:
  retrieval:
    - name: "context_precision"
      weight: 0.25
      config:
        method: "ragas"
    - name: "context_recall"
      weight: 0.20
      config:
        method: "ragas"
    - name: "retrieval_relevance"
      weight: 0.15
      config:
        similarity_threshold: 0.7

  generation:
    - name: "faithfulness"
      weight: 0.25
      config:
        method: "ragas"
        judge_model: "gpt-4-turbo"
    - name: "answer_relevancy"
      weight: 0.15
      config:
        method: "ragas"

llm_judges:
  primary:
    model: "gpt-4-turbo"
    temperature: 0.1
    max_tokens: 1000
  fallback:
    model: "gpt-3.5-turbo"
    temperature: 0.1
    max_tokens: 1000

cost_control:
  max_cost_per_evaluation: 0.10
  budget_allocation:
    retrieval_metrics: 0.3
    generation_metrics: 0.7
```

```python
# pipelines/rag_evaluator.py
from ragas import evaluate
from ragas.metrics import (
    answer_relevancy,
    faithfulness,
    context_recall,
    context_precision
)
from datasets import Dataset
import openai

class RAGEvaluationPipeline:
    def __init__(self, config_path: str):
        self.config = self._load_config(config_path)
        self.ragas_metrics = [
            answer_relevancy,
            faithfulness,
            context_recall,
            context_precision
        ]
        self.llm_client = openai.OpenAI()

    async def evaluate_rag_response(self, query: str, response: str,
                                  context: List[str]) -> Dict:
        """Evaluate RAG system response"""

        # Prepare data for RAGAS
        dataset = Dataset.from_dict({
            "question": [query],
            "answer": [response],
            "contexts": [context],
            "ground_truths": [[]]  # Optional if available
        })

        # Run RAGAS evaluation
        ragas_result = evaluate(
            dataset=dataset,
            metrics=self.ragas_metrics
        )

        # Additional custom metrics
        custom_metrics = await self._calculate_custom_metrics(
            query, response, context
        )

        # Combine results
        combined_scores = {
            **ragas_result,
            **custom_metrics
        }

        # Calculate weighted overall score
        overall_score = self._calculate_weighted_score(combined_scores)

        return {
            "scores": combined_scores,
            "overall_score": overall_score,
            "detailed_analysis": await self._detailed_analysis(
                query, response, context
            )
        }

    async def _detailed_analysis(self, query: str, response: str,
                               context: List[str]) -> Dict:
        """Perform detailed analysis of RAG response"""
        analysis_prompt = f"""
        Analyze this RAG system response in detail:

        Query: {query}
        Response: {response}
        Context: {' '.join(context[:3])}...

        Provide analysis on:
        1. How well the response uses the provided context
        2. Any claims not supported by the context
        3. Missing information that was available in context
        4. Overall quality assessment

        Format as JSON with analysis sections.
        """

        completion = await self.llm_client.chat.completions.acreate(
            model=self.config["llm_judges"]["primary"]["model"],
            messages=[
                {"role": "system", "content": "You are an expert RAG system evaluator."},
                {"role": "user", "content": analysis_prompt}
            ],
            temperature=0.1,
            response_format={"type": "json_object"}
        )

        return json.loads(completion.choices[0].message.content)
```

### 1.3 Production Monitoring Pipeline

**Use Case**: Continuous quality monitoring in production
**Components**: Real-time metrics, alerting, trend analysis

```yaml
# config/monitoring_pipeline.yaml
pipeline:
  name: "production_monitoring"
  version: "1.0.0"

monitoring:
  mode: "continuous" # continuous, batch, on_demand
  sampling_rate: 0.1 # Monitor 10% of responses

real_time_metrics:
  latency:
    enabled: true
    p50_threshold: 1000 # ms
    p95_threshold: 3000 # ms
    p99_threshold: 5000 # ms

  quality:
    enabled: true
    metrics:
      - "toxicity_score"
      - "basic_coherence"
      - "length_appropriateness"
    alert_threshold: 0.3 # Score below this triggers alert

  throughput:
    enabled: true
    min_rps: 10
    max_rps: 1000

batch_analysis:
  frequency: "hourly"
  window_size: "1h"
  metrics:
    - "bert_score"
    - "semantic_similarity"
    - "user_satisfaction"

alerts:
  channels:
    - type: "slack"
      webhook: "${SLACK_WEBHOOK_URL}"
    - type: "email"
      recipients: ["team@company.com"]
    - type: "pagerduty"
      integration_key: "${PAGERDUTY_KEY}"

  conditions:
    - name: "quality_degradation"
      condition: "quality_score < 0.7 for 5 minutes"
      severity: "warning"
    - name: "high_error_rate"
      condition: "error_rate > 0.05 for 2 minutes"
      severity: "critical"
    - name: "latency_spike"
      condition: "p95_latency > 5000 for 3 minutes"
      severity: "warning"

storage:
  metrics_retention: "30d"
  detailed_logs: "7d"
  aggregated_stats: "1y"
```

```python
# pipelines/monitoring_pipeline.py
import asyncio
from collections import deque
from datetime import datetime, timedelta
import statistics

class ProductionMonitoringPipeline:
    def __init__(self, config_path: str):
        self.config = self._load_config(config_path)
        self.metrics_buffer = deque(maxlen=10000)
        self.alert_manager = AlertManager(self.config["alerts"])
        self.running = False

    async def start_monitoring(self):
        """Start continuous monitoring"""
        self.running = True

        # Start monitoring tasks
        tasks = [
            asyncio.create_task(self._real_time_monitoring()),
            asyncio.create_task(self._batch_analysis()),
            asyncio.create_task(self._alert_processing())
        ]

        await asyncio.gather(*tasks)

    async def monitor_response(self, response_data: Dict):
        """Monitor individual response"""
        start_time = datetime.now()

        # Calculate real-time metrics
        metrics = await self._calculate_real_time_metrics(response_data)

        # Add timing information
        metrics["processing_time"] = (datetime.now() - start_time).total_seconds() * 1000
        metrics["timestamp"] = start_time

        # Store in buffer
        self.metrics_buffer.append(metrics)

        # Check for immediate alerts
        await self._check_alert_conditions(metrics)

        # Sample for detailed analysis
        if self._should_sample_for_analysis():
            await self._queue_for_detailed_analysis(response_data)

    async def _real_time_monitoring(self):
        """Continuous real-time monitoring loop"""
        while self.running:
            current_time = datetime.now()
            window_start = current_time - timedelta(minutes=5)

            # Get recent metrics
            recent_metrics = [
                m for m in self.metrics_buffer
                if m["timestamp"] > window_start
            ]

            if recent_metrics:
                # Calculate aggregate statistics
                stats = self._calculate_window_stats(recent_metrics)

                # Update dashboards
                await self._update_dashboards(stats)

                # Check alert conditions
                await self._check_window_alerts(stats)

            await asyncio.sleep(30)  # Check every 30 seconds

    async def _calculate_real_time_metrics(self, response_data: Dict) -> Dict:
        """Calculate lightweight metrics for real-time monitoring"""
        metrics = {}

        # Toxicity check (fast)
        if "toxicity_score" in self.config["real_time_metrics"]["quality"]["metrics"]:
            metrics["toxicity_score"] = await self._quick_toxicity_check(
                response_data["response"]
            )

        # Basic coherence (heuristic-based)
        if "basic_coherence" in self.config["real_time_metrics"]["quality"]["metrics"]:
            metrics["basic_coherence"] = self._basic_coherence_score(
                response_data["response"]
            )

        # Length appropriateness
        if "length_appropriateness" in self.config["real_time_metrics"]["quality"]["metrics"]:
            metrics["length_appropriateness"] = self._check_length_appropriateness(
                response_data["response"],
                response_data.get("expected_length")
            )

        return metrics

    def _basic_coherence_score(self, text: str) -> float:
        """Fast heuristic coherence assessment"""
        # Simple heuristics for coherence
        score = 1.0

        # Check for repetition
        sentences = text.split('.')
        if len(sentences) > 2:
            unique_ratio = len(set(sentences)) / len(sentences)
            score *= unique_ratio

        # Check for reasonable sentence length variation
        sentence_lengths = [len(s.split()) for s in sentences if s.strip()]
        if sentence_lengths:
            length_std = statistics.stdev(sentence_lengths) if len(sentence_lengths) > 1 else 0
            # Normalize score based on length variation
            score *= min(1.0, length_std / 10)

        return max(0.0, min(1.0, score))
```

## 2. Configuration Templates

### 2.1 Environment-Specific Configurations

```yaml
# config/environments/development.yaml
environment: "development"

processing:
  parallel_workers: 2
  timeout_seconds: 60

metrics:
  subset: ["bert_score", "basic_coherence"] # Faster metrics for dev

storage:
  backend: "local"
  path: "./dev_results"

monitoring:
  enabled: false

cost_limits:
  max_daily_spend: 10.00
```

```yaml
# config/environments/production.yaml
environment: "production"

processing:
  parallel_workers: 8
  timeout_seconds: 300

metrics:
  full_suite: true

storage:
  backend: "postgresql"
  connection_string: "${DATABASE_URL}"

monitoring:
  enabled: true
  detailed_logging: true

cost_limits:
  max_daily_spend: 1000.00

scaling:
  auto_scale: true
  min_instances: 2
  max_instances: 10
  target_cpu: 70
```

### 2.2 Task-Specific Configurations

```yaml
# config/tasks/customer_support.yaml
task_type: "customer_support"

metrics:
  priority_weights:
    helpfulness: 0.30
    accuracy: 0.25
    safety: 0.20
    clarity: 0.15
    response_time: 0.10

quality_thresholds:
  minimum_overall: 0.8
  safety_threshold: 0.95
  accuracy_threshold: 0.9

special_handling:
  escalation_keywords: ["complaint", "refund", "cancel"]
  high_stakes_domains: ["billing", "account_security"]
```

```yaml
# config/tasks/content_creation.yaml
task_type: "content_creation"

metrics:
  priority_weights:
    creativity: 0.35
    style: 0.25
    engagement: 0.20
    accuracy: 0.15
    safety: 0.05

quality_thresholds:
  minimum_overall: 0.7
  creativity_threshold: 0.8
  style_consistency: 0.85

evaluation_approaches:
  human_evaluation_rate: 0.3 # 30% get human evaluation
  expert_review_rate: 0.1 # 10% get expert review
```

## 3. Deployment Templates

### 3.1 Docker Containerization

```dockerfile
# Dockerfile
FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create non-root user
RUN useradd -m -u 1000 evaluator
USER evaluator

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:8000/health')"

# Run application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

```yaml
# docker-compose.yml
version: "3.8"

services:
  evaluation-api:
    build: .
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql://user:pass@db:5432/evaluation
      - REDIS_URL=redis://redis:6379
      - OPENAI_API_KEY=${OPENAI_API_KEY}
    depends_on:
      - db
      - redis
    volumes:
      - ./config:/app/config
      - ./logs:/app/logs
    restart: unless-stopped

  db:
    image: postgres:14
    environment:
      - POSTGRES_DB=evaluation
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=pass
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

  monitoring:
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
    volumes:
      - grafana_data:/var/lib/grafana
      - ./grafana/dashboards:/etc/grafana/provisioning/dashboards
      - ./grafana/datasources:/etc/grafana/provisioning/datasources

volumes:
  postgres_data:
  redis_data:
  grafana_data:
```

### 3.2 Kubernetes Deployment

```yaml
# k8s/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: evaluation-service
  labels:
    app: evaluation-service
spec:
  replicas: 3
  selector:
    matchLabels:
      app: evaluation-service
  template:
    metadata:
      labels:
        app: evaluation-service
    spec:
      containers:
        - name: evaluation-api
          image: evaluation-service:latest
          ports:
            - containerPort: 8000
          env:
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: evaluation-secrets
                  key: database-url
            - name: OPENAI_API_KEY
              valueFrom:
                secretKeyRef:
                  name: evaluation-secrets
                  key: openai-api-key
          resources:
            requests:
              memory: "1Gi"
              cpu: "500m"
            limits:
              memory: "2Gi"
              cpu: "1000m"
          livenessProbe:
            httpGet:
              path: /health
              port: 8000
            initialDelaySeconds: 30
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /ready
              port: 8000
            initialDelaySeconds: 5
            periodSeconds: 5
          volumeMounts:
            - name: config-volume
              mountPath: /app/config
              readOnly: true
      volumes:
        - name: config-volume
          configMap:
            name: evaluation-config

---
apiVersion: v1
kind: Service
metadata:
  name: evaluation-service
spec:
  selector:
    app: evaluation-service
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8000
  type: LoadBalancer

---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: evaluation-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: evaluation-service
  minReplicas: 2
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 80
```

## 4. Monitoring and Alerting Templates

### 4.1 Prometheus Configuration

```yaml
# monitoring/prometheus.yml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

rule_files:
  - "evaluation_rules.yml"

alerting:
  alertmanagers:
    - static_configs:
        - targets:
            - alertmanager:9093

scrape_configs:
  - job_name: "evaluation-service"
    static_configs:
      - targets: ["evaluation-service:8000"]
    metrics_path: "/metrics"
    scrape_interval: 10s

  - job_name: "postgres"
    static_configs:
      - targets: ["postgres-exporter:9187"]

  - job_name: "redis"
    static_configs:
      - targets: ["redis-exporter:9121"]
```

### 4.2 Alert Rules

```yaml
# monitoring/evaluation_rules.yml
groups:
  - name: evaluation_quality
    rules:
      - alert: QualityDegradation
        expr: avg_over_time(evaluation_quality_score[5m]) < 0.7
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: "Evaluation quality has degraded"
          description: "Average quality score has been below 0.7 for 2 minutes"

      - alert: HighErrorRate
        expr: rate(evaluation_errors_total[5m]) > 0.05
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "High evaluation error rate detected"
          description: "Error rate is {{ $value }} errors per second"

      - alert: HighLatency
        expr: histogram_quantile(0.95, rate(evaluation_duration_seconds_bucket[5m])) > 5
        for: 3m
        labels:
          severity: warning
        annotations:
          summary: "High evaluation latency"
          description: "95th percentile latency is {{ $value }} seconds"

  - name: evaluation_costs
    rules:
      - alert: CostSpike
        expr: increase(evaluation_cost_total[1h]) > 100
        for: 0m
        labels:
          severity: warning
        annotations:
          summary: "Evaluation cost spike detected"
          description: "Hourly cost increased by ${{ $value }}"

      - alert: DailyBudgetExceeded
        expr: evaluation_daily_cost > 1000
        for: 0m
        labels:
          severity: critical
        annotations:
          summary: "Daily evaluation budget exceeded"
          description: "Daily cost is ${{ $value }}, exceeding budget"
```

### 4.3 Grafana Dashboard

```json
{
  "dashboard": {
    "title": "LLM Evaluation Metrics",
    "panels": [
      {
        "title": "Quality Score Trends",
        "type": "graph",
        "targets": [
          {
            "expr": "avg_over_time(evaluation_quality_score[5m])",
            "legendFormat": "Overall Quality"
          },
          {
            "expr": "avg_over_time(evaluation_accuracy_score[5m])",
            "legendFormat": "Accuracy"
          },
          {
            "expr": "avg_over_time(evaluation_safety_score[5m])",
            "legendFormat": "Safety"
          }
        ]
      },
      {
        "title": "Evaluation Throughput",
        "type": "singlestat",
        "targets": [
          {
            "expr": "rate(evaluation_requests_total[5m])",
            "legendFormat": "Requests/sec"
          }
        ]
      },
      {
        "title": "Cost Analysis",
        "type": "graph",
        "targets": [
          {
            "expr": "increase(evaluation_cost_total[1h])",
            "legendFormat": "Hourly Cost"
          },
          {
            "expr": "evaluation_cost_per_request",
            "legendFormat": "Cost per Request"
          }
        ]
      }
    ]
  }
}
```

## 5. Testing and Validation Templates

### 5.1 Integration Test Suite

```python
# tests/integration/test_evaluation_pipeline.py
import pytest
import asyncio
from unittest.mock import Mock, patch

class TestEvaluationPipeline:
    @pytest.fixture
    async def pipeline(self):
        config = {
            "metrics": {"semantic": [{"name": "bert_score", "weight": 1.0}]},
            "processing": {"batch_size": 2, "timeout_seconds": 30}
        }
        return BasicEvaluationPipeline(config)

    @pytest.mark.asyncio
    async def test_single_evaluation(self, pipeline):
        """Test single response evaluation"""
        request = EvaluationRequest(
            prompt="What is the capital of France?",
            response="The capital of France is Paris.",
            task_id="test_001"
        )

        result = await pipeline.evaluate(request)

        assert result.task_id == "test_001"
        assert "bert_score" in result.scores
        assert 0 <= result.overall_score <= 1
        assert result.processing_time > 0

    @pytest.mark.asyncio
    async def test_batch_evaluation(self, pipeline):
        """Test batch processing"""
        requests = [
            EvaluationRequest(
                prompt=f"Question {i}",
                response=f"Answer {i}",
                task_id=f"test_{i:03d}"
            )
            for i in range(5)
        ]

        results = await pipeline.evaluate_batch(requests)

        assert len(results) == 5
        assert all(isinstance(r, EvaluationResult) for r in results)

    @pytest.mark.asyncio
    async def test_error_handling(self, pipeline):
        """Test error handling for invalid inputs"""
        with pytest.raises(ValueError):
            await pipeline.evaluate(EvaluationRequest(
                prompt="",  # Empty prompt should fail validation
                response="Valid response"
            ))

    @pytest.mark.asyncio
    async def test_timeout_handling(self, pipeline):
        """Test timeout behavior"""
        # Mock a slow metric calculation
        with patch.object(pipeline.metrics['bert_score'], 'calculate') as mock_calc:
            mock_calc.side_effect = asyncio.TimeoutError()

            request = EvaluationRequest(
                prompt="Test prompt",
                response="Test response"
            )

            result = await pipeline.evaluate(request)
            # Should handle timeout gracefully
            assert result is not None
```

### 5.2 Performance Test Suite

```python
# tests/performance/test_throughput.py
import asyncio
import time
import statistics

class TestPerformance:
    @pytest.mark.asyncio
    async def test_throughput_benchmark(self):
        """Benchmark evaluation throughput"""
        pipeline = BasicEvaluationPipeline("config/test.yaml")

        # Create test requests
        requests = [
            EvaluationRequest(
                prompt=f"Test prompt {i}",
                response=f"Test response {i}" * 50,  # Longer responses
                task_id=f"perf_test_{i}"
            )
            for i in range(100)
        ]

        start_time = time.time()
        results = await pipeline.evaluate_batch(requests)
        end_time = time.time()

        total_time = end_time - start_time
        throughput = len(results) / total_time

        # Assert minimum throughput
        assert throughput >= 10, f"Throughput {throughput:.2f} req/s below minimum"

        # Check latency distribution
        latencies = [r.processing_time for r in results]
        p95_latency = statistics.quantiles(latencies, n=20)[18]  # 95th percentile

        assert p95_latency <= 5.0, f"P95 latency {p95_latency:.2f}s too high"

    @pytest.mark.asyncio
    async def test_memory_usage(self):
        """Test memory usage under load"""
        import psutil
        process = psutil.Process()

        initial_memory = process.memory_info().rss / 1024 / 1024  # MB

        # Process large batch
        pipeline = BasicEvaluationPipeline("config/test.yaml")
        large_requests = [
            EvaluationRequest(
                prompt="Large prompt " * 100,
                response="Large response " * 100,
                task_id=f"memory_test_{i}"
            )
            for i in range(50)
        ]

        await pipeline.evaluate_batch(large_requests)

        final_memory = process.memory_info().rss / 1024 / 1024  # MB
        memory_increase = final_memory - initial_memory

        # Assert reasonable memory usage
        assert memory_increase < 500, f"Memory increase {memory_increase:.2f}MB too high"
```

## 📖 Related Framework Resources

### **Before Pipeline Development**
- **[Decision Trees](../decision-trees/metric-selection-by-task.md)**: Select appropriate metrics for automation *(Primary Authority)*
- **[Implementation Guides](../implementation-guides/evaluation-approaches.md)**: Understand automated evaluation approaches
- **[Master Roadmap](../implementation-guides/master-roadmap.md)**: Plan deployment timelines and phases

### **Tool & Technology Selection**
- **[Tool Comparison Matrix](../implementation-guides/tool-comparison-matrix.md)**: Select monitoring and automation tools *(Definitive Source)*
- **[Quality Dimensions](../quality-dimensions/llm-quality-mapping.md)**: Understand what each automated metric measures
- **[Cost-Benefit Calculator](../getting-started/cost-benefit-calculator.md)**: Budget for infrastructure and operational costs

### **Getting Started Resources**
- **[Starter Evaluation Toolkit](../getting-started/starter-evaluation-toolkit.md)**: Begin with simple automated metrics
- **[Evaluation Selection Wizard](../getting-started/evaluation-selection-wizard.md)**: Determine appropriate automation scope
- **[Human Evaluation Guidelines](../annotation-templates/human-evaluation-guidelines.md)**: Integrate human evaluation into automated pipelines

This comprehensive set of automated evaluation pipeline templates provides a production-ready foundation for implementing LLM evaluation systems across different scales and requirements.

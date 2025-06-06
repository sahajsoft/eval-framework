# Human Evaluation Guidelines and Templates

## Overview

This document provides comprehensive guidelines, templates, and protocols for human evaluation of LLM-generated content. It includes standardized annotation procedures, quality control measures, and task-specific evaluation frameworks.

**🔗 Related Resources**: [Implementation Guides](../implementation-guides/evaluation-approaches.md) | [Tool Matrix](../implementation-guides/tool-comparison-matrix.md) | [Cost Calculator](../getting-started/cost-benefit-calculator.md) | [Quality Dimensions](../quality-dimensions/llm-quality-mapping.md)

## 1. General Annotation Guidelines

### 1.1 Core Principles

**Objectivity**: Evaluate based on defined criteria, not personal preferences
**Consistency**: Apply the same standards across all evaluations
**Accuracy**: Take sufficient time to provide thoughtful assessments
**Documentation**: Provide clear justifications for scores and decisions

### 1.2 Evaluation Scale

All evaluations use a **5-point Likert scale** unless otherwise specified:

- **5 - Excellent**: Exceeds expectations, exemplary quality
- **4 - Good**: Meets expectations, minor issues only
- **3 - Satisfactory**: Acceptable quality with notable issues
- **2 - Poor**: Below expectations, significant problems
- **1 - Very Poor**: Major deficiencies, unacceptable quality

**Half-point scores (e.g., 3.5, 4.5)** may be used when responses fall clearly between rating levels.

### 1.3 Time Allocation Guidelines

| Task Type         | Expected Time | Complexity  | Notes                              |
| ----------------- | ------------- | ----------- | ---------------------------------- |
| Simple Q&A        | 2-4 minutes   | Low         | Factual verification               |
| Creative Writing  | 5-10 minutes  | High        | Style and creativity assessment    |
| Technical Content | 8-15 minutes  | High        | Accuracy verification required     |
| RAG Evaluation    | 6-12 minutes  | Medium-High | Context comparison needed          |
| Code Review       | 10-20 minutes | Very High   | Functional testing may be required |

## 2. Task-Specific Evaluation Templates

### 2.1 Question Answering Evaluation

**Template ID**: QA-EVAL-001
**Use Case**: Factual question answering, customer support, information retrieval

#### Evaluation Criteria

**A. Factual Accuracy** (Weight: 30%)

- Are all factual claims correct and verifiable?
- Are there any hallucinations or false information?
- Is the information current and relevant?

**Scoring Guide**:

- **5**: All facts verified correct, no inaccuracies
- **4**: Mostly accurate, 1-2 minor factual issues
- **3**: Generally accurate, some notable errors
- **2**: Several factual errors or outdated information
- **1**: Major inaccuracies, mostly incorrect information

**B. Completeness** (Weight: 25%)

- Does the answer address all aspects of the question?
- Is sufficient detail provided?
- Are important caveats or limitations mentioned?

**Scoring Guide**:

- **5**: Comprehensive answer covering all relevant aspects
- **4**: Covers most important aspects, minor gaps
- **3**: Addresses main question but misses some elements
- **2**: Partial answer, significant gaps in coverage
- **1**: Incomplete, fails to adequately address question

**C. Clarity and Organization** (Weight: 20%)

- Is the response well-structured and easy to follow?
- Is the language clear and appropriate for the audience?
- Are complex concepts explained effectively?

**D. Relevance** (Weight: 15%)

- Does the response directly address the asked question?
- Is all included information pertinent to the query?
- Does it avoid unnecessary tangents?

**E. Helpfulness** (Weight: 10%)

- Would this response be useful to someone asking this question?
- Does it provide actionable information when appropriate?
- Is the tone appropriate and supportive?

#### Annotation Form

```
QUESTION ANSWERING EVALUATION

Task ID: _______________
Evaluator ID: _______________
Date: _______________

Original Question:
[Display question here]

Generated Answer:
[Display answer here]

EVALUATION SCORES (1-5 scale):

Factual Accuracy: [ ]
Justification: _________________________________

Completeness: [ ]
Justification: _________________________________

Clarity and Organization: [ ]
Justification: _________________________________

Relevance: [ ]
Justification: _________________________________

Helpfulness: [ ]
Justification: _________________________________

OVERALL ASSESSMENT:
Overall Score: [ ] (average of weighted scores)

Key Strengths:
_____________________________________________

Key Weaknesses:
_____________________________________________

Suggestions for Improvement:
_____________________________________________

Additional Comments:
_____________________________________________

Evaluation Confidence: [ ] Low [ ] Medium [ ] High
```

### 2.2 RAG System Evaluation

**Template ID**: RAG-EVAL-001
**Use Case**: Document Q&A, knowledge base systems, research assistance

#### Evaluation Criteria

**A. Faithfulness to Context** (Weight: 35%)

- Are all claims in the response supported by the provided context?
- Does the response avoid adding information not in the context?
- Are any contradictions with the context present?

**B. Answer Quality** (Weight: 25%)

- How well does the answer address the original question?
- Is the response comprehensive and well-structured?
- Is the language clear and appropriate?

**C. Context Utilization** (Weight: 20%)

- Does the response effectively use relevant information from the context?
- Is important information from the context included?
- Does it synthesize information from multiple sources when applicable?

**D. Citation Accuracy** (Weight: 10%)

- Are citations or references accurate and helpful?
- Do they point to the correct parts of the source material?
- Are they formatted appropriately?

**E. Coherence** (Weight: 10%)

- Is the response logically structured?
- Do ideas flow naturally?
- Is the response internally consistent?

#### Annotation Form

```
RAG SYSTEM EVALUATION

Task ID: _______________
Evaluator ID: _______________
Date: _______________

Original Question:
[Display question]

Retrieved Context:
[Display context documents/passages]

Generated Answer:
[Display answer]

EVALUATION SCORES (1-5 scale):

Faithfulness to Context: [ ]
- All claims supported by context? [ ] Yes [ ] No
- Any unsupported information? [ ] Yes [ ] No
- Any contradictions? [ ] Yes [ ] No
Justification: _________________________________

Answer Quality: [ ]
Justification: _________________________________

Context Utilization: [ ]
- Uses relevant context effectively? [ ] Yes [ ] No
- Misses important context information? [ ] Yes [ ] No
Justification: _________________________________

Citation Accuracy: [ ]
- Citations present? [ ] Yes [ ] No
- Citations accurate? [ ] Yes [ ] No
Justification: _________________________________

Coherence: [ ]
Justification: _________________________________

FAITHFULNESS CHECK:
Please list any claims in the answer that are NOT supported by the context:
1. _____________________________________________
2. _____________________________________________
3. _____________________________________________

CONTEXT COVERAGE:
What important information from the context was NOT used in the answer?
_____________________________________________

OVERALL ASSESSMENT:
Overall Score: [ ]
Would you trust this answer? [ ] Yes [ ] No

Key Strengths:
_____________________________________________

Key Weaknesses:
_____________________________________________
```

### 2.3 Creative Writing Evaluation

**Template ID**: CW-EVAL-001
**Use Case**: Content creation, storytelling, marketing copy

#### Evaluation Criteria

**A. Creativity and Originality** (Weight: 30%)

- Is the content novel and imaginative?
- Does it demonstrate creative thinking?
- Does it avoid clichés and generic content?

**B. Style and Voice** (Weight: 25%)

- Is the writing style appropriate for the task?
- Is the voice consistent throughout?
- Does it match the requested tone and style?

**C. Engagement** (Weight: 20%)

- Is the content interesting and compelling?
- Would it hold a reader's attention?
- Does it evoke appropriate emotions or responses?

**D. Structure and Flow** (Weight: 15%)

- Is the content well-organized?
- Do ideas flow logically?
- Is pacing appropriate for the content type?

**E. Technical Quality** (Weight: 10%)

- Is grammar and syntax correct?
- Is word choice appropriate and varied?
- Are there any mechanical errors?

#### Annotation Form

```
CREATIVE WRITING EVALUATION

Task ID: _______________
Evaluator ID: _______________
Date: _______________

Writing Prompt/Request:
[Display prompt]

Generated Content:
[Display content]

Target Audience: _______________
Content Type: _______________
Requested Style/Tone: _______________

EVALUATION SCORES (1-5 scale):

Creativity and Originality: [ ]
- Novel ideas or approaches? [ ] Yes [ ] No
- Avoids clichés? [ ] Yes [ ] No
Justification: _________________________________

Style and Voice: [ ]
- Matches requested style? [ ] Yes [ ] No
- Consistent voice? [ ] Yes [ ] No
Justification: _________________________________

Engagement: [ ]
- Compelling content? [ ] Yes [ ] No
- Appropriate for audience? [ ] Yes [ ] No
Justification: _________________________________

Structure and Flow: [ ]
Justification: _________________________________

Technical Quality: [ ]
- Grammar/syntax correct? [ ] Yes [ ] No
- Word choice appropriate? [ ] Yes [ ] No
Justification: _________________________________

CREATIVITY ASSESSMENT:
Most creative/original aspects:
_____________________________________________

Areas lacking creativity:
_____________________________________________

OVERALL ASSESSMENT:
Overall Score: [ ]

Would you be satisfied with this content for its intended purpose?
[ ] Yes [ ] No

Why or why not?
_____________________________________________
```

### 2.4 Code Generation Evaluation

**Template ID**: CODE-EVAL-001
**Use Case**: Programming assistance, code completion, technical documentation

#### Evaluation Criteria

**A. Functional Correctness** (Weight: 40%)

- Does the code execute without errors?
- Does it produce the expected output?
- Are edge cases handled appropriately?

**B. Code Quality** (Weight: 25%)

- Is the code well-structured and readable?
- Does it follow best practices?
- Is it efficiently implemented?

**C. Security** (Weight: 15%)

- Are there any security vulnerabilities?
- Does it follow security best practices?
- Are inputs properly validated?

**D. Documentation** (Weight: 10%)

- Are comments helpful and appropriate?
- Is the code self-explanatory?
- Are variable names descriptive?

**E. Instruction Following** (Weight: 10%)

- Does the code meet the specified requirements?
- Are constraints and specifications followed?
- Is the requested functionality implemented?

#### Annotation Form

```
CODE GENERATION EVALUATION

Task ID: _______________
Evaluator ID: _______________
Date: _______________

Programming Request:
[Display request/prompt]

Generated Code:
[Display code]

Programming Language: _______________
Complexity Level: [ ] Beginner [ ] Intermediate [ ] Advanced

EVALUATION SCORES (1-5 scale):

Functional Correctness: [ ]
- Code executes without errors? [ ] Yes [ ] No
- Produces expected output? [ ] Yes [ ] No
- Handles edge cases? [ ] Yes [ ] No
Testing notes: _________________________________

Code Quality: [ ]
- Well-structured? [ ] Yes [ ] No
- Follows best practices? [ ] Yes [ ] No
- Efficiently implemented? [ ] Yes [ ] No
Quality notes: _________________________________

Security: [ ]
- Any security concerns? [ ] Yes [ ] No
- Proper input validation? [ ] Yes [ ] No
Security notes: _________________________________

Documentation: [ ]
- Adequate comments? [ ] Yes [ ] No
- Descriptive names? [ ] Yes [ ] No
Documentation notes: _________________________________

Instruction Following: [ ]
- Meets requirements? [ ] Yes [ ] No
- Follows constraints? [ ] Yes [ ] No
Compliance notes: _________________________________

FUNCTIONAL TESTING:
Did you test the code? [ ] Yes [ ] No
If yes, what tests did you perform?
_____________________________________________

Test results:
_____________________________________________

OVERALL ASSESSMENT:
Overall Score: [ ]

Would you use this code in a production environment?
[ ] Yes [ ] No [ ] With modifications

What modifications would be needed?
_____________________________________________
```

## 3. Quality Control Protocols

### 3.1 Inter-Rater Reliability Testing

**Purpose**: Ensure consistent evaluation standards across annotators

**Protocol**:

1. **Training Phase**: All annotators evaluate the same 20 sample responses
2. **Calibration**: Discuss discrepancies and refine understanding
3. **Qualification Test**: Annotators must achieve >80% agreement with gold standard
4. **Ongoing Monitoring**: 10% of tasks are dual-annotated for reliability checks

**Agreement Thresholds**:

- **Excellent**: κ > 0.8 (Krippendorff's alpha)
- **Good**: κ > 0.6
- **Acceptable**: κ > 0.4
- **Poor**: κ < 0.4 (requires retraining)

### 3.2 Golden Standard Creation

**Process**:

1. Expert team creates reference evaluations for diverse response types
2. Multiple experts evaluate each response independently
3. Consensus scores are established through discussion
4. Golden standard is reviewed and updated quarterly

**Golden Standard Coverage**:

- 50 examples per task type
- Range of quality levels (1-5 scale)
- Common edge cases and difficult decisions
- Regular updates with new examples

### 3.3 Annotator Performance Monitoring

**Metrics Tracked**:

- Agreement with golden standard
- Consistency over time
- Evaluation speed vs. quality
- Bias detection in scoring patterns

**Performance Review Process**:

- Weekly automated performance reports
- Monthly one-on-one feedback sessions
- Quarterly comprehensive reviews
- Additional training for underperforming annotators

## 4. Training Materials

### 4.1 Annotator Onboarding Checklist

**Pre-Training Requirements**:

- [ ] Complete background check (if required)
- [ ] Sign confidentiality agreement
- [ ] Review evaluation philosophy and principles
- [ ] Understand compensation and performance expectations

**Training Modules** (8-hour program):

- [ ] Module 1: Evaluation fundamentals (1 hour)
- [ ] Module 2: Task-specific criteria (2 hours)
- [ ] Module 3: Practice evaluations with feedback (3 hours)
- [ ] Module 4: Quality control and edge cases (1 hour)
- [ ] Module 5: Platform training and tools (1 hour)

**Certification Requirements**:

- [ ] Pass written assessment (80% minimum)
- [ ] Complete practice evaluations (κ > 0.6 with gold standard)
- [ ] Demonstrate platform proficiency
- [ ] Receive supervisor approval

### 4.2 Common Evaluation Challenges

**Challenge 1: Subjective vs. Objective Criteria**

- **Issue**: Annotators apply personal preferences instead of defined criteria
- **Solution**: Emphasize objective rubrics, provide examples of correct application
- **Training**: Practice with borderline cases, discuss reasoning

**Challenge 2: Anchor Bias**

- **Issue**: First few evaluations influence subsequent scoring patterns
- **Solution**: Randomize evaluation order, provide calibration breaks
- **Training**: Awareness of cognitive biases, mitigation strategies

**Challenge 3: Context Complexity**

- **Issue**: Difficulty evaluating responses with complex or technical context
- **Solution**: Provide domain expertise, create reference materials
- **Training**: Domain-specific training modules, expert consultation

**Challenge 4: Fatigue Effects**

- **Issue**: Quality degrades with prolonged evaluation sessions
- **Solution**: Limit session length, require breaks, monitor performance
- **Training**: Time management, quality maintenance strategies

### 4.3 Escalation Procedures

**Level 1: Automatic Flags**

- Scores outside normal range
- Evaluation time too fast/slow
- Low confidence ratings
  **Action**: Supervisor review within 24 hours

**Level 2: Quality Concerns**

- Low agreement with golden standard
- Inconsistent scoring patterns
- Annotator requests clarification
  **Action**: Additional training or expert consultation

**Level 3: Difficult Cases**

- Unclear evaluation criteria
- Novel or edge case responses
- Disagreement among experts
  **Action**: Expert panel review, criteria refinement

## 5. Platform Integration Templates

### 5.1 Annotation Interface Specifications

**Required Interface Elements**:

- Clear display of all evaluation materials
- Intuitive scoring interfaces (sliders, radio buttons)
- Mandatory justification fields
- Progress tracking and saving capabilities
- Quality control checks and validation

**Accessibility Requirements**:

- Keyboard navigation support
- Screen reader compatibility
- Adjustable text size and contrast
- Mobile-friendly responsive design

### 5.2 Data Export Formats

**Individual Evaluation Record**:

```json
{
  "evaluation_id": "eval_12345",
  "task_id": "task_67890",
  "annotator_id": "annotator_001",
  "timestamp": "2024-01-15T14:30:00Z",
  "task_type": "question_answering",
  "scores": {
    "factual_accuracy": 4.0,
    "completeness": 3.5,
    "clarity": 4.5,
    "relevance": 4.0,
    "helpfulness": 4.0
  },
  "overall_score": 4.0,
  "justifications": {
    "factual_accuracy": "All facts appear correct...",
    "completeness": "Missing some detail on...",
    "clarity": "Very well written...",
    "relevance": "Directly addresses question...",
    "helpfulness": "Provides actionable advice..."
  },
  "confidence": "high",
  "evaluation_time_seconds": 245,
  "flags": [],
  "metadata": {
    "annotator_experience": "expert",
    "domain": "technology",
    "difficulty": "medium"
  }
}
```

## 📖 Related Framework Resources

### **Planning & Strategy**
- **[Decision Trees](../decision-trees/metric-selection-by-task.md)**: Determine when human evaluation is needed *(Primary Authority)*
- **[Cost-Benefit Calculator](../getting-started/cost-benefit-calculator.md)**: Budget for human evaluation costs and ROI
- **[Quality Dimensions](../quality-dimensions/llm-quality-mapping.md)**: Understand what aspects require human judgment

### **Implementation & Tools**
- **[Tool Comparison Matrix](../implementation-guides/tool-comparison-matrix.md)**: Select human evaluation platforms *(Definitive Source)*
- **[Implementation Guides](../implementation-guides/evaluation-approaches.md)**: Technical setup for human evaluation systems
- **[Master Roadmap](../implementation-guides/master-roadmap.md)**: Integration timelines for human evaluation

### **Getting Started Resources**
- **[Evaluation Selection Wizard](../getting-started/evaluation-selection-wizard.md)**: Determine appropriate human evaluation scope
- **[Starter Evaluation Toolkit](../getting-started/starter-evaluation-toolkit.md)**: Simple human feedback collection
- **[Quick Assessment Tool](../getting-started/quick-assessment-tool.md)**: Assess if human evaluation is needed

These guidelines provide the foundation for implementing reliable, scalable human evaluation as part of a comprehensive LLM evaluation strategy.

This comprehensive framework provides the foundation for consistent, high-quality human evaluation of LLM systems across diverse applications and use cases.

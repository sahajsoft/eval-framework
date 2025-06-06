# Evaluation Selection Wizard

## Overview

This interactive wizard guides teams through selecting the right evaluation approach for their AI project. Answer the questions below to get a customized evaluation recommendation with specific metrics, tools, and implementation guidance.

## 🧭 Start Here: Project Assessment

### Step 1: Define Your AI System

**What type of AI system are you building?**

```
A) Question & Answer System
   - Customer support chatbot
   - Knowledge base search
   - FAQ automation
   → Go to Section A: Q&A Systems

B) Content Generation System
   - Blog posts, marketing copy
   - Creative writing, stories
   - Product descriptions
   → Go to Section B: Content Generation

C) Document Analysis System (RAG)
   - Document Q&A
   - Research assistance
   - Information extraction
   → Go to Section C: RAG Systems

D) Code Assistant
   - Code completion
   - Code generation
   - Code explanation
   → Go to Section D: Code Systems

E) Specialized Task
   - Translation, summarization
   - Data analysis, classification
   - Multi-modal tasks
   → Go to Section E: Specialized Tasks
```

---

## 📋 Section A: Q&A Systems

### A1: Accuracy Requirements

**How accurate do your answers need to be?**

- **Critical (Medical/Legal/Financial)**: >98% accuracy required
- **High (Business/Professional)**: >90% accuracy required
- **Medium (General Information)**: >80% accuracy acceptable
- **Low (Entertainment/Creative)**: Accuracy less critical

### A2: Scale and Budget

**What's your expected usage and budget?**

- **High Volume (>10K queries/day)**: Focus on automated metrics
- **Medium Volume (1K-10K queries/day)**: Hybrid approach
- **Low Volume (<1K queries/day)**: Can afford more human evaluation

### A3: Domain Specificity

**How specialized is your domain?**

- **Highly Specialized**: Requires domain expert evaluation
- **Moderately Specialized**: General experts sufficient
- **General Domain**: Standard evaluation approaches work

### Q&A Evaluation Recommendations

**For Critical Accuracy + High Volume:**

```yaml
recommended_approach: "Multi-layered Automated + Expert Review"
primary_metrics:
  - factual_accuracy: 0.30 # Use fact-checking APIs
  - answer_completeness: 0.25 # LLM-as-judge evaluation
  - source_attribution: 0.20 # Citation verification
  - user_satisfaction: 0.15 # Direct user feedback
  - safety_compliance: 0.10 # Automated safety checks

implementation_plan:
  phase_1: "Automated fact-checking + safety"
  phase_2: "LLM-as-judge for completeness"
  phase_3: "Expert review sampling (5-10%)"

monthly_budget: "$500-2000"
setup_time: "2-4 weeks"
```

**For Medium Accuracy + Medium Volume:**

```yaml
recommended_approach: "LLM-as-Judge + User Feedback"
primary_metrics:
  - answer_relevance: 0.25 # Semantic similarity
  - factual_consistency: 0.25 # LLM verification
  - user_helpfulness: 0.20 # User ratings
  - response_completeness: 0.15 # Coverage analysis
  - response_time: 0.15 # Performance metrics

implementation_plan:
  phase_1: "Basic relevance + user feedback"
  phase_2: "LLM-as-judge evaluation"
  phase_3: "Optimization based on patterns"

monthly_budget: "$200-800"
setup_time: "1-2 weeks"
```

---

## ✍️ Section B: Content Generation

### B1: Content Type

**What type of content are you generating?**

- **Marketing/Business**: Brand consistency, persuasiveness
- **Creative/Entertainment**: Originality, engagement
- **Educational**: Accuracy, clarity, appropriateness
- **Technical**: Precision, completeness, accuracy

### B2: Brand Risk Tolerance

**How sensitive is your brand to content issues?**

- **High Sensitivity**: Financial, healthcare, children's content
- **Medium Sensitivity**: Professional services, B2B
- **Low Sensitivity**: Entertainment, casual content

### B3: Human Oversight Available

**Do you have content experts available?**

- **Yes, Dedicated Team**: Can do regular human review
- **Yes, Part-time**: Limited expert review capacity
- **No**: Must rely on automated evaluation

### Content Generation Recommendations

**For High Brand Sensitivity + Expert Team:**

```yaml
recommended_approach: "Human-First with AI Support"
primary_metrics:
  - brand_alignment: 0.25 # Human expert review
  - content_quality: 0.25 # Editorial assessment
  - safety_compliance: 0.20 # Automated + human review
  - audience_appropriateness: 0.15 # Target audience fit
  - engagement_potential: 0.15 # Predicted engagement

implementation_plan:
  phase_1: "Human review + basic safety"
  phase_2: "LLM-as-judge for efficiency"
  phase_3: "Predictive quality models"

human_review_rate: "50-100%"
monthly_budget: "$1000-5000"
setup_time: "2-3 weeks"
```

**For Creative Content + Limited Oversight:**

```yaml
recommended_approach: "AI-Enhanced with Sampling"
primary_metrics:
  - creativity_score: 0.30 # Novelty and originality
  - coherence_quality: 0.25 # Logical flow and structure
  - style_consistency: 0.20 # Voice and tone matching
  - user_engagement: 0.15 # Predicted engagement
  - safety_check: 0.10 # Basic safety filtering

implementation_plan:
  phase_1: "Automated creativity + safety"
  phase_2: "User feedback integration"
  phase_3: "Style optimization"

human_review_rate: "10-20%"
monthly_budget: "$300-1000"
setup_time: "1-2 weeks"
```

---

## 📄 Section C: RAG Systems

### C1: Source Material Type

**What kind of documents are you working with?**

- **Structured (Databases, APIs)**: High accuracy requirements
- **Semi-structured (Reports, Articles)**: Medium accuracy needs
- **Unstructured (Notes, Conversations)**: Flexibility required

### C2: Answer Verification Needs

**How important is answer verification?**

- **Critical**: Every answer must be traceable to source
- **Important**: Most answers should be verifiable
- **Moderate**: General accuracy is sufficient

### C3: Update Frequency

**How often does your knowledge base change?**

- **Real-time**: Constantly updating information
- **Regular**: Weekly/monthly updates
- **Static**: Infrequent changes

### RAG System Recommendations

**For Critical Verification + Structured Sources:**

```yaml
recommended_approach: "Faithfulness-First with Citation Tracking"
primary_metrics:
  - answer_faithfulness: 0.35 # RAGAS faithfulness metric
  - citation_accuracy: 0.25 # Source attribution verification
  - context_relevance: 0.20 # Retrieved content quality
  - answer_completeness: 0.15 # Coverage of user query
  - retrieval_precision: 0.05 # Search quality metrics

implementation_plan:
  phase_1: "RAGAS evaluation + basic citations"
  phase_2: "Enhanced citation verification"
  phase_3: "Context optimization"

tools_needed: ["RAGAS", "Citation verification", "Semantic search"]
monthly_budget: "$400-1500"
setup_time: "2-3 weeks"
tool_selection: "See Tool Comparison Matrix for detailed vendor selection"
```

**For Moderate Verification + Dynamic Content:**

```yaml
recommended_approach: "Balanced RAG with Monitoring"
primary_metrics:
  - answer_relevance: 0.25 # Query-answer alignment
  - context_utilization: 0.25 # Effective use of retrieved info
  - factual_consistency: 0.20 # LLM-based fact checking
  - user_satisfaction: 0.15 # Direct user feedback
  - system_performance: 0.15 # Speed and reliability

implementation_plan:
  phase_1: "Basic RAG metrics + user feedback"
  phase_2: "LLM-as-judge evaluation"
  phase_3: "Performance optimization"

tools_needed: ["RAGAS", "LLM-as-judge", "User feedback"]
monthly_budget: "$200-800"
setup_time: "1-2 weeks"
```

---

## 💻 Section D: Code Systems

### D1: Code Criticality

**How critical is the generated code?**

- **Production Systems**: Must be secure, efficient, correct
- **Development Tools**: Helpful but can have minor issues
- **Learning/Examples**: Educational value most important

### D2: Language and Complexity

**What programming contexts are you supporting?**

- **Enterprise Languages (Java, C#, etc.)**: High standards
- **Scripting (Python, JavaScript)**: Moderate standards
- **Multiple Languages**: Varied requirements

### D3: Security Requirements

**What are your security needs?**

- **High Security**: Financial, healthcare, enterprise
- **Medium Security**: Standard business applications
- **Low Security**: Internal tools, prototypes

### Code System Recommendations

**For Production + High Security:**

```yaml
recommended_approach: "Multi-Stage Verification"
primary_metrics:
  - functional_correctness: 0.30 # Automated testing
  - security_compliance: 0.25 # Security scanning
  - code_quality: 0.20 # Style and best practices
  - performance_efficiency: 0.15 # Benchmarking
  - documentation_quality: 0.10 # Comment and docs

implementation_plan:
  phase_1: "Automated testing + security scanning"
  phase_2: "Code quality analysis"
  phase_3: "Performance optimization"

tools_needed: ["Testing frameworks", "Security scanners", "Code analyzers"]
monthly_budget: "$300-1200"
setup_time: "2-4 weeks"
```

**For Development Tools + Medium Security:**

```yaml
recommended_approach: "Balanced Code Evaluation"
primary_metrics:
  - syntactic_correctness: 0.25 # Basic syntax validation
  - logical_correctness: 0.25 # Functional testing
  - helpfulness: 0.20 # User feedback
  - code_style: 0.15 # Style guide compliance
  - security_basics: 0.15 # Basic security checks

implementation_plan:
  phase_1: "Syntax + basic testing"
  phase_2: "User feedback integration"
  phase_3: "Style and security enhancement"

tools_needed: ["Linters", "Test runners", "User feedback"]
monthly_budget: "$150-600"
setup_time: "1-2 weeks"
```

---

## 🎯 Section E: Specialized Tasks

### E1: Task Complexity

**How complex is your specialized task?**

- **High Complexity**: Multi-step reasoning, domain expertise
- **Medium Complexity**: Structured but nuanced tasks
- **Low Complexity**: Well-defined, repeatable tasks

### E2: Output Variability

**How variable are acceptable outputs?**

- **Low Variability**: Specific format/content required
- **Medium Variability**: Some flexibility acceptable
- **High Variability**: Creative interpretation encouraged

### E3: Evaluation Expertise

**Do you have task-specific evaluation expertise?**

- **Yes, Internal Experts**: Domain specialists available
- **Yes, External Access**: Can consult experts
- **No, Limited Expertise**: Must rely on general approaches

### Specialized Task Recommendations

**For High Complexity + Expert Available:**

```yaml
recommended_approach: "Expert-Guided Evaluation"
primary_metrics:
  - task_accuracy: 0.30 # Expert assessment
  - methodology_correctness: 0.25 # Approach validation
  - completeness: 0.20 # Coverage assessment
  - presentation_quality: 0.15 # Output format and clarity
  - efficiency: 0.10 # Resource utilization

implementation_plan:
  phase_1: "Expert evaluation setup"
  phase_2: "Pattern identification"
  phase_3: "Automated screening development"

expert_involvement: "High (30-50% review rate)"
monthly_budget: "$800-3000"
setup_time: "3-6 weeks"
```

**For Low Complexity + Limited Expertise:**

```yaml
recommended_approach: "Template-Based Evaluation"
primary_metrics:
  - format_compliance: 0.30 # Template adherence
  - basic_accuracy: 0.25 # Factual correctness
  - completeness_check: 0.20 # Required elements present
  - user_satisfaction: 0.15 # Feedback collection
  - processing_efficiency: 0.10 # Performance metrics

implementation_plan:
  phase_1: "Template validation + basic checks"
  phase_2: "User feedback integration"
  phase_3: "Quality optimization"

automation_rate: "High (80-90%)"
monthly_budget: "$100-500"
setup_time: "1-2 weeks"
```

---

## 🎯 Quick Decision Matrix

Use this matrix for rapid evaluation approach selection:

| Your Situation                  | Recommended Approach      | Primary Tool      | Monthly Budget |
| ------------------------------- | ------------------------- | ----------------- | -------------- |
| **High Stakes + High Volume**   | Automated + Expert Sample | LLM-judge + Human | $1000-3000     |
| **High Stakes + Low Volume**    | Human-First               | Expert Review     | $2000-5000     |
| **Medium Stakes + High Volume** | LLM-as-Judge              | GPT-4/Claude      | $300-1000      |
| **Medium Stakes + Low Volume**  | Hybrid Approach           | Mixed Tools       | $200-800       |
| **Low Stakes + High Volume**    | Automated                 | Open Source       | $50-300        |
| **Low Stakes + Low Volume**     | Basic Automated           | Simple Tools      | $25-150        |

> 💡 **Need specific metrics?** See the [Metrics Selection Guide](metrics-selection-guide.md) for detailed metric catalogs and implementation resources.

## 🚀 Implementation Quick Start

### Immediate Next Steps (Choose Your Path)

**Path A: Safety-First Approach** (Recommended for most)

1. Implement toxicity detection (2 hours)
2. Add basic relevance checking (2 hours)
3. Set up monitoring dashboard (4 hours)
4. Configure alerts (1 hour)

**Path B: Quality-First Approach** (For content-critical applications)

1. Set up LLM-as-judge evaluation (4 hours)
2. Create quality rubrics (3 hours)
3. Implement human review sampling (3 hours)
4. Build feedback loops (2 hours)

**Path C: User-First Approach** (For customer-facing applications)

1. Implement user feedback collection (3 hours)
2. Set up task success tracking (3 hours)
3. Add experience metrics (2 hours)
4. Create improvement workflows (4 hours)

### Validation Checklist

Before finalizing your evaluation approach, verify:

- [ ] **Business Alignment**: Metrics directly support business goals
- [ ] **Resource Fit**: Implementation within available time/budget
- [ ] **Technical Feasibility**: Required tools and expertise available
- [ ] **Scalability**: Approach works at expected usage levels
- [ ] **Improvement Path**: Clear plan for enhancing evaluation over time

### Getting Help

**If you're still unsure:**

1. Start with the Safety-First approach (lowest risk)
2. Implement basic user feedback collection
3. Run for 2-4 weeks to gather data
4. Use results to refine your evaluation strategy

**Common Decision Points:**

- **Budget Limited**: Focus on automated metrics first
- **Quality Critical**: Invest in human evaluation early
- **Scale Uncertain**: Start simple, plan for growth
- **Domain Complex**: Engage experts from the beginning

## 🚀 Next Steps  

**Ready to implement?** Choose your next step:

1. **[Starter Evaluation Toolkit](starter-evaluation-toolkit.md)**: Get hands-on with day 1 implementation
2. **[Master Implementation Roadmap](../implementation-guides/master-roadmap.md)**: Plan your long-term evaluation strategy
3. **[Cost-Benefit Calculator](cost-benefit-calculator.md)**: Calculate ROI and justify your evaluation investment

## 📖 Related Framework Resources

### **Implementation & Deployment**
- **[Starter Evaluation Toolkit](starter-evaluation-toolkit.md)**: Day 1 implementation with code examples
- **[Implementation Guides](../implementation-guides/evaluation-approaches.md)**: Detailed technical setup instructions
- **[Automation Templates](../automation-templates/pipeline-templates.md)**: Production-ready deployment configurations

### **Tool & Vendor Selection**
- **[Tool Comparison Matrix](../implementation-guides/tool-comparison-matrix.md)**: Comprehensive vendor selection and platform guidance *(Definitive Source)*
- **[Cost-Benefit Calculator](cost-benefit-calculator.md)**: ROI analysis and budget optimization

### **Strategic Planning**
- **[Master Implementation Roadmap](../implementation-guides/master-roadmap.md)**: Long-term planning with specialized templates
- **[Decision Trees](../decision-trees/metric-selection-by-task.md)**: Task-specific metric selection guidance *(Primary Authority)*
- **[Quality Dimensions](../quality-dimensions/llm-quality-mapping.md)**: Comprehensive quality framework

### **Quick Assessment**
- **[Quick Assessment Tool](quick-assessment-tool.md)**: 2-minute evaluation readiness check
- **[Human Evaluation Guidelines](../annotation-templates/human-evaluation-guidelines.md)**: Standardized annotation workflows

This wizard provides a systematic way to select evaluation approaches that match your specific context and constraints while providing a clear path forward.

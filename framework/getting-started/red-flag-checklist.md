# AI Evaluation Red Flag Checklist

## Overview

This checklist helps identify warning signs that indicate urgent need for more rigorous evaluation. Use it to catch evaluation gaps before they become costly problems and to prioritize evaluation investments.

## 🚨 Immediate Action Required (Stop Everything)

### Critical Safety Red Flags

**System is producing harmful content:**

- [ ] **Toxicity/Hate Speech**: AI generates offensive, discriminatory, or hateful content
- [ ] **Misinformation**: AI confidently states false information as fact
- [ ] **Bias Amplification**: AI consistently shows unfair bias against protected groups
- [ ] **Privacy Violations**: AI exposes personal or confidential information
- [ ] **Legal Risk**: AI provides illegal advice or violates regulations

**Action**: Immediately implement safety filters and human review for all outputs

### Business-Critical Red Flags

**User trust is eroding:**

- [ ] **User Complaints**: Multiple complaints about AI quality per day
- [ ] **Social Media Issues**: Negative posts about AI failures going viral
- [ ] **Customer Churn**: Users leaving due to poor AI experience
- [ ] **Support Overload**: Support tickets increasing due to AI errors
- [ ] **Executive Escalation**: C-level executives asking about AI quality

**Action**: Deploy comprehensive evaluation within 48 hours

### Financial Impact Red Flags

**Money being lost:**

- [ ] **Revenue Impact**: Direct revenue loss attributable to AI quality
- [ ] **Cost Overruns**: Unexpected costs from AI errors (support, rework, fixes)
- [ ] **SLA Violations**: Missing service level agreements due to AI performance
- [ ] **Partnership Risk**: Partners threatening to leave due to AI quality
- [ ] **Competitive Loss**: Losing deals specifically due to AI capabilities

**Action**: Calculate true cost of poor evaluation and invest immediately

## ⚠️ Urgent Attention Needed (Within 1 Week)

### Quality Degradation Signals

**System performance declining:**

- [ ] **Accuracy Drop**: >5% decrease in accuracy metrics over last month
- [ ] **User Satisfaction**: Ratings dropping below 4.0/5.0 consistently
- [ ] **Response Quality**: Increasing "poor quality" flags from users
- [ ] **Task Failure**: Success rate declining below 80%
- [ ] **Inconsistency**: High variance in output quality for similar inputs

**Action**: Implement quality monitoring and root cause analysis

### Scale-Related Warning Signs

**Volume outgrowing evaluation:**

- [ ] **Manual Bottleneck**: Human evaluation can't keep up with production volume
- [ ] **Spot Check Gaps**: Less than 1% of outputs being manually reviewed
- [ ] **Delayed Detection**: Quality issues discovered days/weeks after occurrence
- [ ] **Resource Strain**: Evaluation team overwhelmed with workload
- [ ] **Missing Coverage**: Some use cases have no evaluation coverage

**Action**: Deploy automated evaluation systems

### Technical Debt Indicators

**Evaluation system breaking down:**

- [ ] **Outdated Metrics**: Using evaluation methods designed for previous model versions
- [ ] **Tool Failures**: Evaluation tools frequently failing or producing inconsistent results
- [ ] **Process Breakdown**: Team bypassing evaluation steps due to time pressure
- [ ] **Knowledge Gaps**: Key team members leave with no evaluation knowledge transfer
- [ ] **Integration Issues**: Evaluation not integrated into development/deployment pipeline

**Action**: Modernize evaluation infrastructure

## 🔍 Attention Required (Within 1 Month)

### Early Warning Indicators

**Evaluation gaps becoming visible:**

- [ ] **Limited Metrics**: Only tracking 1-2 basic metrics (like response time)
- [ ] **No Baselines**: Can't answer "Is this better than last month?"
- [ ] **Gut Decisions**: Making product decisions based on "feels right"
- [ ] **User Feedback Void**: No systematic way to collect user input
- [ ] **Competitive Blind Spot**: No idea how your AI compares to competitors

**Action**: Implement systematic evaluation framework

### Organizational Red Flags

**Team/process issues:**

- [ ] **No Evaluation Owner**: Nobody specifically responsible for AI quality
- [ ] **Siloed Knowledge**: Only one person understands evaluation setup
- [ ] **Ad-hoc Testing**: Testing happens inconsistently or only before releases
- [ ] **No Documentation**: Evaluation processes not documented
- [ ] **Budget Uncertainty**: No dedicated budget for evaluation activities

**Action**: Establish evaluation governance and processes

### Strategic Risk Signals

**Missing business alignment:**

- [ ] **Unclear Success**: Can't define what "good AI performance" means
- [ ] **Misaligned Metrics**: Optimizing for metrics that don't drive business value
- [ ] **No ROI Tracking**: Can't demonstrate value of AI improvements
- [ ] **Innovation Paralysis**: Afraid to improve AI because of unknown risks
- [ ] **Regulatory Blindness**: No evaluation for compliance requirements

**Action**: Align evaluation with business strategy

## 🎯 Industry-Specific Red Flags

### Healthcare AI

- [ ] **Diagnostic Errors**: Any incorrect medical diagnoses or recommendations
- [ ] **Safety Protocol Gaps**: Not evaluating for FDA/regulatory compliance
- [ ] **Patient Risk**: Potential harm to patient outcomes
- [ ] **Professional Liability**: Healthcare providers expressing liability concerns

### Financial Services

- [ ] **Regulatory Risk**: Not evaluating for financial regulation compliance
- [ ] **Bias in Decisions**: Unfair outcomes in lending, insurance, or investment decisions
- [ ] **Market Risk**: Trading or investment recommendations causing losses
- [ ] **Fraud Detection Gaps**: Missing fraudulent transactions or false positives

### Legal Technology

- [ ] **Legal Accuracy**: Incorrect legal advice or case law citations
- [ ] **Professional Standards**: Not meeting bar association requirements
- [ ] **Client Risk**: Potential harm to client cases or legal standing
- [ ] **Malpractice Exposure**: Lawyers concerned about professional liability

### Educational Technology

- [ ] **Learning Impact**: Students performing worse with AI assistance
- [ ] **Bias in Assessment**: Unfair evaluation of student work
- [ ] **Privacy Concerns**: Student data not properly protected
- [ ] **Academic Integrity**: AI enabling or encouraging cheating

### Customer Service

- [ ] **Escalation Overload**: Too many conversations requiring human intervention
- [ ] **Brand Damage**: AI responses harming company reputation
- [ ] **Customer Retention**: AI interactions driving customer churn
- [ ] **Agent Frustration**: Human agents frustrated with AI handoffs

## 📊 Quantitative Thresholds

### Immediate Action Thresholds

- **Safety Rate**: <95% of outputs pass safety checks
- **User Satisfaction**: <3.5/5.0 average rating
- **Task Success**: <70% successful task completion
- **Response Time**: >5 seconds average response time
- **Error Rate**: >10% of outputs contain obvious errors

### Warning Thresholds

- **Safety Rate**: <98% of outputs pass safety checks
- **User Satisfaction**: <4.0/5.0 average rating
- **Task Success**: <80% successful task completion
- **Response Time**: >3 seconds average response time
- **Error Rate**: >5% of outputs contain obvious errors

### Monitoring Thresholds

- **Safety Rate**: <99% of outputs pass safety checks
- **User Satisfaction**: <4.5/5.0 average rating
- **Task Success**: <90% successful task completion
- **Response Time**: >2 seconds average response time
- **Error Rate**: >2% of outputs contain obvious errors

## 🔄 Regular Assessment Schedule

### Daily Checks (Automated)

- [ ] Safety metrics above minimum thresholds
- [ ] System performance within SLA bounds
- [ ] Error rates below warning levels
- [ ] No critical user complaints

### Weekly Reviews (Team)

- [ ] Quality trends analysis
- [ ] User feedback review
- [ ] Evaluation system health check
- [ ] Team capacity and workload assessment

### Monthly Assessments (Leadership)

- [ ] Comprehensive red flag checklist review
- [ ] ROI measurement and business impact
- [ ] Competitive positioning analysis
- [ ] Strategic evaluation planning

### Quarterly Audits (Organization)

- [ ] Complete evaluation system audit
- [ ] Regulatory compliance review
- [ ] Industry benchmark comparison
- [ ] Investment and resource planning

## 🚀 Action Response Templates

### For Critical Red Flags (0-48 hours)

1. **Immediate**: Stop problematic outputs, implement emergency fixes
2. **Hour 4**: Assemble crisis response team
3. **Hour 8**: Deploy emergency evaluation measures
4. **Hour 24**: Communicate with stakeholders
5. **Hour 48**: Complete root cause analysis and permanent fix plan

### For Urgent Issues (1 week)

1. **Day 1**: Acknowledge issue and create action plan
2. **Day 2-3**: Implement temporary measures
3. **Day 4-5**: Deploy systematic solution
4. **Day 6-7**: Validate fix and document lessons learned

### For Attention Required (1 month)

1. **Week 1**: Research and plan solution
2. **Week 2**: Implement foundational improvements
3. **Week 3**: Deploy and test comprehensive solution
4. **Week 4**: Optimize and establish ongoing processes

This red flag checklist serves as an early warning system to help teams identify and address evaluation gaps before they become expensive problems.

**STOP THE PREVIOUS WORKFLOW**

You are an expert prompt engineer and system debugger. I am reporting a
discrepancy between the agent's actual behavior and the expected behavior
defined in the context.

## The Issue

{{args}}

## Task:

Analyze the current conversation history, the active context files (System
Prompts, GEMINI.md, Extensions), and the user's last prompt to determine the
root cause.

### 1. Root Cause Analysis

Investigate the most likely reasons for this deviation. Consider the
following factors, **but do not limit your analysis to these**:

- **Context Hierarchy & Conflicts:** Are there contradictory instructions
  between the system prompt, Gemini CLI extension contexts, and project-specific
  `GEMINI.md` files?
- **Prompt Framing:** Did the specific wording of the user's request (e.g.,
  asking for specific steps) inadvertently override a general system policy?
- **Trigger Keywords:** Did the agent latch onto specific keywords in the
  workspace (like file name or config files) that biased it towards a standard
  default instead of the custom rule?
- **Instruction Strength:** Was the ignored instruction phrased weakly (e.g.,
  "You can...") vs. authoritatively (e.g., "You MUST...")?

### 2. Remediation Strategy

Provide concrete suggestions to fix this behavior.

- **Context/Docs Updates:** How should the `GEMINI.md` or system instructions be
  rewritten to be more robust? (e.g., changing phrasing, removing
  contradictions, moving location, adding negative constraints).
- **Prompt Refinement:** How should the user's prompt be rephrased to ensure the
  correct context i triggered?

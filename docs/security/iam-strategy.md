**The Four Types of Identities in Our Project**

**We'll design four major identity categories.**

    AWS Account

    │

    *┌──────────────────\──────────────────┐*

* │						                  │                						    │

    **Developers                                      Infrastructure                                                       Runtime**

    **│                 						        │                							  │**

**IAM Identity     				 Terraform Role   						  Lambda Role**

 **│**

**GitHub Actions Role**

Every category has a different purpose.


**Human Identities**

Developers, Architects, Operators. -- These are people.

Their permissions should be:

**temporary **

**auditable **

**least privilege **

Eventually we'll migrate these to IAM Identity Center.


**Infrastructure Identity**

Terraform needs permissions. But not unlimited permissions.

Terraform should manage:

**Lambda **

**EventBridge **

**IAM Roles **

**DynamoDB **

**CloudWatch **

**Secrets Manager **

**Terraform should ****not** become your day-to-day administrator account.


**Runtime Identity**

**Our Lambda function will also need permissions. Think carefully. Does Lambda need AdministratorAccess?**

**Absolutely not.**

**It only needs:**

Read Facebook configuration

↓

Read Secrets

↓

Invoke Bedrock

↓

Write CloudWatch logs

↓

Read Calendar

↓

Write DynamoDB

That's all.


**AI Identity**

This is where AI engineering becomes interesting.

Our Bedrock Agent doesn't magically gain access to AWS.

Instead:

Agent

↓

Tool

↓

IAM Role

↓

AWS Service

The tool executes using AWS credentials. The LLM never bypasses IAM. This separation is critical for security.


**GitHub Actions Identity**

Eventually:

GitHub

↓

OIDC

↓

IAM Role

↓

Terraform

↓

AWS

Notice something. No access keys. No stored passwords. No long-lived secrets.

This is one of the reasons OIDC has become the preferred pattern for CI/CD.


**Least Privilege**

Let's compare two policies.

Bad:

{

**  "Action":"*",**

**  "Resource":"*",**

**  "Effect":"Allow"**

}

Good:

{

  "Action":[

    "bedrock:InvokeModel",

    "logs:CreateLogStream",

"logs:PutLogEvents"

  ],

    "Resource":"Specific Resources",

 **"Effect":"Allow"**

}

The second policy grants only the permissions required.

**6.10 Permission Boundaries**

**Large organizations often use permission boundaries.**

**Think of them as:**

**Maximum permissions.**

**Even if someone accidentally grants AdministratorAccess, the boundary prevents exceeding predefined limits.**

**We won't implement boundaries immediately, but we'll revisit them in the enterprise modules.**

**6.11 Trust Relationships**

**IAM Roles have two important parts.**

**Permissions**

**AND**

**Trust.**

**Example:**

**Lambda**

**↓**

**Assume Role**

**↓**

**Execution Role**

**↓**

**AWS Services**

**The trust policy answers:**

**Who is allowed to assume this role?**

**The permissions policy answers:**

**What can the role do once assumed?**

**Understanding this distinction is essential.**

**6.12 IAM Architecture**

**Here's our target architecture.**

**                  AWS Account**

**──────────────────────────────────────────────**

**Developer**

**↓**

**IAM Identity Center**

**↓**

**Developer Role**

**──────────────────────────────────────────────**

**Terraform**

**↓**

**Deployment Role**

**──────────────────────────────────────────────**

**GitHub Actions**

**↓**

**OIDC Role**

**──────────────────────────────────────────────**

**Lambda**

**↓**

**Execution Role**

**──────────────────────────────────────────────**

**AgentCore**

**↓**

**Tool Roles**

**──────────────────────────────────────────────**

**Notice that each identity has a single, well-defined responsibility.**

**6.13 Role Matrix**

| **Identity**       | **Purpose**                   | **Long-lived?**     |
| ------------------------ | ----------------------------------- | ------------------------- |
| **Developer**      | **Local development**         | **No (future SSO)** |
| **Terraform**      | **Infrastructure deployment** | **No**              |
| **GitHub Actions** | **CI/CD**                     | **No**              |
| **Lambda**         | **Runtime**                   | **Temporary**       |
| **Agent Tool**     | **Tool execution**            | **Temporary**       |

**Long-lived credentials should be the exception, not the norm.**

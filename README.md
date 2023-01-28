# alexei-gcp

Alexei Google Cloud Platform port. Alexei is an attempt to simplify DevOps...**forever**.

# Design Patterns

Initially, the Terraform will be completely comprised *within* the project **root**. It will be split up into multiple *environments* as **modules** are developed to deploy within those environments.

For instance, a prospective environment could be called **tf_deploy_bellanov** that deploys the infrastruture of the Bellanov L.L.C. **organization**.
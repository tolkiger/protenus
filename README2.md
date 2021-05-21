# TASK #2: TERRAFORM
1. Describe how traffic flows within your architecture / solution.
   * Once the container image has been deployed to ECS Fargate, the ALB will be sending healthcheck traffic. If healthcheck passes, then ALB allows traffic to the container. The ALB has a listener to listen for requests on port 443. The listener then forwards the traffic to the listening port of the container (port 80). 
2. Imagine this application returned sensitive data, how would you ensure security for
the application?
   * Since the application is using an ALB, we can use secure listeners for encrypted traffic between clients and the ALB using AWS ACM for certificates. Also, setup the Security groups to ensure only allows IP ranges are whitelisted to contact the ALB. 
3. Explain how you would monitor this application to ensure it meets a defined SLA.
   * CloudWatch alerts can be placed in ALB, target group, ECS Task to continuously monitor the application and push SNS notifications via EMAIL and SMS messages to DevOps team to monitor the alert.
4. Assuming this container received frequent updates, explain from a high-level how you
would orchestrate continuous deployments.
   * This infrastructure already allows deployments to be uninterrupted by allowing more than the required quantity of tasks to run and take over the requests. Every time the application code has new commits, the CICD pipeline will trigger and deploy the latest version of the container image. ECS will provision a new task with the latest container image and once ready, it will deregister and deprovision the older task that contains the older version of the container image.
5. Within AWS, how could you reduce the cost to run your solution? What pros or cons
are associated with these?
   * To reduce cost on this solution, we can do a few things:
      * Monitor CPU/Mem metrics to ensure adequate Cluster size is set:
         * This allows to properly provision the size of CPU/Mem for the ECS Cluster.
      * Setup Fargate Spot:
        * There is no price bidding for Fargate Spot, it’s solely subject to available capacity. Keep in mind, you should only run tasks designed to handle unexpected interruption with 2 minutes warning.
      * Setup Compute Savings Plans:
        * It offers savings of up to 50% on AWS Fargate usage in exchange for a commiment to use a specific amount of compute usage (measured in dollars per hour) for a one or three year term.
      * Put on schedule applications that do not need to be ran continously
      * Set autoscaling
   
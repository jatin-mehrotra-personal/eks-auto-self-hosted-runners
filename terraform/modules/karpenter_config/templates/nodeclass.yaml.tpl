apiVersion: eks.amazonaws.com/v1
kind: NodeClass
metadata:
  name: ${nodeclass_name}
  labels:
    app.kubernetes.io/managed-by: terraform
spec:
  # Use the role from parameters
  role: ${node_role}
  
  # Use the security group from parameters
  securityGroupSelectorTerms:
    - id: ${security_group_id}
  
  # Use the subnets from parameters
  subnetSelectorTerms:
    - id: ${subnet_id_1a}
    - id: ${subnet_id_1b}
  
  # Storage configuration from parameters
  ephemeralStorage:
    iops: ${storage_iops}
    size: ${storage_size}
    throughput: ${storage_throughput}

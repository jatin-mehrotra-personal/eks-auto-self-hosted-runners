apiVersion: karpenter.sh/v1
kind: NodePool
metadata:
  name: ${nodepool_name}
spec:
  template:
    spec:
      nodeClassRef:
        group: eks.amazonaws.com
        kind: NodeClass
        name: ${nodeclass_name}

      requirements:
            - key: "eks.amazonaws.com/instance-category"
              operator: In
              values: ["${instance_category[0]}"]
            - key: "eks.amazonaws.com/instance-family"
              operator: In
              values: ["${instance_family[0]}"]
            - key: "eks.amazonaws.com/instance-cpu"
              operator: In
              values: ["${instance_cpu[0]}"]
            - key: "topology.kubernetes.io/zone"
              operator: In
              values: ["${availability_zones[0]}", "${availability_zones[1]}"]
            - key: "kubernetes.io/arch"
              operator: In
              values: ["${architecture[0]}"]
            - key: "karpenter.sh/capacity-type"
              operator: In
              values: ["${capacity_type[0]}"]

  disruption:
    consolidationPolicy: ${consolidation_policy}
    consolidateAfter: ${consolidate_after}
  limits:
    cpu: ${cpu_limit}

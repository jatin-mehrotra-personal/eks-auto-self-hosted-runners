#!/bin/bash
NAMESPACE=$1
echo "Cleaning up namespace $NAMESPACE..."

# Check if namespace exists
if kubectl get namespace $NAMESPACE &>/dev/null; then
  echo "Namespace $NAMESPACE exists. Starting cleanup..."
  
  # Handle AutoscalingRunnerSet resources
  if kubectl api-resources | grep -q autoscalingrunnerset; then
    echo "Processing AutoscalingRunnerSet resources..."
    RUNNER_SETS=$(kubectl get autoscalingrunnerset -n $NAMESPACE -o name 2>/dev/null | cut -d'/' -f2) || true
    
    for RS in $RUNNER_SETS; do
      echo "Removing finalizers from AutoscalingRunnerSet: $RS"
      kubectl patch autoscalingrunnerset $RS -n $NAMESPACE --type=json -p '[{"op": "remove", "path": "/metadata/finalizers"}]' 2>/dev/null || true
    done
  fi
  
  # Handle EphemeralRunnerSet resources
  if kubectl api-resources | grep -q ephemeralrunnerset; then
    echo "Processing EphemeralRunnerSet resources..."
    EPHEMERAL_SETS=$(kubectl get ephemeralrunnerset -n $NAMESPACE -o name 2>/dev/null | cut -d'/' -f2) || true
    
    for ES in $EPHEMERAL_SETS; do
      echo "Removing finalizers from EphemeralRunnerSet: $ES"
      kubectl patch ephemeralrunnerset $ES -n $NAMESPACE --type=json -p '[{"op": "remove", "path": "/metadata/finalizers"}]' 2>/dev/null || true
    done
  fi
  
  # Handle AutoscalingListener resources
  if kubectl api-resources | grep -q autoscalinglistener; then
    echo "Processing AutoscalingListener resources..."
    LISTENERS=$(kubectl get autoscalinglistener -n $NAMESPACE -o name 2>/dev/null | cut -d'/' -f2) || true
    
    for L in $LISTENERS; do
      echo "Removing finalizers from AutoscalingListener: $L"
      kubectl patch autoscalinglistener $L -n $NAMESPACE --type=json -p '[{"op": "remove", "path": "/metadata/finalizers"}]' 2>/dev/null || true
    done
  fi
  
  # Handle ServiceAccounts
  echo "Processing ServiceAccounts..."
  SAS=$(kubectl get serviceaccounts -n $NAMESPACE -o name 2>/dev/null | cut -d'/' -f2) || true
  for SA in $SAS; do
    echo "Removing finalizers from ServiceAccount: $SA"
    kubectl patch serviceaccount $SA -n $NAMESPACE --type=json -p '[{"op": "remove", "path": "/metadata/finalizers"}]' 2>/dev/null || true
  done
  
  # Handle RoleBindings
  echo "Processing RoleBindings..."
  ROLEBINDINGS=$(kubectl get rolebindings -n $NAMESPACE -o name 2>/dev/null | cut -d'/' -f2) || true
  for RB in $ROLEBINDINGS; do
    echo "Removing finalizers from RoleBinding: $RB"
    kubectl patch rolebinding $RB -n $NAMESPACE --type=json -p '[{"op": "remove", "path": "/metadata/finalizers"}]' 2>/dev/null || true
  done
  
  # Handle Roles
  echo "Processing Roles..."
  ROLES=$(kubectl get roles -n $NAMESPACE -o name 2>/dev/null | cut -d'/' -f2) || true
  for ROLE in $ROLES; do
    echo "Removing finalizers from Role: $ROLE"
    kubectl patch role $ROLE -n $NAMESPACE --type=json -p '[{"op": "remove", "path": "/metadata/finalizers"}]' 2>/dev/null || true
  done
  
  echo "Finalizers removed. Letting Terraform handle resource deletion."
else
  echo "Namespace $NAMESPACE does not exist. Nothing to clean up."
fi

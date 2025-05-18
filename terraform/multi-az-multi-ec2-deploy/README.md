# Terraform: Deploy Multiple EC2 Instances per Availability Zone

This Terraform configuration dynamically deploys **multiple EC2 instances in each Availability Zone (AZ)** of the `ap-south-1` AWS region. The code uses advanced constructs like **nested `for` loops**, **`flatten()`**, **`for_each`**, and **custom key mapping** to achieve scalable and predictable EC2 provisioning.

---

## 🚀 What This Code Does

- Queries all available AZs in `ap-south-1`.
- Creates **n EC2 instances per AZ** (configurable via a variable).
- Tags each instance uniquely using AZ name and index (e.g., `ec2-ap-south-1a-0`).
- Outputs the complete AZ-instance mapping and flattened AZ+index list.

---

## 🔧 Key Concepts Explained

---

### 🔁 Nested for with `flatten()`
```hcl
az_index_list = flatten([
  for az in data.aws_availability_zones.az.names : [
    for i in range(var.instance_count) : {
      key   = "${az}-${i}"
      value = az
    }
  ]
])
```
* This double loop creates a list of maps, where each item is like:
```
{ key = "ap-south-1a-0", value = "ap-south-1a" }
{ key = "ap-south-1a-1", value = "ap-south-1a" }
```


### 📦 Map Construction for `for_each`
```hcl 
instance_matrix = {
  for pair in local.az_index_list :
  pair.key => pair.value
}
```
* Converts the flat list into a map of:
```
{
  "ap-south-1a-0" = "ap-south-1a"
  "ap-south-1a-1" = "ap-south-1a"
  ...
}
```
* This map is ideal for for_each, ensuring each EC2 instance has a unique key.


### 🔁 `for_each` on EC2 Resource
```hcl
resource "aws_instance" "multi-instance" {
  for_each = local.instance_matrix
  ...
}
```
* This tells Terraform to create one EC2 instance for each entry in the map.
* Ensures predictable naming, clear plan diffs, and safe instance tracking.



### 🏷️ Dynamic Tagging
```hcl
tags = {
  Name = "ec2-${each.key}"
}
```
* Tags each instance with a meaningful name like:
```
ec2-ap-south-1a-0
.
.
ec2-ap-south-1c-1
```
* Useful for monitoring, debugging, and cost tracking.

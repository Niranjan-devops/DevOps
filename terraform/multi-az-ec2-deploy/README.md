# Terraform: EC2 Deployment Across Multiple Availability Zones (Multi-AZ)

This Terraform configuration dynamically deploys **EC2 instances across all available availability zones (AZs)** in a given AWS region. It uses dynamic constructs like `for_each`, `each.key`, and `toset(...)` for scalable and readable multi-AZ provisioning.

---

## 💡 Key Terraform Concepts Used

---

### 🔁 `for_each` 

`for_each` is used to **create multiple instances of a resource**, one for each element in a set or map.

hcl
for_each = toset(data.aws_availability_zones.az.names) ```

In this case:

data.aws_availability_zones.az.names returns a list of AZs.
toset(...) converts this list to a set, which is required by for_each.

This tells Terraform to create one aws_instance per unique availability zone.


### 🧷 `each.key`
When using for_each, Terraform exposes the current loop element via the each object.

```availability_zone = each.key```

each.key refers to the current AZ name in the iteration.
Example: "ap-south-1a"

It's also used to dynamically tag each instance:

```
tags = {
  Name = "demo-${each.key}"
}
```

🔄 toset(...)
``` toset(data.aws_availability_zones.az.names)```
Converts a list to a set for use with for_each.
Ensures uniqueness and compatibility.
Ideal when you only need values (AZ names) without keys.

⚖️ Why Not Use count?
You might consider writing:
```
count = length(data.aws_availability_zones.az.names)
availability_zone = data.aws_availability_zones.az.names[count.index]
```

However, this approach has drawbacks:
❌ You lose the AZ name as a unique identifier.
❌ Tagging becomes less readable: Name = demo-${count.index}.
❌ AZ order changes can lead to resource recreation.
✅ Use for_each when the identity of each item (like an AZ name) matters.

🛠 What This Code Does
Queries all available AZs in the ap-south-1 region.
Deploys one EC2 instance per AZ.
Tags each instance as demo-<AZ> for clarity (e.g., demo-ap-south-1a).
Ensures high availability across the region.





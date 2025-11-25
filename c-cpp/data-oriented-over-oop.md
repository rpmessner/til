---
published: true
---

# Data-Oriented Design Over OOP

Following Jonathan Blow's philosophy, prefer simple structs and functions over class hierarchies:

```cpp
// BAD: Over-engineered OOP
class VulkanRenderer : public Singleton<VulkanRenderer> {
    // 500 lines of abstraction
};
VulkanRenderer::Instance().DoThing();

// GOOD: Data-oriented
struct VulkanState {
    VkInstance instance;
    VkDevice device;
    // Just the data we need
};
VulkanState vk = {};
init_vulkan(&vk);
```

Key principles:
1. **Simple beats clever** - "Well designed" code that won't compile is worthless
2. **Patterns are often anti-patterns** - Singleton, Factory add complexity without value
3. **Direct is better than abstracted** - Just call the functions
4. **Data over objects** - A struct with its data is clearer than a class with hidden state

Signs you're over-engineering:
- ❌ Design patterns everywhere (Singleton, Factory, Template Method)
- ❌ Deep inheritance hierarchies (A → B → C → D)
- ❌ Template metaprogramming
- ❌ Gang of Four patterns applied religiously
- ❌ Code won't compile because abstractions got in the way

Better approach:
- ✅ Plain structs holding data
- ✅ Free functions that operate on structs
- ✅ Only abstract when you have 3+ concrete examples
- ✅ Solve today's problems today, not hypothetical future ones

---
published: true
---

# Simple C-Style Vulkan Initialization

Instead of wrapping Vulkan in complex class hierarchies, use a plain C struct and functions:

```cpp
// Simple state struct - no classes, no inheritance
struct VulkanState {
    VkInstance instance;
    VkPhysicalDevice physical_device;
    VkDevice device;
    VkSurfaceKHR surface;
    GLFWwindow* window;
};

bool create_vulkan_instance(VulkanState* vk) {
    VkApplicationInfo app_info = {};
    app_info.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
    app_info.pApplicationName = "My App";
    app_info.applicationVersion = VK_MAKE_VERSION(1, 0, 0);
    app_info.pEngineName = "No Engine";
    app_info.apiVersion = VK_API_VERSION_1_3;

    VkInstanceCreateInfo create_info = {};
    create_info.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
    create_info.pApplicationInfo = &app_info;

    // Get GLFW extensions
    uint32_t glfw_ext_count = 0;
    const char** glfw_exts = glfwGetRequiredInstanceExtensions(&glfw_ext_count);
    create_info.enabledExtensionCount = glfw_ext_count;
    create_info.ppEnabledExtensionNames = glfw_exts;

    return vkCreateInstance(&create_info, nullptr, &vk->instance) == VK_SUCCESS;
}

void cleanup_vulkan(VulkanState* vk) {
    vkDestroyDevice(vk->device, nullptr);
    vkDestroySurfaceKHR(vk->instance, vk->surface, nullptr);
    vkDestroyInstance(vk->instance, nullptr);
}

// Usage
int main() {
    VulkanState vk = {};
    if (!create_vulkan_instance(&vk)) return 1;
    // ... use vk
    cleanup_vulkan(&vk);
}
```

Benefits:
- Clear what data exists (it's all in the struct)
- No hidden state in singleton/static members
- Easy to understand what each function does
- Compile time: <1 second
- Lines of code: ~200 vs 3000+ for "enterprise" OOP version

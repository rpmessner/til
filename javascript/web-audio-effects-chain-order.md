---
published: true
---

# Web Audio Effects Chain Order

The order of audio effects significantly impacts the final sound. Follow the standard guitar pedal chain order:

1. **Filter** (first) - Shape the tone before processing
2. **Distortion** - Add harmonics to the filtered signal
3. **Delay** - Echo the processed sound
4. **Reverb** (last) - Add space; most CPU-intensive

```javascript
function createEffectsChain(audioContext, params) {
  let chain = [];

  if (params.cutoff) chain.push(createFilter(audioContext, params));
  if (params.shape) chain.push(createDistortion(audioContext, params));
  if (params.delay) chain.push(createDelay(audioContext, params));
  if (params.room) chain.push(createReverb(audioContext, params));

  // Connect in order
  for (let i = 0; i < chain.length - 1; i++) {
    chain[i].connect(chain[i + 1]);
  }

  return { input: chain[0], output: chain[chain.length - 1] };
}
```

Why this order matters:
- Filtering after distortion removes harmonics you just created
- Reverb before delay creates muddy, undefined echoes
- Distortion after reverb creates harsh, unpleasant artifacts

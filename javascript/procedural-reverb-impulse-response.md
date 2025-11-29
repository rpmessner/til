---
published: true
---

# Generate Reverb Impulse Responses Procedurally

Instead of loading audio files for convolution reverb, generate impulse responses procedurally. Apply an exponential decay envelope to noise:

```javascript
function generateImpulseResponse(audioContext, duration, decay) {
  const sampleRate = audioContext.sampleRate;
  const length = sampleRate * duration;
  const buffer = audioContext.createBuffer(2, length, sampleRate);
  const leftChannel = buffer.getChannelData(0);
  const rightChannel = buffer.getChannelData(1);

  for (let i = 0; i < length; i++) {
    const t = i / sampleRate;
    const envelope = Math.exp(-decay * t);
    leftChannel[i] = (Math.random() * 2 - 1) * envelope;
    rightChannel[i] = (Math.random() * 2 - 1) * envelope;
  }

  return buffer;
}

// Usage with ConvolverNode
const ir = generateImpulseResponse(audioContext, 2.0, 3.0);
const reverb = audioContext.createConvolver();
reverb.buffer = ir;
```

Benefits:
- No external audio file dependencies
- Works offline immediately
- Adjustable room size via duration/decay parameters
- Cache generated IRs by parameter values for performance

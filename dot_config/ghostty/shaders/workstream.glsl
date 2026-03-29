// workstream.glsl — Workstream-aware pane shader for Ghostty
// Detects the subtle background tint that ws applies to each tmux pane
// and amplifies it into a living energy field unique to each workstream.
//
// Each workstream gets a color from the Catppuccin Mocha palette:
//   mauve  (#1e1e38) → purple plasma tendrils
//   teal   (#1e2e2e) → cyan matrix cascade
//   blue   (#1e2636) → blue nebula drift
//   pink   (#2e1e2a) → magenta ember glow
//   green  (#2a2e1e) → green aurora veil
//   peach  (#2e261e) → orange lava flow
//   yellow (#2e2e1e) → golden shimmer
//   lavender (#241e2e) → indigo deep pulse

// --- Noise functions ---

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float hash3(vec3 p) {
    return fract(sin(dot(p, vec3(127.1, 311.7, 74.7))) * 43758.5453);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

float fbm(vec2 p, int octaves) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100.0);
    for (int i = 0; i < octaves; i++) {
        v += a * noise(p);
        p = p * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

// --- Color detection ---
// Detect which workstream color a pixel's background belongs to.
// Returns a hue signal (0-1) and saturation based on the tint.

vec3 detectTint(vec3 bg) {
    // Catppuccin Mocha base is roughly (0.118, 0.118, 0.180) = #1e1e2e
    // ws add applies tints like #1e1e38, #1e2e2e, etc. — deltas of ~0.03-0.06.
    // We need a high threshold to avoid false positives from aurora noise.
    vec3 base = vec3(0.118, 0.118, 0.180);
    vec3 delta = bg - base;

    // If the pixel is anything other than very dark background, skip it.
    // This prevents diff highlights, selection, status bars, etc. from triggering.
    float brightness = dot(bg, vec3(0.299, 0.587, 0.114));
    if (brightness > 0.15) return vec3(0.0);

    // Signal strength — how much does this deviate from base?
    float strength = length(delta);
    if (strength < 0.03) return vec3(0.0); // Only trigger on real ws tints

    // Map 0.03-0.08 range to 0-1
    strength = smoothstep(0.03, 0.08, strength);

    // Normalize the deviation direction to get a hue
    vec3 dir = normalize(delta + 0.001);

    return vec3(dir.r, dir.g, strength);
}

// --- Effect functions per color family ---

// Plasma tendrils — organic flowing lines
float plasma(vec2 uv, float t) {
    float v = 0.0;
    v += sin(uv.x * 10.0 + t);
    v += sin((uv.y * 10.0 + t) * 0.5);
    v += sin((uv.x * 10.0 + uv.y * 10.0 + t) * 0.3333);
    vec2 q = vec2(uv.x + sin(t * 0.3) * 2.0, uv.y + cos(t * 0.2) * 2.0);
    v += sin(length(q) * 5.0);
    return v * 0.25;
}

// Matrix-style cascade — vertical streaks
float cascade(vec2 uv, float t) {
    float col = floor(uv.x * 30.0);
    float speed = hash(vec2(col, 0.0)) * 2.0 + 0.5;
    float phase = hash(vec2(col, 1.0)) * 6.28;
    float y = fract(uv.y + t * speed * 0.05 + phase);
    float brightness = smoothstep(0.0, 0.3, y) * smoothstep(1.0, 0.5, y);
    float flicker = hash(vec2(col, floor(t * 4.0)));
    return brightness * (0.5 + 0.5 * flicker);
}

// Nebula drift — slow cloudy movement
float nebula(vec2 uv, float t) {
    vec2 q = vec2(
        fbm(uv * 2.0 + t * 0.02, 5),
        fbm(uv * 2.0 + vec2(5.2, 1.3) + t * 0.02, 5)
    );
    return fbm(uv * 3.0 + q * 1.5, 4);
}

// Ember glow — pulsing warm particles
float embers(vec2 uv, float t) {
    float v = 0.0;
    for (int i = 0; i < 6; i++) {
        float fi = float(i);
        vec2 center = vec2(
            hash(vec2(fi, 0.0)) + sin(t * 0.1 + fi) * 0.1,
            hash(vec2(fi, 1.0)) + cos(t * 0.08 + fi * 1.3) * 0.15
        );
        float dist = length(uv - center);
        float pulse = 0.5 + 0.5 * sin(t * 0.5 + fi * 2.0);
        v += pulse * exp(-dist * dist * 40.0);
    }
    return v;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 terminal = texture(iChannel0, uv);

    // Sample a small area around this pixel to get a stable background read
    // (individual pixels may be text, so we sample neighbors)
    vec3 bgSample = vec3(0.0);
    float sampleCount = 0.0;
    float texelX = 1.0 / iResolution.x;
    float texelY = 1.0 / iResolution.y;
    for (int dx = -2; dx <= 2; dx++) {
        for (int dy = -2; dy <= 2; dy++) {
            vec2 offset = vec2(float(dx) * texelX * 4.0, float(dy) * texelY * 4.0);
            vec4 s = texture(iChannel0, uv + offset);
            float b = dot(s.rgb, vec3(0.299, 0.587, 0.114));
            if (b < 0.2) { // Only count dark pixels (background)
                bgSample += s.rgb;
                sampleCount += 1.0;
            }
        }
    }
    if (sampleCount > 0.0) bgSample /= sampleCount;

    // Detect tint
    vec3 tint = detectTint(bgSample);
    float tintStrength = tint.z;

    // No tint = no effect (pass through to aurora shader)
    if (tintStrength < 0.01) {
        fragColor = terminal;
        return;
    }

    // Determine dominant channel for effect selection
    float t = iTime;
    float effect = 0.0;
    vec3 effectColor = vec3(0.0);

    // Red-dominant tints: pink/peach/yellow → embers
    // Green-dominant tints: teal/green → cascade
    // Blue-dominant tints: mauve/blue/lavender → plasma/nebula
    vec3 delta = bgSample - vec3(0.118, 0.118, 0.180);

    if (delta.b > abs(delta.r) && delta.b > abs(delta.g)) {
        // Blue family — mauve, blue, lavender
        effect = plasma(uv, t * 0.3);
        // Pick color from the actual tint
        effectColor = mix(
            vec3(0.796, 0.651, 0.961), // mauve
            vec3(0.537, 0.706, 0.980), // blue
            smoothstep(-0.02, 0.02, delta.r - delta.g)
        );
    } else if (delta.g > abs(delta.r) && delta.g > abs(delta.b)) {
        // Green family — teal, green
        effect = cascade(uv, t);
        effectColor = mix(
            vec3(0.588, 0.827, 0.800), // teal
            vec3(0.651, 0.890, 0.631), // green
            smoothstep(0.0, 0.03, delta.g - 0.02)
        );
    } else {
        // Red family — pink, peach, yellow
        effect = embers(uv, t);
        effectColor = mix(
            vec3(0.961, 0.761, 0.906), // pink
            vec3(0.980, 0.702, 0.529), // peach
            smoothstep(-0.01, 0.02, delta.r - delta.g)
        );
    }

    // Nebula underlayer for all tints (very subtle)
    float nebulaVal = nebula(uv, t) * 0.3;
    effect = max(effect, nebulaVal);

    // Scale intensity — tintStrength is now 0-1 via smoothstep
    float intensity = tintStrength * effect * 0.12;

    // Don't wash out text — reduce effect where content is bright
    float textPresence = max(terminal.r, max(terminal.g, terminal.b));
    intensity *= (1.0 - textPresence * 0.7);

    // Breathing modulation — slow pulse
    float breath = 0.8 + 0.2 * sin(t * 0.4);
    intensity *= breath;

    // Final blend
    vec3 color = terminal.rgb + effectColor * intensity;

    fragColor = vec4(color, terminal.a);
}

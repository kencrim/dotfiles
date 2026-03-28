// aurora.glsl — Subtle aurora background for Ghostty
// A slow-moving color wash using Catppuccin Mocha palette.
// Designed to be visible but never distracting.

// Ghostty provides these uniforms automatically:
// uniform sampler2D iChannel0;  — terminal surface texture
// uniform vec2 iResolution;     — viewport size in pixels
// uniform float iTime;          — seconds since start
// uniform int iFrame;           — frame counter

// Noise function for organic movement
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
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

float fbm(vec2 p) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100.0);
    for (int i = 0; i < 4; i++) {
        v += a * noise(p);
        p = p * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;

    // Sample the terminal content
    vec4 terminal = texture(iChannel0, uv);

    // Catppuccin Mocha palette colors (muted for background use)
    vec3 mauve   = vec3(0.796, 0.651, 0.961);  // #cba6f7
    vec3 blue    = vec3(0.537, 0.706, 0.980);  // #89b4fa
    vec3 teal    = vec3(0.588, 0.827, 0.800);  // #94e2d5
    vec3 base    = vec3(0.118, 0.118, 0.180);  // #1e1e2e

    // Slow organic movement
    float t = iTime * 0.04; // Very slow
    vec2 q = vec2(fbm(uv * 1.5 + t), fbm(uv * 1.5 + vec2(5.2, 1.3) + t));
    float f = fbm(uv * 2.0 + q);

    // Vertical bias — aurora lives in top half
    float verticalFade = smoothstep(0.0, 0.7, uv.y);

    // Mix aurora colors
    vec3 aurora = mix(blue, mauve, f);
    aurora = mix(aurora, teal, q.x * 0.5);

    // Very subtle — just enough to notice
    float intensity = 0.06 * verticalFade * (0.5 + 0.5 * f);

    // Blend behind terminal content
    // Only affect cells with no explicit foreground content
    float textPresence = max(terminal.r, max(terminal.g, terminal.b));
    float bgMix = intensity * (1.0 - textPresence * 0.8);

    vec3 color = mix(terminal.rgb, aurora, bgMix);

    fragColor = vec4(color, terminal.a);
}

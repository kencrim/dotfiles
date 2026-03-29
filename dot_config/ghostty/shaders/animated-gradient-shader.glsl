// Slow blue-grey gradient — barely moves, never distracts.
// Drifts between cool blue-grey tones matching Catppuccin Mocha.

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec4 terminal = texture(iChannel0, uv);

    // Very slow drift
    float angle = iTime * 0.06;

    // Blue-grey family with real color movement
    vec3 color1 = vec3(0.08, 0.08, 0.22); // deep indigo
    vec3 color2 = vec3(0.14, 0.20, 0.30); // steel blue
    vec3 color3 = vec3(0.16, 0.10, 0.22); // dusty mauve
    vec3 color4 = vec3(0.08, 0.18, 0.20); // ocean teal

    // Gentle spatial gradient — diagonal
    float grad = smoothstep(0.0, 1.0, (uv.x + uv.y) * 0.5);

    // Slow color cycling between four tones
    vec3 top = mix(color1, color2, sin(angle) * 0.5 + 0.5);
    vec3 bot = mix(color3, color4, sin(angle + 1.5) * 0.5 + 0.5);
    vec3 bg = mix(top, bot, grad);

    // Only apply to dark background pixels — leave text and UI alone
    float brightness = dot(terminal.rgb, vec3(0.299, 0.587, 0.114));
    float mask = smoothstep(0.12, 0.06, brightness);

    vec3 color = mix(terminal.rgb, bg, mask * 0.85);
    fragColor = vec4(color, terminal.a);
}

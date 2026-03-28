// cursor-glow.glsl — Soft glow around cursor for Ghostty
// A gentle radial highlight that follows the cursor.
// Works best with background-opacity < 1.0.

// Ghostty 1.2+ cursor uniforms:
// uniform vec2 iCursorPos;     — cursor position in pixels
// uniform float iCursorColor;  — cursor color (not always available)

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 terminal = texture(iChannel0, uv);

    // Cursor position in UV space
    vec2 cursorUV = iCursorPos / iResolution.xy;

    // Distance from cursor
    vec2 diff = uv - cursorUV;
    diff.x *= iResolution.x / iResolution.y; // Correct aspect ratio
    float dist = length(diff);

    // Catppuccin lavender for glow
    vec3 glowColor = vec3(0.702, 0.718, 0.953); // #b4befe

    // Soft falloff — visible within ~120px radius equivalent
    float radius = 0.12;
    float glow = exp(-dist * dist / (2.0 * radius * radius));

    // Very subtle intensity
    float intensity = glow * 0.08;

    // Don't wash out text
    float textPresence = max(terminal.r, max(terminal.g, terminal.b));
    intensity *= (1.0 - textPresence * 0.6);

    vec3 color = terminal.rgb + glowColor * intensity;

    fragColor = vec4(color, terminal.a);
}

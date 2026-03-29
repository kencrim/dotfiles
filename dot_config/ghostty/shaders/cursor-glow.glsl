// cursor-glow.glsl — Tight cursor highlight for Ghostty
// A small, crisp glow that sits right behind the cursor.

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 terminal = texture(iChannel0, uv);

    // Cursor position in UV space
    // iCurrentCursor.xy is the cursor position in pixels
    // Nudge up by half a cell height to visually center on the cursor
    vec2 cursorPixel = iCurrentCursor.xy - vec2(0.0, iCurrentCursor.w * 0.5);
    vec2 cursorUV = cursorPixel / iResolution.xy;

    // Distance from cursor, aspect-corrected
    vec2 diff = uv - cursorUV;
    diff.x *= iResolution.x / iResolution.y;
    float dist = length(diff);

    // Catppuccin lavender
    vec3 glowColor = vec3(0.702, 0.718, 0.953); // #b4befe

    // Very tight — roughly 1 character wide
    float radius = 0.01;
    float glow = exp(-dist * dist / (2.0 * radius * radius));

    // Subtle — just a hint of backlight
    float intensity = glow * 0.05;

    // Don't touch text
    float textPresence = max(terminal.r, max(terminal.g, terminal.b));
    intensity *= (1.0 - textPresence * 0.9);

    vec3 color = terminal.rgb + glowColor * intensity;
    fragColor = vec4(color, terminal.a);
}

// Steadfast is a fast and high-quality graphical overhaul for Minecraft (JE)
// Copyright (C) 2026 coderbot
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
out float4 color;

#ifdef MC_RENDER_STAGE_STARS
	uniform int renderStage;
#endif

uniform float blindness;

void main() {
	#ifdef MC_RENDER_STAGE_STARS
		bool stars = renderStage == MC_RENDER_STAGE_STARS;
	#else
		// Fallback star detection from https://github.com/shaderLABS/Base-120
		// File: /shaders/gbuffers_skybasic.vsh
		bool stars = gl_Color.r == gl_Color.g
			&& gl_Color.g == gl_Color.b
			&& gl_Color.r >= 0.5;
	#endif

	if (stars) {
		gl_Position = ftransform();
	} else {
		gl_Position = float4(-1.0);
	}

	// Fade away the stars during blindness
	float blindnessFade = max(0.0, 1.0 - 10.0 * blindness);
	color = float4(float3(blindnessFade), gl_Color.a);
}

// Copyright (c) 2015 Uber Technologies, Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

/* vertex shader for the grid-layer */
#define SHADER_NAME grid-layer-vs

// #pragma glslify: preproject = require(../../../../shaderlib/preproject)
// #pragma glslify: scale = require(../../../../shaderlib/scale)
// #pragma glslify: project = require(../../../../shaderlib/project)

attribute vec3 vertices;
attribute vec3 instancePositions;
attribute vec4 instanceColors;
attribute vec3 instancePickingColors;

uniform float maxCount;
uniform float opacity;
uniform float renderPickingBuffer;
uniform vec3 scale;
uniform vec3 selectedPickingColor;

varying vec4 vColor;

void main(void) {
  float alpha = instancePickingColors == selectedPickingColor ? 1.5 * instanceColors.w : instanceColors.w;
  vColor = vec4(mix(instanceColors.xyz / maxCount, instancePickingColors / 255., renderPickingBuffer), alpha);

  gl_Position = vec4(instancePositions + vertices * scale, 1.0);
}
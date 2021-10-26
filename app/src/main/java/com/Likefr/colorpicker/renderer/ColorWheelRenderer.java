package com.Likefr.colorpicker.renderer;

import com.Likefr.colorpicker.ColorCircle;

import java.util.List;

public interface ColorWheelRenderer {
	float GAP_PERCENTAGE = 0.025f;

	void draw();

	ColorWheelRenderOption getRenderOption();

	void initWith(ColorWheelRenderOption colorWheelRenderOption);

	List<ColorCircle> getColorCircleList();
}

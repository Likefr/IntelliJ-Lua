package com.Likefr.colorpicker.builder;

import com.Likefr.colorpicker.ColorPickerView;
import com.Likefr.colorpicker.renderer.ColorWheelRenderer;
import com.Likefr.colorpicker.renderer.FlowerColorWheelRenderer;
import com.Likefr.colorpicker.renderer.SimpleColorWheelRenderer;

public class ColorWheelRendererBuilder {
	public static ColorWheelRenderer getRenderer(ColorPickerView.WHEEL_TYPE wheelType) {
		switch (wheelType) {
			case CIRCLE:
				return new SimpleColorWheelRenderer();
			case FLOWER:
				return new FlowerColorWheelRenderer();
		}
		throw new IllegalArgumentException("wrong WHEEL_TYPE");
	}
}
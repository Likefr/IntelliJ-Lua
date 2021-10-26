/*
 * Copyright (c) 2013 Tah Wei Hoon.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Apache License Version 2.0,
 * with full text available at http://www.apache.org/licenses/LICENSE-2.0.html
 *
 * This software is provided "as is". Use at your own risk.
 */

package com.qklua.editor;

import java.util.HashMap;

public abstract class ColorScheme
{
	public enum Colorable
	{
		FOREGROUND, BACKGROUND, SELECTION_FOREGROUND, SELECTION_BACKGROUND,
		CARET_FOREGROUND, CARET_BACKGROUND, CARET_DISABLED, LINE_HIGHLIGHT,
		NON_PRINTING_GLYPH, COMMENT, KEYWORD, NAME, LITERAL,STRING,
		SECONDARY,
		//自定义a-l
		NAMEA,NAMEB,NAMEC,NAMED,NAMEE,NAMEF,NAMEG,NAMEH,NAMEI,NAMEJ,NAMEK,NAMEL,NAMEM,NAMEN,NAMEO,NAMEP,NAMEQ,NAMER,NAMES,NAMET
	}
		

	protected HashMap<Colorable, Integer> _colors = generateDefaultColors();

	public void setColor(Colorable colorable, int color)
	{
		_colors.put(colorable, color);
	}

	public int getColor(Colorable colorable)
	{
		Integer color = _colors.get(colorable);
		if (color == null)
		{
			TextWarriorException.fail("Color not specified for " + colorable);
			return 0;
		}
		return color.intValue();
	}

	// Currently, color scheme is tightly coupled with semantics of the token types
	public int getTokenColor(int tokenType)
	{
		Colorable element;
		switch (tokenType)
		{
			case Lexer.NORMAL:
				element = Colorable.FOREGROUND;
				break;
			case Lexer.KEYWORD:
				element = Colorable.KEYWORD;
				break;
			case Lexer.NAME:
				element = Colorable.NAME;
				break;
				//自定义namea-namel
			case Lexer.NAMEA:
				element = Colorable.NAMEA;
				break;
			case Lexer.NAMEB:
				element = Colorable.NAMEB;
				break;
			case Lexer.NAMEC:
				element = Colorable.NAMEC;
				break;
			case Lexer.NAMED:
				element = Colorable.NAMED;
				break;
			case Lexer.NAMEE:
				element = Colorable.NAMEE;
				break;
			case Lexer.NAMEF:
				element = Colorable.NAMEF;
				break;
			case Lexer.NAMEG:
				element = Colorable.NAMEG;
				break;
			case Lexer.NAMEH:
				element = Colorable.NAMEH;
				break;
			case Lexer.NAMEI:
				element = Colorable.NAMEI;
				break;
			case Lexer.NAMEJ:
				element = Colorable.NAMEJ;
				break;
			case Lexer.NAMEK:
				element = Colorable.NAMEK;
				break;
			case Lexer.NAMEL:
				element = Colorable.NAMEL;
				break;
			case Lexer.NAMEM:
				element = Colorable.NAMEM;
				break;
			case Lexer.NAMEN:
				element = Colorable.NAMEN;
				break;
			case Lexer.NAMEO:
				element = Colorable.NAMEO;
				break;
			case Lexer.NAMEP:
				element = Colorable.NAMEP;
				break;
			case Lexer.NAMEQ:
				element = Colorable.NAMEQ;
				break;
			case Lexer.NAMER:
				element = Colorable.NAMER;
				break;
			case Lexer.NAMES:
				element = Colorable.NAMES;
				break;
			case Lexer.NAMET:
				element = Colorable.NAMET;
				break;
			
				
			case Lexer.DOUBLE_SYMBOL_LINE: //fall-through
			case Lexer.DOUBLE_SYMBOL_DELIMITED_MULTILINE:
			case Lexer.SINGLE_SYMBOL_LINE_B:
				element = Colorable.COMMENT;
				break;
			case Lexer.SINGLE_SYMBOL_DELIMITED_A: //fall-through
			case Lexer.SINGLE_SYMBOL_DELIMITED_B:
				element = Colorable.STRING;
				break;
			case Lexer.LITERAL:
				element = Colorable.LITERAL;
				break;
			case Lexer.SINGLE_SYMBOL_LINE_A: //fall-through
			case Lexer.SINGLE_SYMBOL_WORD:
			case Lexer.OPERATOR:
				element = Colorable.SECONDARY;
				break;
			default:
				TextWarriorException.fail("Invalid token type");
				element = Colorable.FOREGROUND;
				break;
		}
		return getColor(element);
	}

	/**
	 * Whether this color scheme uses a dark background, like black or dark grey.
	 */
	public abstract boolean isDark();

	private HashMap<Colorable, Integer> generateDefaultColors()
	{
		// High-contrast, black-on-white color scheme
		HashMap<Colorable, Integer> colors = new HashMap<Colorable, Integer>(Colorable.values().length);
		colors.put(Colorable.FOREGROUND, BLACK);//前景 黑
		colors.put(Colorable.BACKGROUND, WHITE);//背景 白
		colors.put(Colorable.SELECTION_FOREGROUND, WHITE);//选择前景色
		colors.put(Colorable.SELECTION_BACKGROUND, 0xFF97C024);//选择背景 浅绿色
		colors.put(Colorable.CARET_FOREGROUND, WHITE); //插入符号前景 白
		colors.put(Colorable.CARET_BACKGROUND, LIGHT_BLUE2);//插入符号背景 蓝
		colors.put(Colorable.CARET_DISABLED, GREY); //插入符号被禁用色  灰色
		colors.put(Colorable.LINE_HIGHLIGHT, 0x20888888); //线条突出显示色 灰色

		colors.put(Colorable.NON_PRINTING_GLYPH, LIGHT_GREY);//非打印字形

		colors.put(Colorable.COMMENT, OLIVE_GREEN); //评论颜色
		colors.put(Colorable.KEYWORD, DARK_BLUE); // 关键字
		colors.put(Colorable.NAME, INDIGO); // 主关键词
		colors.put(Colorable.LITERAL, LIGHT_BLUE); // 
		colors.put(Colorable.STRING, PURPLE); // Eclipse default color
		colors.put(Colorable.SECONDARY, GREY);//SECONDARY
		//自定义默认添加namea-namel的颜色
		colors.put(Colorable.NAMEA, 0xFF0000FF); 
		colors.put(Colorable.NAMEB, 0xFF0000FF); 
		colors.put(Colorable.NAMEC, 0xFF0000FF); 
		colors.put(Colorable.NAMED, 0xFF0000FF); 
		colors.put(Colorable.NAMEE, 0xFF0000FF); 
		colors.put(Colorable.NAMEF, 0xFF0000FF); 
		colors.put(Colorable.NAMEG, 0xFF0000FF); 
		colors.put(Colorable.NAMEH, 0xFF0000FF); 
		colors.put(Colorable.NAMEI, 0xFF0000FF); 
		colors.put(Colorable.NAMEJ, 0xFF0000FF); 
		colors.put(Colorable.NAMEK, 0xFF0000FF); 
		colors.put(Colorable.NAMEL, 0xFF0000FF); 
		colors.put(Colorable.NAMEM, 0xFF0000FF); 
		colors.put(Colorable.NAMEN, 0xFF0000FF); 
		colors.put(Colorable.NAMEO, 0xFF0000FF); 
		colors.put(Colorable.NAMEP, 0xFF0000FF); 
		colors.put(Colorable.NAMEQ, 0xFF0000FF); 
		colors.put(Colorable.NAMER, 0xFF0000FF); 
		colors.put(Colorable.NAMES, 0xFF0000FF); 
		colors.put(Colorable.NAMET, 0xFF0000FF); 
		
		
		return colors;
	}

	// In ARGB format: 0xAARRGGBB
	private static final int BLACK = 0xFF000000;
	private static final int BLUE = 0xFF0000FF;
	private static final int DARK_RED = 0xFF8B0000;
	private static final int DARK_BLUE = 0xFFD040DD;
	private static final int GREY = 0xFF808080;
	private static final int LIGHT_GREY = 0xFFAAAAAA;
	private static final int MAROON = 0xFF800000;
	private static final int INDIGO = 0xFF2A40FF;
	private static final int OLIVE_GREEN = 0xFF3F7F5F;
	private static final int PURPLE = 0xFFDD4488;
	private static final int RED = 0x44FF0000;
	private static final int WHITE = 0xFFFFFFE0;
	private static final int PURPLE2 = 0xFFFF00FF;
	private static final int LIGHT_BLUE = 0xFF6080FF;
	private static final int LIGHT_BLUE2 = 0xFF40B0FF;
	private static final int GREEN = 0xFF88AA88;
}

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
import java.util.*;

/**
 * Base class for programming language syntax.
 * By default, C-like symbols and operators are included, but not keywords.
 */
public abstract class Language {
    public final static char EOF = '\uFFFF';
    public final static char NULL_CHAR = '\u0000';
    public final static char NEWLINE = '\n';
    public final static char BACKSPACE = '\b';
    public final static char TAB = '\t';
    public final static String GLYPH_NEWLINE = "\u21b5";
    public final static String GLYPH_SPACE = "\u00b7";
    public final static String GLYPH_TAB = "\u00bb";


    private final static char[] BASIC_C_OPERATORS = {
            '(', ')', '{', '}', '.', ',', ';', '=', '+', '-',
            '/', '*', '&', '!', '|', ':', '[', ']', '<', '>',
            '?', '~', '%', '^'
    };

	protected HashMap<String, String[]> _bases = new HashMap<String, String[]>(0);
	//自定义 k,v关键词添加
	protected HashMap<String, String[]> _basesa = new HashMap<String, String[]>(0);
    protected HashMap<String, Integer> _keywords = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _names= new HashMap<String, Integer>(0);
	//自定义关键词
	protected HashMap<String, Integer> _namesa = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesb = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesc = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesd = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namese = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesf = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesg = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesh = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesi = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesj = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesk = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesl = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesm = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesn = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _nameso = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesp = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesq = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namesr = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namess = new HashMap<String, Integer>(0);
    protected HashMap<String, Integer> _namest = new HashMap<String, Integer>(0);
    
	
	
	
    protected HashMap<String, Integer> _users = new HashMap<String, Integer>(0);
    protected HashMap<Character, Integer> _operators = generateOperators(BASIC_C_OPERATORS);

    private ArrayList<String> _ueserCache = new ArrayList<String>();
    private String[] _userWords = new String[0];
    private String[] _keyword;
    private String[] _name;
    //自定义关键词
	private String[] _namea;
	private String[] _nameb;
	private String[] _namec;
	private String[] _named;
	private String[] _namee;
	private String[] _namef;
	private String[] _nameg;
	private String[] _nameh;
	private String[] _namei;
	private String[] _namej;
	private String[] _namek;
	private String[] _namel;
	private String[] _namem;
	private String[] _namen;
	private String[] _nameo;
	private String[] _namep;
	private String[] _nameq;
	private String[] _namer;
	private String[] _namesss;
	private String[] _namet;
	
	
    public void updateUserWord() {
        // TODO: Implement this method
        String[] uw = new String[_ueserCache.size()];
        _userWords = _ueserCache.toArray(uw);
    }

    public String[] getUserWord() {
        return _userWords;
    }

    public String[] getNames() {
        return _name;
    }
	//自定义关键词
	public String[] getNamesa() {
        return _namea;
    }
	public String[] getNamesb() {
        return _nameb;
    }
	public String[] getNamesc() {
        return _namec;
    }
	public String[] getNamesd() {
        return _named;
    }
	public String[] getNamese() {
        return _namee;
    }
	public String[] getNamesf() {
        return _namef;
    }
	public String[] getNamesg() {
        return _nameg;
    }
	public String[] getNamesh() {
        return _nameh;
    }
	public String[] getNamesi() {
        return _namei;
    }
	public String[] getNamesj() {
        return _namej;
    }
	public String[] getNamesk() {
        return _namek;
    }
	public String[] getNamesl() {
        return _namel;
    }
	public String[] getNamesm() {
        return _namem;
    }
	public String[] getNamesn() {
        return _namen;
    }
	public String[] getNameso() {
        return _nameo;
    }
	public String[] getNamesp() {
        return _namep;
    }
	public String[] getNamesq() {
        return _nameq;
    }
	public String[] getNamesr() {
        return _namer;
    }
   public String[] getNamess() {
        return _namesss;
    }
	public String[] getNamest() {
        return _namet;
    }
	
	
    public String[] getBasePackage(String name) {
        return _bases.get(name);
    }
	//自定义k,v关键词添加
	public String[] getBasePackagea(String name) {
        return _basesa.get(name);
    }
	
	

    public String[] getKeywords() {
        return _keyword;
    }

    public void setKeywords(String[] keywords) {
        _keyword = keywords;
        _keywords = new HashMap<String, Integer>(keywords.length);
        for (int i = 0; i < keywords.length; ++i) {
            _keywords.put(keywords[i], Lexer.KEYWORD);
        }
    }

    public void setNames(String[] names) {
        _name = names;
        ArrayList<String> buf = new ArrayList<String>();
        _names = new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _names.put(names[i], Lexer.NAME);
        }
        _name = new String[buf.size()];
        buf.toArray(_name);
    }
	//自定义关键词
	
	public void setNamesa(String[] names) {
        _namea = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesa = new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesa.put(names[i], Lexer.NAMEA);
        }
        _namea = new String[buf.size()];
        buf.toArray(_namea);
    }
	
	
	public void setNamesb(String[] names) {
        _nameb = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesb = new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesb.put(names[i], Lexer.NAMEB);
        }
        _nameb= new String[buf.size()];
        buf.toArray(_nameb);
    }
	public void setNamesc(String[] names) {
        _namec = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesc = new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesc.put(names[i], Lexer.NAMEC);
        }
        _namec = new String[buf.size()];
        buf.toArray(_namec);
    }
	public void setNamesd(String[] names) {
        _named = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesd = new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesd.put(names[i], Lexer.NAMED);
        }
        _named = new String[buf.size()];
        buf.toArray(_named);
    }
	public void setNamese(String[] names) {
        _namee = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namese= new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namese.put(names[i], Lexer.NAMEE);
        }
        _namee = new String[buf.size()];
        buf.toArray(_namee);
    }
	public void setNamesf(String[] names) {
        _namef = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesf = new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesf.put(names[i], Lexer.NAMEF);
        }
        _namef= new String[buf.size()];
        buf.toArray(_namef);
    }
	public void setNamesg(String[] names) {
        _nameg = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesg= new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesg.put(names[i], Lexer.NAMEG);
        }
        _nameg= new String[buf.size()];
        buf.toArray(_nameg);
    }
	public void setNamesh(String[] names) {
        _nameh = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesh = new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesh.put(names[i], Lexer.NAMEH);
        }
        _nameh = new String[buf.size()];
        buf.toArray(_nameh);
    }
	public void setNamesi(String[] names) {
        _namei = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesi= new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesi.put(names[i], Lexer.NAMEI);
        }
        _namei = new String[buf.size()];
        buf.toArray(_namei);
    }
	public void setNamesj(String[] names) {
        _namej = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesj = new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesj.put(names[i], Lexer.NAMEJ);
        }
        _namej = new String[buf.size()];
        buf.toArray(_namej);
    }
	public void setNamesk(String[] names) {
        _namek = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesk= new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesk.put(names[i], Lexer.NAMEK);
        }
        _namek = new String[buf.size()];
        buf.toArray(_namek);
    }
	public void setNamesl(String[] names) {
        _namel = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesl = new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesl.put(names[i], Lexer.NAMEL);
        }
        _namel = new String[buf.size()];
        buf.toArray(_namel);
    }
	public void setNamesm(String[] names) {
        _namem = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesm= new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesm.put(names[i], Lexer.NAMEM);
        }
        _namem = new String[buf.size()];
        buf.toArray(_namem);
    }
	public void setNamesn(String[] names) {
        _namen = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesn = new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesn.put(names[i], Lexer.NAMEN);
        }
        _namen = new String[buf.size()];
        buf.toArray(_namen);
    }
	public void setNameso(String[] names) {
        _nameo = names;
        ArrayList<String> buf = new ArrayList<String>();
        _nameso= new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _nameso.put(names[i], Lexer.NAMEO);
        }
        _nameo= new String[buf.size()];
        buf.toArray(_nameo);
    }
	public void setNamesp(String[] names) {
        _namep = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesp = new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesp.put(names[i], Lexer.NAMEP);
        }
        _namep = new String[buf.size()];
        buf.toArray(_namep);
    }
	public void setNamesq(String[] names) {
        _nameq = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesq= new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesq.put(names[i], Lexer.NAMEQ);
        }
        _nameq = new String[buf.size()];
        buf.toArray(_nameq);
    }
	public void setNamesr(String[] names) {
        _namer = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namesr = new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namesr.put(names[i], Lexer.NAMER);
        }
        _namer = new String[buf.size()];
        buf.toArray(_namer);
    }
	public void setNamess(String[] names) {
        _namesss = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namess = new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namess.put(names[i], Lexer.NAMES);
        }
        _namesss= new String[buf.size()];
        buf.toArray(_namesss);
    }
	
	public void setNamest(String[] names) {
        _namet = names;
        ArrayList<String> buf = new ArrayList<String>();
        _namest = new HashMap<String, Integer>(names.length);
        for (int i = 0; i < names.length; ++i) {
            if (!buf.contains(names[i]))
                buf.add(names[i]);
            _namest.put(names[i], Lexer.NAMET);
        }
        _namet= new String[buf.size()];
        buf.toArray(_namet);
    }
	

    public void addBasePackage(String name, String[] names) {
        _bases.put(name, names);
    }
	//自定义k,v关键词添加
	public void addBasePackagea(String name, String[] names) {
        _basesa.put(name, names);
    }

    public void removeBasePackage(String name) {
        _bases.remove(name);
    }

    public void clearUserWord() {
        _ueserCache.clear();
        _users.clear();
    }

    public void addUserWord(String name) {
        if (!_ueserCache.contains(name) && !_names.containsKey(name))
            _ueserCache.add(name);
        _users.put(name, Lexer.NAME);
    }

    protected void setOperators(char[] operators) {
        _operators = generateOperators(operators);
    }

    private HashMap<Character, Integer> generateOperators(char[] operators) {
        HashMap<Character, Integer> operatorsMap = new HashMap<Character, Integer>(operators.length);
        for (int i = 0; i < operators.length; ++i) {
            operatorsMap.put(operators[i], Lexer.OPERATOR);
        }
        return operatorsMap;
    }

    public final boolean isOperator(char c) {
        return _operators.containsKey(Character.valueOf(c));
    }

    public final boolean isKeyword(String s) {
        return _keywords.containsKey(s);
    }

    public final boolean isName(String s) {
        return _names.containsKey(s);
    }
    //自定义关键词
	public final boolean isNamea(String s) {
        return _namesa.containsKey(s);
    }
	public final boolean isNameb(String s) {
        return _namesb.containsKey(s);
    }
	public final boolean isNamec(String s) {
        return _namesc.containsKey(s);
    }
	public final boolean isNamed(String s) {
        return _namesd.containsKey(s);
    }
	public final boolean isNamee(String s) {
        return _namese.containsKey(s);
    }
	public final boolean isNamef(String s) {
        return _namesf.containsKey(s);
    }
	public final boolean isNameg(String s) {
        return _namesg.containsKey(s);
    }
	public final boolean isNameh(String s) {
        return _namesh.containsKey(s);
    }
	public final boolean isNamei(String s) {
        return _namesi.containsKey(s);
    }
	public final boolean isNamej(String s) {
        return _namesj.containsKey(s);
    }
	public final boolean isNamek(String s) {
        return _namesk.containsKey(s);
    }
	public final boolean isNamel(String s) {
        return _namesl.containsKey(s);
    }
	public final boolean isNamem(String s) {
        return _namesm.containsKey(s);
    }
	public final boolean isNamen(String s) {
        return _namesn.containsKey(s);
    }
	public final boolean isNameo(String s) {
        return _nameso.containsKey(s);
    }
	public final boolean isNamep(String s) {
        return _namesp.containsKey(s);
    }
	public final boolean isNameq(String s) {
        return _namesq.containsKey(s);
    }
	public final boolean isNamer(String s) {
        return _namesr.containsKey(s);
    }
	public final boolean isNames(String s) {
        return _namess.containsKey(s);
    }
	public final boolean isNamet(String s) {
        return _namest.containsKey(s);
    }
	
	
    public final boolean isBasePackage(String s) {
        return _bases.containsKey(s);
    }
	
    public final boolean isBaseWord(String p, String s) {
        String[] pkg = _bases.get(p);
        for (String n : pkg) {
            if (n.equals(s))
                return true;
        }
        return false;
    }
	//自定义k,v关键词
	public final boolean isBasePackagea(String s) {
        return _basesa.containsKey(s);
    }
	public final boolean isBaseWorda(String p, String s) {
        String[] pkg = _basesa.get(p);
        for (String n : pkg) {
            if (n.equals(s))
                return true;
        }
        return false;
    }

    public final boolean isUserWord(String s) {
        return _users.containsKey(s);
    }

    private boolean contains(String[] a, String s) {
        for (String n : a) {
            if (n.equals(s))
                return true;
        }
        return false;
    }

    private boolean contains(ArrayList<String> a, String s) {
        for (String n : a) {
            if (n.equals(s))
                return true;
        }
        return false;
    }

    public boolean isWhitespace(char c) {
        return (c == ' ' || c == '\n' || c == '\t' ||
                c == '\r' || c == '\f' || c == EOF);
    }

    public boolean isSentenceTerminator(char c) {
        return (c == '.');
    }

    public boolean isEscapeChar(char c) {
        return (c == '\\');
    }

    /**
     * Derived classes that do not do represent C-like programming languages
     * should return false; otherwise return true
     */
    public boolean isProgLang() {
        return true;
    }

    /**
     * Whether the word after c is a token
     */
    public boolean isWordStart(char c) {
        return false;
    }

    /**
     * Whether cSc is a token, where S is a sequence of characters that are on the same line
     */
    public boolean isDelimiterA(char c) {
        return (c == '"');
    }

    /**
     * Same concept as isDelimiterA(char), but Language and its subclasses can
     * specify a second type of symbol to use here
     */
    public boolean isDelimiterB(char c) {
        return (c == '\'');
    }

    /**
     * Whether cL is a token, where L is a sequence of characters until the end of the line
     */
    public boolean isLineAStart(char c) {
        return (c == '#');
    }

    /**
     * Same concept as isLineAStart(char), but Language and its subclasses can
     * specify a second type of symbol to use here
     */
    public boolean isLineBStart(char c) {
        return false;
    }

    /**
     * Whether c0c1L is a token, where L is a sequence of characters until the end of the line
     */
    public boolean isLineStart(char c0, char c1) {
        return (c0 == '/' && c1 == '/');
    }

    /**
     * Whether c0c1 signifies the start of a multi-line token
     */
    public boolean isMultilineStartDelimiter(char c0, char c1) {
        return (c0 == '/' && c1 == '*');
    }

    /**
     * Whether c0c1 signifies the end of a multi-line token
     */
    public boolean isMultilineEndDelimiter(char c0, char c1) {
        return (c0 == '*' && c1 == '/');
    }
}

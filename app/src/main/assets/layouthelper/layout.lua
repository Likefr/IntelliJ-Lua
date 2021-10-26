layout={
  main={
    LinearLayout,
    orientation="vertical",
    backgroundColor=background;
  },

  dlg={
    LinearLayout,
    orientation="vertical",
    backgroundColor=background;
    {TextView,
      id="label",
    },
    {EditText,
      id="fld",
      layout_width="fill",
    },
    {Button,
      text="确定",
      onClick="ok",
    },
  },

  ck={
    LinearLayout;
    backgroundColor=background;
    {
      RadioGroup;
      layout_weight="1";
      id="ck_rg";
    };
    {
      Button;
      Text="确定";
      id="ck_bt";
    };
    orientation="vertical";
  };
}
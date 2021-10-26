require "import"
import "IntelliJ"
import "LayBox"

local layout={
  LinearLayout;
  layout_width="-1";
  layout_height="-1";
  orientation="vertical";
      backgroundColor=background;
  {
    LinearLayout;
    layout_width="-1";
    layout_height="-2";
    elevation="0";
    backgroundColor=background;
    orientation="vertical";
    {
      LinearLayout;
      layout_width="-1";
      layout_height="56dp";
      gravity="center|left";
      id="mActionBar";
    backgroundColor=background;
      {
        LinearLayout;
        orientation="horizontal";
        layout_height="56dp";
        layout_width="56dp";
        gravity="center";
    backgroundColor=background;
        {
          ImageView;
          ColorFilter=wbColor;
          src="res/left.png";
          layout_height="32dp";
          layout_width="32dp";
          padding="4dp";
          id="fh";
          onClick=function()this.finish()end;
        };
      };
      {
        TextView;
        textColor=wbColor;
        text="渐变颜色参考";
        paddingLeft="16dp";
        textSize="20dp";
        layout_height="-2";
        layout_width="-2";
        Typeface=字体("product-Bold");
      };
    };
  };
  {
    GridView;
    id="lv";
    layout_width="-1";
    layout_height="-1";
  };
};
activity.setContentView(loadlayout(layout))



mml={
  LinearLayout;
  layout_width="-1";
  layout_height="-1";
  {
    CardView;
    CardElevation="0dp";
    CardBackgroundColor=background;
    Radius="8dp";
    layout_width="-1";
    layout_height="-2";
    layout_margin="16dp";
    layout_marginTop="8dp";
    layout_marginBottom="8dp";
    {
      LinearLayout;
      layout_width="-1";
      layout_height="72dp";
      gravity="left|center";
      id="ym";
      {
        TextView;
        layout_width="-1";
        layout_height="-1";
        textColor="#ff212121";
        textSize="16dp";
        padding="16dp";
        layout_weight="1";
        gravity="left|center";
        id="dml";
        Typeface=字体("product-Bold");
      };
      {
        TextView;
        layout_width="-1";
        layout_height="-1";
        textColor="#ff212121";
        textSize="16dp";
        padding="16dp";
        layout_weight="1";
        gravity="right|center";
        id="dmr";
        Typeface=字体("product-Bold");
      };
    };
  };
};
adp=LuaAdapter(activity,mml)
function Add_Color(l,r)
  local ln=l:match("0xFF(.+)")
  local lj='#'..ln
  local rn=r:match("0xFF(.+)")
  local rj='#'..rn
  adp.add{
    dml={text=lj},
    ym={BackgroundDrawable=GradientDrawable(GradientDrawable.Orientation.LEFT_RIGHT,{l,r})},
    dmr={text=rj}
  }
end

Add_Color("0xFFFDEB71","0xFFF8D800")
Add_Color("0xFFABDCFF","0xFF0396FF")
Add_Color("0xFFFEB692","0xFFEA5455")
Add_Color("0xFFCE9FFC","0xFF7367F0")
Add_Color("0xFF90F7EC","0xFF32CCBC")
Add_Color("0xFFFFF6B7","0xFFF6416C")
Add_Color("0xFF81FBB8","0xFF28C76F")
Add_Color("0xFFE2B0FF","0xFF9F44D3")
Add_Color("0xFFF97794","0xFF623AA2")
Add_Color("0xFFFCCF31","0xFFF55555")
Add_Color("0xFFF761A1","0xFF8C1BAB")
Add_Color("0xFF43CBFF","0xFF9708CC")
Add_Color("0xFF5EFCE8","0xFF736EFE")
Add_Color("0xFFFAD7A1","0xFFE96D71")
Add_Color("0xFFFFD26F","0xFF3677FF")
Add_Color("0xFF83A4D4","0xFFB6FBFF")
Add_Color("0xFFFF5E75","0xFFFF42EB")
Add_Color("0xFFFF96F9","0xFFC32BAC")
Add_Color("0xFFA050F1","0xFF8F3196")
Add_Color("0xFFEFB884","0xFFBE944D")
Add_Color("0xFF7CE084","0xFF50BF1C")
Add_Color("0xFF43CBFF","0xFF3C8CE7")
Add_Color("0xFF5F87FF","0xFF122EF1")
Add_Color("0xFF42A5F5","0xFF00C853")
Add_Color("0xFFFF6B66","0xFFF0703E")
Add_Color("0xFFCB7575","0xFFA3C9C7")
Add_Color("0xFF5CAB7D","0xFFF68657")
Add_Color("0xFFC65146","0xFF84B1ED")
Add_Color("0xFF6A60A9","0xFFFC913A")
Add_Color("0xFF1E8AE8","0xFF0075D5")
Add_Color("0xFFFB7299","0xFFF670DA")
Add_Color("0xFF3F51B3","0xFFE81C61")
Add_Color("0xFF7986CB","0xFF5EFFAE")
Add_Color("0xFF363C4A","0xFF1F8792")
Add_Color("0xFF087EA2","0xFF08BBE4")
Add_Color("0xFF544E74","0xFFE68967")
Add_Color("0xFF155F82","0xFFA5700A")

lv.Adapter=adp
lv.onItemClick=function(l,v,p,i)
  local lm=v.Tag.dml.Text
  local rm=v.Tag.dmr.Text
  --Snakebar("已复制颜色 "..lm..","..rm)
  复制文本(lm..","..rm)
  print(lm..","..rm)
end

listalpha=AlphaAnimation(0,1)
listalpha.setDuration(256)
controller=LayoutAnimationController(listalpha)
controller.setDelay(0.4)
controller.setOrder(LayoutAnimationController.ORDER_NORMAL)
lv.setLayoutAnimation(controller)

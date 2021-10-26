require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "com.sdsmdg.tastytoast.*"
import "android.view.*"
import "android.widget.Toast"
toasts={
 erro= {
  CardView,
  radius="8dp";
  layout_width="match_parent",
  layout_height="wrap_content",
  {
   LinearLayout,
   layout_width="wrap_content",
   layout_height="wrap_content",
   background="#ffd9524d",
   orientation="horizontal",
   {
    LinearLayout,
    layout_width="55dp",
    layout_height="fill",
    gravity="center",
    background="#ffffff",
    layout_gravity="center",
    {
     ErrorToastView,
     id="q",
     layout_width="50dp",
     layout_height="50dp",
    },
   },
   {
    TextView,
    id="toastMessage",
    layout_width="match_parent",
    layout_height="wrap_content",
    textColor="#ffffff";
    gravity="center_vertical",
    padding="10dp",
   },
  },
 },

 defaul={
  CardView,
  radius="8dp";
  layout_width="match_parent",
  layout_height="wrap_content",
  {
   LinearLayout,
   layout_width="wrap_content",
   layout_height="wrap_content",
   background="#444344",
   orientation="horizontal",
   {
    LinearLayout,
    layout_width="55dp",
    layout_height="fill",
    gravity="center",
    background="#ffffff",
    layout_gravity="center",
    {
     DefaultToastView,
     id="q",
     layout_width="50dp",
     layout_height="50dp",
    },
   },
   {
    TextView,
    id="toastMessage",
    layout_width="match_parent",
    layout_height="wrap_content",
    textColor="#ffffff";
    gravity="center_vertical",
    padding="10dp",
   },
  },
 },

 info=
 {
  CardView,
  radius="8dp";
  layout_width="match_parent",
  layout_height="wrap_content",
  {
   LinearLayout,
   layout_width="wrap_content",
   layout_height="wrap_content",
   background="#3378b5",
   orientation="horizontal",
   {
    LinearLayout,
    layout_width="55dp",
    layout_height="fill",
    gravity="center",
    background="#ffffff",
    layout_gravity="center",
    {
     InfoToastView,
     id="q",
     layout_width="50dp",
     layout_height="50dp",
    },
   },
   {
    TextView,
    id="toastMessage",
    layout_width="match_parent",
    layout_height="wrap_content",
    textColor="#ffffff";
    gravity="center_vertical",
    padding="10dp",
   },
  },
 },
 success={
  CardView,
  radius="8dp";
  layout_width="match_parent",
  layout_height="wrap_content",
  {
   LinearLayout,
   layout_width="wrap_content",
   layout_height="wrap_content",
   background="#56b65a",
   orientation="horizontal",
   {
    LinearLayout,
    layout_width="55dp",
    layout_height="fill",
    gravity="center",
    background="#ffffff",
    layout_gravity="center",
    {
     SuccessToastView,
     id="q",
     layout_width="50dp",
     layout_height="50dp",
    },
   },
   {
    TextView,
    id="toastMessage",
    layout_width="match_parent",
    layout_height="wrap_content",
    textColor="#ffffff";
    gravity="center_vertical",
    padding="10dp",
   },
  },
 },

 warning={
  CardView,
  radius="8dp";
  layout_width="match_parent",
  layout_height="wrap_content",
  {
   LinearLayout,
   layout_width="wrap_content",
   layout_height="wrap_content",
   background="#efac4e",
   orientation="horizontal",
   {
    LinearLayout,
    layout_width="55dp",
    layout_height="fill",
    gravity="center",
    background="#ffffff",
    layout_gravity="center",
    {
     WarningToastView,
     id="q",
     layout_width="50dp",
     layout_height="50dp",
    },
   },
   {
    TextView,
    id="toastMessage",
    layout_width="match_parent",
    layout_height="wrap_content",
    textColor="#ffffff";
    gravity="center_vertical",
    padding="10dp",
   },
  },
 },
 confusing={
  CardView,
  radius="8dp";
  layout_width="match_parent",
  layout_height="wrap_content",
  {
   LinearLayout,
   layout_width="wrap_content",
   layout_height="wrap_content",
   background="#fb9b4d",
   orientation="horizontal",
   {
    LinearLayout,
    layout_width="55dp",
    layout_height="fill",
    gravity="center",
    background="#ffffff",
    layout_gravity="center",
    {
     ConfusingToastView,
     id="q",
     layout_width="50dp",
     layout_height="50dp",
    },
   },
   {
    TextView,
    id="toastMessage",
    layout_width="match_parent",
    layout_height="wrap_content",
    textColor="#ffffff";
    gravity="center_vertical",
    padding="10dp",
   },
  },
 },
}




--设置文字
--toastMessage.Text="没封装"

err=toasts.erro
success=toasts.success
info=toasts.info
defaul=toasts.defaul
warning=toasts.warning
confusing=toasts.confusing


function print(content,model)
 if model ==nil or model=="" then
  model=defaul
 end
 if content ==nil or content=="" then
  content="弹出消息"
 end
 if model==warning then

  TastyToast.makeText(this, content, TastyToast.LENGTH_LONG, TastyToast.WARNING);
  else

  toast=Toast.makeText(activity,"",Toast.LENGTH_SHORT)
  .setView(loadlayout(model))
  .show()

  toastMessage.Text=content
  q.startAnim()
 end

end




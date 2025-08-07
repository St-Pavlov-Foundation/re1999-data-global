module("modules.logic.signin.view.SignInView", package.seeall)

local var_0_0 = class("SignInView", BaseView)
local var_0_1 = SLFramework.AnimatorPlayer

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._imageweek = gohelper.findChildImage(arg_1_0.viewGO, "bg/#image_week")
	arg_1_0._goroleitem = gohelper.findChild(arg_1_0.viewGO, "bg/#go_roleitem")
	arg_1_0._simagetopicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#go_roleitem/#simage_topicon")
	arg_1_0._goicontip = gohelper.findChild(arg_1_0.viewGO, "bg/#go_roleitem/#go_icontip")
	arg_1_0._txtbirtime = gohelper.findChildText(arg_1_0.viewGO, "bg/#go_roleitem/#txt_birtime")
	arg_1_0._txtlimit = gohelper.findChildText(arg_1_0.viewGO, "bg/#go_roleitem/#txt_limit")
	arg_1_0._goget = gohelper.findChild(arg_1_0.viewGO, "rightContent/#go_get")
	arg_1_0._gonoget = gohelper.findChild(arg_1_0.viewGO, "rightContent/#go_noget")
	arg_1_0._gomonthdetail = gohelper.findChild(arg_1_0.viewGO, "rightContent/monthdetail")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "scroll_desc/Viewport/Content/#txt_desc")
	arg_1_0._txtday = gohelper.findChildText(arg_1_0.viewGO, "leftContent/#txt_day")
	arg_1_0._txtdayfestival = gohelper.findChildText(arg_1_0.viewGO, "leftContent/#txt_day_festival")
	arg_1_0._txtmonth = gohelper.findChildText(arg_1_0.viewGO, "leftContent/#txt_month")
	arg_1_0._txtdate = gohelper.findChildText(arg_1_0.viewGO, "leftContent/#txt_date")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "leftBottomContent/#go_rewarditem")
	arg_1_0._simageorangebg = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#simage_orangebg")
	arg_1_0._godayrewarditem = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem")
	arg_1_0._gorewardbg = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#simage_rewardbg")
	arg_1_0._simagerewardbg = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#go_dayrewarditem/#simage_rewardbg")
	arg_1_0._gototalreward = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward")
	arg_1_0._txtdaycount = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/monthtitle/#txt_daycount")
	arg_1_0._txtmonthtitle = gohelper.findChildText(arg_1_0.viewGO, "leftBottomContent/#go_rewarditem/#go_dayrewarditem/#go_totalreward/monthtitle")
	arg_1_0._gomonth1 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1")
	arg_1_0._monthreward1Click = gohelper.getClick(arg_1_0._gomonth1)
	arg_1_0._gomonthmask1 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1")
	arg_1_0._month1canvasGroup = arg_1_0._gomonthmask1:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._gorewardmark1 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#go_rewardmark1")
	arg_1_0._txtmonthquantity1 = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#txt_monthquantity1")
	arg_1_0._txtrewardcount1 = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#txt_count1")
	arg_1_0._gomonthtip1 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthtip1")
	arg_1_0._gomonthget1 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthget1")
	arg_1_0._gomonthgetlightanim1 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthget1/vxeffect")
	arg_1_0._gonomonthget1 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_nomonthget1")
	arg_1_0._gogetmonthbg1 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#go_getbg1")
	arg_1_0._simagemonthicon1 = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#simage_monthicon1")
	arg_1_0._month1Ani = arg_1_0._simagemonthicon1.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gomonth2 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2")
	arg_1_0._monthreward2Click = gohelper.getClick(arg_1_0._gomonth2)
	arg_1_0._gomonthmask2 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2")
	arg_1_0._month2canvasGroup = arg_1_0._gomonthmask2:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._gorewardmark2 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#go_rewardmark2")
	arg_1_0._txtmonthquantity2 = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#txt_monthquantity2")
	arg_1_0._txtrewardcount2 = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#txt_count2")
	arg_1_0._gomonthtip2 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthtip2")
	arg_1_0._gomonthget2 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthget2")
	arg_1_0._gomonthgetlightanim2 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthget2/vxeffect")
	arg_1_0._gonomonthget2 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_nomonthget2")
	arg_1_0._gogetmonthbg2 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#go_getbg2")
	arg_1_0._simagemonthicon2 = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#simage_monthicon2")
	arg_1_0._month2Ani = arg_1_0._simagemonthicon2.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gomonth3 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3")
	arg_1_0._monthreward3Click = gohelper.getClick(arg_1_0._gomonth3)
	arg_1_0._gomonthmask3 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3")
	arg_1_0._month3canvasGroup = arg_1_0._gomonthmask3:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._gorewardmark3 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#go_rewardmark3")
	arg_1_0._txtmonthquantity3 = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#txt_monthquantity3")
	arg_1_0._txtrewardcount3 = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#txt_count3")
	arg_1_0._gomonthtip3 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthtip3")
	arg_1_0._gomonthget3 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthget3")
	arg_1_0._gomonthgetlightanim3 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthget3/vxeffect")
	arg_1_0._gonomonthget3 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_nomonthget3")
	arg_1_0._gogetmonthbg3 = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#go_getbg3")
	arg_1_0._simagemonthicon3 = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#simage_monthicon3")
	arg_1_0._month3Ani = arg_1_0._simagemonthicon3.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gocurrentreward = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal")
	arg_1_0._gonormaldayreward = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/")
	arg_1_0._gonormalday = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday")
	arg_1_0._normaldayClick = gohelper.getClick(arg_1_0._gonormalday)
	arg_1_0._gonormalday_gold = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday")
	arg_1_0._normaldayClick_gold = gohelper.getClick(arg_1_0._gonormalday_gold)
	arg_1_0._simagenormaldayrewardicon = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#simage_normaldayrewardicon")
	arg_1_0._txtnormaldayrewardcount = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#simage_normaldayrewardicon/#txt_normaldayrewardcount")
	arg_1_0._txtnormaldayrewardname = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#txt_normaldayrewardname")
	arg_1_0._gonormaldaysigned = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned")
	arg_1_0._gonormaldayget = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned/#go_normaldayget")
	arg_1_0._gonormaldaynoget = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned/#go_normaldaynoget")
	arg_1_0._normaldayrewardAni = arg_1_0._simagenormaldayrewardicon.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gonormaldayreward_gold = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2")
	arg_1_0._simagenormaldayrewardicon_gold = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#simage_normaldayrewardicon")
	arg_1_0._txtnormaldayrewardcount_gold = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#simage_normaldayrewardicon/#txt_normaldayrewardcount")
	arg_1_0._txtnormaldayrewardname_gold = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#txt_normaldayrewardname")
	arg_1_0._gonormaldaysigned_gold = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned")
	arg_1_0._gonormaldayget_gold = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned/#go_normaldayget")
	arg_1_0._gonormaldaynoget_gold = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned/#go_normaldaynoget")
	arg_1_0._normaldayrewardAni_gold = arg_1_0._simagenormaldayrewardicon_gold.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gomonthcard = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard")
	arg_1_0._gomonthcarddayreward = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward")
	arg_1_0._gomonthcardday = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday")
	arg_1_0._monthcarddayClick = gohelper.getClick(arg_1_0._gomonthcardday)
	arg_1_0._gomonthcardday_gold = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday")
	arg_1_0._monthcarddayClick_gold = gohelper.getClick(arg_1_0._gomonthcardday_gold)
	arg_1_0._txtmonthcarddayrewardname = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#txt_monthcarddayrewardname")
	arg_1_0._simagemonthcarddayrewardicon = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#simage_monthcarddayrewardicon")
	arg_1_0._txtmonthcarddayrewardcount = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#simage_monthcarddayrewardicon/#txt_monthcarddayrewardcount")
	arg_1_0._gomonthcarddaysigned = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned")
	arg_1_0._gomonthcarddayget = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned/#go_monthcarddayget")
	arg_1_0._gomonthcarddaynoget = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned/#go_nomonthcarddayget")
	arg_1_0._gomonthcarddayreward_gold = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2")
	arg_1_0._txtmonthcarddayrewardname_gold = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#txt_monthcarddayrewardname")
	arg_1_0._simagemonthcarddayrewardicon_gold = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#simage_monthcarddayrewardicon")
	arg_1_0._txtmonthcarddayrewardcount_gold = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#simage_monthcarddayrewardicon/#txt_monthcarddayrewardcount")
	arg_1_0._gomonthcarddaysigned_gold = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned")
	arg_1_0._gomonthcarddayget_gold = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned/#go_monthcarddayget")
	arg_1_0._gomonthcarddaynoget_gold = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned/#go_nomonthcarddayget")
	arg_1_0._gomonthcardreward = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward")
	arg_1_0._gomonthcardrewarditem = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem")
	arg_1_0._txtmonthcardname = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#txt_monthcardname")
	arg_1_0._simagemonthcardicon = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#simage_monthcardicon")
	arg_1_0._monthcardClick = gohelper.getClick(arg_1_0._gomonthcardrewarditem.gameObject)
	arg_1_0._gomonthcardpowerrewarditem = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem")
	arg_1_0._txtmonthcardcount = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#simage_monthcardicon/#txt_monthcardcount")
	arg_1_0._txtmonthcardpowername = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#txt_monthcardname")
	arg_1_0._simagemonthcardpowericon = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#simage_monthcardicon")
	arg_1_0._monthcardpowerClick = gohelper.getClick(arg_1_0._gomonthcardpowerrewarditem.gameObject)
	arg_1_0._txtmonthcardpowercount = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#simage_monthcardicon/#txt_monthcardcount")
	arg_1_0._gopowerlimittime = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_powerlimittime")
	arg_1_0._golimittime = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/#txt_limittime")
	arg_1_0._gonormallimittimebg = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/normalbg")
	arg_1_0._goredlimittimebg = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/redbg")
	arg_1_0._gomonthcardsigned = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned")
	arg_1_0._gomonthcardget = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardget")
	arg_1_0._gomonthcardnoget = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardnoget")
	arg_1_0._gomonthcardpowernoget = gohelper.findChild(arg_1_0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardpowernoget")
	arg_1_0._gobirthdayrewarditem = gohelper.findChild(arg_1_0._gorewarditem, "#go_birthdayrewarditem")
	arg_1_0._simagebirthdaybg = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#simage_birthdaybg")
	arg_1_0._simagebirthdaybg2 = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#simage_birthdaybg2")
	arg_1_0._gobirthday = gohelper.findChild(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday")
	arg_1_0._simagebirthdayIcon = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#simage_icon")
	arg_1_0._btngift = gohelper.findChildButtonWithAudio(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#btn_gift")
	arg_1_0._gogiftget = gohelper.findChild(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_get")
	arg_1_0._gogiftnoget = gohelper.findChild(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_noget")
	arg_1_0._gogiftreddot = gohelper.findChild(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_reddot")
	arg_1_0._gobirthdayrewarddetail = gohelper.findChild(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail")
	arg_1_0._gocontentSize = gohelper.findChild(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize")
	arg_1_0._trstitle = gohelper.findChild(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/bg/title").transform
	arg_1_0._txtrewarddetailtitle = gohelper.findChildText(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/title/#txt_rewarddetailtitle")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/Viewport/Content")
	arg_1_0._goclickarea = gohelper.findChild(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/Viewport/Content/#go_rewardContent/#go_clickarea")
	arg_1_0._gorewarddetailitem = gohelper.findChild(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/#go_rewarddetailItem")
	arg_1_0._txtdeco = gohelper.findChildText(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/ScrollView/Viewport/#txt_deco")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#simage_signature")
	arg_1_0._btnqiehuan = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "leftBottomContent/#btn_qiehuan")
	arg_1_0._goqiehuan = gohelper.findChild(arg_1_0.viewGO, "leftBottomContent/#btn_qiehuan/#qiehuan")

	local var_1_0 = GMController.instance:getGMNode("signinview", gohelper.findChild(arg_1_0.viewGO, "leftContent"))

	if var_1_0 then
		arg_1_0._gogmhelp = gohelper.findChild(var_1_0, "#go_gmhelp")
		arg_1_0._inputheros = gohelper.findChildTextMeshInputField(var_1_0, "#go_gmhelp/#input_heros")
		arg_1_0._droptimes = gohelper.findChildDropdown(var_1_0, "#go_gmhelp/#drop_times")
		arg_1_0._gochangedate = gohelper.findChild(var_1_0, "#go_changedate")
		arg_1_0._inputdate = gohelper.findChildTextMeshInputField(var_1_0, "#go_changedate/#input_date")
		arg_1_0._btnchangedateright = gohelper.findChildButtonWithAudio(var_1_0, "#go_changedate/#btn_changedateright")
		arg_1_0._btnchangedateleft = gohelper.findChildButtonWithAudio(var_1_0, "#go_changedate/#btn_changedateleft")
		arg_1_0._btnswitchdecorate = gohelper.findChildButtonWithAudio(var_1_0, "#go_gmhelp/#_btns_switchdecorate")
	end

	arg_1_0._gomonth = gohelper.findChild(arg_1_0.viewGO, "#go_month")
	arg_1_0._scrollmonth = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_month/#scroll_month")
	arg_1_0._gomonthlayout = gohelper.findChild(arg_1_0.viewGO, "#go_month/#scroll_month/#go_monthlayout")
	arg_1_0._gomonthitem = gohelper.findChild(arg_1_0.viewGO, "#go_month/#scroll_month/#go_monthlayout/#go_monthitem")
	arg_1_0._gosigninmonthitem = gohelper.findChild(arg_1_0.viewGO, "#go_month/#scroll_month/#go_monthlayout/#go_monthitem/#go_signinmonthitem")
	arg_1_0._gomonthleftline = gohelper.findChild(arg_1_0.viewGO, "#go_month/leftline")
	arg_1_0._gomonthrightline = gohelper.findChild(arg_1_0.viewGO, "#go_month/rightline")
	arg_1_0._gomonthanim = gohelper.findChild(arg_1_0.viewGO, "#go_month"):GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_switch")
	arg_1_0._imageswitchicon = gohelper.findChildImage(arg_1_0.viewGO, "#btn_switch/#image_switchicon")
	arg_1_0._gonodes = gohelper.findChild(arg_1_0.viewGO, "#go_nodes")
	arg_1_0._gonodeitem = gohelper.findChild(arg_1_0.viewGO, "#go_nodes/node")
	arg_1_0._btnrewarddetailclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_rewarddetailclose")
	arg_1_0._viewAnimPlayer = var_0_1.Get(arg_1_0.viewGO)
	arg_1_0._viewAniEventWrap = arg_1_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_1_0._gofestivaldecorationright = gohelper.findChild(arg_1_0.viewGO, "bg/#go_festivaldecorationright")
	arg_1_0._gofestivaldecorationleft = gohelper.findChild(arg_1_0.viewGO, "#go_festivaldecorationleft")
	arg_1_0._gofestivaldecorationtop = gohelper.findChild(arg_1_0.viewGO, "bg/#simage_bg/#go_festivaldecorationtop")
	arg_1_0._godayrewarditem_festivaldecorationtop = gohelper.findChild(arg_1_0._godayrewarditem, "#go_festivaldecorationtop")
	arg_1_0._godayrewarditem_gofestivaldecorationleft2 = gohelper.findChild(arg_1_0._godayrewarditem, "#go_festivaldecorationleft2")
	arg_1_0._gorewardicon = gohelper.findChild(arg_1_0.viewGO, "bg/#go_rewardicon")
	arg_1_0._imgbias = gohelper.findChildImage(arg_1_0.viewGO, "leftContent/#image_bias")
	arg_1_0._goeffect = gohelper.findChild(arg_1_0.viewGO, "#go_effect")
	arg_1_0._goLifeCircle = gohelper.findChild(arg_1_0.viewGO, "#go_LifeCircle")
	arg_1_0._gobtnchange = gohelper.findChild(arg_1_0.viewGO, "#go_btnchange")
	arg_1_0._btnchange = gohelper.findChildButtonWithAudio(arg_1_0._gobtnchange, "#btn_change")
	arg_1_0._btnchange2 = gohelper.findChildButtonWithAudio(arg_1_0._gobtnchange, "#btn_change2")
	arg_1_0._gochange = gohelper.findChild(arg_1_0._gobtnchange, "#go_change")
	arg_1_0._gobtnchange_gofestivaldecoration = gohelper.findChild(arg_1_0._gobtnchange, "#go_festivaldecoration")
	arg_1_0._goLifeCircleRed = gohelper.findChild(arg_1_0._gobtnchange, "#go_LifeCircleRed")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._onBtnSwitch, arg_2_0)
	arg_2_0._btnqiehuan:AddClickListener(arg_2_0._btnqiehuanOnClick, arg_2_0)
	arg_2_0._btngift:AddClickListener(arg_2_0._onBtnGift, arg_2_0)
	arg_2_0._btnrewarddetailclose:AddClickListener(arg_2_0._onBtnRewardDetailClick, arg_2_0)

	if arg_2_0._droptimes then
		arg_2_0._droptimes:AddOnValueChanged(arg_2_0._onTimesValueChanged, arg_2_0)
	end

	if arg_2_0._inputheros then
		arg_2_0._inputheros:AddOnValueChanged(arg_2_0._onInputValueChanged, arg_2_0)
	end

	if arg_2_0._inputdate then
		arg_2_0._inputheros:AddOnValueChanged(arg_2_0._onInputDateChange, arg_2_0)
	end

	if arg_2_0._btnchangedateleft then
		arg_2_0._btnchangedateleft:AddClickListener(arg_2_0._onBtnChangeDateLeftClick, arg_2_0)
	end

	if arg_2_0._btnchangedateright then
		arg_2_0._btnchangedateright:AddClickListener(arg_2_0._onBtnChangeDateRightClick, arg_2_0)
	end

	if arg_2_0._btnswitchdecorate then
		arg_2_0._btnswitchdecorate:AddClickListener(arg_2_0._onBtnChangeDecorate, arg_2_0)
	end

	arg_2_0._btnchange:AddClickListener(arg_2_0._btnchangeOnClick, arg_2_0)
	arg_2_0._btnchange2:AddClickListener(arg_2_0._btnchangeOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnswitch:RemoveClickListener()
	arg_3_0._btnqiehuan:RemoveClickListener()
	arg_3_0._btngift:RemoveClickListener()
	arg_3_0._btnrewarddetailclose:RemoveClickListener()

	if arg_3_0._droptimes then
		arg_3_0._droptimes:RemoveOnValueChanged()
	end

	if arg_3_0._inputheros then
		arg_3_0._inputheros:RemoveOnValueChanged()
	end

	if arg_3_0._inputdate then
		arg_3_0._inputdate:RemoveOnValueChanged()
	end

	if arg_3_0._btnchangedateright then
		arg_3_0._btnchangedateright:RemoveClickListener()
	end

	if arg_3_0._btnchangedateleft then
		arg_3_0._btnchangedateleft:RemoveClickListener()
	end

	if arg_3_0._btnswitchdecorate then
		arg_3_0._btnswitchdecorate:RemoveClickListener()
	end

	arg_3_0._btnchange:RemoveClickListener()
	arg_3_0._btnchange2:RemoveClickListener()
end

var_0_0.MaxTipContainerHeight = 420
var_0_0.EveryTipItemHeight = 135
var_0_0.TipVerticalInterval = 25

local var_0_2 = "SignInView:_switchLifeCircleAnsSignIn"

function var_0_0._onTimesValueChanged(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:_getTextInputheros()

	if not var_4_0 or var_4_0 == "" then
		return
	end

	local var_4_1 = string.splitToNumber(var_4_0, "|")

	if not var_4_1 or #var_4_1 < 1 then
		return
	end

	gohelper.setActive(arg_4_0._btnqiehuan.gameObject, true)
end

function var_0_0._onInputDateChange(arg_5_0)
	return
end

function var_0_0._onBtnChangeDateLeftClick(arg_6_0)
	arg_6_0:_refreshGMDateContent(1)
end

function var_0_0._onBtnChangeDateRightClick(arg_7_0)
	arg_7_0:_refreshGMDateContent(-1)
end

function var_0_0._onBtnChangeDecorate(arg_8_0)
	if arg_8_0._isActiveLifeCircle then
		GameFacade.showToast(ToastEnum.IconId, "生命签界面是常驻界面，无法切换氛围！")

		return
	end

	arg_8_0:_switchFestivalDecoration(not arg_8_0._haveFestival)
	arg_8_0:_setPropItems()
end

function var_0_0._refreshGMDateContent(arg_9_0, arg_9_1)
	local var_9_0 = string.splitToNumber(arg_9_0._inputdate:GetText(), "-")

	if not var_9_0 or #var_9_0 ~= 3 then
		logError("请按照正确的格式输入日期！")

		return
	end

	local var_9_1 = TimeUtil.timeToTimeStamp(var_9_0[1], var_9_0[2], var_9_0[3], 1, 1, 1) + 86400 * arg_9_1
	local var_9_2 = os.date("%w", var_9_1)

	UISpriteSetMgr.instance:setSignInSprite(arg_9_0._imageweek, "date_" .. tostring(var_9_2))

	arg_9_0._txtdesc.text = SignInConfig.instance:getSignDescByDate(var_9_1)

	local var_9_3 = string.format("%02d", os.date("%d", var_9_1))

	arg_9_0:_setDayTextStr(var_9_3)

	arg_9_0._txtmonth.text = string.format("%02d", os.date("%m", var_9_1))
	arg_9_0._txtdate.text = string.format("%s.%s", string.upper(string.sub(os.date("%B", var_9_1), 1, 3)), os.date("%Y", var_9_1))

	local var_9_4 = TimeUtil.timestampToString1(var_9_1)

	arg_9_0._inputdate:SetText(var_9_4)
end

function var_0_0._onInputValueChanged(arg_10_0)
	if arg_10_0:_getTextInputheros() ~= "" then
		gohelper.setActive(arg_10_0._btnqiehuan.gameObject, true)

		return
	end

	local var_10_0 = SignInModel.instance:getSignBirthdayHeros(arg_10_0._targetDate[1], arg_10_0._targetDate[2], arg_10_0._targetDate[3])

	if arg_10_0._curDate.year == arg_10_0._targetDate[1] and arg_10_0._curDate.month == arg_10_0._targetDate[2] and arg_10_0._curDate.day == arg_10_0._targetDate[3] then
		var_10_0 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	gohelper.setActive(arg_10_0._btnqiehuan.gameObject, #var_10_0 > 0)
end

function var_0_0._onBtnSwitch(arg_11_0)
	SignInModel.instance:setNewSwitch(true)

	local var_11_0 = SignInModel.instance:isShowBirthday()

	SignInModel.instance:setShowBirthday(not var_11_0)
	SignInController.instance:dispatchEvent(SignInEvent.SwitchBirthdayState)
	arg_11_0:_setTitleInfo()
end

function var_0_0._btnqiehuanOnClick(arg_12_0)
	local var_12_0 = SignInModel.instance:getSignBirthdayHeros(arg_12_0._targetDate[1], arg_12_0._targetDate[2], arg_12_0._targetDate[3])

	if arg_12_0._curDate.year == arg_12_0._targetDate[1] and arg_12_0._curDate.month == arg_12_0._targetDate[2] and arg_12_0._curDate.day == arg_12_0._targetDate[3] then
		var_12_0 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local var_12_1 = arg_12_0:_getTextInputheros()

	if var_12_1 ~= "" then
		var_12_0 = string.splitToNumber(var_12_1, "|")
	end

	arg_12_0._index = (arg_12_0._index + 1) % (#var_12_0 + 1)

	UIBlockMgr.instance:startBlock("signshowing")
	TaskDispatcher.runDelay(arg_12_0._onQiehuanFinished, arg_12_0, 0.85)

	if arg_12_0._index == 1 then
		arg_12_0:_setRewardItems()
		arg_12_0:_playAnim("tobirthday")
	elseif arg_12_0._index > 1 then
		arg_12_0:_playAnim("birhtobirth")
	else
		arg_12_0:_playAnim("tonormal")
	end
end

function var_0_0._onQiehuanFinished(arg_13_0)
	UIBlockMgr.instance:endBlock("signshowing")
end

function var_0_0._onBtnGift(arg_14_0)
	local var_14_0 = SignInModel.instance:getSignBirthdayHeros(arg_14_0._targetDate[1], arg_14_0._targetDate[2], arg_14_0._targetDate[3])

	if arg_14_0._curDate.year == arg_14_0._targetDate[1] and arg_14_0._curDate.month == arg_14_0._targetDate[2] and arg_14_0._curDate.day == arg_14_0._targetDate[3] then
		local var_14_1 = SignInModel.instance:getCurDayBirthdayHeros()
		local var_14_2 = arg_14_0:_getTextInputheros()

		if var_14_2 ~= "" then
			var_14_1 = string.splitToNumber(var_14_2, "|")
		end

		local var_14_3 = var_14_1[arg_14_0._index]

		if not SignInModel.instance:isHeroBirthdayGet(var_14_3) then
			arg_14_0._startGetReward = true

			SignInRpc.instance:sendGetHeroBirthdayRequest(var_14_3)

			return
		end
	end

	arg_14_0:_showBirthdayRewardDetail()
end

function var_0_0._onBtnRewardDetailClick(arg_15_0)
	gohelper.setActive(arg_15_0._btnrewarddetailclose.gameObject, false)
	gohelper.setActive(arg_15_0._gobirthdayrewarddetail, false)
end

function var_0_0._addCustomEvent(arg_16_0)
	arg_16_0._monthreward1Click:AddClickListener(arg_16_0._onMonthRewardClick, arg_16_0, 1)
	arg_16_0._monthreward2Click:AddClickListener(arg_16_0._onMonthRewardClick, arg_16_0, 2)
	arg_16_0._monthreward3Click:AddClickListener(arg_16_0._onMonthRewardClick, arg_16_0, 3)
	arg_16_0._normaldayClick:AddClickListener(arg_16_0._onDayRewardClick, arg_16_0)
	arg_16_0._monthcarddayClick:AddClickListener(arg_16_0._onDayRewardClick, arg_16_0)
	arg_16_0._normaldayClick_gold:AddClickListener(arg_16_0._onDayGoldRewardClick, arg_16_0)
	arg_16_0._monthcarddayClick_gold:AddClickListener(arg_16_0._onDayGoldRewardClick, arg_16_0)
	arg_16_0._monthcardClick:AddClickListener(arg_16_0._onMonthCardRewardClick, arg_16_0)
	arg_16_0._monthcardpowerClick:AddClickListener(arg_16_0._onMonthCardPowerRewardClick, arg_16_0)
	arg_16_0._viewAniEventWrap:AddEventListener("changetobirthday", arg_16_0._onChangeToBirthday, arg_16_0)
	arg_16_0._viewAniEventWrap:AddEventListener("changetonormal", arg_16_0._onChangeToNormal, arg_16_0)
	arg_16_0._viewAniEventWrap:AddEventListener("birthdaytobirthday", arg_16_0._onChangeBirthdayToBirthday, arg_16_0)
	SignInController.instance:registerCallback(SignInEvent.GetSignInInfo, arg_16_0._onGetSignInInfo, arg_16_0)
	SignInController.instance:registerCallback(SignInEvent.GetSignInReply, arg_16_0._onGetSignInReply, arg_16_0)
	SignInController.instance:registerCallback(SignInEvent.GetSignInAddUp, arg_16_0._setMonthView, arg_16_0)
	SignInController.instance:registerCallback(SignInEvent.SignInItemClick, arg_16_0._onChangeItemClick, arg_16_0)
	SignInController.instance:registerCallback(SignInEvent.ClickSignInMonthItem, arg_16_0._closeViewEffect, arg_16_0)
	SignInController.instance:registerCallback(SignInEvent.GetHeroBirthday, arg_16_0._onGetHeroBirthday, arg_16_0)
	SignInController.instance:registerCallback(SignInEvent.CloseSignInView, arg_16_0._onEscapeBtnClick, arg_16_0)
	PlayerController.instance:registerCallback(PlayerEvent.OnDailyRefresh, arg_16_0._onDailyRefresh, arg_16_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_16_0._onCloseViewFinish, arg_16_0)
end

function var_0_0._removeCustomEvent(arg_17_0)
	arg_17_0._monthreward1Click:RemoveClickListener()
	arg_17_0._monthreward2Click:RemoveClickListener()
	arg_17_0._monthreward3Click:RemoveClickListener()
	arg_17_0._normaldayClick:RemoveClickListener()
	arg_17_0._monthcarddayClick:RemoveClickListener()
	arg_17_0._normaldayClick_gold:RemoveClickListener()
	arg_17_0._monthcarddayClick_gold:RemoveClickListener()
	arg_17_0._monthcardClick:RemoveClickListener()
	arg_17_0._monthcardpowerClick:RemoveClickListener()
	arg_17_0._viewAniEventWrap:RemoveAllEventListener()
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInInfo, arg_17_0._onGetSignInInfo, arg_17_0)
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInReply, arg_17_0._onGetSignInReply, arg_17_0)
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInAddUp, arg_17_0._setMonthView, arg_17_0)
	SignInController.instance:unregisterCallback(SignInEvent.SignInItemClick, arg_17_0._onChangeItemClick, arg_17_0)
	SignInController.instance:unregisterCallback(SignInEvent.ClickSignInMonthItem, arg_17_0._closeViewEffect, arg_17_0)
	SignInController.instance:unregisterCallback(SignInEvent.GetHeroBirthday, arg_17_0._onGetHeroBirthday, arg_17_0)
	SignInController.instance:unregisterCallback(SignInEvent.CloseSignInView, arg_17_0._onEscapeBtnClick, arg_17_0)
	PlayerController.instance:unregisterCallback(PlayerEvent.OnDailyRefresh, arg_17_0._onDailyRefresh, arg_17_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_17_0._onCloseViewFinish, arg_17_0)
end

function var_0_0._onEscapeBtnClick(arg_18_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_close)
	arg_18_0:_playAnim("out")
	TaskDispatcher.runDelay(arg_18_0._waitCloseView, arg_18_0, 0.2)
end

function var_0_0._onDayRewardClick(arg_19_0)
	MaterialTipController.instance:showMaterialInfo(arg_19_0._curDayRewards[1], arg_19_0._curDayRewards[2])
end

function var_0_0._onDayGoldRewardClick(arg_20_0)
	MaterialTipController.instance:showMaterialInfo(arg_20_0._goldReward[1], arg_20_0._goldReward[2])
end

function var_0_0._onMonthCardRewardClick(arg_21_0)
	MaterialTipController.instance:showMaterialInfo(arg_21_0._curmonthCardRewards[1], arg_21_0._curmonthCardRewards[2])
end

function var_0_0._onMonthCardPowerRewardClick(arg_22_0)
	MaterialTipController.instance:showMaterialInfo(arg_22_0._curmonthCardPower[1], arg_22_0._curmonthCardPower[2])
end

function var_0_0._onChangeToBirthday(arg_23_0)
	gohelper.setSiblingBefore(arg_23_0._godayrewarditem, arg_23_0._gobirthdayrewarditem)
end

function var_0_0._onChangeToNormal(arg_24_0)
	arg_24_0:_setRewardItems()
	gohelper.setSiblingBefore(arg_24_0._gobirthdayrewarditem, arg_24_0._godayrewarditem)
end

function var_0_0._onChangeBirthdayToBirthday(arg_25_0)
	arg_25_0:_setRewardItems()
end

function var_0_0._onGetSignInInfo(arg_26_0)
	arg_26_0:_setMonthView()
end

function var_0_0._onGetSignInReply(arg_27_0)
	arg_27_0:_setMonthView()
end

function var_0_0._onGetHeroBirthday(arg_28_0)
	local var_28_0 = SignInModel.instance:getSignBirthdayHeros(arg_28_0._targetDate[1], arg_28_0._targetDate[2], arg_28_0._targetDate[3])

	if arg_28_0._curDate.year == arg_28_0._targetDate[1] and arg_28_0._curDate.month == arg_28_0._targetDate[2] and arg_28_0._curDate.day == arg_28_0._targetDate[3] then
		var_28_0 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local var_28_1 = arg_28_0:_getTextInputheros()

	if var_28_1 ~= "" and arg_28_0._curDate.year == arg_28_0._targetDate[1] and arg_28_0._curDate.month == arg_28_0._targetDate[2] and arg_28_0._curDate.day == arg_28_0._targetDate[3] then
		var_28_0 = string.splitToNumber(var_28_1, "|")
	end

	local var_28_2 = false

	for iter_28_0, iter_28_1 in pairs(var_28_0) do
		if not SignInModel.instance:isHeroBirthdayGet(iter_28_1) then
			var_28_2 = true
		end
	end

	gohelper.setActive(arg_28_0._goqiehuan, var_28_2)
	gohelper.setActive(arg_28_0._gogiftnoget, false)
	gohelper.setActive(arg_28_0._gogiftget, true)
end

function var_0_0._closeViewEffect(arg_29_0)
	arg_29_0._clickMonth = true
	arg_29_0._index = 0

	arg_29_0:_playAnim("idel")
	arg_29_0:_setMonthView()
	gohelper.setSiblingBefore(arg_29_0._gobirthdayrewarditem, arg_29_0._godayrewarditem)
end

function var_0_0.onClickModalMask(arg_30_0)
	arg_30_0:_onEscapeBtnClick()
end

function var_0_0._waitCloseView(arg_31_0)
	SignInController.instance:openSignInDetailView(arg_31_0.viewParam)
	arg_31_0:closeThis()
end

function var_0_0._editableInitView(arg_32_0)
	gohelper.addUIClickAudio(arg_32_0._btnqiehuan.gameObject, AudioEnum.UI.play_ui_sign_in_qiehuan)
	gohelper.addUIClickAudio(arg_32_0._btnswitch.gameObject, AudioEnum.UI.play_ui_sign_in_switch)

	arg_32_0._clickMonth = false

	gohelper.setActive(arg_32_0._gomonthleftline, false)
	gohelper.setActive(arg_32_0._gomonthrightline, false)
	gohelper.setActive(arg_32_0._gomonthget1, false)
	gohelper.setActive(arg_32_0._gonomonthget1, false)
	gohelper.setActive(arg_32_0._gomonthget2, false)
	gohelper.setActive(arg_32_0._gonomonthget2, false)
	gohelper.setActive(arg_32_0._gomonthget3, false)
	gohelper.setActive(arg_32_0._gonomonthget3, false)
	gohelper.setActive(arg_32_0._gomonthcardsigned, false)
	gohelper.setActive(arg_32_0._gomonthcarddaysigned, false)
	gohelper.setActive(arg_32_0._gomonthcarddaysigned_gold, false)
	gohelper.setActive(arg_32_0._gonormaldaysigned, false)
	gohelper.setActive(arg_32_0._gonormaldaysigned_gold, false)
	arg_32_0._normaldayrewardAni:Play("none")
	arg_32_0._normaldayrewardAni_gold:Play("none")
	arg_32_0:_playAnim("go_view_in2")

	arg_32_0._gogetmonthbgs = arg_32_0:getUserDataTb_()

	table.insert(arg_32_0._gogetmonthbgs, arg_32_0._gogetmonthbg1)
	table.insert(arg_32_0._gogetmonthbgs, arg_32_0._gogetmonthbg2)
	table.insert(arg_32_0._gogetmonthbgs, arg_32_0._gogetmonthbg3)

	arg_32_0._gomonthmasks = arg_32_0:getUserDataTb_()

	table.insert(arg_32_0._gomonthmasks, arg_32_0._gomonthmask1)
	table.insert(arg_32_0._gomonthmasks, arg_32_0._gomonthmask2)
	table.insert(arg_32_0._gomonthmasks, arg_32_0._gomonthmask3)

	arg_32_0._gomonthgets = arg_32_0:getUserDataTb_()

	table.insert(arg_32_0._gomonthgets, arg_32_0._gomonthget1)
	table.insert(arg_32_0._gomonthgets, arg_32_0._gomonthget2)
	table.insert(arg_32_0._gomonthgets, arg_32_0._gomonthget3)

	arg_32_0._gonomonthgets = arg_32_0:getUserDataTb_()

	table.insert(arg_32_0._gonomonthgets, arg_32_0._gonomonthget1)
	table.insert(arg_32_0._gonomonthgets, arg_32_0._gonomonthget2)
	table.insert(arg_32_0._gonomonthgets, arg_32_0._gonomonthget3)
	arg_32_0._simagebg:LoadImage(ResUrl.getSignInBg("bg_white2"))
	arg_32_0._simagebg1:LoadImage(ResUrl.getSignInBg("bg_zs"))
	arg_32_0._simageorangebg:LoadImage(ResUrl.getSignInBg("img_bcard3"))
	arg_32_0._simagerewardbg:LoadImage(ResUrl.getSignInBg("img_di"))

	arg_32_0._rewardTipItems = {}
	arg_32_0._nodeItems = {}
	arg_32_0._monthItemTabs = arg_32_0:getUserDataTb_()
	arg_32_0._monthgetlightanimTab = arg_32_0:getUserDataTb_()
	arg_32_0._delayAnimTab = arg_32_0:getUserDataTb_()
	arg_32_0._monthRewards = arg_32_0:getUserDataTb_()

	table.insert(arg_32_0._monthgetlightanimTab, arg_32_0._gomonthgetlightanim1)
	table.insert(arg_32_0._monthgetlightanimTab, arg_32_0._gomonthgetlightanim2)
	table.insert(arg_32_0._monthgetlightanimTab, arg_32_0._gomonthgetlightanim3)

	for iter_32_0, iter_32_1 in ipairs(arg_32_0._monthgetlightanimTab) do
		gohelper.setActive(iter_32_1, false)
	end

	arg_32_0._btnchangeGo = arg_32_0._btnchange.gameObject
	arg_32_0._btnchange2Go = arg_32_0._btnchange2.gameObject

	arg_32_0:_setActive_LifeCicle(false)
	RedDotController.instance:addRedDot(arg_32_0._goLifeCircleRed, RedDotEnum.DotNode.LifeCircleNewConfig, nil, arg_32_0._checkLifeCircleRed, arg_32_0)
end

function var_0_0.onOpen(arg_33_0)
	arg_33_0._index = 0
	arg_33_0._checkSignIn = true

	SignInModel.instance:setShowBirthday(arg_33_0.viewParam.isBirthday)
	arg_33_0:_addCustomEvent()
	arg_33_0:_setMonthView(true)
	arg_33_0:_setRedDot()

	if arg_33_0._gogmhelp then
		gohelper.setActive(arg_33_0._gogmhelp, GMController.instance:isOpenGM())
	end

	if arg_33_0._gochangedate then
		gohelper.setActive(arg_33_0._gochangedate, GMController.instance:isOpenGM())
	end

	SignInModel.instance:setNewShowDetail(true)
	NavigateMgr.instance:addEscape(ViewName.SignInView, arg_33_0._onEscapeBtnClick, arg_33_0)
	arg_33_0:_refreshFestivalDecoration()
end

function var_0_0._initIndex(arg_34_0)
	if not arg_34_0._isCurDayRewardGet then
		return
	end

	for iter_34_0 = 1, 3 do
		local var_34_0 = SignInModel.instance:isSignTotalRewardGet(iter_34_0)
		local var_34_1 = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(iter_34_0).signinaddup)

		if not var_34_0 and var_34_1 then
			return
		end
	end

	local var_34_2 = SignInModel.instance:getSignBirthdayHeros(arg_34_0._targetDate[1], arg_34_0._targetDate[2], arg_34_0._targetDate[3])

	if arg_34_0._curDate.year == arg_34_0._targetDate[1] and arg_34_0._curDate.month == arg_34_0._targetDate[2] and arg_34_0._curDate.day == arg_34_0._targetDate[3] then
		var_34_2 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local var_34_3 = arg_34_0:_getTextInputheros()

	if var_34_3 ~= "" and arg_34_0._curDate.year == arg_34_0._targetDate[1] and arg_34_0._curDate.month == arg_34_0._targetDate[2] and arg_34_0._curDate.day == arg_34_0._targetDate[3] then
		var_34_2 = string.splitToNumber(var_34_3, "|")
	end

	for iter_34_1, iter_34_2 in ipairs(var_34_2) do
		if not SignInModel.instance:isHeroBirthdayGet(iter_34_2) then
			gohelper.setSiblingBefore(arg_34_0._godayrewarditem, arg_34_0._gobirthdayrewarditem)

			arg_34_0._index = iter_34_1

			return
		end
	end
end

function var_0_0._onDailyRefresh(arg_35_0)
	arg_35_0._index = 0
	arg_35_0._checkSignIn = true

	gohelper.setActive(arg_35_0._gomonthget1, false)
	gohelper.setActive(arg_35_0._gonomonthget1, false)
	gohelper.setActive(arg_35_0._gomonthget2, false)
	gohelper.setActive(arg_35_0._gonomonthget2, false)
	gohelper.setActive(arg_35_0._gomonthget3, false)
	gohelper.setActive(arg_35_0._gonomonthget3, false)
	gohelper.setActive(arg_35_0._gonormaldaysigned, false)
	gohelper.setActive(arg_35_0._gonormaldaysigned_gold, false)
	gohelper.setActive(arg_35_0._gomonthcarddaysigned, false)
	gohelper.setActive(arg_35_0._gomonthcarddaysigned_gold, false)
	gohelper.setActive(arg_35_0._gomonthcardsigned, false)
	gohelper.setActive(arg_35_0._gonormaldayget, false)
	gohelper.setActive(arg_35_0._gonormaldayget_gold, false)
	gohelper.setActive(arg_35_0._gomonthcarddayget, false)
	gohelper.setActive(arg_35_0._gomonthcarddayget_gold, false)
	gohelper.setActive(arg_35_0._gomonthcardget, false)
	gohelper.setActive(arg_35_0._gonormaldaynoget, false)
	gohelper.setActive(arg_35_0._gomonthcarddaynoget, false)
	gohelper.setActive(arg_35_0._gomonthcarddaynoget_gold, false)
	gohelper.setActive(arg_35_0._gomonthcardnoget, false)
	gohelper.setActive(arg_35_0._gomonthcardpowernoget, false)
	gohelper.setActive(arg_35_0._goget, false)
	gohelper.setActive(arg_35_0._gonoget, true)
	gohelper.setActive(arg_35_0._goget, false)
	gohelper.setActive(arg_35_0._gonoget, false)
	arg_35_0:_setMonthView()
	arg_35_0:_onChangeToNormal()
end

function var_0_0._onChangeItemClick(arg_36_0)
	arg_36_0._index = 0

	arg_36_0:_playAnim("idel")
	arg_36_0:_setMonthView()
	gohelper.setSiblingBefore(arg_36_0._gobirthdayrewarditem, arg_36_0._godayrewarditem)
end

function var_0_0._setMonthView(arg_37_0, arg_37_1)
	arg_37_0:_setSignInData()

	if arg_37_1 then
		arg_37_0:_playOpenAudio()
		arg_37_0:_initIndex()
	end

	arg_37_0:_setTitleInfo()
	arg_37_0:_setRewardItems()
	arg_37_0:_setMonthViewRewardTips()
	arg_37_0:_setPropItems()
	arg_37_0:_setMonthItems()

	if not arg_37_0._checkSignIn then
		return
	end

	if not arg_37_0._isCurDayRewardGet then
		gohelper.setActive(arg_37_0._gonormaldaysigned, true)
		gohelper.setActive(arg_37_0._gonormaldaysigned_gold, true)
		gohelper.setActive(arg_37_0._gomonthcarddaysigned, true)
		gohelper.setActive(arg_37_0._gomonthcarddaysigned_gold, true)
		gohelper.setActive(arg_37_0._gomonthcardsigned, true)
		gohelper.setActive(arg_37_0._gonormaldayget, true)
		gohelper.setActive(arg_37_0._gonormaldayget_gold, true)
		gohelper.setActive(arg_37_0._gomonthcarddayget, true)
		gohelper.setActive(arg_37_0._gomonthcarddayget_gold, true)
		gohelper.setActive(arg_37_0._gomonthcardget, true)
		gohelper.setActive(arg_37_0._gonormaldaynoget, false)
		gohelper.setActive(arg_37_0._gomonthcarddaynoget, false)
		gohelper.setActive(arg_37_0._gomonthcarddaynoget_gold, false)
		gohelper.setActive(arg_37_0._gomonthcardnoget, false)
		gohelper.setActive(arg_37_0._gomonthcardpowernoget, false)
		gohelper.setActive(arg_37_0._goget, false)
		gohelper.setActive(arg_37_0._gonoget, true)
		arg_37_0._normaldayrewardAni:Play("none")
		arg_37_0._normaldayrewardAni_gold:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(arg_37_0._txtnormaldayrewardcount, 1)

		arg_37_0._checkSignIn = false

		UIBlockMgr.instance:startBlock("signshowing")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_dailyrewards)
		TaskDispatcher.runDelay(arg_37_0._delaySignInRequest, arg_37_0, 1.3)
	else
		gohelper.setActive(arg_37_0._gonormaldaysigned, true)
		gohelper.setActive(arg_37_0._gonormaldaysigned_gold, true)
		gohelper.setActive(arg_37_0._gomonthcarddaysigned, true)
		gohelper.setActive(arg_37_0._gomonthcarddaysigned_gold, true)
		gohelper.setActive(arg_37_0._gomonthcardsigned, true)
		gohelper.setActive(arg_37_0._gonormaldayget, false)
		gohelper.setActive(arg_37_0._gonormaldayget_gold, false)
		gohelper.setActive(arg_37_0._gomonthcarddayget, false)
		gohelper.setActive(arg_37_0._gomonthcarddayget_gold, false)
		gohelper.setActive(arg_37_0._gomonthcardget, false)
		gohelper.setActive(arg_37_0._gonormaldaynoget, true)
		gohelper.setActive(arg_37_0._gomonthcarddaynoget, true)
		gohelper.setActive(arg_37_0._gomonthcarddaynoget_gold, true)
		gohelper.setActive(arg_37_0._gomonthcardnoget, true)
		gohelper.setActive(arg_37_0._gomonthcardpowernoget, true)
		gohelper.setActive(arg_37_0._goget, true)
		gohelper.setActive(arg_37_0._gonoget, false)
		ZProj.UGUIHelper.SetColorAlpha(arg_37_0._txtnormaldayrewardcount, 0.7)

		if arg_37_0._gonormaldayget.activeSelf then
			arg_37_0._normaldayrewardAni:Play("none")
			arg_37_0._normaldayrewardAni_gold:Play("none")
		else
			gohelper.setActive(arg_37_0._gomonthcarddayget, false)
			gohelper.setActive(arg_37_0._gomonthcarddayget_gold, false)
			gohelper.setActive(arg_37_0._gomonthcardget, false)
			gohelper.setActive(arg_37_0._gomonthcardnoget, true)
			gohelper.setActive(arg_37_0._gomonthcardpowernoget, true)
			gohelper.setActive(arg_37_0._gomonthcarddaynoget, true)
			gohelper.setActive(arg_37_0._gomonthcarddaynoget_gold, true)
			arg_37_0._normaldayrewardAni:Play("lingqu")
			arg_37_0._normaldayrewardAni_gold:Play("lingqu")
		end
	end
end

function var_0_0._setSignInData(arg_38_0)
	arg_38_0._curDate = SignInModel.instance:getCurDate()
	arg_38_0._targetDate = SignInModel.instance:getSignTargetDate()
	arg_38_0._curDayRewards = string.splitToNumber(SignInConfig.instance:getSignRewards(tonumber(arg_38_0._curDate.day)).signinBonus, "#")
	arg_38_0._rewardGetState = SignInModel.instance:isSignDayRewardGet(arg_38_0._targetDate[3])
	arg_38_0._isCurDayRewardGet = SignInModel.instance:isSignDayRewardGet(arg_38_0._curDate.day)
end

function var_0_0._playOpenAudio(arg_39_0)
	local var_39_0 = SignInModel.instance:getValidMonthCard(arg_39_0._curDate.year, arg_39_0._curDate.month, arg_39_0._curDate.day)

	if not arg_39_0._isCurDayRewardGet and var_39_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_menology)

		return
	end

	local var_39_1 = false

	for iter_39_0 = 1, 3 do
		local var_39_2 = SignInModel.instance:isSignTotalRewardGet(iter_39_0)
		local var_39_3 = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(iter_39_0).signinaddup)

		if not var_39_2 and var_39_3 then
			var_39_1 = true
		end
	end

	if var_39_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_special)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_general)
end

function var_0_0._setTitleInfo(arg_40_0)
	local var_40_0 = TimeUtil.timeToTimeStamp(arg_40_0._targetDate[1], arg_40_0._targetDate[2], arg_40_0._targetDate[3], TimeDispatcher.DailyRefreshTime, 1, 1)
	local var_40_1 = ServerTime.weekDayInServerLocal()

	if var_40_1 >= 7 then
		var_40_1 = 0
	end

	UISpriteSetMgr.instance:setSignInSprite(arg_40_0._imageweek, "date_" .. tostring(var_40_1))

	arg_40_0._txtdesc.text = SignInConfig.instance:getSignDescByDate(var_40_0)

	arg_40_0:_setDayTextStr(string.format("%02d", arg_40_0._targetDate[3]))

	arg_40_0._txtmonth.text = string.format("%02d", arg_40_0._targetDate[2])
	arg_40_0._txtdate.text = string.format("%s.%s", string.upper(string.sub(os.date("%B", var_40_0), 1, 3)), arg_40_0._targetDate[1])

	local var_40_2 = SignInModel.instance:isShowBirthday() and "switch_icon1" or "switch_icon2"

	UISpriteSetMgr.instance:setSignInSprite(arg_40_0._imageswitchicon, var_40_2)

	local var_40_3, var_40_4 = SignInModel.instance:getAdvanceHero()

	if var_40_3 == 0 then
		gohelper.setActive(arg_40_0._goroleitem, false)
	else
		gohelper.setActive(arg_40_0._goroleitem, true)

		local var_40_5 = HeroModel.instance:getByHeroId(var_40_3)
		local var_40_6 = var_40_5 and var_40_5.skin or HeroConfig.instance:getHeroCO(var_40_3).skinId

		arg_40_0._simagetopicon:LoadImage(ResUrl.getHeadIconSmall(var_40_6))

		arg_40_0._txtbirtime.text = var_40_4
		arg_40_0._txtlimit.text = var_40_4 > 1 and "Days Later" or "Day Later"
	end
end

function var_0_0._setDayTextStr(arg_41_0, arg_41_1)
	arg_41_0._txtday.text = arg_41_1
	arg_41_0._txtdayfestival.text = arg_41_1
end

function var_0_0._setRewardItems(arg_42_0)
	local var_42_0 = SignInModel.instance:getSignBirthdayHeros(arg_42_0._targetDate[1], arg_42_0._targetDate[2], arg_42_0._targetDate[3])

	if arg_42_0._curDate.year == arg_42_0._targetDate[1] and arg_42_0._curDate.month == arg_42_0._targetDate[2] and arg_42_0._curDate.day == arg_42_0._targetDate[3] then
		var_42_0 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local var_42_1 = arg_42_0:_getTextInputheros()

	if var_42_1 ~= "" and arg_42_0._curDate.year == arg_42_0._targetDate[1] and arg_42_0._curDate.month == arg_42_0._targetDate[2] and arg_42_0._curDate.day == arg_42_0._targetDate[3] then
		var_42_0 = string.splitToNumber(var_42_1, "|")
	end

	if arg_42_0._curDate.year == arg_42_0._targetDate[1] and arg_42_0._curDate.month == arg_42_0._targetDate[2] and arg_42_0._curDate.day == arg_42_0._targetDate[3] then
		if arg_42_0._index > 0 then
			RedDotController.instance:addRedDot(arg_42_0._gogiftreddot, RedDotEnum.DotNode.SignInBirthReward, var_42_0[arg_42_0._index])
		end
	else
		RedDotController.instance:addRedDot(arg_42_0._gogiftreddot, 0)
	end

	local var_42_2 = false

	if arg_42_0._curDate.year == arg_42_0._targetDate[1] and arg_42_0._curDate.month == arg_42_0._targetDate[2] and arg_42_0._curDate.day == arg_42_0._targetDate[3] then
		for iter_42_0, iter_42_1 in pairs(var_42_0) do
			if not SignInModel.instance:isHeroBirthdayGet(iter_42_1) then
				var_42_2 = true
			end
		end
	end

	gohelper.setActive(arg_42_0._goqiehuan, var_42_2)

	for iter_42_2, iter_42_3 in pairs(arg_42_0._nodeItems) do
		gohelper.setActive(iter_42_3.go, false)
	end

	if #var_42_0 > 0 then
		for iter_42_4 = 1, #var_42_0 + 1 do
			if not arg_42_0._nodeItems[iter_42_4] then
				arg_42_0._nodeItems[iter_42_4] = arg_42_0:getUserDataTb_()
				arg_42_0._nodeItems[iter_42_4].go = gohelper.cloneInPlace(arg_42_0._gonodeitem, "node" .. tostring(iter_42_4))
				arg_42_0._nodeItems[iter_42_4].on = gohelper.findChild(arg_42_0._nodeItems[iter_42_4].go, "on")
				arg_42_0._nodeItems[iter_42_4].off = gohelper.findChild(arg_42_0._nodeItems[iter_42_4].off, "off")
			end

			gohelper.setActive(arg_42_0._nodeItems[iter_42_4].go, true)
			gohelper.setActive(arg_42_0._nodeItems[iter_42_4].on, arg_42_0._index == iter_42_4 - 1)
			gohelper.setActive(arg_42_0._nodeItems[iter_42_4].off, arg_42_0._index ~= iter_42_4 - 1)
		end

		gohelper.setActive(arg_42_0._gonodes, true)

		if arg_42_0._index == 0 then
			arg_42_0:_showDayRewardItem()
		else
			arg_42_0:_showBirthdayRewardItem()
		end
	else
		gohelper.setActive(arg_42_0._gonodes, false)
		arg_42_0:_showNoBirthdayRewardItem()
	end
end

function var_0_0._showNoBirthdayRewardItem(arg_43_0)
	gohelper.setActive(arg_43_0._btnqiehuan.gameObject, false)
	gohelper.setActive(arg_43_0._simageorangebg.gameObject, false)
	gohelper.setActive(arg_43_0._gobirthdayrewarditem, false)
end

function var_0_0._showDayRewardItem(arg_44_0)
	gohelper.setActive(arg_44_0._gobirthday, false)
	gohelper.setActive(arg_44_0._btnqiehuan.gameObject, true)
	gohelper.setActive(arg_44_0._simageorangebg.gameObject, true)
	gohelper.setActive(arg_44_0._gobirthdayrewarditem, true)
	arg_44_0._simagebirthdaybg:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	arg_44_0._simagebirthdaybg2:LoadImage(ResUrl.getSignInBg("img_bcard1"))
end

function var_0_0._showBirthdayRewardItem(arg_45_0)
	gohelper.setActive(arg_45_0._gobirthday, true)
	gohelper.setActive(arg_45_0._btnqiehuan.gameObject, true)
	gohelper.setActive(arg_45_0._simageorangebg.gameObject, true)
	gohelper.setActive(arg_45_0._gobirthdayrewarditem, true)
	arg_45_0._simagebirthdaybg:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	arg_45_0._simagebirthdaybg2:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	arg_45_0:_setBirthdayInfo()
end

function var_0_0._delaySignInRequest(arg_46_0)
	gohelper.setActive(arg_46_0._gonormaldaysigned, true)
	gohelper.setActive(arg_46_0._gonormaldaysigned_gold, true)
	gohelper.setActive(arg_46_0._gomonthcarddaysigned, true)
	gohelper.setActive(arg_46_0._gomonthcarddaysigned_gold, true)
	gohelper.setActive(arg_46_0._gomonthcardsigned, true)
	gohelper.setActive(arg_46_0._gonormaldayget, false)
	gohelper.setActive(arg_46_0._gonormaldayget_gold, false)
	gohelper.setActive(arg_46_0._gomonthcarddayget, false)
	gohelper.setActive(arg_46_0._gomonthcarddayget_gold, false)
	gohelper.setActive(arg_46_0._gomonthcardget, false)
	gohelper.setActive(arg_46_0._gonormaldaynoget, true)
	gohelper.setActive(arg_46_0._gomonthcarddaynoget, true)
	gohelper.setActive(arg_46_0._gomonthcarddaynoget_gold, true)
	gohelper.setActive(arg_46_0._gomonthcardnoget, true)
	gohelper.setActive(arg_46_0._gomonthcardpowernoget, true)
	gohelper.setActive(arg_46_0._goget, true)
	gohelper.setActive(arg_46_0._gonoget, false)
	arg_46_0._normaldayrewardAni:Play("lingqu")
	arg_46_0._normaldayrewardAni_gold:Play("lingqu")
	ZProj.UGUIHelper.SetColorAlpha(arg_46_0._txtnormaldayrewardcount, 0.7)
	UIBlockMgr.instance:endBlock("signshowing")

	if arg_46_0._startGetReward then
		return
	end

	LifeCircleController.instance:sendSignInRequest()

	arg_46_0._startGetReward = true
end

function var_0_0._onCloseViewFinish(arg_47_0, arg_47_1)
	if arg_47_1 == ViewName.CommonPropView then
		if not arg_47_0._startGetReward then
			return
		end

		arg_47_0._startGetReward = false

		local var_47_0 = SignInModel.instance:getCurDayBirthdayHeros()

		if arg_47_0._index >= #var_47_0 then
			return
		end

		arg_47_0:_btnqiehuanOnClick()
	end
end

function var_0_0._onWaitSwitchBirthFinished(arg_48_0)
	UIBlockMgr.instance:endBlock("switchshowing")
end

function var_0_0._onCloseMonthRewardDetailClick(arg_49_0)
	gohelper.setActive(arg_49_0._gomonthrewarddetail, false)
end

function var_0_0._onMonthRewardClick(arg_50_0, arg_50_1)
	local var_50_0 = SignInModel.instance:isSignTotalRewardGet(arg_50_1)
	local var_50_1 = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(arg_50_1).signinaddup)

	gohelper.setActive(arg_50_0._gogetmonthbgs[arg_50_1], var_50_1)

	if not var_50_0 and var_50_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_receive)
		gohelper.setActive(arg_50_0._gomonthgets[arg_50_1], true)
		gohelper.setActive(arg_50_0._monthgetlightanimTab[arg_50_1], true)

		arg_50_0._targetid = arg_50_1

		TaskDispatcher.runDelay(arg_50_0._showGetRewards, arg_50_0, 1.2)
	else
		MaterialTipController.instance:showMaterialInfo(tonumber(arg_50_0._monthRewards[arg_50_1].reward[1]), tonumber(arg_50_0._monthRewards[arg_50_1].reward[2]))
	end
end

function var_0_0._showGetRewards(arg_51_0)
	if arg_51_0._targetid then
		gohelper.setActive(arg_51_0._gomonthgets[arg_51_0._targetid], false)
		gohelper.setActive(arg_51_0._gonomonthgets[arg_51_0._targetid], true)
		SignInRpc.instance:sendSignInAddupRequest(arg_51_0._targetid)

		arg_51_0._targetid = nil
	end
end

function var_0_0._setBirthdayInfo(arg_52_0)
	local var_52_0 = SignInModel.instance:getSignBirthdayHeros(arg_52_0._targetDate[1], arg_52_0._targetDate[2], arg_52_0._targetDate[3])

	if arg_52_0._curDate.year == arg_52_0._targetDate[1] and arg_52_0._curDate.month == arg_52_0._targetDate[2] and arg_52_0._curDate.day == arg_52_0._targetDate[3] then
		var_52_0 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local var_52_1 = arg_52_0:_getTextInputheros()

	if var_52_1 ~= "" then
		var_52_0 = string.splitToNumber(var_52_1, "|")
	end

	local var_52_2 = var_52_0[arg_52_0._index]
	local var_52_3 = HeroModel.instance:getByHeroId(var_52_2)
	local var_52_4 = var_52_3 and var_52_3.skin or HeroConfig.instance:getHeroCO(var_52_2).skinId

	arg_52_0._simagebirthdayIcon:LoadImage(ResUrl.getHeadIconSmall(var_52_4))

	local var_52_5 = SignInModel.instance:getHeroBirthdayCount(var_52_2)
	local var_52_6 = var_52_5

	if arg_52_0._curDate.month == arg_52_0._targetDate[2] then
		local var_52_7 = SignInModel.instance:isHeroBirthdayGet(var_52_2)

		if arg_52_0._curDate.year == arg_52_0._targetDate[1] then
			var_52_6 = var_52_7 and var_52_5 or var_52_5 + 1
		else
			var_52_6 = var_52_7 and var_52_5 - 1 or var_52_5
		end
	end

	if var_52_1 ~= "" then
		var_52_6 = arg_52_0._droptimes:GetValue() + 1
	end

	local var_52_8 = string.split(HeroConfig.instance:getHeroCO(var_52_2).desc, "|")[var_52_6]

	arg_52_0._txtdeco.text = var_52_8

	ZProj.UGUIHelper.RebuildLayout(arg_52_0._txtdeco.gameObject.transform)
	gohelper.setActive(arg_52_0._txtdeco.gameObject, false)
	gohelper.setActive(arg_52_0._txtdeco.gameObject, true)
	arg_52_0._simagesignature:LoadImage(ResUrl.getSignature(tostring(var_52_2)))

	local var_52_9 = true

	if arg_52_0._curDate.year == arg_52_0._targetDate[1] and arg_52_0._curDate.month == arg_52_0._targetDate[2] and arg_52_0._curDate.day == arg_52_0._targetDate[3] then
		var_52_9 = SignInModel.instance:isHeroBirthdayGet(var_52_2)
	end

	gohelper.setActive(arg_52_0._gogiftnoget, not var_52_9)
	gohelper.setActive(arg_52_0._gogiftget, var_52_9)
end

function var_0_0._setMonthViewRewardTips(arg_53_0)
	local var_53_0 = SignInModel.instance:getTotalSignDays()
	local var_53_1 = string.format("<color=#ED7B3C>%s</color>", var_53_0)
	local var_53_2 = string.format(luaLang("p_activitysignin_signindaystitle"), var_53_1)

	arg_53_0._txtmonthtitle.text = var_53_2

	local var_53_3 = SignInConfig.instance:getSignMonthRewards()

	for iter_53_0 = 1, 3 do
		arg_53_0:_showMonthRewardInfo(iter_53_0)
	end

	local var_53_4 = SignInModel.instance:isSignTotalRewardGet(1)
	local var_53_5 = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(1).signinaddup)

	gohelper.setActive(arg_53_0._gorewardmark1, not var_53_4 and var_53_5)
	gohelper.setActive(arg_53_0._gogetmonthbg1, var_53_5)

	if var_53_4 then
		gohelper.setActive(arg_53_0._gomonthget1, arg_53_0._gomonthget1.activeSelf)
		gohelper.setActive(arg_53_0._gonomonthget1, not arg_53_0._gomonthget1.activeSelf)
		arg_53_0._month1Ani:Play("lingqu")
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthquantity1, 0.5)
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtrewardcount1, 0.5)
	else
		gohelper.setActive(arg_53_0._gomonthget1, false)
		gohelper.setActive(arg_53_0._gonomonthget1, false)
		arg_53_0._month1Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthquantity1, 1)
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtrewardcount1, 1)
	end

	local var_53_6 = SignInModel.instance:isSignTotalRewardGet(2)
	local var_53_7 = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(2).signinaddup)

	gohelper.setActive(arg_53_0._gorewardmark2, not var_53_6 and var_53_7)
	gohelper.setActive(arg_53_0._gogetmonthbg2, var_53_7)

	if var_53_6 then
		gohelper.setActive(arg_53_0._gomonthget2, arg_53_0._gomonthget2.activeSelf)
		gohelper.setActive(arg_53_0._gonomonthget2, not arg_53_0._gomonthget2.activeSelf)
		arg_53_0._month2Ani:Play("lingqu")
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthquantity2, 0.5)
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtrewardcount2, 0.5)
	else
		gohelper.setActive(arg_53_0._gomonthget2, false)
		gohelper.setActive(arg_53_0._gonomonthget2, false)
		arg_53_0._month2Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthquantity2, 1)
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtrewardcount2, 1)
	end

	local var_53_8 = SignInModel.instance:isSignTotalRewardGet(3)
	local var_53_9 = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(3).signinaddup)

	gohelper.setActive(arg_53_0._gorewardmark3, not var_53_8 and var_53_9)
	gohelper.setActive(arg_53_0._gogetmonthbg3, var_53_9)

	if var_53_8 then
		gohelper.setActive(arg_53_0._gomonthget3, arg_53_0._gomonthget3.activeSelf)
		gohelper.setActive(arg_53_0._gonomonthget3, not arg_53_0._gomonthget3.activeSelf)
		arg_53_0._month3Ani:Play("lingqu")
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthquantity3, 0.5)
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtrewardcount3, 0.5)
	else
		gohelper.setActive(arg_53_0._gomonthget3, false)
		gohelper.setActive(arg_53_0._gonomonthget3, false)
		arg_53_0._month3Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthquantity3, 1)
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtrewardcount3, 1)
	end

	local var_53_10 = SignInModel.instance:getSignTargetDate()

	arg_53_0:_setGoldRewards(var_53_10)

	arg_53_0._curDayRewards = string.splitToNumber(SignInConfig.instance:getSignRewards(var_53_10[3]).signinBonus, "#")

	local var_53_11, var_53_12 = ItemModel.instance:getItemConfigAndIcon(arg_53_0._curDayRewards[1], arg_53_0._curDayRewards[2], true)

	arg_53_0._txtnormaldayrewardcount.text = luaLang("multiple") .. tostring(arg_53_0._curDayRewards[3])
	arg_53_0._txtmonthcarddayrewardcount.text = luaLang("multiple") .. tostring(arg_53_0._curDayRewards[3])

	arg_53_0._simagenormaldayrewardicon:LoadImage(var_53_12)
	arg_53_0._simagemonthcarddayrewardicon:LoadImage(var_53_12)

	if tonumber(arg_53_0._curDayRewards[1]) == MaterialEnum.MaterialType.Equip then
		arg_53_0._simagenormaldayrewardicon:LoadImage(ResUrl.getPropItemIcon(var_53_11.icon))
		arg_53_0._simagemonthcarddayrewardicon:LoadImage(ResUrl.getPropItemIcon(var_53_11.icon))
	end

	local var_53_13 = SignInModel.instance:getValidMonthCard(var_53_10[1], var_53_10[2], var_53_10[3])

	gohelper.setActive(arg_53_0._gomonthcard, var_53_13)
	gohelper.setActive(arg_53_0._gonormal, not var_53_13)

	if var_53_13 then
		local var_53_14 = string.split(StoreConfig.instance:getMonthCardConfig(var_53_13).dailyBonus, "|")

		arg_53_0._curmonthCardRewards = string.splitToNumber(var_53_14[1], "#")
		arg_53_0._curmonthCardPower = string.splitToNumber(var_53_14[2], "#")
		arg_53_0._txtmonthcardcount.text = luaLang("multiple") .. tostring(arg_53_0._curmonthCardRewards[3])
		arg_53_0._txtmonthcardpowercount.text = luaLang("multiple") .. tostring(arg_53_0._curmonthCardPower[3])

		local var_53_15, var_53_16 = ItemModel.instance:getItemConfigAndIcon(arg_53_0._curmonthCardRewards[1], arg_53_0._curmonthCardRewards[2], true)

		arg_53_0._simagemonthcardicon:LoadImage(var_53_16)

		local var_53_17, var_53_18 = ItemModel.instance:getItemConfigAndIcon(arg_53_0._curmonthCardPower[1], arg_53_0._curmonthCardPower[2], true)

		arg_53_0._simagemonthcardpowericon:LoadImage(var_53_18)
		gohelper.setActive(arg_53_0._gopowerlimittime, false)

		if var_53_17.expireTime then
			gohelper.setActive(arg_53_0._gopowerlimittime, true)
		end

		local var_53_19 = StoreModel.instance:getMonthCardInfo()

		if var_53_19 then
			local var_53_20 = var_53_19:getRemainDay()

			if var_53_20 > 0 then
				gohelper.setActive(arg_53_0._golimittime.gameObject, true)

				if var_53_20 <= StoreEnum.MonthCardStatus.NotEnoughThreeDay then
					gohelper.setActive(arg_53_0._goredlimittimebg, true)
					gohelper.setActive(arg_53_0._gonormallimittimebg, false)
				else
					gohelper.setActive(arg_53_0._goredlimittimebg, false)
					gohelper.setActive(arg_53_0._gonormallimittimebg, true)
				end

				arg_53_0._txtlimittime.text = formatLuaLang("remain_day", var_53_20)
			else
				gohelper.setActive(arg_53_0._golimittime.gameObject, false)
			end
		end

		local var_53_21 = arg_53_0._curDate.year == arg_53_0._targetDate[1] and arg_53_0._curDate.month == arg_53_0._targetDate[2] and arg_53_0._curDate.day == arg_53_0._targetDate[3] and not arg_53_0._rewardGetState

		gohelper.setActive(arg_53_0._gomonthcardget, var_53_21)
		gohelper.setActive(arg_53_0._gomonthcarddayget, var_53_21)
		gohelper.setActive(arg_53_0._gomonthcarddayget_gold, var_53_21)
		gohelper.setActive(arg_53_0._gomonthcardnoget, not var_53_21)
		gohelper.setActive(arg_53_0._gomonthcardpowernoget, not var_53_21)
		gohelper.setActive(arg_53_0._gomonthcarddaynoget, not var_53_21)
		gohelper.setActive(arg_53_0._gomonthcarddaynoget_gold, not var_53_21)
	end
end

function var_0_0._setGoldRewards(arg_54_0, arg_54_1)
	if SignInModel.instance:checkIsGoldDay(arg_54_1) then
		local var_54_0 = SignInModel.instance:getTargetDailyAllowanceBonus(arg_54_1)

		gohelper.setActive(arg_54_0._gonormaldayreward_gold, var_54_0)
		gohelper.setActive(arg_54_0._gomonthcarddayreward_gold, var_54_0)

		if var_54_0 then
			local var_54_1 = string.split(var_54_0, "#")

			arg_54_0._goldReward = var_54_1

			local var_54_2, var_54_3 = ItemModel.instance:getItemConfigAndIcon(var_54_1[1], var_54_1[2], true)

			arg_54_0._txtnormaldayrewardcount_gold.text = luaLang("multiple") .. tostring(var_54_1[3])
			arg_54_0._txtmonthcarddayrewardcount_gold.text = luaLang("multiple") .. tostring(var_54_1[3])

			arg_54_0._simagenormaldayrewardicon_gold:LoadImage(var_54_3)
			arg_54_0._simagemonthcarddayrewardicon_gold:LoadImage(var_54_3)

			if tonumber(var_54_1[1]) == MaterialEnum.MaterialType.Equip then
				arg_54_0._simagenormaldayrewardicon_gold:LoadImage(ResUrl.getPropItemIcon(var_54_2.icon))
				arg_54_0._simagemonthcarddayrewardicon_gold:LoadImage(ResUrl.getPropItemIcon(var_54_2.icon))
			end
		end
	else
		gohelper.setActive(arg_54_0._gonormaldayreward_gold, false)
		gohelper.setActive(arg_54_0._gomonthcarddayreward_gold, false)
	end
end

function var_0_0._showMonthRewardInfo(arg_55_0, arg_55_1)
	local var_55_0 = {
		rewardCo = SignInConfig.instance:getSignMonthReward(arg_55_1)
	}

	var_55_0.rewards = string.split(var_55_0.rewardCo.signinBonus, "|")
	var_55_0.reward = string.split(var_55_0.rewards[1], "#")

	local var_55_1, var_55_2 = ItemModel.instance:getItemConfigAndIcon(var_55_0.reward[1], var_55_0.reward[2])

	arg_55_0["_simagemonthicon" .. arg_55_1]:LoadImage(var_55_2)

	arg_55_0["_txtmonthquantity" .. arg_55_1].text = var_55_0.rewardCo.signinaddup
	arg_55_0["_txtrewardcount" .. arg_55_1].text = string.format("<size=22>%s</size>%s", luaLang("multiple"), var_55_0.reward[3])

	table.insert(arg_55_0._monthRewards, arg_55_1, var_55_0)
end

function var_0_0._setPropItems(arg_56_0)
	local var_56_0 = os.date("%d", os.time({
		day = 0,
		year = arg_56_0._targetDate[1],
		month = arg_56_0._targetDate[2] + 1
	}))
	local var_56_1 = {}

	for iter_56_0 = 1, tonumber(var_56_0) do
		local var_56_2 = string.splitToNumber(SignInConfig.instance:getSignRewards(iter_56_0).signinBonus, "#")
		local var_56_3 = {
			materilType = var_56_2[1],
			materilId = var_56_2[2],
			quantity = var_56_2[3]
		}

		var_56_3.isIcon = true
		var_56_3.parent = arg_56_0

		table.insert(var_56_1, var_56_3)
	end

	SignInListModel.instance:setPropList(var_56_1)
end

function var_0_0._setMonthItems(arg_57_0)
	local var_57_0 = SignInModel.instance:getShowMonthItemCo()

	arg_57_0:_onCloneSigninMonthItem(var_57_0)
end

function var_0_0._onCloneSigninMonthItem(arg_58_0, arg_58_1)
	for iter_58_0, iter_58_1 in ipairs(arg_58_1) do
		local var_58_0 = arg_58_0._monthItemTabs[iter_58_0]

		if not var_58_0 then
			var_58_0 = {
				go = gohelper.clone(arg_58_0._gosigninmonthitem, arg_58_0._gomonthitem, "item" .. iter_58_0)
			}
			var_58_0.anim = gohelper.findChild(var_58_0.go, "obj"):GetComponent(typeof(UnityEngine.Animator))
			var_58_0.anim.enabled = false

			gohelper.setActive(var_58_0.go, false)

			var_58_0.monthitem = MonoHelper.addNoUpdateLuaComOnceToGo(var_58_0.go, SignInMonthListItem, arg_58_0)

			table.insert(arg_58_0._monthItemTabs, var_58_0)
		end

		var_58_0.monthitem:init(var_58_0.go)
		var_58_0.monthitem:onUpdateMO(iter_58_1)
	end

	arg_58_0:_showSigninMonthItemEffect(arg_58_1)
end

function var_0_0._showSigninMonthItemEffect(arg_59_0, arg_59_1)
	for iter_59_0 = 1, #arg_59_1 do
		local function var_59_0()
			arg_59_0:_showMonthItem(iter_59_0)
		end

		TaskDispatcher.runDelay(var_59_0, arg_59_0, iter_59_0 * 0.03)
		table.insert(arg_59_0._delayAnimTab, var_59_0)
	end

	TaskDispatcher.runDelay(arg_59_0._onLineAniStart, arg_59_0, (#arg_59_1 + 1) * 0.1)
end

function var_0_0._showMonthItem(arg_61_0, arg_61_1)
	gohelper.setActive(arg_61_0._monthItemTabs[arg_61_1].go, true)

	arg_61_0._monthItemTabs[arg_61_1].anim.enabled = true
end

function var_0_0._showBirthdayRewardDetail(arg_62_0)
	gohelper.setActive(arg_62_0._gobirthdayrewarddetail, true)
	gohelper.setActive(arg_62_0._btnrewarddetailclose.gameObject, true)

	local var_62_0 = SignInModel.instance:getSignBirthdayHeros(arg_62_0._targetDate[1], arg_62_0._targetDate[2], arg_62_0._targetDate[3])

	if arg_62_0._curDate.year == arg_62_0._targetDate[1] and arg_62_0._curDate.month == arg_62_0._targetDate[2] and arg_62_0._curDate.day == arg_62_0._targetDate[3] then
		var_62_0 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local var_62_1 = arg_62_0:_getTextInputheros()

	if var_62_1 ~= "" then
		var_62_0 = string.splitToNumber(var_62_1, "|")
	end

	local var_62_2 = var_62_0[arg_62_0._index]
	local var_62_3 = SignInModel.instance:getHeroBirthdayCount(var_62_2)
	local var_62_4 = var_62_3

	if arg_62_0._curDate.month == arg_62_0._targetDate[2] then
		local var_62_5 = SignInModel.instance:isHeroBirthdayGet(var_62_2)

		if arg_62_0._curDate.year == arg_62_0._targetDate[1] then
			var_62_4 = var_62_5 and var_62_3 or var_62_3 + 1
		else
			var_62_4 = var_62_5 and var_62_3 - 1 or var_62_3
		end
	end

	if var_62_1 ~= "" then
		var_62_4 = arg_62_0._droptimes:GetValue() + 1
	end

	local var_62_6 = string.split(HeroConfig.instance:getHeroCO(var_62_2).birthdayBonus, ";")[var_62_4]
	local var_62_7 = string.split(var_62_6, "|")

	arg_62_0:_hideAllRewardTipsItem()

	for iter_62_0, iter_62_1 in ipairs(var_62_7) do
		if not arg_62_0._rewardTipItems[iter_62_0] then
			local var_62_8 = {
				go = gohelper.clone(arg_62_0._gorewarddetailitem, arg_62_0._gorewardContent, "item" .. iter_62_0)
			}
			local var_62_9 = gohelper.findChild(var_62_8.go, "icon")

			var_62_8.icon = IconMgr.instance:getCommonItemIcon(var_62_9)

			table.insert(arg_62_0._rewardTipItems, var_62_8)
		end

		gohelper.setActive(arg_62_0._rewardTipItems[iter_62_0].go, true)

		local var_62_10 = string.split(iter_62_1, "#")
		local var_62_11, var_62_12 = ItemModel.instance:getItemConfigAndIcon(var_62_10[1], var_62_10[2])

		arg_62_0._rewardTipItems[iter_62_0].icon:setMOValue(var_62_10[1], var_62_10[2], var_62_10[3], nil, true)
		arg_62_0._rewardTipItems[iter_62_0].icon:setScale(0.6)
		arg_62_0._rewardTipItems[iter_62_0].icon:isShowQuality(false)
		arg_62_0._rewardTipItems[iter_62_0].icon:isShowCount(false)

		gohelper.findChildText(arg_62_0._rewardTipItems[iter_62_0].go, "name").text = var_62_11.name
		gohelper.findChildText(arg_62_0._rewardTipItems[iter_62_0].go, "name/quantity").text = luaLang("multiple") .. var_62_10[3]
	end

	arg_62_0:_computeRewardsTipsContainerHeight(#var_62_7)
end

function var_0_0._hideAllRewardTipsItem(arg_63_0)
	for iter_63_0, iter_63_1 in ipairs(arg_63_0._rewardTipItems) do
		gohelper.setActive(iter_63_1.go, false)
	end
end

function var_0_0._computeRewardsTipsContainerHeight(arg_64_0, arg_64_1)
	local var_64_0 = recthelper.getHeight(arg_64_0._trstitle) + arg_64_1 * recthelper.getHeight(arg_64_0._gorewarddetailitem.transform) - 10

	recthelper.setHeight(arg_64_0._gocontentSize.transform, var_64_0)
end

function var_0_0._onLineAniStart(arg_65_0)
	gohelper.setActive(arg_65_0._gomonthleftline, true)
	gohelper.setActive(arg_65_0._gomonthrightline, true)
end

function var_0_0._setRedDot(arg_66_0)
	RedDotController.instance:addRedDot(arg_66_0._gomonthtip1, RedDotEnum.DotNode.SignInMonthTab, 1)
	RedDotController.instance:addRedDot(arg_66_0._gomonthtip2, RedDotEnum.DotNode.SignInMonthTab, 2)
	RedDotController.instance:addRedDot(arg_66_0._gomonthtip3, RedDotEnum.DotNode.SignInMonthTab, 3)
end

function var_0_0._switchFestivalDecoration(arg_67_0, arg_67_1)
	if arg_67_0._haveFestival == arg_67_1 then
		return
	end

	arg_67_0._haveFestival = arg_67_1

	arg_67_0:_refreshFestivalDecoration()
end

function var_0_0._refreshFestivalDecoration(arg_68_0)
	local var_68_0 = arg_68_0:haveFestival()

	gohelper.setActive(arg_68_0._gofestivaldecorationright, var_68_0)
	gohelper.setActive(arg_68_0._gofestivaldecorationleft, var_68_0)
	gohelper.setActive(arg_68_0._gofestivaldecorationtop, var_68_0)
	gohelper.setActive(arg_68_0._gorewardicon, not var_68_0)
	gohelper.setActive(arg_68_0._goeffect, var_68_0)
	gohelper.setActive(arg_68_0._godayrewarditem_festivaldecorationtop, var_68_0)
	gohelper.setActive(arg_68_0._godayrewarditem_gofestivaldecorationleft2, var_68_0)
	gohelper.setActive(arg_68_0._gobtnchange_gofestivaldecoration, var_68_0)
	gohelper.setActive(arg_68_0._gochange, not var_68_0)
	gohelper.setActive(arg_68_0._txtday, not var_68_0)
	gohelper.setActive(arg_68_0._txtdayfestival, var_68_0)
	arg_68_0:_setFestivalColor(arg_68_0._txtmonth)
	arg_68_0:_setFestivalColor(arg_68_0._imgbias)
	arg_68_0:_setFestivalColor(arg_68_0._txtday)
	arg_68_0:_setFestivalColor(arg_68_0._txtdate)
	arg_68_0._simagebg:LoadImage(ResUrl.getSignInBg(var_68_0 and "act_bg_white2" or "bg_white2"))
	arg_68_0._simagerewardbg:LoadImage(ResUrl.getSignInBg(var_68_0 and "act_img_di" or "img_di"))
end

function var_0_0.onClose(arg_69_0)
	TaskDispatcher.cancelTask(arg_69_0._setActive_LifeCircle, arg_69_0)
	TaskDispatcher.cancelTask(arg_69_0._onSwitchRewardAnim, arg_69_0)
	UIBlockHelper.instance:endBlock(var_0_2)

	if arg_69_0._lifeCircleSignView then
		arg_69_0._lifeCircleSignView:onClose()
	end

	arg_69_0:_removeCustomEvent()
end

function var_0_0.onDestroyView(arg_70_0)
	GameUtil.onDestroyViewMember(arg_70_0, "_lifeCircleSignView")
	UIBlockMgr.instance:endBlock("signshowing")
	SignInModel.instance:setNewSwitch(false)
	SignInListModel.instance:clearPropList()
	TaskDispatcher.cancelTask(arg_70_0._setView1Effect, arg_70_0)
	TaskDispatcher.cancelTask(arg_70_0._onLineAniStart, arg_70_0)
	TaskDispatcher.cancelTask(arg_70_0._delaySignInRequest, arg_70_0)
	TaskDispatcher.cancelTask(arg_70_0._showGetRewards, arg_70_0)
	TaskDispatcher.cancelTask(arg_70_0._onWaitSwitchBirthFinished, arg_70_0)

	for iter_70_0, iter_70_1 in pairs(arg_70_0._delayAnimTab) do
		TaskDispatcher.cancelTask(iter_70_1, arg_70_0)
	end

	arg_70_0._simagebg:UnLoadImage()
	arg_70_0._simagemonthicon1:UnLoadImage()
	arg_70_0._simagemonthicon2:UnLoadImage()
	arg_70_0._simagemonthicon3:UnLoadImage()
	arg_70_0._simagenormaldayrewardicon:UnLoadImage()
	arg_70_0._simageorangebg:UnLoadImage()
	arg_70_0._simagerewardbg:UnLoadImage()
	arg_70_0._simagebirthdaybg:UnLoadImage()
	arg_70_0._simagebirthdaybg2:UnLoadImage()
	arg_70_0._simagebirthdayIcon:UnLoadImage()

	if arg_70_0.viewParam and arg_70_0.viewParam.callback then
		arg_70_0.viewParam.callback(arg_70_0.viewParam.callbackObj)
	end
end

function var_0_0.closeThis(arg_71_0)
	var_0_0.super.closeThis(arg_71_0)
end

function var_0_0._getTextInputheros(arg_72_0)
	if arg_72_0._inputheros then
		return arg_72_0._inputheros:GetText()
	end

	return ""
end

function var_0_0.haveFestival(arg_73_0, arg_73_1)
	if arg_73_0._haveFestival == nil or arg_73_1 then
		arg_73_0._haveFestival = SignInModel.instance.checkFestivalDecorationUnlock()
	end

	return arg_73_0._haveFestival
end

function var_0_0._setFestivalColor(arg_74_0, arg_74_1)
	local var_74_0 = arg_74_0:haveFestival() and "#3D201A" or "#222222"

	SLFramework.UGUI.GuiHelper.SetColor(arg_74_1, var_74_0)
end

function var_0_0._btnchangeOnClick(arg_75_0)
	arg_75_0:_setActive_LifeCicle(not arg_75_0._isActiveLifeCircle)
end

function var_0_0._setActive_LifeCicle(arg_76_0, arg_76_1)
	gohelper.setActive(arg_76_0._gomonth, not arg_76_1)

	if arg_76_0._isActiveLifeCircle == arg_76_1 then
		return
	end

	arg_76_0._isActiveLifeCircle = arg_76_1

	if arg_76_1 then
		arg_76_0:_refreshLifeCircleView()
	end

	if arg_76_0._lifeCircleSignView then
		arg_76_0:_switchLifeCircleAnsSignIn(arg_76_1)
	else
		arg_76_0:_setActive_LifeCircle(arg_76_1)
	end
end

function var_0_0._refreshLifeCircleView(arg_77_0)
	local var_77_0 = arg_77_0._lifeCircleSignView

	if not var_77_0 then
		var_77_0 = LifeCircleSignView.New({
			parent = arg_77_0,
			baseViewContainer = arg_77_0.viewContainer
		})

		local var_77_1 = arg_77_0.viewContainer:getResInst(SignInEnum.ResPath.lifecirclesignview, arg_77_0._goLifeCircle)

		var_77_0:init(var_77_1)
		var_77_0:onOpen()

		arg_77_0._lifeCircleSignView = var_77_0
	else
		var_77_0:onUpdateParam()
	end
end

function var_0_0._switchLifeCircleAnsSignIn(arg_78_0, arg_78_1)
	TaskDispatcher.cancelTask(arg_78_0._setActive_LifeCircle, arg_78_0)
	UIBlockHelper.instance:endBlock(var_0_2)

	if arg_78_1 then
		arg_78_0:_playAnim("switch_reward")
		TaskDispatcher.runDelay(arg_78_0._onSwitchRewardAnim, arg_78_0, 0.16)
	else
		UIBlockHelper.instance:startBlock(var_0_2, 2, arg_78_0.viewName)
		arg_78_0:_playAnim("switch_main")
		TaskDispatcher.runDelay(arg_78_0._setActive_LifeCircle, arg_78_0, 0.16)
	end
end

function var_0_0._setActive_LifeCircle(arg_79_0, arg_79_1)
	gohelper.setActive(arg_79_0._goLifeCircle, arg_79_1 and true or false)
	gohelper.setActive(arg_79_0._btnchangeGo, arg_79_1)
	gohelper.setActive(arg_79_0._btnchange2Go, not arg_79_1)

	if arg_79_1 then
		arg_79_0:_switchFestivalDecoration(false)
	else
		if arg_79_0._haveFestival ~= arg_79_0:haveFestival(true) then
			arg_79_0:_refreshFestivalDecoration()
		end

		UIBlockHelper.instance:endBlock(var_0_2)
	end
end

function var_0_0._checkLifeCircleRed(arg_80_0, arg_80_1)
	arg_80_1.show = LifeCircleController.instance:isShowRed()

	arg_80_1:showRedDot(RedDotEnum.Style.Normal)
end

function var_0_0._onSwitchRewardAnim(arg_81_0)
	arg_81_0:_setActive_LifeCircle(true)
end

function var_0_0._playAnim(arg_82_0, arg_82_1, arg_82_2, arg_82_3)
	arg_82_0._viewAnimPlayer:Play(arg_82_1, arg_82_2 or function()
		return
	end, arg_82_3)
end

return var_0_0

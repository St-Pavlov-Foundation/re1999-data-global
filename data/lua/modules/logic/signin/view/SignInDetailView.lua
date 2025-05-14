module("modules.logic.signin.view.SignInDetailView", package.seeall)

local var_0_0 = class("SignInDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._imagesignature = gohelper.findChildImage(arg_1_0.viewGO, "bg/#image_signature")
	arg_1_0._goroleitem = gohelper.findChild(arg_1_0.viewGO, "bg/#go_roleitem")
	arg_1_0._simagetopicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#go_roleitem/#simage_topicon")
	arg_1_0._goicontip = gohelper.findChild(arg_1_0.viewGO, "bg/#go_roleitem/#go_icontip")
	arg_1_0._txtbirtime = gohelper.findChildText(arg_1_0.viewGO, "bg/#go_roleitem/#txt_birtime")
	arg_1_0._txtlimit = gohelper.findChildText(arg_1_0.viewGO, "bg/#go_roleitem/#txt_limit")
	arg_1_0._txtmonth = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_month")
	arg_1_0._txtday = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_day")
	arg_1_0._imageweek = gohelper.findChildImage(arg_1_0.viewGO, "content/#image_week")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "content/scroll_desc/Viewport/Content/#txt_desc")
	arg_1_0._simageorangebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#simage_orangebg")
	arg_1_0._gobirthdayrewarditem = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem")
	arg_1_0._simagebirthdaybg = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#simage_birthdaybg")
	arg_1_0._simagebirthdaybg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#simage_birthdaybg2")
	arg_1_0._gobirthday = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#simage_icon")
	arg_1_0._btngift = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#btn_gift")
	arg_1_0._gogiftnoget = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_noget")
	arg_1_0._gogiftget = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_get")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_reddot")
	arg_1_0._txtmonthtitle = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/monthtitle")
	arg_1_0._txtdeco = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/scrollview/viewport/#txt_deco")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#simage_signature")
	arg_1_0._gobirthdayrewarddetail = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail")
	arg_1_0._gocontentSize = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize")
	arg_1_0._trstitle = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/bg/title").transform
	arg_1_0._txtrewarddetailtitle = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/bg/title/#txt_rewarddetailtitle")
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/Viewport/Content")
	arg_1_0._gorewarddetailitem = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/#go_rewarddetailItem")
	arg_1_0._godayrewarditem = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem")
	arg_1_0._simagerewardbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#simage_rewardbg")
	arg_1_0._gototalreward = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward")
	arg_1_0._txtdaycount = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/monthtitle/#txt_daycount")
	arg_1_0._gomonth1 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1")
	arg_1_0._monthreward1Click = gohelper.getClick(arg_1_0._gomonth1)
	arg_1_0._gomonthmask1 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1")
	arg_1_0._month1canvasGroup = arg_1_0._gomonthmask1:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._gogetmonthbg1 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#go_getmonthbg1")
	arg_1_0._gorewardmark1 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#go_rewardmark1")
	arg_1_0._simagemonthicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#simage_monthicon1")
	arg_1_0._month1Ani = arg_1_0._simagemonthicon1.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtmonthquantity1 = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#txt_monthquantity1")
	arg_1_0._txtmonthrewardcount1 = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#txt_monthrewardcount1")
	arg_1_0._gomonthtip1 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthtip1")
	arg_1_0._gomonthget1 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthget1")
	arg_1_0._gonomonthget1 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_nomonthget1")
	arg_1_0._gomonth2 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2")
	arg_1_0._monthreward2Click = gohelper.getClick(arg_1_0._gomonth2)
	arg_1_0._gomonthmask2 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2")
	arg_1_0._month2canvasGroup = arg_1_0._gomonthmask2:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._gogetmonthbg2 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#go_getmonthbg2")
	arg_1_0._gorewardmark2 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#go_rewardmark2")
	arg_1_0._simagemonthicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#simage_monthicon2")
	arg_1_0._month2Ani = arg_1_0._simagemonthicon2.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtmonthquantity2 = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#txt_monthquantity2")
	arg_1_0._txtmonthrewardcount2 = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#txt_monthrewardcount2")
	arg_1_0._gomonthtip2 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthtip2")
	arg_1_0._gomonthget2 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthget2")
	arg_1_0._gonomonthget2 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_nomonthget2")
	arg_1_0._gomonth3 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3")
	arg_1_0._monthreward3Click = gohelper.getClick(arg_1_0._gomonth3)
	arg_1_0._gomonthmask3 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3")
	arg_1_0._month3canvasGroup = arg_1_0._gomonthmask3:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._gogetmonthbg3 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#go_getmonthbg3")
	arg_1_0._gorewardmark3 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#go_rewardmark3")
	arg_1_0._simagemonthicon3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#simage_monthicon3")
	arg_1_0._month3Ani = arg_1_0._simagemonthicon3.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtmonthquantity3 = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#txt_monthquantity3")
	arg_1_0._txtmonthrewardcount3 = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#txt_monthrewardcount3")
	arg_1_0._gomonthtip3 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthtip3")
	arg_1_0._gomonthget3 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthget3")
	arg_1_0._gonomonthget3 = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_nomonthget3")
	arg_1_0._gocurrentreward = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal")
	arg_1_0._gonormaldayreward = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward")
	arg_1_0._gonormalday = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday")
	arg_1_0._normaldayClick = gohelper.getClick(arg_1_0._gonormalday)
	arg_1_0._gonormalday_gold = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday")
	arg_1_0._normaldayClick_gold = gohelper.getClick(arg_1_0._gonormalday_gold)
	arg_1_0._txtnormaldayrewardname = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#txt_normaldayrewardname")
	arg_1_0._simagenormaldayrewardicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#simage_normaldayrewardicon")
	arg_1_0._normaldayrewardAni = arg_1_0._simagenormaldayrewardicon.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtnormaldayrewardcount = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#simage_normaldayrewardicon/#txt_normaldayrewardcount")
	arg_1_0._gonormaldaysigned = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned")
	arg_1_0._gonormaldayget = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned/#go_normaldayget")
	arg_1_0._gonormaldaynoget = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned/#go_normaldaynoget")
	arg_1_0._gonormaldayreward_gold = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2")
	arg_1_0._txtnormaldayrewardname_gold = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#txt_normaldayrewardname")
	arg_1_0._simagenormaldayrewardicon_gold = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#simage_normaldayrewardicon")
	arg_1_0._normaldayrewardAni_gold = arg_1_0._simagenormaldayrewardicon_gold.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtnormaldayrewardcount_gold = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#simage_normaldayrewardicon/#txt_normaldayrewardcount")
	arg_1_0._gonormaldaysigned_gold = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned")
	arg_1_0._gonormaldayget_gold = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned/#go_normaldayget")
	arg_1_0._gonormaldaynoget_gold = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned/#go_normaldaynoget")
	arg_1_0._normaldayrewardAni_gold = arg_1_0._simagenormaldayrewardicon_gold.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gomonthcard = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard")
	arg_1_0._gomonthcarddayreward = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward")
	arg_1_0._gomonthcardday = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday")
	arg_1_0._monthcarddayClick = gohelper.getClick(arg_1_0._gomonthcardday)
	arg_1_0._gomonthcardday_gold = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday")
	arg_1_0._monthcarddayClick_gold = gohelper.getClick(arg_1_0._gomonthcardday_gold)
	arg_1_0._txtmonthcarddayrewardname = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#txt_monthcarddayrewardname")
	arg_1_0._simagemonthcarddayrewardicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#simage_monthcarddayrewardicon")
	arg_1_0._monthcarddayrewardAni = arg_1_0._simagemonthcarddayrewardicon.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtmonthcarddayrewardcount = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#simage_monthcarddayrewardicon/#txt_monthcarddayrewardcount")
	arg_1_0._gomonthcarddaysigned = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned")
	arg_1_0._gomonthcarddayget = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned/#go_monthcarddayget")
	arg_1_0._gomonthcarddaynoget = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned/#go_monthcarddaynoget")
	arg_1_0._gomonthcarddayreward_gold = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2")
	arg_1_0._txtmonthcarddayrewardname_gold = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#txt_monthcarddayrewardname")
	arg_1_0._simagemonthcarddayrewardicon_gold = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#simage_monthcarddayrewardicon")
	arg_1_0._monthcarddayrewardAni_gold = arg_1_0._simagemonthcarddayrewardicon_gold.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtmonthcarddayrewardcount_gold = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#simage_monthcarddayrewardicon/#txt_monthcarddayrewardcount")
	arg_1_0._gomonthcarddaysigned_gold = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned")
	arg_1_0._gomonthcarddayget_gold = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned/#go_monthcarddayget")
	arg_1_0._gomonthcarddaynoget_gold = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned/#go_monthcarddaynoget")
	arg_1_0._gomonthcardreward = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward")
	arg_1_0._gomonthcardrewarditem = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem")
	arg_1_0._txtmonthcardname = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#txt_monthcardname")
	arg_1_0._simagemonthcardicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#simage_monthcardicon")
	arg_1_0._monthcardClick = gohelper.getClick(arg_1_0._gomonthcardrewarditem.gameObject)
	arg_1_0._gomonthcardpowerrewarditem = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem")
	arg_1_0._txtmonthcardcount = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#simage_monthcardicon/#txt_monthcardcount")
	arg_1_0._txtmonthcardpowername = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#txt_monthcardname")
	arg_1_0._simagemonthcardpowericon = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#simage_monthcardicon")
	arg_1_0._monthcardpowerClick = gohelper.getClick(arg_1_0._gomonthcardpowerrewarditem.gameObject)
	arg_1_0._txtmonthcardpowercount = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#simage_monthcardicon/#txt_monthcardcount")
	arg_1_0._golimittime = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/#txt_limittime")
	arg_1_0._gonormallimittimebg = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/normalbg")
	arg_1_0._goredlimittimebg = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/redbg")
	arg_1_0._gomonthcardsigned = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned")
	arg_1_0._gomonthcardget = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardget")
	arg_1_0._gomonthcardnoget = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardnoget")
	arg_1_0._gomonthcardpowernoget = gohelper.findChild(arg_1_0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardpowernoget")
	arg_1_0._btnqiehuan = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/#btn_qiehuan")
	arg_1_0._goqiehuan = gohelper.findChild(arg_1_0.viewGO, "content/#btn_qiehuan/#qiehuan")
	arg_1_0._btncalendar = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_calendar")
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._gonodes = gohelper.findChild(arg_1_0.viewGO, "#go_nodes")
	arg_1_0._gonodeitem = gohelper.findChild(arg_1_0.viewGO, "#go_nodes/#go_nodeitem")
	arg_1_0._btnrewarddetailclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_rewarddetailclose")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gofestivaldecorationtop = gohelper.findChild(arg_1_0.viewGO, "bg/#go_festivalDecorationTop")
	arg_1_0._gofestivaldecorationbottom = gohelper.findChild(arg_1_0.viewGO, "content/#go_festivalDecorationBottom")
	arg_1_0._gorewardicon = gohelper.findChild(arg_1_0.viewGO, "bg/#go_rewardicon")
	arg_1_0._imgbias = gohelper.findChildImage(arg_1_0.viewGO, "content/#image_bias")
	arg_1_0._viewAnim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._viewAniEventWrap = arg_1_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	arg_1_0._goeffect = gohelper.findChild(arg_1_0.viewGO, "#go_effect")

	local var_1_0 = GMController.instance:getGMNode("signindetailview", gohelper.findChild(arg_1_0.viewGO, "content"))

	if var_1_0 then
		arg_1_0._btnswitchdecorate = gohelper.findChildButtonWithAudio(var_1_0, "#_btns_switchdecorate")
	end

	arg_1_0._godayrewarditem_image3 = gohelper.findChild(arg_1_0._godayrewarditem, "image3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngift:AddClickListener(arg_2_0._btngiftOnClick, arg_2_0)
	arg_2_0._btnqiehuan:AddClickListener(arg_2_0._btnqiehuanOnClick, arg_2_0)
	arg_2_0._btnrewarddetailclose:AddClickListener(arg_2_0._onBtnRewardDetailClick, arg_2_0)
	arg_2_0._btncalendar:AddClickListener(arg_2_0._btncalendarOnClick, arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)

	if arg_2_0._btnswitchdecorate then
		arg_2_0._btnswitchdecorate:AddClickListener(arg_2_0._onBtnChangeDecorate, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngift:RemoveClickListener()
	arg_3_0._btnqiehuan:RemoveClickListener()
	arg_3_0._btnrewarddetailclose:RemoveClickListener()
	arg_3_0._btncalendar:RemoveClickListener()
	arg_3_0._btncloseview:RemoveClickListener()

	if arg_3_0._btnswitchdecorate then
		arg_3_0._btnswitchdecorate:RemoveClickListener()
	end
end

function var_0_0._onBtnChangeDecorate(arg_4_0)
	arg_4_0:_switchFestivalDecoration(not arg_4_0._haveFestival)
end

function var_0_0._btngiftOnClick(arg_5_0)
	local var_5_0 = SignInModel.instance:getSignBirthdayHeros(arg_5_0._targetDate[1], arg_5_0._targetDate[2], arg_5_0._targetDate[3])

	if arg_5_0._curDate.year == arg_5_0._targetDate[1] and arg_5_0._curDate.month == arg_5_0._targetDate[2] and arg_5_0._curDate.day == arg_5_0._targetDate[3] then
		local var_5_1 = SignInModel.instance:getCurDayBirthdayHeros()[arg_5_0._index]

		if not SignInModel.instance:isHeroBirthdayGet(var_5_1) then
			arg_5_0._startGetReward = true

			SignInRpc.instance:sendGetHeroBirthdayRequest(var_5_1)

			return
		end
	end

	arg_5_0:_showBirthdayRewardDetail()
end

function var_0_0._showBirthdayRewardDetail(arg_6_0)
	gohelper.setActive(arg_6_0._gobirthdayrewarddetail, true)
	gohelper.setActive(arg_6_0._btnrewarddetailclose.gameObject, true)

	local var_6_0 = SignInModel.instance:getSignBirthdayHeros(arg_6_0._targetDate[1], arg_6_0._targetDate[2], arg_6_0._targetDate[3])

	if arg_6_0._curDate.year == arg_6_0._targetDate[1] and arg_6_0._curDate.month == arg_6_0._targetDate[2] and arg_6_0._curDate.day == arg_6_0._targetDate[3] then
		var_6_0 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local var_6_1 = var_6_0[arg_6_0._index]
	local var_6_2 = SignInModel.instance:getHeroBirthdayCount(var_6_1)
	local var_6_3 = var_6_2

	if arg_6_0._curDate.month == arg_6_0._targetDate[2] then
		local var_6_4 = SignInModel.instance:isHeroBirthdayGet(var_6_1)

		if arg_6_0._curDate.year == arg_6_0._targetDate[1] then
			var_6_3 = var_6_4 and var_6_2 or var_6_2 + 1
		else
			var_6_3 = var_6_4 and var_6_2 - 1 or var_6_2
		end
	end

	local var_6_5 = string.split(HeroConfig.instance:getHeroCO(var_6_1).birthdayBonus, ";")[var_6_3]
	local var_6_6 = string.split(var_6_5, "|")

	arg_6_0:_hideAllRewardTipsItem()

	for iter_6_0, iter_6_1 in ipairs(var_6_6) do
		if not arg_6_0._rewardTipItems[iter_6_0] then
			local var_6_7 = {
				go = gohelper.clone(arg_6_0._gorewarddetailitem, arg_6_0._gorewardcontent, "item" .. iter_6_0)
			}
			local var_6_8 = gohelper.findChild(var_6_7.go, "icon")

			var_6_7.icon = IconMgr.instance:getCommonItemIcon(var_6_8)

			table.insert(arg_6_0._rewardTipItems, var_6_7)
		end

		gohelper.setActive(arg_6_0._rewardTipItems[iter_6_0].go, true)

		local var_6_9 = string.split(iter_6_1, "#")
		local var_6_10, var_6_11 = ItemModel.instance:getItemConfigAndIcon(var_6_9[1], var_6_9[2])

		arg_6_0._rewardTipItems[iter_6_0].icon:setMOValue(var_6_9[1], var_6_9[2], var_6_9[3], nil, true)
		arg_6_0._rewardTipItems[iter_6_0].icon:setScale(0.6)
		arg_6_0._rewardTipItems[iter_6_0].icon:isShowQuality(false)
		arg_6_0._rewardTipItems[iter_6_0].icon:isShowCount(false)

		gohelper.findChildText(arg_6_0._rewardTipItems[iter_6_0].go, "name").text = var_6_10.name
		gohelper.findChildText(arg_6_0._rewardTipItems[iter_6_0].go, "name/quantity").text = luaLang("multiple") .. var_6_9[3]
	end

	arg_6_0:_computeRewardsTipsContainerHeight(#var_6_6)
end

function var_0_0._hideAllRewardTipsItem(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._rewardTipItems) do
		gohelper.setActive(iter_7_1.go, false)
	end
end

function var_0_0._computeRewardsTipsContainerHeight(arg_8_0, arg_8_1)
	local var_8_0 = recthelper.getHeight(arg_8_0._trstitle) + arg_8_1 * recthelper.getHeight(arg_8_0._gorewarddetailitem.transform) - 10

	recthelper.setHeight(arg_8_0._gocontentSize.transform, var_8_0)
end

function var_0_0._btnqiehuanOnClick(arg_9_0)
	local var_9_0 = SignInModel.instance:getSignBirthdayHeros(arg_9_0._targetDate[1], arg_9_0._targetDate[2], arg_9_0._targetDate[3])

	if arg_9_0._curDate.year == arg_9_0._targetDate[1] and arg_9_0._curDate.month == arg_9_0._targetDate[2] and arg_9_0._curDate.day == arg_9_0._targetDate[3] then
		var_9_0 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	arg_9_0._index = (arg_9_0._index + 1) % (#var_9_0 + 1)

	UIBlockMgr.instance:startBlock("signshowing")
	TaskDispatcher.runDelay(arg_9_0._onQiehuanFinished, arg_9_0, 0.85)

	if arg_9_0._index == 1 then
		arg_9_0:_setRewardItems()
		arg_9_0._viewAnim:Play("tobirthday", 0, 0)
	elseif arg_9_0._index > 1 then
		arg_9_0._viewAnim:Play("birthtobirth", 0, 0)
	else
		arg_9_0._viewAnim:Play("tonormal", 0, 0)
	end
end

function var_0_0._onQiehuanFinished(arg_10_0)
	UIBlockMgr.instance:endBlock("signshowing")
end

function var_0_0._btncalendarOnClick(arg_11_0)
	arg_11_0._viewAnim:Play("out")
	TaskDispatcher.runDelay(arg_11_0._waitOpenSignInView, arg_11_0, 0.2)
end

function var_0_0._waitOpenSignInView(arg_12_0)
	SignInController.instance:openSignInView(arg_12_0.viewParam)
	arg_12_0:closeThis()
end

function var_0_0._btncloseviewOnClick(arg_13_0)
	arg_13_0:_onEscapeBtnClick()
end

function var_0_0._onBtnRewardDetailClick(arg_14_0)
	gohelper.setActive(arg_14_0._btnrewarddetailclose.gameObject, false)
	gohelper.setActive(arg_14_0._gobirthdayrewarddetail, false)
end

function var_0_0._addCustomEvent(arg_15_0)
	arg_15_0._monthreward1Click:AddClickListener(arg_15_0._onMonthRewardClick, arg_15_0, 1)
	arg_15_0._monthreward2Click:AddClickListener(arg_15_0._onMonthRewardClick, arg_15_0, 2)
	arg_15_0._monthreward3Click:AddClickListener(arg_15_0._onMonthRewardClick, arg_15_0, 3)
	arg_15_0._normaldayClick:AddClickListener(arg_15_0._onDayRewardClick, arg_15_0)
	arg_15_0._monthcarddayClick:AddClickListener(arg_15_0._onDayRewardClick, arg_15_0)
	arg_15_0._normaldayClick_gold:AddClickListener(arg_15_0._onDayGoldRewardClick, arg_15_0)
	arg_15_0._monthcarddayClick_gold:AddClickListener(arg_15_0._onDayGoldRewardClick, arg_15_0)
	arg_15_0._monthcardClick:AddClickListener(arg_15_0._onMonthCardRewardClick, arg_15_0)
	arg_15_0._monthcardpowerClick:AddClickListener(arg_15_0._onMonthCardPowerRewardClick, arg_15_0)
	arg_15_0._viewAniEventWrap:AddEventListener("changetobirthday", arg_15_0._onChangeToBirthday, arg_15_0)
	arg_15_0._viewAniEventWrap:AddEventListener("changetonormal", arg_15_0._onChangeToNormal, arg_15_0)
	arg_15_0._viewAniEventWrap:AddEventListener("birthdaytobirthday", arg_15_0._onChangeBirthdayToBirthday, arg_15_0)
	SignInController.instance:registerCallback(SignInEvent.GetSignInInfo, arg_15_0._onGetSignInInfo, arg_15_0)
	SignInController.instance:registerCallback(SignInEvent.GetSignInReply, arg_15_0._onGetSignInReply, arg_15_0)
	SignInController.instance:registerCallback(SignInEvent.GetSignInAddUp, arg_15_0._setMonthView, arg_15_0)
	SignInController.instance:registerCallback(SignInEvent.SignInItemClick, arg_15_0._onChangeItemClick, arg_15_0)
	SignInController.instance:registerCallback(SignInEvent.ClickSignInMonthItem, arg_15_0._closeViewEffect, arg_15_0)
	SignInController.instance:registerCallback(SignInEvent.GetHeroBirthday, arg_15_0._onGetHeroBirthday, arg_15_0)
	SignInController.instance:registerCallback(SignInEvent.CloseSignInDetailView, arg_15_0._onEscapeBtnClick, arg_15_0)
	PlayerController.instance:registerCallback(PlayerEvent.OnDailyRefresh, arg_15_0._onDailyRefresh, arg_15_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_15_0._onCloseViewFinish, arg_15_0)
end

function var_0_0._removeCustomEvent(arg_16_0)
	arg_16_0._monthreward1Click:RemoveClickListener()
	arg_16_0._monthreward2Click:RemoveClickListener()
	arg_16_0._monthreward3Click:RemoveClickListener()
	arg_16_0._normaldayClick:RemoveClickListener()
	arg_16_0._monthcarddayClick:RemoveClickListener()
	arg_16_0._normaldayClick_gold:RemoveClickListener()
	arg_16_0._monthcarddayClick_gold:RemoveClickListener()
	arg_16_0._monthcardClick:RemoveClickListener()
	arg_16_0._monthcardpowerClick:RemoveClickListener()
	arg_16_0._viewAniEventWrap:RemoveAllEventListener()
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInInfo, arg_16_0._onGetSignInInfo, arg_16_0)
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInReply, arg_16_0._onGetSignInReply, arg_16_0)
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInAddUp, arg_16_0._setMonthView, arg_16_0)
	SignInController.instance:unregisterCallback(SignInEvent.SignInItemClick, arg_16_0._onChangeItemClick, arg_16_0)
	SignInController.instance:unregisterCallback(SignInEvent.ClickSignInMonthItem, arg_16_0._closeViewEffect, arg_16_0)
	SignInController.instance:unregisterCallback(SignInEvent.GetHeroBirthday, arg_16_0._onGetHeroBirthday, arg_16_0)
	SignInController.instance:unregisterCallback(SignInEvent.CloseSignInDetailView, arg_16_0._onEscapeBtnClick, arg_16_0)
	PlayerController.instance:unregisterCallback(PlayerEvent.OnDailyRefresh, arg_16_0._onDailyRefresh, arg_16_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_16_0._onCloseViewFinish, arg_16_0)
end

function var_0_0._onEscapeBtnClick(arg_17_0)
	arg_17_0._viewAnim:Play("out")
	TaskDispatcher.runDelay(arg_17_0.clickCloseView, arg_17_0, 0.2)
end

function var_0_0.clickCloseView(arg_18_0)
	if arg_18_0.viewParam and arg_18_0.viewParam.callback then
		arg_18_0.viewParam.callback(arg_18_0.viewParam.callbackObj)
	end

	arg_18_0:closeThis()
end

function var_0_0._editableInitView(arg_19_0)
	gohelper.addUIClickAudio(arg_19_0._btnqiehuan.gameObject, AudioEnum.UI.play_ui_sign_in_qiehuan)
	gohelper.setActive(arg_19_0._gomonthget1, false)
	gohelper.setActive(arg_19_0._gonomonthget1, false)
	gohelper.setActive(arg_19_0._gomonthget2, false)
	gohelper.setActive(arg_19_0._gonomonthget2, false)
	gohelper.setActive(arg_19_0._gomonthget3, false)
	gohelper.setActive(arg_19_0._gonomonthget3, false)
	gohelper.setActive(arg_19_0._gonormaldaysigned, false)
	gohelper.setActive(arg_19_0._gonormaldaysigned_gold, false)
	gohelper.setActive(arg_19_0._gomonthcarddaysigned, false)
	gohelper.setActive(arg_19_0._gomonthcarddaysigned_gold, false)
	gohelper.setActive(arg_19_0._gomonthcardsigned, false)
	arg_19_0._normaldayrewardAni:Play("none")
	arg_19_0._normaldayrewardAni_gold:Play("none")
	arg_19_0._monthcarddayrewardAni:Play("none")
	arg_19_0._monthcarddayrewardAni_gold:Play("none")

	arg_19_0._gogetmonthbgs = arg_19_0:getUserDataTb_()

	table.insert(arg_19_0._gogetmonthbgs, arg_19_0._gogetmonthbg1)
	table.insert(arg_19_0._gogetmonthbgs, arg_19_0._gogetmonthbg2)
	table.insert(arg_19_0._gogetmonthbgs, arg_19_0._gogetmonthbg3)

	arg_19_0._gomonthmasks = arg_19_0:getUserDataTb_()

	table.insert(arg_19_0._gomonthmasks, arg_19_0._gomonthmask1)
	table.insert(arg_19_0._gomonthmasks, arg_19_0._gomonthmask2)
	table.insert(arg_19_0._gomonthmasks, arg_19_0._gomonthmask3)

	arg_19_0._gomonthgets = arg_19_0:getUserDataTb_()

	table.insert(arg_19_0._gomonthgets, arg_19_0._gomonthget1)
	table.insert(arg_19_0._gomonthgets, arg_19_0._gomonthget2)
	table.insert(arg_19_0._gomonthgets, arg_19_0._gomonthget3)

	arg_19_0._gonomonthgets = arg_19_0:getUserDataTb_()

	table.insert(arg_19_0._gonomonthgets, arg_19_0._gonomonthget1)
	table.insert(arg_19_0._gonomonthgets, arg_19_0._gonomonthget2)
	table.insert(arg_19_0._gonomonthgets, arg_19_0._gonomonthget3)
	arg_19_0._simagebg:LoadImage(ResUrl.getSignInBg("bg_white"))
	arg_19_0._simageorangebg:LoadImage(ResUrl.getSignInBg("img_bcard3"))
	arg_19_0._simagerewardbg:LoadImage(ResUrl.getSignInBg("img_di"))

	arg_19_0._rewardTipItems = {}
	arg_19_0._nodeItems = {}
	arg_19_0._monthgetlightanimTab = arg_19_0:getUserDataTb_()
	arg_19_0._delayAnimTab = arg_19_0:getUserDataTb_()
	arg_19_0._monthRewards = arg_19_0:getUserDataTb_()

	table.insert(arg_19_0._monthgetlightanimTab, arg_19_0._gomonthgetlightanim1)
	table.insert(arg_19_0._monthgetlightanimTab, arg_19_0._gomonthgetlightanim2)
	table.insert(arg_19_0._monthgetlightanimTab, arg_19_0._gomonthgetlightanim3)

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._monthgetlightanimTab) do
		gohelper.setActive(iter_19_1, false)
	end
end

function var_0_0.onOpen(arg_20_0)
	if arg_20_0.viewParam.back then
		arg_20_0._viewAnim:Play("AutoIn")
	else
		arg_20_0._viewAnim:Play("NormalIn")
	end

	arg_20_0._index = 0
	arg_20_0._checkSignIn = true

	arg_20_0:_setMonthView(true)
	arg_20_0:_setRedDot()
	arg_20_0:_addCustomEvent()
	NavigateMgr.instance:addEscape(ViewName.SignInDetailView, arg_20_0._onEscapeBtnClick, arg_20_0)
	arg_20_0:_refreshFestivalDecoration()
end

function var_0_0._onDailyRefresh(arg_21_0)
	arg_21_0._index = 0
	arg_21_0._checkSignIn = true

	gohelper.setActive(arg_21_0._gomonthget1, false)
	gohelper.setActive(arg_21_0._gonomonthget1, false)
	gohelper.setActive(arg_21_0._gomonthget2, false)
	gohelper.setActive(arg_21_0._gonomonthget2, false)
	gohelper.setActive(arg_21_0._gomonthget3, false)
	gohelper.setActive(arg_21_0._gonomonthget3, false)
	gohelper.setActive(arg_21_0._gonormaldaysigned, false)
	gohelper.setActive(arg_21_0._gonormaldaysigned_gold, false)
	gohelper.setActive(arg_21_0._gomonthcarddaysigned, false)
	gohelper.setActive(arg_21_0._gomonthcarddaysigned_gold, false)
	gohelper.setActive(arg_21_0._gomonthcardsigned, false)
	gohelper.setActive(arg_21_0._gonormaldayget, false)
	gohelper.setActive(arg_21_0._gonormaldayget_gold, false)
	gohelper.setActive(arg_21_0._gomonthcardget, false)
	gohelper.setActive(arg_21_0._gomonthcarddayget, false)
	gohelper.setActive(arg_21_0._gomonthcarddayget_gold, false)
	gohelper.setActive(arg_21_0._gonormaldaynoget, false)
	gohelper.setActive(arg_21_0._gomonthcardnoget, false)
	gohelper.setActive(arg_21_0._gomonthcardpowernoget, false)
	gohelper.setActive(arg_21_0._gomonthcarddaynoget, false)
	gohelper.setActive(arg_21_0._gomonthcarddaynoget_gold, false)
	arg_21_0:_setMonthView()
end

function var_0_0._onChangeItemClick(arg_22_0, arg_22_1)
	arg_22_0.currentSelectMaterialType = arg_22_1.materilType
	arg_22_0.currentSelectMaterialId = arg_22_1.materilId

	if tonumber(arg_22_1.materilType) == MaterialEnum.MaterialType.Equip then
		local var_22_0, var_22_1 = ItemModel.instance:getItemConfigAndIcon(arg_22_1.materilType, arg_22_1.materilId, true)
	end
end

function var_0_0._onMonthCardRewardClick(arg_23_0)
	MaterialTipController.instance:showMaterialInfo(arg_23_0._curmonthCardRewards[1], arg_23_0._curmonthCardRewards[2])
end

function var_0_0._onMonthCardPowerRewardClick(arg_24_0)
	MaterialTipController.instance:showMaterialInfo(arg_24_0._curmonthCardPower[1], arg_24_0._curmonthCardPower[2])
end

function var_0_0._onChangeToBirthday(arg_25_0)
	gohelper.setSiblingBefore(arg_25_0._godayrewarditem, arg_25_0._gobirthdayrewarditem)
end

function var_0_0._onChangeToNormal(arg_26_0)
	arg_26_0:_setRewardItems()
	gohelper.setSiblingBefore(arg_26_0._gobirthdayrewarditem, arg_26_0._godayrewarditem)
end

function var_0_0._onChangeBirthdayToBirthday(arg_27_0)
	arg_27_0:_setRewardItems()
end

function var_0_0._onGetSignInInfo(arg_28_0)
	arg_28_0:_setMonthView()
end

function var_0_0._onGetSignInReply(arg_29_0)
	arg_29_0:_setMonthView()
end

function var_0_0._onGetHeroBirthday(arg_30_0)
	local var_30_0 = SignInModel.instance:getSignBirthdayHeros(arg_30_0._targetDate[1], arg_30_0._targetDate[2], arg_30_0._targetDate[3])

	if arg_30_0._curDate.year == arg_30_0._targetDate[1] and arg_30_0._curDate.month == arg_30_0._targetDate[2] and arg_30_0._curDate.day == arg_30_0._targetDate[3] then
		var_30_0 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local var_30_1 = false

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		if not SignInModel.instance:isHeroBirthdayGet(iter_30_1) then
			var_30_1 = true
		end
	end

	gohelper.setActive(arg_30_0._goqiehuan, var_30_1)
	gohelper.setActive(arg_30_0._gogiftnoget, false)
	gohelper.setActive(arg_30_0._gogiftget, true)
end

function var_0_0._closeViewEffect(arg_31_0)
	arg_31_0._clickMonth = true
	arg_31_0._index = 0

	arg_31_0._viewAnim:Play("idel")
	arg_31_0:_setMonthView()
	gohelper.setSiblingBefore(arg_31_0._gobirthdayrewarditem, arg_31_0._godayrewarditem)
end

function var_0_0._setMonthView(arg_32_0, arg_32_1)
	arg_32_0:_setSignInData()

	if arg_32_1 then
		arg_32_0:_playOpenAudio()
		arg_32_0:_initIndex()
	end

	arg_32_0:_setTitleInfo()
	arg_32_0:_setRewardItems()
	arg_32_0:_setMonthViewRewardTips()

	if not arg_32_0._checkSignIn then
		return
	end

	if not arg_32_0._isCurDayRewardGet then
		gohelper.setActive(arg_32_0._gonormaldaysigned, true)
		gohelper.setActive(arg_32_0._gonormaldaysigned_gold, true)
		gohelper.setActive(arg_32_0._gomonthcarddaysigned, true)
		gohelper.setActive(arg_32_0._gomonthcarddaysigned_gold, true)
		gohelper.setActive(arg_32_0._gomonthcardsigned, true)
		gohelper.setActive(arg_32_0._gonormaldayget, true)
		gohelper.setActive(arg_32_0._gonormaldayget_gold, true)
		gohelper.setActive(arg_32_0._gomonthcardget, true)
		gohelper.setActive(arg_32_0._gomonthcarddayget, true)
		gohelper.setActive(arg_32_0._gomonthcarddayget_gold, true)
		gohelper.setActive(arg_32_0._gonormaldaynoget, false)
		gohelper.setActive(arg_32_0._gomonthcardnoget, false)
		gohelper.setActive(arg_32_0._gomonthcardpowernoget, false)
		gohelper.setActive(arg_32_0._gomonthcarddaynoget, false)
		gohelper.setActive(arg_32_0._gomonthcarddaynoget_gold, false)
		arg_32_0._normaldayrewardAni:Play("none")
		arg_32_0._normaldayrewardAni_gold:Play("none")
		arg_32_0._monthcarddayrewardAni:Play("none")
		arg_32_0._monthcarddayrewardAni_gold:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(arg_32_0._txtnormaldayrewardcount, 1)

		arg_32_0._checkSignIn = false

		UIBlockMgr.instance:startBlock("signshowing")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_dailyrewards)
		TaskDispatcher.runDelay(arg_32_0._delaySignInRequest, arg_32_0, 1.3)
	else
		gohelper.setActive(arg_32_0._gonormaldaysigned, true)
		gohelper.setActive(arg_32_0._gonormaldaysigned_gold, true)
		gohelper.setActive(arg_32_0._gomonthcarddaysigned, true)
		gohelper.setActive(arg_32_0._gomonthcarddaysigned_gold, true)
		gohelper.setActive(arg_32_0._gomonthcardsigned, true)
		gohelper.setActive(arg_32_0._gonormaldayget, false)
		gohelper.setActive(arg_32_0._gonormaldayget_gold, false)
		gohelper.setActive(arg_32_0._gomonthcarddayget, false)
		gohelper.setActive(arg_32_0._gomonthcarddayget_gold, false)
		gohelper.setActive(arg_32_0._gomonthcardget, false)
		gohelper.setActive(arg_32_0._gonormaldaynoget, true)
		gohelper.setActive(arg_32_0._gomonthcarddaynoget, true)
		gohelper.setActive(arg_32_0._gomonthcarddaynoget_gold, true)
		gohelper.setActive(arg_32_0._gomonthcardnoget, true)
		gohelper.setActive(arg_32_0._gomonthcardpowernoget, true)
		gohelper.setActive(arg_32_0._gomonthcardpowernoget_gold, true)
		ZProj.UGUIHelper.SetColorAlpha(arg_32_0._txtnormaldayrewardcount, 0.7)

		if arg_32_0._gonormaldayget.activeSelf then
			arg_32_0._normaldayrewardAni.enabled = true
			arg_32_0._normaldayrewardAni_gold.enabled = true
			arg_32_0._monthcarddayrewardAni.enabled = true
			arg_32_0._monthcarddayrewardAni_gold.enabled = true

			arg_32_0._normaldayrewardAni:Play("none")
			arg_32_0._normaldayrewardAni_gold:Play("none")
			arg_32_0._monthcarddayrewardAni:Play("none")
			arg_32_0._monthcarddayrewardAni_gold:Play("none")
		else
			gohelper.setActive(arg_32_0._gomonthcarddayget, false)
			gohelper.setActive(arg_32_0._gomonthcarddayget_gold, false)
			gohelper.setActive(arg_32_0._gomonthcardget, false)

			arg_32_0._normaldayrewardAni.enabled = true
			arg_32_0._normaldayrewardAni_gold.enabled = true
			arg_32_0._monthcarddayrewardAni.enabled = true
			arg_32_0._monthcarddayrewardAni_gold.enabled = true

			if not arg_32_0._clickMonth then
				gohelper.setActive(arg_32_0._gomonthcardnoget, true)
				gohelper.setActive(arg_32_0._gomonthcardpowernoget, true)
				gohelper.setActive(arg_32_0._gomonthcarddaynoget, true)
				gohelper.setActive(arg_32_0._gomonthcarddaynoget_gold, true)
				arg_32_0._monthcarddayrewardAni:Play("lingqu")
				arg_32_0._monthcarddayrewardAni_gold:Play("lingqu")
			else
				arg_32_0._monthcarddayrewardAni:Play("none")
				arg_32_0._monthcarddayrewardAni_gold:Play("none")
				gohelper.setActive(arg_32_0._gomonthcardnoget, true)
				gohelper.setActive(arg_32_0._gomonthcardpowernoget, true)
				gohelper.setActive(arg_32_0._gomonthcarddaynoget, true)
				gohelper.setActive(arg_32_0._gomonthcarddaynoget_gold, true)
			end

			arg_32_0._normaldayrewardAni:Play("lingqu")
			arg_32_0._normaldayrewardAni_gold:Play("lingqu")
			arg_32_0._monthcarddayrewardAni:Play("lingqu")
			arg_32_0._monthcarddayrewardAni_gold:Play("lingqu")
		end
	end
end

function var_0_0._setSignInData(arg_33_0)
	arg_33_0._curDate = SignInModel.instance:getCurDate()
	arg_33_0._targetDate = SignInModel.instance:getSignTargetDate()
	arg_33_0._curDayRewards = string.splitToNumber(SignInConfig.instance:getSignRewards(tonumber(arg_33_0._curDate.day)).signinBonus, "#")
	arg_33_0._rewardGetState = SignInModel.instance:isSignDayRewardGet(arg_33_0._targetDate[3])
	arg_33_0._isCurDayRewardGet = SignInModel.instance:isSignDayRewardGet(arg_33_0._curDate.day)
end

function var_0_0._playOpenAudio(arg_34_0)
	local var_34_0 = SignInModel.instance:getValidMonthCard(arg_34_0._curDate.year, arg_34_0._curDate.month, arg_34_0._curDate.day)

	if not arg_34_0._isCurDayRewardGet and var_34_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_menology)

		return
	end

	local var_34_1 = false

	for iter_34_0 = 1, 3 do
		local var_34_2 = SignInModel.instance:isSignTotalRewardGet(iter_34_0)
		local var_34_3 = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(iter_34_0).signinaddup)

		if not var_34_2 and var_34_3 then
			var_34_1 = true
		end
	end

	if var_34_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_special)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_general)
end

function var_0_0._initIndex(arg_35_0)
	if not arg_35_0._isCurDayRewardGet then
		return
	end

	for iter_35_0 = 1, 3 do
		local var_35_0 = SignInModel.instance:isSignTotalRewardGet(iter_35_0)
		local var_35_1 = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(iter_35_0).signinaddup)

		if not var_35_0 and var_35_1 then
			return
		end
	end

	local var_35_2 = SignInModel.instance:getSignBirthdayHeros(arg_35_0._targetDate[1], arg_35_0._targetDate[2], arg_35_0._targetDate[3])

	if arg_35_0._curDate.year == arg_35_0._targetDate[1] and arg_35_0._curDate.month == arg_35_0._targetDate[2] and arg_35_0._curDate.day == arg_35_0._targetDate[3] then
		var_35_2 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local var_35_3 = arg_35_0._inputheros:GetText()

	if var_35_3 and var_35_3 ~= "" and arg_35_0._curDate.year == arg_35_0._targetDate[1] and arg_35_0._curDate.month == arg_35_0._targetDate[2] and arg_35_0._curDate.day == arg_35_0._targetDate[3] then
		var_35_2 = string.splitToNumber(var_35_3, "|")
	end

	for iter_35_1, iter_35_2 in ipairs(var_35_2) do
		if not SignInModel.instance:isHeroBirthdayGet(iter_35_2) then
			arg_35_0._index = iter_35_1

			gohelper.setSiblingBefore(arg_35_0._gobirthdayrewarditem, arg_35_0._godayrewarditem)

			return
		end
	end
end

function var_0_0._setTitleInfo(arg_36_0)
	local var_36_0 = TimeUtil.timeToTimeStamp(arg_36_0._targetDate[1], arg_36_0._targetDate[2], arg_36_0._targetDate[3], TimeDispatcher.DailyRefreshTime, 1, 1)
	local var_36_1 = ServerTime.weekDayInServerLocal()

	if var_36_1 >= 7 then
		var_36_1 = 0
	end

	UISpriteSetMgr.instance:setSignInSprite(arg_36_0._imageweek, "date_" .. tostring(var_36_1))

	arg_36_0._txtdesc.text = SignInConfig.instance:getSignDescByDate(var_36_0)
	arg_36_0._txtday.text = string.format("%02d", arg_36_0._targetDate[3])
	arg_36_0._txtmonth.text = string.format("%02d", arg_36_0._targetDate[2])

	local var_36_2, var_36_3 = SignInModel.instance:getAdvanceHero()

	if var_36_2 == 0 then
		gohelper.setActive(arg_36_0._goroleitem, false)
	else
		gohelper.setActive(arg_36_0._goroleitem, true)

		local var_36_4 = HeroModel.instance:getByHeroId(var_36_2)
		local var_36_5 = var_36_4 and var_36_4.skin or HeroConfig.instance:getHeroCO(var_36_2).skinId

		arg_36_0._simagetopicon:LoadImage(ResUrl.getHeadIconSmall(var_36_5))

		arg_36_0._txtbirtime.text = var_36_3
		arg_36_0._txtlimit.text = var_36_3 > 1 and "Days Later" or "Day Later"
	end
end

function var_0_0._setRewardItems(arg_37_0)
	local var_37_0 = SignInModel.instance:getSignBirthdayHeros(arg_37_0._targetDate[1], arg_37_0._targetDate[2], arg_37_0._targetDate[3])

	if arg_37_0._curDate.year == arg_37_0._targetDate[1] and arg_37_0._curDate.month == arg_37_0._targetDate[2] and arg_37_0._curDate.day == arg_37_0._targetDate[3] then
		var_37_0 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	if arg_37_0._curDate.year == arg_37_0._targetDate[1] and arg_37_0._curDate.month == arg_37_0._targetDate[2] and arg_37_0._curDate.day == arg_37_0._targetDate[3] then
		if arg_37_0._index > 0 then
			RedDotController.instance:addRedDot(arg_37_0._goreddot, RedDotEnum.DotNode.SignInBirthReward, var_37_0[arg_37_0._index])
		end
	else
		RedDotController.instance:addRedDot(arg_37_0._goreddot, 0)
	end

	for iter_37_0, iter_37_1 in pairs(arg_37_0._nodeItems) do
		gohelper.setActive(iter_37_1.go, false)
	end

	local var_37_1 = false

	if arg_37_0._curDate.year == arg_37_0._targetDate[1] and arg_37_0._curDate.month == arg_37_0._targetDate[2] and arg_37_0._curDate.day == arg_37_0._targetDate[3] then
		for iter_37_2, iter_37_3 in pairs(var_37_0) do
			if not SignInModel.instance:isHeroBirthdayGet(iter_37_3) then
				var_37_1 = true
			end
		end
	end

	gohelper.setActive(arg_37_0._goqiehuan, var_37_1)

	if #var_37_0 > 0 then
		for iter_37_4 = 1, #var_37_0 + 1 do
			if not arg_37_0._nodeItems[iter_37_4] then
				arg_37_0._nodeItems[iter_37_4] = arg_37_0:getUserDataTb_()
				arg_37_0._nodeItems[iter_37_4].go = gohelper.cloneInPlace(arg_37_0._gonodeitem, "node" .. tostring(iter_37_4))
				arg_37_0._nodeItems[iter_37_4].on = gohelper.findChild(arg_37_0._nodeItems[iter_37_4].go, "on")
				arg_37_0._nodeItems[iter_37_4].off = gohelper.findChild(arg_37_0._nodeItems[iter_37_4].off, "off")
			end

			gohelper.setActive(arg_37_0._nodeItems[iter_37_4].go, true)
			gohelper.setActive(arg_37_0._nodeItems[iter_37_4].on, arg_37_0._index == iter_37_4 - 1)
			gohelper.setActive(arg_37_0._nodeItems[iter_37_4].off, arg_37_0._index ~= iter_37_4 - 1)
		end

		gohelper.setActive(arg_37_0._gonodes, true)

		if arg_37_0._index == 0 then
			arg_37_0:_showDayRewardItem()
		else
			arg_37_0:_showBirthdayRewardItem()
		end
	else
		gohelper.setActive(arg_37_0._gonodes, false)
		arg_37_0:_showNoBirthdayRewardItem()
	end
end

function var_0_0._showNoBirthdayRewardItem(arg_38_0)
	gohelper.setActive(arg_38_0._btnqiehuan.gameObject, false)
	gohelper.setActive(arg_38_0._simageorangebg.gameObject, false)
	gohelper.setActive(arg_38_0._gobirthdayrewarditem, false)
end

function var_0_0._showDayRewardItem(arg_39_0)
	gohelper.setActive(arg_39_0._gobirthday, false)
	gohelper.setActive(arg_39_0._btnqiehuan.gameObject, true)
	gohelper.setActive(arg_39_0._simageorangebg.gameObject, true)
	gohelper.setActive(arg_39_0._gobirthdayrewarditem, true)
	arg_39_0._simagebirthdaybg:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	arg_39_0._simagebirthdaybg2:LoadImage(ResUrl.getSignInBg("img_bcard1"))
end

function var_0_0._showBirthdayRewardItem(arg_40_0)
	gohelper.setActive(arg_40_0._gobirthday, true)
	gohelper.setActive(arg_40_0._btnqiehuan.gameObject, true)
	gohelper.setActive(arg_40_0._simageorangebg.gameObject, true)
	gohelper.setActive(arg_40_0._gobirthdayrewarditem, true)
	arg_40_0._simagebirthdaybg:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	arg_40_0._simagebirthdaybg2:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	arg_40_0:_setBirthdayInfo()
end

function var_0_0._setBirthdayInfo(arg_41_0)
	local var_41_0 = SignInModel.instance:getSignBirthdayHeros(arg_41_0._targetDate[1], arg_41_0._targetDate[2], arg_41_0._targetDate[3])

	if arg_41_0._curDate.year == arg_41_0._targetDate[1] and arg_41_0._curDate.month == arg_41_0._targetDate[2] and arg_41_0._curDate.day == arg_41_0._targetDate[3] then
		var_41_0 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	local var_41_1 = var_41_0[arg_41_0._index]
	local var_41_2 = HeroModel.instance:getByHeroId(var_41_1)
	local var_41_3 = var_41_2 and var_41_2.skin or HeroConfig.instance:getHeroCO(var_41_1).skinId

	arg_41_0._simageicon:LoadImage(ResUrl.getHeadIconSmall(var_41_3))

	local var_41_4 = SignInModel.instance:getHeroBirthdayCount(var_41_1)
	local var_41_5 = var_41_4

	if arg_41_0._curDate.month == arg_41_0._targetDate[2] then
		local var_41_6 = SignInModel.instance:isHeroBirthdayGet(var_41_1)

		if arg_41_0._curDate.year == arg_41_0._targetDate[1] then
			var_41_5 = var_41_6 and var_41_4 or var_41_4 + 1
		else
			var_41_5 = var_41_6 and var_41_4 - 1 or var_41_4
		end
	end

	local var_41_7 = string.split(HeroConfig.instance:getHeroCO(var_41_1).desc, "|")[var_41_5]

	arg_41_0._txtdeco.text = var_41_7

	arg_41_0._simagesignature:LoadImage(ResUrl.getSignature(tostring(var_41_1)))

	local var_41_8 = true

	if arg_41_0._curDate.year == arg_41_0._targetDate[1] and arg_41_0._curDate.month == arg_41_0._targetDate[2] and arg_41_0._curDate.day == arg_41_0._targetDate[3] then
		var_41_8 = SignInModel.instance:isHeroBirthdayGet(var_41_1)
	end

	gohelper.setActive(arg_41_0._gogiftnoget, not var_41_8)
	gohelper.setActive(arg_41_0._gogiftget, var_41_8)
end

function var_0_0._delaySignInRequest(arg_42_0)
	gohelper.setActive(arg_42_0._gomonthcarddaysigned, true)
	gohelper.setActive(arg_42_0._gomonthcarddaysigned_gold, true)
	gohelper.setActive(arg_42_0._gonormaldaysigned, true)
	gohelper.setActive(arg_42_0._gonormaldaysigned_gold, true)
	gohelper.setActive(arg_42_0._gomonthcardsigned, true)
	gohelper.setActive(arg_42_0._gonormaldayget, false)
	gohelper.setActive(arg_42_0._gonormaldayget_gold, false)
	gohelper.setActive(arg_42_0._gomonthcarddayget, false)
	gohelper.setActive(arg_42_0._gomonthcarddayget_gold, false)
	gohelper.setActive(arg_42_0._gomonthcardget, false)
	gohelper.setActive(arg_42_0._gonormaldaynoget, true)
	gohelper.setActive(arg_42_0._gomonthcarddaynoget, true)
	gohelper.setActive(arg_42_0._gomonthcarddaynoget_gold, true)
	gohelper.setActive(arg_42_0._gomonthcardnoget, true)
	gohelper.setActive(arg_42_0._gomonthcardpowernoget, true)
	arg_42_0._normaldayrewardAni:Play("lingqu")
	arg_42_0._normaldayrewardAni_gold:Play("lingqu")
	arg_42_0._monthcarddayrewardAni:Play("lingqu")
	arg_42_0._monthcarddayrewardAni_gold:Play("lingqu")
	UIBlockMgr.instance:endBlock("signshowing")

	if arg_42_0._startGetReward then
		return
	end

	LifeCircleController.instance:sendSignInRequest()

	arg_42_0._startGetReward = true
end

function var_0_0._setRedDot(arg_43_0)
	RedDotController.instance:addRedDot(arg_43_0._gomonthtip1, RedDotEnum.DotNode.SignInMonthTab, 1)
	RedDotController.instance:addRedDot(arg_43_0._gomonthtip2, RedDotEnum.DotNode.SignInMonthTab, 2)
	RedDotController.instance:addRedDot(arg_43_0._gomonthtip3, RedDotEnum.DotNode.SignInMonthTab, 3)
end

function var_0_0.onClose(arg_44_0)
	arg_44_0:_removeCustomEvent()
end

function var_0_0._onCloseMonthRewardDetailClick(arg_45_0)
	gohelper.setActive(arg_45_0._gomonthrewarddetail, false)
end

function var_0_0.onClickModalMask(arg_46_0)
	arg_46_0:_onEscapeBtnClick()
end

function var_0_0._onMonthRewardClick(arg_47_0, arg_47_1)
	local var_47_0 = SignInModel.instance:isSignTotalRewardGet(arg_47_1)
	local var_47_1 = SignInModel.instance:getTotalSignDays() >= tonumber(SignInConfig.instance:getSignMonthReward(arg_47_1).signinaddup)

	gohelper.setActive(arg_47_0._gogetmonthbgs[arg_47_1], var_47_1)

	if not var_47_0 and var_47_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_receive)
		gohelper.setActive(arg_47_0._gomonthgets[arg_47_1], true)
		gohelper.setActive(arg_47_0._monthgetlightanimTab[arg_47_1], true)

		arg_47_0._targetid = arg_47_1

		TaskDispatcher.runDelay(arg_47_0._showGetRewards, arg_47_0, 1.2)
	else
		MaterialTipController.instance:showMaterialInfo(tonumber(arg_47_0._monthRewards[arg_47_1].reward[1]), tonumber(arg_47_0._monthRewards[arg_47_1].reward[2]))
	end
end

function var_0_0._showGetRewards(arg_48_0)
	if arg_48_0._targetid then
		gohelper.setActive(arg_48_0._gomonthgets[arg_48_0._targetid], false)
		gohelper.setActive(arg_48_0._gonomonthgets[arg_48_0._targetid], true)
		SignInRpc.instance:sendSignInAddupRequest(arg_48_0._targetid)

		arg_48_0._targetid = nil
	end
end

function var_0_0._onDayRewardClick(arg_49_0)
	MaterialTipController.instance:showMaterialInfo(arg_49_0._curDayRewards[1], arg_49_0._curDayRewards[2])
end

function var_0_0._onDayGoldRewardClick(arg_50_0)
	MaterialTipController.instance:showMaterialInfo(arg_50_0._goldReward[1], arg_50_0._goldReward[2])
end

function var_0_0._onCloseViewFinish(arg_51_0, arg_51_1)
	if arg_51_1 == ViewName.CommonPropView then
		if not arg_51_0._startGetReward then
			return
		end

		arg_51_0._startGetReward = false

		local var_51_0 = SignInModel.instance:getCurDayBirthdayHeros()

		if arg_51_0._index >= #var_51_0 then
			return
		end

		arg_51_0:_btnqiehuanOnClick()
	end
end

function var_0_0._showMonthRewardInfo(arg_52_0, arg_52_1)
	local var_52_0 = {
		rewardCo = SignInConfig.instance:getSignMonthReward(arg_52_1)
	}

	var_52_0.rewards = string.split(var_52_0.rewardCo.signinBonus, "|")
	var_52_0.reward = string.split(var_52_0.rewards[1], "#")

	local var_52_1, var_52_2 = ItemModel.instance:getItemConfigAndIcon(var_52_0.reward[1], var_52_0.reward[2])

	arg_52_0["_simagemonthicon" .. arg_52_1]:LoadImage(var_52_2)

	arg_52_0["_txtmonthquantity" .. arg_52_1].text = var_52_0.rewardCo.signinaddup
	arg_52_0["_txtmonthrewardcount" .. arg_52_1].text = string.format("<size=12>%s</size>%s", luaLang("multiple"), var_52_0.reward[3])

	table.insert(arg_52_0._monthRewards, arg_52_1, var_52_0)
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
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthrewardcount1, 0.5)
	else
		gohelper.setActive(arg_53_0._gomonthget1, false)
		gohelper.setActive(arg_53_0._gonomonthget1, false)
		arg_53_0._month1Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthquantity1, 1)
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthrewardcount1, 1)
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
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthrewardcount2, 0.5)
	else
		gohelper.setActive(arg_53_0._gomonthget2, false)
		gohelper.setActive(arg_53_0._gonomonthget2, false)
		arg_53_0._month2Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthquantity2, 1)
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthrewardcount2, 1)
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
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthrewardcount3, 0.5)
	else
		gohelper.setActive(arg_53_0._gomonthget3, false)
		gohelper.setActive(arg_53_0._gonomonthget3, false)
		arg_53_0._month3Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthquantity3, 1)
		ZProj.UGUIHelper.SetColorAlpha(arg_53_0._txtmonthrewardcount3, 1)
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

function var_0_0._switchFestivalDecoration(arg_55_0, arg_55_1)
	if arg_55_0._haveFestival == arg_55_1 then
		return
	end

	arg_55_0._haveFestival = arg_55_1

	arg_55_0:_refreshFestivalDecoration()
end

function var_0_0._refreshFestivalDecoration(arg_56_0)
	local var_56_0 = arg_56_0:haveFestival()

	gohelper.setActive(arg_56_0._gofestivaldecorationtop, var_56_0)
	gohelper.setActive(arg_56_0._gofestivaldecorationbottom, var_56_0)
	gohelper.setActive(arg_56_0._gorewardicon, not var_56_0)
	gohelper.setActive(arg_56_0._goeffect, var_56_0)
	gohelper.setActive(arg_56_0._godayrewarditem_image3, var_56_0)
	arg_56_0:_setFestivalColor(arg_56_0._txtmonth)
	arg_56_0:_setFestivalColor(arg_56_0._imgbias)
	arg_56_0:_setFestivalColor(arg_56_0._txtday)
	arg_56_0._simagebg:LoadImage(ResUrl.getSignInBg(var_56_0 and "act_bg_white" or "bg_white"))
	arg_56_0._simagerewardbg:LoadImage(ResUrl.getSignInBg(var_56_0 and "act_img_di" or "img_di"))
end

function var_0_0.onDestroyView(arg_57_0)
	UIBlockMgr.instance:endBlock("signshowing")
	TaskDispatcher.cancelTask(arg_57_0._setView1Effect, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._onLineAniStart, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._calendarBtnEffect, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._delaySignInRequest, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._showGetRewards, arg_57_0)

	for iter_57_0, iter_57_1 in pairs(arg_57_0._delayAnimTab) do
		TaskDispatcher.cancelTask(iter_57_1, arg_57_0)
	end

	arg_57_0._simagebg:UnLoadImage()
	arg_57_0._simagerewardbg:UnLoadImage()
	arg_57_0._simagemonthicon1:UnLoadImage()
	arg_57_0._simagemonthicon2:UnLoadImage()
	arg_57_0._simagemonthicon3:UnLoadImage()
end

function var_0_0.closeThis(arg_58_0)
	var_0_0.super.closeThis(arg_58_0)
	MailController.instance:showOrRegisterEvent()
end

function var_0_0.haveFestival(arg_59_0)
	if arg_59_0._haveFestival == nil then
		arg_59_0._haveFestival = SignInModel.instance.checkFestivalDecorationUnlock()
	end

	return arg_59_0._haveFestival
end

function var_0_0._setFestivalColor(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0:haveFestival() and "#3D201A" or "#222222"

	SLFramework.UGUI.GuiHelper.SetColor(arg_60_1, var_60_0)
end

return var_0_0

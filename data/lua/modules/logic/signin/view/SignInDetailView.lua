module("modules.logic.signin.view.SignInDetailView", package.seeall)

slot0 = class("SignInDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._imagesignature = gohelper.findChildImage(slot0.viewGO, "bg/#image_signature")
	slot0._goroleitem = gohelper.findChild(slot0.viewGO, "bg/#go_roleitem")
	slot0._simagetopicon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#go_roleitem/#simage_topicon")
	slot0._goicontip = gohelper.findChild(slot0.viewGO, "bg/#go_roleitem/#go_icontip")
	slot0._txtbirtime = gohelper.findChildText(slot0.viewGO, "bg/#go_roleitem/#txt_birtime")
	slot0._txtlimit = gohelper.findChildText(slot0.viewGO, "bg/#go_roleitem/#txt_limit")
	slot0._txtmonth = gohelper.findChildText(slot0.viewGO, "content/#txt_month")
	slot0._txtday = gohelper.findChildText(slot0.viewGO, "content/#txt_day")
	slot0._imageweek = gohelper.findChildImage(slot0.viewGO, "content/#image_week")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "content/scroll_desc/Viewport/Content/#txt_desc")
	slot0._simageorangebg = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#simage_orangebg")
	slot0._gobirthdayrewarditem = gohelper.findChild(slot0.viewGO, "content/reward/#go_birthdayrewarditem")
	slot0._simagebirthdaybg = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#simage_birthdaybg")
	slot0._simagebirthdaybg2 = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#simage_birthdaybg2")
	slot0._gobirthday = gohelper.findChild(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#simage_icon")
	slot0._btngift = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#btn_gift")
	slot0._gogiftnoget = gohelper.findChild(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_noget")
	slot0._gogiftget = gohelper.findChild(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_get")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_reddot")
	slot0._txtmonthtitle = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/monthtitle")
	slot0._txtdeco = gohelper.findChildText(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/scrollview/viewport/#txt_deco")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#simage_signature")
	slot0._gobirthdayrewarddetail = gohelper.findChild(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail")
	slot0._gocontentSize = gohelper.findChild(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize")
	slot0._trstitle = gohelper.findChild(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/bg/title").transform
	slot0._txtrewarddetailtitle = gohelper.findChildText(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/bg/title/#txt_rewarddetailtitle")
	slot0._gorewardcontent = gohelper.findChild(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/Viewport/Content")
	slot0._gorewarddetailitem = gohelper.findChild(slot0.viewGO, "content/reward/#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/#go_rewarddetailItem")
	slot0._godayrewarditem = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem")
	slot0._simagerewardbg = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#go_dayrewarditem/#simage_rewardbg")
	slot0._gototalreward = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward")
	slot0._txtdaycount = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/monthtitle/#txt_daycount")
	slot0._gomonth1 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1")
	slot0._monthreward1Click = gohelper.getClick(slot0._gomonth1)
	slot0._gomonthmask1 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1")
	slot0._month1canvasGroup = slot0._gomonthmask1:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._gogetmonthbg1 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#go_getmonthbg1")
	slot0._gorewardmark1 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#go_rewardmark1")
	slot0._simagemonthicon1 = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#simage_monthicon1")
	slot0._month1Ani = slot0._simagemonthicon1.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtmonthquantity1 = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#txt_monthquantity1")
	slot0._txtmonthrewardcount1 = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#txt_monthrewardcount1")
	slot0._gomonthtip1 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthtip1")
	slot0._gomonthget1 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthget1")
	slot0._gonomonthget1 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month1/#go_nomonthget1")
	slot0._gomonth2 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2")
	slot0._monthreward2Click = gohelper.getClick(slot0._gomonth2)
	slot0._gomonthmask2 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2")
	slot0._month2canvasGroup = slot0._gomonthmask2:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._gogetmonthbg2 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#go_getmonthbg2")
	slot0._gorewardmark2 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#go_rewardmark2")
	slot0._simagemonthicon2 = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#simage_monthicon2")
	slot0._month2Ani = slot0._simagemonthicon2.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtmonthquantity2 = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#txt_monthquantity2")
	slot0._txtmonthrewardcount2 = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#txt_monthrewardcount2")
	slot0._gomonthtip2 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthtip2")
	slot0._gomonthget2 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthget2")
	slot0._gonomonthget2 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month2/#go_nomonthget2")
	slot0._gomonth3 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3")
	slot0._monthreward3Click = gohelper.getClick(slot0._gomonth3)
	slot0._gomonthmask3 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3")
	slot0._month3canvasGroup = slot0._gomonthmask3:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._gogetmonthbg3 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#go_getmonthbg3")
	slot0._gorewardmark3 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#go_rewardmark3")
	slot0._simagemonthicon3 = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#simage_monthicon3")
	slot0._month3Ani = slot0._simagemonthicon3.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtmonthquantity3 = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#txt_monthquantity3")
	slot0._txtmonthrewardcount3 = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#txt_monthrewardcount3")
	slot0._gomonthtip3 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthtip3")
	slot0._gomonthget3 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthget3")
	slot0._gonomonthget3 = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_totalreward/#go_month3/#go_nomonthget3")
	slot0._gocurrentreward = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal")
	slot0._gonormaldayreward = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward")
	slot0._gonormalday = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday")
	slot0._normaldayClick = gohelper.getClick(slot0._gonormalday)
	slot0._gonormalday_gold = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday")
	slot0._normaldayClick_gold = gohelper.getClick(slot0._gonormalday_gold)
	slot0._txtnormaldayrewardname = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#txt_normaldayrewardname")
	slot0._simagenormaldayrewardicon = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#simage_normaldayrewardicon")
	slot0._normaldayrewardAni = slot0._simagenormaldayrewardicon.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtnormaldayrewardcount = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#simage_normaldayrewardicon/#txt_normaldayrewardcount")
	slot0._gonormaldaysigned = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned")
	slot0._gonormaldayget = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned/#go_normaldayget")
	slot0._gonormaldaynoget = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned/#go_normaldaynoget")
	slot0._gonormaldayreward_gold = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2")
	slot0._txtnormaldayrewardname_gold = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#txt_normaldayrewardname")
	slot0._simagenormaldayrewardicon_gold = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#simage_normaldayrewardicon")
	slot0._normaldayrewardAni_gold = slot0._simagenormaldayrewardicon_gold.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtnormaldayrewardcount_gold = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#simage_normaldayrewardicon/#txt_normaldayrewardcount")
	slot0._gonormaldaysigned_gold = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned")
	slot0._gonormaldayget_gold = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned/#go_normaldayget")
	slot0._gonormaldaynoget_gold = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned/#go_normaldaynoget")
	slot0._normaldayrewardAni_gold = slot0._simagenormaldayrewardicon_gold.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._gomonthcard = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard")
	slot0._gomonthcarddayreward = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward")
	slot0._gomonthcardday = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday")
	slot0._monthcarddayClick = gohelper.getClick(slot0._gomonthcardday)
	slot0._gomonthcardday_gold = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday")
	slot0._monthcarddayClick_gold = gohelper.getClick(slot0._gomonthcardday_gold)
	slot0._txtmonthcarddayrewardname = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#txt_monthcarddayrewardname")
	slot0._simagemonthcarddayrewardicon = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#simage_monthcarddayrewardicon")
	slot0._monthcarddayrewardAni = slot0._simagemonthcarddayrewardicon.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtmonthcarddayrewardcount = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#simage_monthcarddayrewardicon/#txt_monthcarddayrewardcount")
	slot0._gomonthcarddaysigned = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned")
	slot0._gomonthcarddayget = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned/#go_monthcarddayget")
	slot0._gomonthcarddaynoget = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned/#go_monthcarddaynoget")
	slot0._gomonthcarddayreward_gold = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2")
	slot0._txtmonthcarddayrewardname_gold = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#txt_monthcarddayrewardname")
	slot0._simagemonthcarddayrewardicon_gold = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#simage_monthcarddayrewardicon")
	slot0._monthcarddayrewardAni_gold = slot0._simagemonthcarddayrewardicon_gold.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtmonthcarddayrewardcount_gold = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#simage_monthcarddayrewardicon/#txt_monthcarddayrewardcount")
	slot0._gomonthcarddaysigned_gold = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned")
	slot0._gomonthcarddayget_gold = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned/#go_monthcarddayget")
	slot0._gomonthcarddaynoget_gold = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned/#go_monthcarddaynoget")
	slot0._gomonthcardreward = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward")
	slot0._gomonthcardrewarditem = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem")
	slot0._txtmonthcardname = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#txt_monthcardname")
	slot0._simagemonthcardicon = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#simage_monthcardicon")
	slot0._monthcardClick = gohelper.getClick(slot0._gomonthcardrewarditem.gameObject)
	slot0._gomonthcardpowerrewarditem = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem")
	slot0._txtmonthcardcount = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#simage_monthcardicon/#txt_monthcardcount")
	slot0._txtmonthcardpowername = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#txt_monthcardname")
	slot0._simagemonthcardpowericon = gohelper.findChildSingleImage(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#simage_monthcardicon")
	slot0._monthcardpowerClick = gohelper.getClick(slot0._gomonthcardpowerrewarditem.gameObject)
	slot0._txtmonthcardpowercount = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#simage_monthcardicon/#txt_monthcardcount")
	slot0._golimittime = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/#txt_limittime")
	slot0._gonormallimittimebg = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/normalbg")
	slot0._goredlimittimebg = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/redbg")
	slot0._gomonthcardsigned = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned")
	slot0._gomonthcardget = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardget")
	slot0._gomonthcardnoget = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardnoget")
	slot0._gomonthcardpowernoget = gohelper.findChild(slot0.viewGO, "content/reward/#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardpowernoget")
	slot0._btnqiehuan = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/#btn_qiehuan")
	slot0._goqiehuan = gohelper.findChild(slot0.viewGO, "content/#btn_qiehuan/#qiehuan")
	slot0._btncalendar = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_calendar")
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")
	slot0._gonodes = gohelper.findChild(slot0.viewGO, "#go_nodes")
	slot0._gonodeitem = gohelper.findChild(slot0.viewGO, "#go_nodes/#go_nodeitem")
	slot0._btnrewarddetailclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_rewarddetailclose")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gofestivaldecorationtop = gohelper.findChild(slot0.viewGO, "bg/#go_festivalDecorationTop")
	slot0._gofestivaldecorationbottom = gohelper.findChild(slot0.viewGO, "content/#go_festivalDecorationBottom")
	slot0._gorewardicon = gohelper.findChild(slot0.viewGO, "bg/#go_rewardicon")
	slot0._imgbias = gohelper.findChildImage(slot0.viewGO, "content/#image_bias")
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._viewAniEventWrap = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "#go_effect")

	if GMController.instance:getGMNode("signindetailview", gohelper.findChild(slot0.viewGO, "content")) then
		slot0._btnswitchdecorate = gohelper.findChildButtonWithAudio(slot1, "#_btns_switchdecorate")
	end

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btngift:AddClickListener(slot0._btngiftOnClick, slot0)
	slot0._btnqiehuan:AddClickListener(slot0._btnqiehuanOnClick, slot0)
	slot0._btnrewarddetailclose:AddClickListener(slot0._onBtnRewardDetailClick, slot0)
	slot0._btncalendar:AddClickListener(slot0._btncalendarOnClick, slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseviewOnClick, slot0)

	if slot0._btnswitchdecorate then
		slot0._btnswitchdecorate:AddClickListener(slot0._onBtnChangeDecorate, slot0)
	end
end

function slot0.removeEvents(slot0)
	slot0._btngift:RemoveClickListener()
	slot0._btnqiehuan:RemoveClickListener()
	slot0._btnrewarddetailclose:RemoveClickListener()
	slot0._btncalendar:RemoveClickListener()
	slot0._btncloseview:RemoveClickListener()

	if slot0._btnswitchdecorate then
		slot0._btnswitchdecorate:RemoveClickListener()

		slot0._showDecorate = nil
	end
end

function slot0._onBtnChangeDecorate(slot0)
	if slot0._showDecorate == nil then
		slot0._showDecorate = SignInModel.instance.checkFestivalDecorationUnlock()
	end

	slot0._showDecorate = not slot0._showDecorate

	slot0:_switchFestivalDecoration(slot0._showDecorate)
end

function slot0._btngiftOnClick(slot0)
	slot1 = SignInModel.instance:getSignBirthdayHeros(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3])

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] and not SignInModel.instance:isHeroBirthdayGet(SignInModel.instance:getCurDayBirthdayHeros()[slot0._index]) then
		slot0._startGetReward = true

		SignInRpc.instance:sendGetHeroBirthdayRequest(slot2)

		return
	end

	slot0:_showBirthdayRewardDetail()
end

function slot0._showBirthdayRewardDetail(slot0)
	gohelper.setActive(slot0._gobirthdayrewarddetail, true)
	gohelper.setActive(slot0._btnrewarddetailclose.gameObject, true)

	slot1 = SignInModel.instance:getSignBirthdayHeros(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3])

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	slot4 = SignInModel.instance:getHeroBirthdayCount(slot1[slot0._index])

	if slot0._curDate.month == slot0._targetDate[2] then
		slot5 = SignInModel.instance:isHeroBirthdayGet(slot2)
		slot4 = slot0._curDate.year == slot0._targetDate[1] and (slot5 and slot3 or slot3 + 1) or slot5 and slot3 - 1 or slot3
	end

	slot0:_hideAllRewardTipsItem()

	for slot10, slot11 in ipairs(string.split(string.split(HeroConfig.instance:getHeroCO(slot2).birthdayBonus, ";")[slot4], "|")) do
		if not slot0._rewardTipItems[slot10] then
			slot13 = {
				go = gohelper.clone(slot0._gorewarddetailitem, slot0._gorewardcontent, "item" .. slot10)
			}
			slot13.icon = IconMgr.instance:getCommonItemIcon(gohelper.findChild(slot13.go, "icon"))

			table.insert(slot0._rewardTipItems, slot13)
		end

		gohelper.setActive(slot0._rewardTipItems[slot10].go, true)

		slot13 = string.split(slot11, "#")
		slot14, slot15 = ItemModel.instance:getItemConfigAndIcon(slot13[1], slot13[2])

		slot0._rewardTipItems[slot10].icon:setMOValue(slot13[1], slot13[2], slot13[3], nil, true)
		slot0._rewardTipItems[slot10].icon:setScale(0.6)
		slot0._rewardTipItems[slot10].icon:isShowQuality(false)
		slot0._rewardTipItems[slot10].icon:isShowCount(false)

		gohelper.findChildText(slot0._rewardTipItems[slot10].go, "name").text = slot14.name
		gohelper.findChildText(slot0._rewardTipItems[slot10].go, "name/quantity").text = luaLang("multiple") .. slot13[3]
	end

	slot0:_computeRewardsTipsContainerHeight(#slot6)
end

function slot0._hideAllRewardTipsItem(slot0)
	for slot4, slot5 in ipairs(slot0._rewardTipItems) do
		gohelper.setActive(slot5.go, false)
	end
end

function slot0._computeRewardsTipsContainerHeight(slot0, slot1)
	recthelper.setHeight(slot0._gocontentSize.transform, recthelper.getHeight(slot0._trstitle) + slot1 * recthelper.getHeight(slot0._gorewarddetailitem.transform) - 10)
end

function slot0._btnqiehuanOnClick(slot0)
	slot1 = SignInModel.instance:getSignBirthdayHeros(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3])

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	slot0._index = (slot0._index + 1) % (#slot1 + 1)

	UIBlockMgr.instance:startBlock("signshowing")
	TaskDispatcher.runDelay(slot0._onQiehuanFinished, slot0, 0.85)

	if slot0._index == 1 then
		slot0:_setRewardItems()
		slot0._viewAnim:Play("tobirthday", 0, 0)
	elseif slot0._index > 1 then
		slot0._viewAnim:Play("birthtobirth", 0, 0)
	else
		slot0._viewAnim:Play("tonormal", 0, 0)
	end
end

function slot0._onQiehuanFinished(slot0)
	UIBlockMgr.instance:endBlock("signshowing")
end

function slot0._btncalendarOnClick(slot0)
	slot0._viewAnim:Play("out")
	TaskDispatcher.runDelay(slot0._waitOpenSignInView, slot0, 0.2)
end

function slot0._waitOpenSignInView(slot0)
	SignInController.instance:openSignInView(slot0.viewParam)
	slot0:closeThis()
end

function slot0._btncloseviewOnClick(slot0)
	slot0:_onEscapeBtnClick()
end

function slot0._onBtnRewardDetailClick(slot0)
	gohelper.setActive(slot0._btnrewarddetailclose.gameObject, false)
	gohelper.setActive(slot0._gobirthdayrewarddetail, false)
end

function slot0._addCustomEvent(slot0)
	slot0._monthreward1Click:AddClickListener(slot0._onMonthRewardClick, slot0, 1)
	slot0._monthreward2Click:AddClickListener(slot0._onMonthRewardClick, slot0, 2)
	slot0._monthreward3Click:AddClickListener(slot0._onMonthRewardClick, slot0, 3)
	slot0._normaldayClick:AddClickListener(slot0._onDayRewardClick, slot0)
	slot0._monthcarddayClick:AddClickListener(slot0._onDayRewardClick, slot0)
	slot0._normaldayClick_gold:AddClickListener(slot0._onDayGoldRewardClick, slot0)
	slot0._monthcarddayClick_gold:AddClickListener(slot0._onDayGoldRewardClick, slot0)
	slot0._monthcardClick:AddClickListener(slot0._onMonthCardRewardClick, slot0)
	slot0._monthcardpowerClick:AddClickListener(slot0._onMonthCardPowerRewardClick, slot0)
	slot0._viewAniEventWrap:AddEventListener("changetobirthday", slot0._onChangeToBirthday, slot0)
	slot0._viewAniEventWrap:AddEventListener("changetonormal", slot0._onChangeToNormal, slot0)
	slot0._viewAniEventWrap:AddEventListener("birthdaytobirthday", slot0._onChangeBirthdayToBirthday, slot0)
	SignInController.instance:registerCallback(SignInEvent.GetSignInInfo, slot0._onGetSignInInfo, slot0)
	SignInController.instance:registerCallback(SignInEvent.GetSignInReply, slot0._onGetSignInReply, slot0)
	SignInController.instance:registerCallback(SignInEvent.GetSignInAddUp, slot0._setMonthView, slot0)
	SignInController.instance:registerCallback(SignInEvent.SignInItemClick, slot0._onChangeItemClick, slot0)
	SignInController.instance:registerCallback(SignInEvent.ClickSignInMonthItem, slot0._closeViewEffect, slot0)
	SignInController.instance:registerCallback(SignInEvent.GetHeroBirthday, slot0._onGetHeroBirthday, slot0)
	SignInController.instance:registerCallback(SignInEvent.CloseSignInDetailView, slot0._onEscapeBtnClick, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0._removeCustomEvent(slot0)
	slot0._monthreward1Click:RemoveClickListener()
	slot0._monthreward2Click:RemoveClickListener()
	slot0._monthreward3Click:RemoveClickListener()
	slot0._normaldayClick:RemoveClickListener()
	slot0._monthcarddayClick:RemoveClickListener()
	slot0._normaldayClick_gold:RemoveClickListener()
	slot0._monthcarddayClick_gold:RemoveClickListener()
	slot0._monthcardClick:RemoveClickListener()
	slot0._monthcardpowerClick:RemoveClickListener()
	slot0._viewAniEventWrap:RemoveAllEventListener()
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInInfo, slot0._onGetSignInInfo, slot0)
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInReply, slot0._onGetSignInReply, slot0)
	SignInController.instance:unregisterCallback(SignInEvent.GetSignInAddUp, slot0._setMonthView, slot0)
	SignInController.instance:unregisterCallback(SignInEvent.SignInItemClick, slot0._onChangeItemClick, slot0)
	SignInController.instance:unregisterCallback(SignInEvent.ClickSignInMonthItem, slot0._closeViewEffect, slot0)
	SignInController.instance:unregisterCallback(SignInEvent.GetHeroBirthday, slot0._onGetHeroBirthday, slot0)
	SignInController.instance:unregisterCallback(SignInEvent.CloseSignInDetailView, slot0._onEscapeBtnClick, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0._onEscapeBtnClick(slot0)
	slot0._viewAnim:Play("out")
	TaskDispatcher.runDelay(slot0.clickCloseView, slot0, 0.2)
end

function slot0.clickCloseView(slot0)
	if slot0.viewParam and slot0.viewParam.callback then
		slot0.viewParam.callback(slot0.viewParam.callbackObj)
	end

	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnqiehuan.gameObject, AudioEnum.UI.play_ui_sign_in_qiehuan)
	gohelper.setActive(slot0._gomonthget1, false)
	gohelper.setActive(slot0._gonomonthget1, false)
	gohelper.setActive(slot0._gomonthget2, false)
	gohelper.setActive(slot0._gonomonthget2, false)
	gohelper.setActive(slot0._gomonthget3, false)
	gohelper.setActive(slot0._gonomonthget3, false)
	gohelper.setActive(slot0._gonormaldaysigned, false)
	gohelper.setActive(slot0._gonormaldaysigned_gold, false)
	gohelper.setActive(slot0._gomonthcarddaysigned, false)
	gohelper.setActive(slot0._gomonthcarddaysigned_gold, false)
	gohelper.setActive(slot0._gomonthcardsigned, false)
	slot0._normaldayrewardAni:Play("none")
	slot0._normaldayrewardAni_gold:Play("none")
	slot0._monthcarddayrewardAni:Play("none")
	slot0._monthcarddayrewardAni_gold:Play("none")

	slot0._gogetmonthbgs = slot0:getUserDataTb_()

	table.insert(slot0._gogetmonthbgs, slot0._gogetmonthbg1)
	table.insert(slot0._gogetmonthbgs, slot0._gogetmonthbg2)
	table.insert(slot0._gogetmonthbgs, slot0._gogetmonthbg3)

	slot0._gomonthmasks = slot0:getUserDataTb_()

	table.insert(slot0._gomonthmasks, slot0._gomonthmask1)
	table.insert(slot0._gomonthmasks, slot0._gomonthmask2)
	table.insert(slot0._gomonthmasks, slot0._gomonthmask3)

	slot0._gomonthgets = slot0:getUserDataTb_()

	table.insert(slot0._gomonthgets, slot0._gomonthget1)
	table.insert(slot0._gomonthgets, slot0._gomonthget2)
	table.insert(slot0._gomonthgets, slot0._gomonthget3)

	slot0._gonomonthgets = slot0:getUserDataTb_()

	table.insert(slot0._gonomonthgets, slot0._gonomonthget1)
	table.insert(slot0._gonomonthgets, slot0._gonomonthget2)
	table.insert(slot0._gonomonthgets, slot0._gonomonthget3)
	slot0._simagebg:LoadImage(ResUrl.getSignInBg("bg_white"))
	slot0._simageorangebg:LoadImage(ResUrl.getSignInBg("img_bcard3"))

	slot4 = "img_di"

	slot0._simagerewardbg:LoadImage(ResUrl.getSignInBg(slot4))

	slot0._rewardTipItems = {}
	slot0._nodeItems = {}
	slot0._monthgetlightanimTab = slot0:getUserDataTb_()
	slot0._delayAnimTab = slot0:getUserDataTb_()
	slot0._monthRewards = slot0:getUserDataTb_()

	table.insert(slot0._monthgetlightanimTab, slot0._gomonthgetlightanim1)
	table.insert(slot0._monthgetlightanimTab, slot0._gomonthgetlightanim2)
	table.insert(slot0._monthgetlightanimTab, slot0._gomonthgetlightanim3)

	for slot4, slot5 in ipairs(slot0._monthgetlightanimTab) do
		gohelper.setActive(slot5, false)
	end
end

function slot0.onOpen(slot0)
	if slot0.viewParam.back then
		slot0._viewAnim:Play("AutoIn")
	else
		slot0._viewAnim:Play("NormalIn")
	end

	slot0._index = 0
	slot0._checkSignIn = true

	slot0:_setMonthView(true)
	slot0:_setRedDot()
	slot0:_addCustomEvent()
	NavigateMgr.instance:addEscape(ViewName.SignInDetailView, slot0._onEscapeBtnClick, slot0)
	slot0:_switchFestivalDecoration(SignInModel.instance.checkFestivalDecorationUnlock())
end

function slot0._onDailyRefresh(slot0)
	slot0._index = 0
	slot0._checkSignIn = true

	gohelper.setActive(slot0._gomonthget1, false)
	gohelper.setActive(slot0._gonomonthget1, false)
	gohelper.setActive(slot0._gomonthget2, false)
	gohelper.setActive(slot0._gonomonthget2, false)
	gohelper.setActive(slot0._gomonthget3, false)
	gohelper.setActive(slot0._gonomonthget3, false)
	gohelper.setActive(slot0._gonormaldaysigned, false)
	gohelper.setActive(slot0._gonormaldaysigned_gold, false)
	gohelper.setActive(slot0._gomonthcarddaysigned, false)
	gohelper.setActive(slot0._gomonthcarddaysigned_gold, false)
	gohelper.setActive(slot0._gomonthcardsigned, false)
	gohelper.setActive(slot0._gonormaldayget, false)
	gohelper.setActive(slot0._gonormaldayget_gold, false)
	gohelper.setActive(slot0._gomonthcardget, false)
	gohelper.setActive(slot0._gomonthcarddayget, false)
	gohelper.setActive(slot0._gomonthcarddayget_gold, false)
	gohelper.setActive(slot0._gonormaldaynoget, false)
	gohelper.setActive(slot0._gomonthcardnoget, false)
	gohelper.setActive(slot0._gomonthcardpowernoget, false)
	gohelper.setActive(slot0._gomonthcarddaynoget, false)
	gohelper.setActive(slot0._gomonthcarddaynoget_gold, false)
	slot0:_setMonthView()
end

function slot0._onChangeItemClick(slot0, slot1)
	slot0.currentSelectMaterialType = slot1.materilType
	slot0.currentSelectMaterialId = slot1.materilId

	if tonumber(slot1.materilType) == MaterialEnum.MaterialType.Equip then
		slot2, slot3 = ItemModel.instance:getItemConfigAndIcon(slot1.materilType, slot1.materilId, true)
	end
end

function slot0._onMonthCardRewardClick(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0._curmonthCardRewards[1], slot0._curmonthCardRewards[2])
end

function slot0._onMonthCardPowerRewardClick(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0._curmonthCardPower[1], slot0._curmonthCardPower[2])
end

function slot0._onChangeToBirthday(slot0)
	gohelper.setSiblingBefore(slot0._godayrewarditem, slot0._gobirthdayrewarditem)
end

function slot0._onChangeToNormal(slot0)
	slot0:_setRewardItems()
	gohelper.setSiblingBefore(slot0._gobirthdayrewarditem, slot0._godayrewarditem)
end

function slot0._onChangeBirthdayToBirthday(slot0)
	slot0:_setRewardItems()
end

function slot0._onGetSignInInfo(slot0)
	slot0:_setMonthView()
end

function slot0._onGetSignInReply(slot0)
	slot0:_setMonthView()
end

function slot0._onGetHeroBirthday(slot0)
	slot1 = SignInModel.instance:getSignBirthdayHeros(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3])

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	slot2 = false

	for slot6, slot7 in pairs(slot1) do
		if not SignInModel.instance:isHeroBirthdayGet(slot7) then
			slot2 = true
		end
	end

	gohelper.setActive(slot0._goqiehuan, slot2)
	gohelper.setActive(slot0._gogiftnoget, false)
	gohelper.setActive(slot0._gogiftget, true)
end

function slot0._closeViewEffect(slot0)
	slot0._clickMonth = true
	slot0._index = 0

	slot0._viewAnim:Play("idel")
	slot0:_setMonthView()
	gohelper.setSiblingBefore(slot0._gobirthdayrewarditem, slot0._godayrewarditem)
end

function slot0._setMonthView(slot0, slot1)
	slot0:_setSignInData()

	if slot1 then
		slot0:_playOpenAudio()
		slot0:_initIndex()
	end

	slot0:_setTitleInfo()
	slot0:_setRewardItems()
	slot0:_setMonthViewRewardTips()

	if not slot0._checkSignIn then
		return
	end

	if not slot0._isCurDayRewardGet then
		gohelper.setActive(slot0._gonormaldaysigned, true)
		gohelper.setActive(slot0._gonormaldaysigned_gold, true)
		gohelper.setActive(slot0._gomonthcarddaysigned, true)
		gohelper.setActive(slot0._gomonthcarddaysigned_gold, true)
		gohelper.setActive(slot0._gomonthcardsigned, true)
		gohelper.setActive(slot0._gonormaldayget, true)
		gohelper.setActive(slot0._gonormaldayget_gold, true)
		gohelper.setActive(slot0._gomonthcardget, true)
		gohelper.setActive(slot0._gomonthcarddayget, true)
		gohelper.setActive(slot0._gomonthcarddayget_gold, true)
		gohelper.setActive(slot0._gonormaldaynoget, false)
		gohelper.setActive(slot0._gomonthcardnoget, false)
		gohelper.setActive(slot0._gomonthcardpowernoget, false)
		gohelper.setActive(slot0._gomonthcarddaynoget, false)
		gohelper.setActive(slot0._gomonthcarddaynoget_gold, false)
		slot0._normaldayrewardAni:Play("none")
		slot0._normaldayrewardAni_gold:Play("none")
		slot0._monthcarddayrewardAni:Play("none")
		slot0._monthcarddayrewardAni_gold:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtnormaldayrewardcount, 1)

		slot0._checkSignIn = false

		UIBlockMgr.instance:startBlock("signshowing")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_dailyrewards)
		TaskDispatcher.runDelay(slot0._delaySignInRequest, slot0, 1.3)
	else
		gohelper.setActive(slot0._gonormaldaysigned, true)
		gohelper.setActive(slot0._gonormaldaysigned_gold, true)
		gohelper.setActive(slot0._gomonthcarddaysigned, true)
		gohelper.setActive(slot0._gomonthcarddaysigned_gold, true)
		gohelper.setActive(slot0._gomonthcardsigned, true)
		gohelper.setActive(slot0._gonormaldayget, false)
		gohelper.setActive(slot0._gonormaldayget_gold, false)
		gohelper.setActive(slot0._gomonthcarddayget, false)
		gohelper.setActive(slot0._gomonthcarddayget_gold, false)
		gohelper.setActive(slot0._gomonthcardget, false)
		gohelper.setActive(slot0._gonormaldaynoget, true)
		gohelper.setActive(slot0._gomonthcarddaynoget, true)
		gohelper.setActive(slot0._gomonthcarddaynoget_gold, true)
		gohelper.setActive(slot0._gomonthcardnoget, true)
		gohelper.setActive(slot0._gomonthcardpowernoget, true)
		gohelper.setActive(slot0._gomonthcardpowernoget_gold, true)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtnormaldayrewardcount, 0.7)

		if slot0._gonormaldayget.activeSelf then
			slot0._normaldayrewardAni.enabled = true
			slot0._normaldayrewardAni_gold.enabled = true
			slot0._monthcarddayrewardAni.enabled = true
			slot0._monthcarddayrewardAni_gold.enabled = true

			slot0._normaldayrewardAni:Play("none")
			slot0._normaldayrewardAni_gold:Play("none")
			slot0._monthcarddayrewardAni:Play("none")
			slot0._monthcarddayrewardAni_gold:Play("none")
		else
			gohelper.setActive(slot0._gomonthcarddayget, false)
			gohelper.setActive(slot0._gomonthcarddayget_gold, false)
			gohelper.setActive(slot0._gomonthcardget, false)

			slot0._normaldayrewardAni.enabled = true
			slot0._normaldayrewardAni_gold.enabled = true
			slot0._monthcarddayrewardAni.enabled = true
			slot0._monthcarddayrewardAni_gold.enabled = true

			if not slot0._clickMonth then
				gohelper.setActive(slot0._gomonthcardnoget, true)
				gohelper.setActive(slot0._gomonthcardpowernoget, true)
				gohelper.setActive(slot0._gomonthcarddaynoget, true)
				gohelper.setActive(slot0._gomonthcarddaynoget_gold, true)
				slot0._monthcarddayrewardAni:Play("lingqu")
				slot0._monthcarddayrewardAni_gold:Play("lingqu")
			else
				slot0._monthcarddayrewardAni:Play("none")
				slot0._monthcarddayrewardAni_gold:Play("none")
				gohelper.setActive(slot0._gomonthcardnoget, true)
				gohelper.setActive(slot0._gomonthcardpowernoget, true)
				gohelper.setActive(slot0._gomonthcarddaynoget, true)
				gohelper.setActive(slot0._gomonthcarddaynoget_gold, true)
			end

			slot0._normaldayrewardAni:Play("lingqu")
			slot0._normaldayrewardAni_gold:Play("lingqu")
			slot0._monthcarddayrewardAni:Play("lingqu")
			slot0._monthcarddayrewardAni_gold:Play("lingqu")
		end
	end
end

function slot0._setSignInData(slot0)
	slot0._curDate = SignInModel.instance:getCurDate()
	slot0._targetDate = SignInModel.instance:getSignTargetDate()
	slot0._curDayRewards = string.splitToNumber(SignInConfig.instance:getSignRewards(tonumber(slot0._curDate.day)).signinBonus, "#")
	slot0._rewardGetState = SignInModel.instance:isSignDayRewardGet(slot0._targetDate[3])
	slot0._isCurDayRewardGet = SignInModel.instance:isSignDayRewardGet(slot0._curDate.day)
end

function slot0._playOpenAudio(slot0)
	if not slot0._isCurDayRewardGet and SignInModel.instance:getValidMonthCard(slot0._curDate.year, slot0._curDate.month, slot0._curDate.day) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_menology)

		return
	end

	slot2 = false

	for slot6 = 1, 3 do
		if not SignInModel.instance:isSignTotalRewardGet(slot6) and tonumber(SignInConfig.instance:getSignMonthReward(slot6).signinaddup) <= SignInModel.instance:getTotalSignDays() then
			slot2 = true
		end
	end

	if slot2 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_special)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_general)
end

function slot0._initIndex(slot0)
	if not slot0._isCurDayRewardGet then
		return
	end

	for slot4 = 1, 3 do
		if not SignInModel.instance:isSignTotalRewardGet(slot4) and tonumber(SignInConfig.instance:getSignMonthReward(slot4).signinaddup) <= SignInModel.instance:getTotalSignDays() then
			return
		end
	end

	slot1 = SignInModel.instance:getSignBirthdayHeros(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3])

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	if slot0._inputheros:GetText() and slot2 ~= "" and slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = string.splitToNumber(slot2, "|")
	end

	for slot6, slot7 in ipairs(slot1) do
		if not SignInModel.instance:isHeroBirthdayGet(slot7) then
			slot0._index = slot6

			gohelper.setSiblingBefore(slot0._gobirthdayrewarditem, slot0._godayrewarditem)

			return
		end
	end
end

function slot0._setTitleInfo(slot0)
	slot1 = TimeUtil.timeToTimeStamp(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3], TimeDispatcher.DailyRefreshTime, 1, 1)

	if ServerTime.weekDayInServerLocal() >= 7 then
		slot2 = 0
	end

	UISpriteSetMgr.instance:setSignInSprite(slot0._imageweek, "date_" .. tostring(slot2))

	slot0._txtdesc.text = SignInConfig.instance:getSignDescByDate(slot1)
	slot0._txtday.text = string.format("%02d", slot0._targetDate[3])
	slot0._txtmonth.text = string.format("%02d", slot0._targetDate[2])
	slot3, slot4 = SignInModel.instance:getAdvanceHero()

	if slot3 == 0 then
		gohelper.setActive(slot0._goroleitem, false)
	else
		gohelper.setActive(slot0._goroleitem, true)
		slot0._simagetopicon:LoadImage(ResUrl.getHeadIconSmall(HeroModel.instance:getByHeroId(slot3) and slot5.skin or HeroConfig.instance:getHeroCO(slot3).skinId))

		slot0._txtbirtime.text = slot4
		slot0._txtlimit.text = slot4 > 1 and "Days Later" or "Day Later"
	end
end

function slot0._setRewardItems(slot0)
	slot1 = SignInModel.instance:getSignBirthdayHeros(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3])

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		if slot0._index > 0 then
			RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.SignInBirthReward, slot1[slot0._index])
		end
	else
		RedDotController.instance:addRedDot(slot0._goreddot, 0)
	end

	for slot5, slot6 in pairs(slot0._nodeItems) do
		gohelper.setActive(slot6.go, false)
	end

	slot2 = false

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		for slot6, slot7 in pairs(slot1) do
			if not SignInModel.instance:isHeroBirthdayGet(slot7) then
				slot2 = true
			end
		end
	end

	gohelper.setActive(slot0._goqiehuan, slot2)

	if #slot1 > 0 then
		for slot6 = 1, #slot1 + 1 do
			if not slot0._nodeItems[slot6] then
				slot0._nodeItems[slot6] = slot0:getUserDataTb_()
				slot0._nodeItems[slot6].go = gohelper.cloneInPlace(slot0._gonodeitem, "node" .. tostring(slot6))
				slot0._nodeItems[slot6].on = gohelper.findChild(slot0._nodeItems[slot6].go, "on")
				slot0._nodeItems[slot6].off = gohelper.findChild(slot0._nodeItems[slot6].off, "off")
			end

			gohelper.setActive(slot0._nodeItems[slot6].go, true)
			gohelper.setActive(slot0._nodeItems[slot6].on, slot0._index == slot6 - 1)
			gohelper.setActive(slot0._nodeItems[slot6].off, slot0._index ~= slot6 - 1)
		end

		gohelper.setActive(slot0._gonodes, true)

		if slot0._index == 0 then
			slot0:_showDayRewardItem()
		else
			slot0:_showBirthdayRewardItem()
		end
	else
		gohelper.setActive(slot0._gonodes, false)
		slot0:_showNoBirthdayRewardItem()
	end
end

function slot0._showNoBirthdayRewardItem(slot0)
	gohelper.setActive(slot0._btnqiehuan.gameObject, false)
	gohelper.setActive(slot0._simageorangebg.gameObject, false)
	gohelper.setActive(slot0._gobirthdayrewarditem, false)
end

function slot0._showDayRewardItem(slot0)
	gohelper.setActive(slot0._gobirthday, false)
	gohelper.setActive(slot0._btnqiehuan.gameObject, true)
	gohelper.setActive(slot0._simageorangebg.gameObject, true)
	gohelper.setActive(slot0._gobirthdayrewarditem, true)
	slot0._simagebirthdaybg:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	slot0._simagebirthdaybg2:LoadImage(ResUrl.getSignInBg("img_bcard1"))
end

function slot0._showBirthdayRewardItem(slot0)
	gohelper.setActive(slot0._gobirthday, true)
	gohelper.setActive(slot0._btnqiehuan.gameObject, true)
	gohelper.setActive(slot0._simageorangebg.gameObject, true)
	gohelper.setActive(slot0._gobirthdayrewarditem, true)
	slot0._simagebirthdaybg:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	slot0._simagebirthdaybg2:LoadImage(ResUrl.getSignInBg("img_bcard1"))
	slot0:_setBirthdayInfo()
end

function slot0._setBirthdayInfo(slot0)
	slot1 = SignInModel.instance:getSignBirthdayHeros(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3])

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	slot0._simageicon:LoadImage(ResUrl.getHeadIconSmall(HeroModel.instance:getByHeroId(slot1[slot0._index]) and slot3.skin or HeroConfig.instance:getHeroCO(slot2).skinId))

	slot6 = SignInModel.instance:getHeroBirthdayCount(slot2)

	if slot0._curDate.month == slot0._targetDate[2] then
		slot7 = SignInModel.instance:isHeroBirthdayGet(slot2)
		slot6 = slot0._curDate.year == slot0._targetDate[1] and (slot7 and slot5 or slot5 + 1) or slot7 and slot5 - 1 or slot5
	end

	slot0._txtdeco.text = string.split(HeroConfig.instance:getHeroCO(slot2).desc, "|")[slot6]

	slot0._simagesignature:LoadImage(ResUrl.getSignature(tostring(slot2)))

	slot8 = true

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot8 = SignInModel.instance:isHeroBirthdayGet(slot2)
	end

	gohelper.setActive(slot0._gogiftnoget, not slot8)
	gohelper.setActive(slot0._gogiftget, slot8)
end

function slot0._delaySignInRequest(slot0)
	gohelper.setActive(slot0._gomonthcarddaysigned, true)
	gohelper.setActive(slot0._gomonthcarddaysigned_gold, true)
	gohelper.setActive(slot0._gonormaldaysigned, true)
	gohelper.setActive(slot0._gonormaldaysigned_gold, true)
	gohelper.setActive(slot0._gomonthcardsigned, true)
	gohelper.setActive(slot0._gonormaldayget, false)
	gohelper.setActive(slot0._gonormaldayget_gold, false)
	gohelper.setActive(slot0._gomonthcarddayget, false)
	gohelper.setActive(slot0._gomonthcarddayget_gold, false)
	gohelper.setActive(slot0._gomonthcardget, false)
	gohelper.setActive(slot0._gonormaldaynoget, true)
	gohelper.setActive(slot0._gomonthcarddaynoget, true)
	gohelper.setActive(slot0._gomonthcarddaynoget_gold, true)
	gohelper.setActive(slot0._gomonthcardnoget, true)
	gohelper.setActive(slot0._gomonthcardpowernoget, true)
	slot0._normaldayrewardAni:Play("lingqu")
	slot0._normaldayrewardAni_gold:Play("lingqu")
	slot0._monthcarddayrewardAni:Play("lingqu")
	slot0._monthcarddayrewardAni_gold:Play("lingqu")
	UIBlockMgr.instance:endBlock("signshowing")
	SignInRpc.instance:sendSignInRequest()

	slot0._startGetReward = true
end

function slot0._setRedDot(slot0)
	RedDotController.instance:addRedDot(slot0._gomonthtip1, RedDotEnum.DotNode.SignInMonthTab, 1)
	RedDotController.instance:addRedDot(slot0._gomonthtip2, RedDotEnum.DotNode.SignInMonthTab, 2)
	RedDotController.instance:addRedDot(slot0._gomonthtip3, RedDotEnum.DotNode.SignInMonthTab, 3)
end

function slot0.onClose(slot0)
	slot0:_removeCustomEvent()
end

function slot0._onCloseMonthRewardDetailClick(slot0)
	gohelper.setActive(slot0._gomonthrewarddetail, false)
end

function slot0.onClickModalMask(slot0)
	slot0:_onEscapeBtnClick()
end

function slot0._onMonthRewardClick(slot0, slot1)
	gohelper.setActive(slot0._gogetmonthbgs[slot1], tonumber(SignInConfig.instance:getSignMonthReward(slot1).signinaddup) <= SignInModel.instance:getTotalSignDays())

	if not SignInModel.instance:isSignTotalRewardGet(slot1) and slot3 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_receive)
		gohelper.setActive(slot0._gomonthgets[slot1], true)
		gohelper.setActive(slot0._monthgetlightanimTab[slot1], true)

		slot0._targetid = slot1

		TaskDispatcher.runDelay(slot0._showGetRewards, slot0, 1.2)
	else
		MaterialTipController.instance:showMaterialInfo(tonumber(slot0._monthRewards[slot1].reward[1]), tonumber(slot0._monthRewards[slot1].reward[2]))
	end
end

function slot0._showGetRewards(slot0)
	if slot0._targetid then
		gohelper.setActive(slot0._gomonthgets[slot0._targetid], false)
		gohelper.setActive(slot0._gonomonthgets[slot0._targetid], true)
		SignInRpc.instance:sendSignInAddupRequest(slot0._targetid)

		slot0._targetid = nil
	end
end

function slot0._onDayRewardClick(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0._curDayRewards[1], slot0._curDayRewards[2])
end

function slot0._onDayGoldRewardClick(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0._goldReward[1], slot0._goldReward[2])
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		if not slot0._startGetReward then
			return
		end

		slot0._startGetReward = false

		if slot0._index >= #SignInModel.instance:getCurDayBirthdayHeros() then
			return
		end

		slot0:_btnqiehuanOnClick()
	end
end

function slot0._showMonthRewardInfo(slot0, slot1)
	slot2 = {
		rewardCo = SignInConfig.instance:getSignMonthReward(slot1)
	}
	slot2.rewards = string.split(slot2.rewardCo.signinBonus, "|")
	slot2.reward = string.split(slot2.rewards[1], "#")
	slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(slot2.reward[1], slot2.reward[2])

	slot0["_simagemonthicon" .. slot1]:LoadImage(slot4)

	slot0["_txtmonthquantity" .. slot1].text = slot2.rewardCo.signinaddup
	slot0["_txtmonthrewardcount" .. slot1].text = string.format("<size=12>%s</size>%s", luaLang("multiple"), slot2.reward[3])

	table.insert(slot0._monthRewards, slot1, slot2)
end

function slot0._setMonthViewRewardTips(slot0)
	slot0._txtmonthtitle.text = string.format(luaLang("p_activitysignin_signindaystitle"), string.format("<color=#ED7B3C>%s</color>", SignInModel.instance:getTotalSignDays()))
	slot4 = SignInConfig.instance:getSignMonthRewards()

	for slot8 = 1, 3 do
		slot0:_showMonthRewardInfo(slot8)
	end

	slot5 = SignInModel.instance:isSignTotalRewardGet(1)
	slot6 = tonumber(SignInConfig.instance:getSignMonthReward(1).signinaddup) <= SignInModel.instance:getTotalSignDays()

	gohelper.setActive(slot0._gorewardmark1, not slot5 and slot6)
	gohelper.setActive(slot0._gogetmonthbg1, slot6)

	if slot5 then
		gohelper.setActive(slot0._gomonthget1, slot0._gomonthget1.activeSelf)
		gohelper.setActive(slot0._gonomonthget1, not slot0._gomonthget1.activeSelf)
		slot0._month1Ani:Play("lingqu")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthquantity1, 0.5)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthrewardcount1, 0.5)
	else
		gohelper.setActive(slot0._gomonthget1, false)
		gohelper.setActive(slot0._gonomonthget1, false)
		slot0._month1Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthquantity1, 1)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthrewardcount1, 1)
	end

	slot7 = SignInModel.instance:isSignTotalRewardGet(2)
	slot8 = tonumber(SignInConfig.instance:getSignMonthReward(2).signinaddup) <= SignInModel.instance:getTotalSignDays()

	gohelper.setActive(slot0._gorewardmark2, not slot7 and slot8)
	gohelper.setActive(slot0._gogetmonthbg2, slot8)

	if slot7 then
		gohelper.setActive(slot0._gomonthget2, slot0._gomonthget2.activeSelf)
		gohelper.setActive(slot0._gonomonthget2, not slot0._gomonthget2.activeSelf)
		slot0._month2Ani:Play("lingqu")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthquantity2, 0.5)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthrewardcount2, 0.5)
	else
		gohelper.setActive(slot0._gomonthget2, false)
		gohelper.setActive(slot0._gonomonthget2, false)
		slot0._month2Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthquantity2, 1)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthrewardcount2, 1)
	end

	slot9 = SignInModel.instance:isSignTotalRewardGet(3)
	slot10 = tonumber(SignInConfig.instance:getSignMonthReward(3).signinaddup) <= SignInModel.instance:getTotalSignDays()

	gohelper.setActive(slot0._gorewardmark3, not slot9 and slot10)
	gohelper.setActive(slot0._gogetmonthbg3, slot10)

	if slot9 then
		gohelper.setActive(slot0._gomonthget3, slot0._gomonthget3.activeSelf)
		gohelper.setActive(slot0._gonomonthget3, not slot0._gomonthget3.activeSelf)
		slot0._month3Ani:Play("lingqu")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthquantity3, 0.5)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthrewardcount3, 0.5)
	else
		gohelper.setActive(slot0._gomonthget3, false)
		gohelper.setActive(slot0._gonomonthget3, false)
		slot0._month3Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthquantity3, 1)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthrewardcount3, 1)
	end

	slot11 = SignInModel.instance:getSignTargetDate()

	slot0:_setGoldRewards(slot11)

	slot0._curDayRewards = string.splitToNumber(SignInConfig.instance:getSignRewards(slot11[3]).signinBonus, "#")
	slot12, slot13 = ItemModel.instance:getItemConfigAndIcon(slot0._curDayRewards[1], slot0._curDayRewards[2], true)
	slot0._txtnormaldayrewardcount.text = luaLang("multiple") .. tostring(slot0._curDayRewards[3])
	slot0._txtmonthcarddayrewardcount.text = luaLang("multiple") .. tostring(slot0._curDayRewards[3])

	slot0._simagenormaldayrewardicon:LoadImage(slot13)
	slot0._simagemonthcarddayrewardicon:LoadImage(slot13)

	if tonumber(slot0._curDayRewards[1]) == MaterialEnum.MaterialType.Equip then
		slot0._simagenormaldayrewardicon:LoadImage(ResUrl.getPropItemIcon(slot12.icon))
		slot0._simagemonthcarddayrewardicon:LoadImage(ResUrl.getPropItemIcon(slot12.icon))
	end

	slot14 = SignInModel.instance:getValidMonthCard(slot11[1], slot11[2], slot11[3])

	gohelper.setActive(slot0._gomonthcard, slot14)
	gohelper.setActive(slot0._gonormal, not slot14)

	if slot14 then
		slot15 = string.split(StoreConfig.instance:getMonthCardConfig(slot14).dailyBonus, "|")
		slot0._curmonthCardRewards = string.splitToNumber(slot15[1], "#")
		slot0._curmonthCardPower = string.splitToNumber(slot15[2], "#")
		slot0._txtmonthcardcount.text = luaLang("multiple") .. tostring(slot0._curmonthCardRewards[3])
		slot0._txtmonthcardpowercount.text = luaLang("multiple") .. tostring(slot0._curmonthCardPower[3])
		slot16, slot17 = ItemModel.instance:getItemConfigAndIcon(slot0._curmonthCardRewards[1], slot0._curmonthCardRewards[2], true)

		slot0._simagemonthcardicon:LoadImage(slot17)

		slot18, slot19 = ItemModel.instance:getItemConfigAndIcon(slot0._curmonthCardPower[1], slot0._curmonthCardPower[2], true)

		slot0._simagemonthcardpowericon:LoadImage(slot19)
		gohelper.setActive(slot0._gopowerlimittime, false)

		if slot18.expireTime then
			gohelper.setActive(slot0._gopowerlimittime, true)
		end

		if StoreModel.instance:getMonthCardInfo() then
			if slot20:getRemainDay() > 0 then
				gohelper.setActive(slot0._golimittime.gameObject, true)

				if slot21 <= StoreEnum.MonthCardStatus.NotEnoughThreeDay then
					gohelper.setActive(slot0._goredlimittimebg, true)
					gohelper.setActive(slot0._gonormallimittimebg, false)
				else
					gohelper.setActive(slot0._goredlimittimebg, false)
					gohelper.setActive(slot0._gonormallimittimebg, true)
				end

				slot0._txtlimittime.text = formatLuaLang("remain_day", slot21)
			else
				gohelper.setActive(slot0._golimittime.gameObject, false)
			end
		end

		slot22 = slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] and not slot0._rewardGetState

		gohelper.setActive(slot0._gomonthcardget, slot22)
		gohelper.setActive(slot0._gomonthcarddayget, slot22)
		gohelper.setActive(slot0._gomonthcarddayget_gold, slot22)
		gohelper.setActive(slot0._gomonthcardnoget, not slot22)
		gohelper.setActive(slot0._gomonthcardpowernoget, not slot22)
		gohelper.setActive(slot0._gomonthcarddaynoget, not slot22)
		gohelper.setActive(slot0._gomonthcarddaynoget_gold, not slot22)
	end
end

function slot0._setGoldRewards(slot0, slot1)
	if SignInModel.instance:checkIsGoldDay(slot1) then
		slot3 = SignInModel.instance:getTargetDailyAllowanceBonus(slot1)

		gohelper.setActive(slot0._gonormaldayreward_gold, slot3)
		gohelper.setActive(slot0._gomonthcarddayreward_gold, slot3)

		if slot3 then
			slot4 = string.split(slot3, "#")
			slot0._goldReward = slot4
			slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot4[1], slot4[2], true)
			slot0._txtnormaldayrewardcount_gold.text = luaLang("multiple") .. tostring(slot4[3])
			slot0._txtmonthcarddayrewardcount_gold.text = luaLang("multiple") .. tostring(slot4[3])

			slot0._simagenormaldayrewardicon_gold:LoadImage(slot6)
			slot0._simagemonthcarddayrewardicon_gold:LoadImage(slot6)

			if tonumber(slot4[1]) == MaterialEnum.MaterialType.Equip then
				slot0._simagenormaldayrewardicon_gold:LoadImage(ResUrl.getPropItemIcon(slot5.icon))
				slot0._simagemonthcarddayrewardicon_gold:LoadImage(ResUrl.getPropItemIcon(slot5.icon))
			end
		end
	else
		gohelper.setActive(slot0._gonormaldayreward_gold, false)
		gohelper.setActive(slot0._gomonthcarddayreward_gold, false)
	end
end

function slot0._switchFestivalDecoration(slot0, slot1)
	gohelper.setActive(slot0._gofestivaldecorationtop, slot1)
	gohelper.setActive(slot0._gofestivaldecorationbottom, slot1)
	gohelper.setActive(slot0._gorewardicon, slot1 == false)
	gohelper.setActive(slot0._goeffect, slot1)
	slot0._simagebg:LoadImage(ResUrl.getSignInBg(slot1 and "v2a2_bg_white" or "bg_white"))

	slot3 = slot1 and "#08634F" or "#222222"

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtmonth, slot3)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imgbias, slot3)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtday, slot3)
end

function slot0.onDestroyView(slot0)
	UIBlockMgr.instance:endBlock("signshowing")
	TaskDispatcher.cancelTask(slot0._setView1Effect, slot0)
	TaskDispatcher.cancelTask(slot0._onLineAniStart, slot0)
	TaskDispatcher.cancelTask(slot0._calendarBtnEffect, slot0)
	TaskDispatcher.cancelTask(slot0._delaySignInRequest, slot0)
	TaskDispatcher.cancelTask(slot0._showGetRewards, slot0)

	for slot4, slot5 in pairs(slot0._delayAnimTab) do
		TaskDispatcher.cancelTask(slot5, slot0)
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagerewardbg:UnLoadImage()
	slot0._simagemonthicon1:UnLoadImage()
	slot0._simagemonthicon2:UnLoadImage()
	slot0._simagemonthicon3:UnLoadImage()
end

function slot0.closeThis(slot0)
	uv0.super.closeThis(slot0)
	MailController.instance:showOrRegisterEvent()
end

return slot0

module("modules.logic.signin.view.SignInView", package.seeall)

slot0 = class("SignInView", BaseView)
slot1 = SLFramework.AnimatorPlayer

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg1")
	slot0._imageweek = gohelper.findChildImage(slot0.viewGO, "bg/#image_week")
	slot0._goroleitem = gohelper.findChild(slot0.viewGO, "bg/#go_roleitem")
	slot0._simagetopicon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#go_roleitem/#simage_topicon")
	slot0._goicontip = gohelper.findChild(slot0.viewGO, "bg/#go_roleitem/#go_icontip")
	slot0._txtbirtime = gohelper.findChildText(slot0.viewGO, "bg/#go_roleitem/#txt_birtime")
	slot0._txtlimit = gohelper.findChildText(slot0.viewGO, "bg/#go_roleitem/#txt_limit")
	slot0._goget = gohelper.findChild(slot0.viewGO, "rightContent/#go_get")
	slot0._gonoget = gohelper.findChild(slot0.viewGO, "rightContent/#go_noget")
	slot0._gomonthdetail = gohelper.findChild(slot0.viewGO, "rightContent/monthdetail")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "scroll_desc/Viewport/Content/#txt_desc")
	slot0._txtday = gohelper.findChildText(slot0.viewGO, "leftContent/#txt_day")
	slot0._txtmonth = gohelper.findChildText(slot0.viewGO, "leftContent/#txt_month")
	slot0._txtdate = gohelper.findChildText(slot0.viewGO, "leftContent/#txt_date")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "leftBottomContent/#go_rewarditem")
	slot0._simageorangebg = gohelper.findChildSingleImage(slot0._gorewarditem, "#simage_orangebg")
	slot0._godayrewarditem = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem")
	slot0._gorewardbg = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#simage_rewardbg")
	slot0._simagerewardbg = gohelper.findChildSingleImage(slot0._gorewarditem, "#go_dayrewarditem/#simage_rewardbg")
	slot0._gototalreward = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward")
	slot0._txtdaycount = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/monthtitle/#txt_daycount")
	slot0._txtmonthtitle = gohelper.findChildText(slot0.viewGO, "leftBottomContent/#go_rewarditem/#go_dayrewarditem/#go_totalreward/monthtitle")
	slot0._gomonth1 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1")
	slot0._monthreward1Click = gohelper.getClick(slot0._gomonth1)
	slot0._gomonthmask1 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1")
	slot0._month1canvasGroup = slot0._gomonthmask1:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._gorewardmark1 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#go_rewardmark1")
	slot0._txtmonthquantity1 = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#txt_monthquantity1")
	slot0._txtrewardcount1 = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#txt_count1")
	slot0._gomonthtip1 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthtip1")
	slot0._gomonthget1 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthget1")
	slot0._gomonthgetlightanim1 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthget1/vxeffect")
	slot0._gonomonthget1 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_nomonthget1")
	slot0._gogetmonthbg1 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#go_getbg1")
	slot0._simagemonthicon1 = gohelper.findChildSingleImage(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month1/#go_monthmask1/#simage_monthicon1")
	slot0._month1Ani = slot0._simagemonthicon1.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._gomonth2 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2")
	slot0._monthreward2Click = gohelper.getClick(slot0._gomonth2)
	slot0._gomonthmask2 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2")
	slot0._month2canvasGroup = slot0._gomonthmask2:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._gorewardmark2 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#go_rewardmark2")
	slot0._txtmonthquantity2 = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#txt_monthquantity2")
	slot0._txtrewardcount2 = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#txt_count2")
	slot0._gomonthtip2 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthtip2")
	slot0._gomonthget2 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthget2")
	slot0._gomonthgetlightanim2 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthget2/vxeffect")
	slot0._gonomonthget2 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_nomonthget2")
	slot0._gogetmonthbg2 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#go_getbg2")
	slot0._simagemonthicon2 = gohelper.findChildSingleImage(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month2/#go_monthmask2/#simage_monthicon2")
	slot0._month2Ani = slot0._simagemonthicon2.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._gomonth3 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3")
	slot0._monthreward3Click = gohelper.getClick(slot0._gomonth3)
	slot0._gomonthmask3 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3")
	slot0._month3canvasGroup = slot0._gomonthmask3:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._gorewardmark3 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#go_rewardmark3")
	slot0._txtmonthquantity3 = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#txt_monthquantity3")
	slot0._txtrewardcount3 = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#txt_count3")
	slot0._gomonthtip3 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthtip3")
	slot0._gomonthget3 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthget3")
	slot0._gomonthgetlightanim3 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthget3/vxeffect")
	slot0._gonomonthget3 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_nomonthget3")
	slot0._gogetmonthbg3 = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#go_getbg3")
	slot0._simagemonthicon3 = gohelper.findChildSingleImage(slot0._gorewarditem, "#go_dayrewarditem/#go_totalreward/#go_month3/#go_monthmask3/#simage_monthicon3")
	slot0._month3Ani = slot0._simagemonthicon3.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._gocurrentreward = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward")
	slot0._gonormal = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal")
	slot0._gonormaldayreward = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/")
	slot0._gonormalday = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday")
	slot0._normaldayClick = gohelper.getClick(slot0._gonormalday)
	slot0._gonormalday_gold = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday")
	slot0._normaldayClick_gold = gohelper.getClick(slot0._gonormalday_gold)
	slot0._simagenormaldayrewardicon = gohelper.findChildSingleImage(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#simage_normaldayrewardicon")
	slot0._txtnormaldayrewardcount = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#simage_normaldayrewardicon/#txt_normaldayrewardcount")
	slot0._txtnormaldayrewardname = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normalday/#txt_normaldayrewardname")
	slot0._gonormaldaysigned = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned")
	slot0._gonormaldayget = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned/#go_normaldayget")
	slot0._gonormaldaynoget = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item1/#go_normaldaysigned/#go_normaldaynoget")
	slot0._normaldayrewardAni = slot0._simagenormaldayrewardicon.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._gonormaldayreward_gold = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2")
	slot0._simagenormaldayrewardicon_gold = gohelper.findChildSingleImage(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#simage_normaldayrewardicon")
	slot0._txtnormaldayrewardcount_gold = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#simage_normaldayrewardicon/#txt_normaldayrewardcount")
	slot0._txtnormaldayrewardname_gold = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normalday/#txt_normaldayrewardname")
	slot0._gonormaldaysigned_gold = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned")
	slot0._gonormaldayget_gold = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned/#go_normaldayget")
	slot0._gonormaldaynoget_gold = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_normal/#go_normaldayreward/LayoutGroup/Item2/#go_normaldaysigned/#go_normaldaynoget")
	slot0._normaldayrewardAni_gold = slot0._simagenormaldayrewardicon_gold.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._gomonthcard = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard")
	slot0._gomonthcarddayreward = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward")
	slot0._gomonthcardday = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday")
	slot0._monthcarddayClick = gohelper.getClick(slot0._gomonthcardday)
	slot0._gomonthcardday_gold = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday")
	slot0._monthcarddayClick_gold = gohelper.getClick(slot0._gomonthcardday_gold)
	slot0._txtmonthcarddayrewardname = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#txt_monthcarddayrewardname")
	slot0._simagemonthcarddayrewardicon = gohelper.findChildSingleImage(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#simage_monthcarddayrewardicon")
	slot0._txtmonthcarddayrewardcount = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcardday/#simage_monthcarddayrewardicon/#txt_monthcarddayrewardcount")
	slot0._gomonthcarddaysigned = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned")
	slot0._gomonthcarddayget = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned/#go_monthcarddayget")
	slot0._gomonthcarddaynoget = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item1/#go_monthcarddaysigned/#go_nomonthcarddayget")
	slot0._gomonthcarddayreward_gold = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2")
	slot0._txtmonthcarddayrewardname_gold = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#txt_monthcarddayrewardname")
	slot0._simagemonthcarddayrewardicon_gold = gohelper.findChildSingleImage(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#simage_monthcarddayrewardicon")
	slot0._txtmonthcarddayrewardcount_gold = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcardday/#simage_monthcarddayrewardicon/#txt_monthcarddayrewardcount")
	slot0._gomonthcarddaysigned_gold = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned")
	slot0._gomonthcarddayget_gold = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned/#go_monthcarddayget")
	slot0._gomonthcarddaynoget_gold = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcarddayreward/LayoutGroup/Item2/#go_monthcarddaysigned/#go_nomonthcarddayget")
	slot0._gomonthcardreward = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward")
	slot0._gomonthcardrewarditem = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem")
	slot0._txtmonthcardname = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#txt_monthcardname")
	slot0._simagemonthcardicon = gohelper.findChildSingleImage(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#simage_monthcardicon")
	slot0._monthcardClick = gohelper.getClick(slot0._gomonthcardrewarditem.gameObject)
	slot0._gomonthcardpowerrewarditem = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem")
	slot0._txtmonthcardcount = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardrewarditem/#simage_monthcardicon/#txt_monthcardcount")
	slot0._txtmonthcardpowername = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#txt_monthcardname")
	slot0._simagemonthcardpowericon = gohelper.findChildSingleImage(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#simage_monthcardicon")
	slot0._monthcardpowerClick = gohelper.getClick(slot0._gomonthcardpowerrewarditem.gameObject)
	slot0._txtmonthcardpowercount = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardpowerrewarditem/#simage_monthcardicon/#txt_monthcardcount")
	slot0._gopowerlimittime = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_powerlimittime")
	slot0._golimittime = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime")
	slot0._txtlimittime = gohelper.findChildText(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/#txt_limittime")
	slot0._gonormallimittimebg = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/normalbg")
	slot0._goredlimittimebg = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_limittime/redbg")
	slot0._gomonthcardsigned = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned")
	slot0._gomonthcardget = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardget")
	slot0._gomonthcardnoget = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardnoget")
	slot0._gomonthcardpowernoget = gohelper.findChild(slot0._gorewarditem, "#go_dayrewarditem/#go_currentreward/#go_monthcard/#go_monthcardreward/#go_monthcardsigned/#go_monthcardpowernoget")
	slot0._gobirthdayrewarditem = gohelper.findChild(slot0._gorewarditem, "#go_birthdayrewarditem")
	slot0._simagebirthdaybg = gohelper.findChildSingleImage(slot0._gorewarditem, "#go_birthdayrewarditem/#simage_birthdaybg")
	slot0._simagebirthdaybg2 = gohelper.findChildSingleImage(slot0._gorewarditem, "#go_birthdayrewarditem/#simage_birthdaybg2")
	slot0._gobirthday = gohelper.findChild(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday")
	slot0._simagebirthdayIcon = gohelper.findChildSingleImage(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#simage_icon")
	slot0._btngift = gohelper.findChildButtonWithAudio(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#btn_gift")
	slot0._gogiftget = gohelper.findChild(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_get")
	slot0._gogiftnoget = gohelper.findChild(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_noget")
	slot0._gogiftreddot = gohelper.findChild(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#btn_gift/#go_reddot")
	slot0._gobirthdayrewarddetail = gohelper.findChild(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail")
	slot0._gocontentSize = gohelper.findChild(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize")
	slot0._trstitle = gohelper.findChild(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/bg/title").transform
	slot0._txtrewarddetailtitle = gohelper.findChildText(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/title/#txt_rewarddetailtitle")
	slot0._gorewardContent = gohelper.findChild(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/Viewport/Content")
	slot0._goclickarea = gohelper.findChild(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/Viewport/Content/#go_rewardContent/#go_clickarea")
	slot0._gorewarddetailitem = gohelper.findChild(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#go_birthdayrewarddetail/#go_contentSize/Scroll View/#go_rewarddetailItem")
	slot0._txtdeco = gohelper.findChildText(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/scroll_desc/Viewport/Content/#txt_deco")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0._gorewarditem, "#go_birthdayrewarditem/#go_birthday/#simage_signature")
	slot0._btnqiehuan = gohelper.findChildButtonWithAudio(slot0.viewGO, "leftBottomContent/#btn_qiehuan")
	slot0._goqiehuan = gohelper.findChild(slot0.viewGO, "leftBottomContent/#btn_qiehuan/#qiehuan")

	if GMController.instance:getGMNode("signinview", gohelper.findChild(slot0.viewGO, "leftContent")) then
		slot0._gogmhelp = gohelper.findChild(slot1, "#go_gmhelp")
		slot0._inputheros = gohelper.findChildTextMeshInputField(slot1, "#go_gmhelp/#input_heros")
		slot0._droptimes = gohelper.findChildDropdown(slot1, "#go_gmhelp/#drop_times")
		slot0._gochangedate = gohelper.findChild(slot1, "#go_changedate")
		slot0._inputdate = gohelper.findChildTextMeshInputField(slot1, "#go_changedate/#input_date")
		slot0._btnchangedateright = gohelper.findChildButtonWithAudio(slot1, "#go_changedate/#btn_changedateright")
		slot0._btnchangedateleft = gohelper.findChildButtonWithAudio(slot1, "#go_changedate/#btn_changedateleft")
		slot0._btnswitchdecorate = gohelper.findChildButtonWithAudio(slot1, "#go_gmhelp/#_btns_switchdecorate")
	end

	slot0._gomonth = gohelper.findChild(slot0.viewGO, "#go_month")
	slot0._scrollmonth = gohelper.findChildScrollRect(slot0.viewGO, "#go_month/#scroll_month")
	slot0._gomonthlayout = gohelper.findChild(slot0.viewGO, "#go_month/#scroll_month/#go_monthlayout")
	slot0._gomonthitem = gohelper.findChild(slot0.viewGO, "#go_month/#scroll_month/#go_monthlayout/#go_monthitem")
	slot0._gosigninmonthitem = gohelper.findChild(slot0.viewGO, "#go_month/#scroll_month/#go_monthlayout/#go_monthitem/#go_signinmonthitem")
	slot0._gomonthleftline = gohelper.findChild(slot0.viewGO, "#go_month/leftline")
	slot0._gomonthrightline = gohelper.findChild(slot0.viewGO, "#go_month/rightline")
	slot0._gomonthanim = gohelper.findChild(slot0.viewGO, "#go_month"):GetComponent(typeof(UnityEngine.Animator))
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_switch")
	slot0._imageswitchicon = gohelper.findChildImage(slot0.viewGO, "#btn_switch/#image_switchicon")
	slot0._gonodes = gohelper.findChild(slot0.viewGO, "#go_nodes")
	slot0._gonodeitem = gohelper.findChild(slot0.viewGO, "#go_nodes/node")
	slot0._btnrewarddetailclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_rewarddetailclose")
	slot0._viewAnimPlayer = uv0.Get(slot0.viewGO)
	slot0._viewAniEventWrap = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	slot0._gofestivaldecorationright = gohelper.findChild(slot0.viewGO, "bg/#go_festivaldecorationright")
	slot0._gofestivaldecorationleft = gohelper.findChild(slot0.viewGO, "#go_festivaldecorationleft")
	slot0._gofestivaldecorationtop = gohelper.findChild(slot0.viewGO, "bg/#simage_bg/#go_festivaldecorationtop")
	slot0._godayrewarditem_festivaldecorationtop = gohelper.findChild(slot0._godayrewarditem, "#go_festivaldecorationtop")
	slot0._godayrewarditem_gofestivaldecorationleft2 = gohelper.findChild(slot0._godayrewarditem, "#go_festivaldecorationleft2")
	slot0._gorewardicon = gohelper.findChild(slot0.viewGO, "bg/#go_rewardicon")
	slot0._imgbias = gohelper.findChildImage(slot0.viewGO, "leftContent/#image_bias")
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "#go_effect")
	slot0._goLifeCircle = gohelper.findChild(slot0.viewGO, "#go_LifeCircle")
	slot0._gobtnchange = gohelper.findChild(slot0.viewGO, "#go_btnchange")
	slot0._btnchange = gohelper.findChildButtonWithAudio(slot0._gobtnchange, "#btn_change")
	slot0._btnchange2 = gohelper.findChildButtonWithAudio(slot0._gobtnchange, "#btn_change2")
	slot0._gochange = gohelper.findChild(slot0._gobtnchange, "#go_change")
	slot0._gobtnchange_gofestivaldecoration = gohelper.findChild(slot0._gobtnchange, "#go_festivaldecoration")
	slot0._goLifeCircleRed = gohelper.findChild(slot0._gobtnchange, "#go_LifeCircleRed")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnswitch:AddClickListener(slot0._onBtnSwitch, slot0)
	slot0._btnqiehuan:AddClickListener(slot0._btnqiehuanOnClick, slot0)
	slot0._btngift:AddClickListener(slot0._onBtnGift, slot0)
	slot0._btnrewarddetailclose:AddClickListener(slot0._onBtnRewardDetailClick, slot0)

	if slot0._droptimes then
		slot0._droptimes:AddOnValueChanged(slot0._onTimesValueChanged, slot0)
	end

	if slot0._inputheros then
		slot0._inputheros:AddOnValueChanged(slot0._onInputValueChanged, slot0)
	end

	if slot0._inputdate then
		slot0._inputheros:AddOnValueChanged(slot0._onInputDateChange, slot0)
	end

	if slot0._btnchangedateleft then
		slot0._btnchangedateleft:AddClickListener(slot0._onBtnChangeDateLeftClick, slot0)
	end

	if slot0._btnchangedateright then
		slot0._btnchangedateright:AddClickListener(slot0._onBtnChangeDateRightClick, slot0)
	end

	if slot0._btnswitchdecorate then
		slot0._btnswitchdecorate:AddClickListener(slot0._onBtnChangeDecorate, slot0)
	end

	slot0._btnchange:AddClickListener(slot0._btnchangeOnClick, slot0)
	slot0._btnchange2:AddClickListener(slot0._btnchangeOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnswitch:RemoveClickListener()
	slot0._btnqiehuan:RemoveClickListener()
	slot0._btngift:RemoveClickListener()
	slot0._btnrewarddetailclose:RemoveClickListener()

	if slot0._droptimes then
		slot0._droptimes:RemoveOnValueChanged()
	end

	if slot0._inputheros then
		slot0._inputheros:RemoveOnValueChanged()
	end

	if slot0._inputdate then
		slot0._inputdate:RemoveOnValueChanged()
	end

	if slot0._btnchangedateright then
		slot0._btnchangedateright:RemoveClickListener()
	end

	if slot0._btnchangedateleft then
		slot0._btnchangedateleft:RemoveClickListener()
	end

	if slot0._btnswitchdecorate then
		slot0._btnswitchdecorate:RemoveClickListener()
	end

	slot0._btnchange:RemoveClickListener()
	slot0._btnchange2:RemoveClickListener()
end

slot0.MaxTipContainerHeight = 420
slot0.EveryTipItemHeight = 135
slot0.TipVerticalInterval = 25
slot2 = "SignInView:_switchLifeCircleAnsSignIn"

function slot0._onTimesValueChanged(slot0, slot1)
end

function slot0._onInputDateChange(slot0)
end

function slot0._onBtnChangeDateLeftClick(slot0)
	slot0:_refreshGMDateContent(1)
end

function slot0._onBtnChangeDateRightClick(slot0)
	slot0:_refreshGMDateContent(-1)
end

function slot0._onBtnChangeDecorate(slot0)
	if slot0._isActiveLifeCircle then
		GameFacade.showToast(ToastEnum.IconId, "生命签界面是常驻界面，无法切换氛围！")

		return
	end

	slot0:_switchFestivalDecoration(not slot0._haveFestival)
	slot0:_setPropItems()
end

function slot0._refreshGMDateContent(slot0, slot1)
	if not string.splitToNumber(slot0._inputdate:GetText(), "-") or #slot2 ~= 3 then
		logError("请按照正确的格式输入日期！")

		return
	end

	slot3 = TimeUtil.timeToTimeStamp(slot2[1], slot2[2], slot2[3], 1, 1, 1) + 86400 * slot1

	UISpriteSetMgr.instance:setSignInSprite(slot0._imageweek, "date_" .. tostring(os.date("%w", slot3)))

	slot0._txtdesc.text = SignInConfig.instance:getSignDescByDate(slot3)
	slot0._txtday.text = string.format("%02d", os.date("%d", slot3))
	slot0._txtmonth.text = string.format("%02d", os.date("%m", slot3))
	slot0._txtdate.text = string.format("%s.%s", string.upper(string.sub(os.date("%B", slot3), 1, 3)), os.date("%Y", slot3))

	slot0._inputdate:SetText(TimeUtil.timestampToString1(slot3))
end

function slot0._onInputValueChanged(slot0)
	if slot0:_getTextInputheros() ~= "" then
		gohelper.setActive(slot0._btnqiehuan.gameObject, true)

		return
	end

	slot2 = SignInModel.instance:getSignBirthdayHeros(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3])

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot2 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	gohelper.setActive(slot0._btnqiehuan.gameObject, #slot2 > 0)
end

function slot0._onBtnSwitch(slot0)
	SignInModel.instance:setNewSwitch(true)
	SignInModel.instance:setShowBirthday(not SignInModel.instance:isShowBirthday())
	SignInController.instance:dispatchEvent(SignInEvent.SwitchBirthdayState)
	slot0:_setTitleInfo()
end

function slot0._btnqiehuanOnClick(slot0)
	slot1 = SignInModel.instance:getSignBirthdayHeros(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3])

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	if slot0:_getTextInputheros() ~= "" then
		slot1 = string.splitToNumber(slot2, "|")
	end

	slot0._index = (slot0._index + 1) % (#slot1 + 1)

	UIBlockMgr.instance:startBlock("signshowing")
	TaskDispatcher.runDelay(slot0._onQiehuanFinished, slot0, 0.85)

	if slot0._index == 1 then
		slot0:_setRewardItems()
		slot0:_playAnim("tobirthday")
	elseif slot0._index > 1 then
		slot0:_playAnim("birhtobirth")
	else
		slot0:_playAnim("tonormal")
	end
end

function slot0._onQiehuanFinished(slot0)
	UIBlockMgr.instance:endBlock("signshowing")
end

function slot0._onBtnGift(slot0)
	slot1 = SignInModel.instance:getSignBirthdayHeros(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3])

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = SignInModel.instance:getCurDayBirthdayHeros()

		if slot0:_getTextInputheros() ~= "" then
			slot1 = string.splitToNumber(slot2, "|")
		end

		if not SignInModel.instance:isHeroBirthdayGet(slot1[slot0._index]) then
			slot0._startGetReward = true

			SignInRpc.instance:sendGetHeroBirthdayRequest(slot3)

			return
		end
	end

	slot0:_showBirthdayRewardDetail()
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
	SignInController.instance:registerCallback(SignInEvent.CloseSignInView, slot0._onEscapeBtnClick, slot0)
	PlayerController.instance:registerCallback(PlayerEvent.OnDailyRefresh, slot0._onDailyRefresh, slot0)
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
	SignInController.instance:unregisterCallback(SignInEvent.CloseSignInView, slot0._onEscapeBtnClick, slot0)
	PlayerController.instance:unregisterCallback(PlayerEvent.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0._onEscapeBtnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_close)
	slot0:_playAnim("out")
	TaskDispatcher.runDelay(slot0._waitCloseView, slot0, 0.2)
end

function slot0._onDayRewardClick(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0._curDayRewards[1], slot0._curDayRewards[2])
end

function slot0._onDayGoldRewardClick(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0._goldReward[1], slot0._goldReward[2])
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

	if slot0:_getTextInputheros() ~= "" and slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = string.splitToNumber(slot2, "|")
	end

	slot3 = false

	for slot7, slot8 in pairs(slot1) do
		if not SignInModel.instance:isHeroBirthdayGet(slot8) then
			slot3 = true
		end
	end

	gohelper.setActive(slot0._goqiehuan, slot3)
	gohelper.setActive(slot0._gogiftnoget, false)
	gohelper.setActive(slot0._gogiftget, true)
end

function slot0._closeViewEffect(slot0)
	slot0._clickMonth = true
	slot0._index = 0

	slot0:_playAnim("idel")
	slot0:_setMonthView()
	gohelper.setSiblingBefore(slot0._gobirthdayrewarditem, slot0._godayrewarditem)
end

function slot0.onClickModalMask(slot0)
	slot0:_onEscapeBtnClick()
end

function slot0._waitCloseView(slot0)
	SignInController.instance:openSignInDetailView(slot0.viewParam)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnqiehuan.gameObject, AudioEnum.UI.play_ui_sign_in_qiehuan)
	gohelper.addUIClickAudio(slot0._btnswitch.gameObject, AudioEnum.UI.play_ui_sign_in_switch)

	slot0._clickMonth = false

	gohelper.setActive(slot0._gomonthleftline, false)
	gohelper.setActive(slot0._gomonthrightline, false)
	gohelper.setActive(slot0._gomonthget1, false)
	gohelper.setActive(slot0._gonomonthget1, false)
	gohelper.setActive(slot0._gomonthget2, false)
	gohelper.setActive(slot0._gonomonthget2, false)
	gohelper.setActive(slot0._gomonthget3, false)
	gohelper.setActive(slot0._gonomonthget3, false)
	gohelper.setActive(slot0._gomonthcardsigned, false)
	gohelper.setActive(slot0._gomonthcarddaysigned, false)
	gohelper.setActive(slot0._gomonthcarddaysigned_gold, false)
	gohelper.setActive(slot0._gonormaldaysigned, false)
	gohelper.setActive(slot0._gonormaldaysigned_gold, false)
	slot0._normaldayrewardAni:Play("none")
	slot0._normaldayrewardAni_gold:Play("none")
	slot0:_playAnim("go_view_in2")

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
	slot0._simagebg:LoadImage(ResUrl.getSignInBg("bg_white2"))
	slot0._simagebg1:LoadImage(ResUrl.getSignInBg("bg_zs"))
	slot0._simageorangebg:LoadImage(ResUrl.getSignInBg("img_bcard3"))

	slot4 = "img_di"

	slot0._simagerewardbg:LoadImage(ResUrl.getSignInBg(slot4))

	slot0._rewardTipItems = {}
	slot0._nodeItems = {}
	slot0._monthItemTabs = slot0:getUserDataTb_()
	slot0._monthgetlightanimTab = slot0:getUserDataTb_()
	slot0._delayAnimTab = slot0:getUserDataTb_()
	slot0._monthRewards = slot0:getUserDataTb_()

	table.insert(slot0._monthgetlightanimTab, slot0._gomonthgetlightanim1)
	table.insert(slot0._monthgetlightanimTab, slot0._gomonthgetlightanim2)
	table.insert(slot0._monthgetlightanimTab, slot0._gomonthgetlightanim3)

	for slot4, slot5 in ipairs(slot0._monthgetlightanimTab) do
		gohelper.setActive(slot5, false)
	end

	slot0._btnchangeGo = slot0._btnchange.gameObject
	slot0._btnchange2Go = slot0._btnchange2.gameObject

	slot0:_setActive_LifeCicle(false)
	RedDotController.instance:addRedDot(slot0._goLifeCircleRed, RedDotEnum.DotNode.LifeCircleNewConfig, nil, slot0._checkLifeCircleRed, slot0)
end

function slot0.onOpen(slot0)
	slot0._index = 0
	slot0._checkSignIn = true

	SignInModel.instance:setShowBirthday(slot0.viewParam.isBirthday)
	slot0:_addCustomEvent()
	slot0:_setMonthView(true)
	slot0:_setRedDot()

	if slot0._gogmhelp then
		gohelper.setActive(slot0._gogmhelp, GMController.instance:isOpenGM())
	end

	if slot0._gochangedate then
		gohelper.setActive(slot0._gochangedate, GMController.instance:isOpenGM())
	end

	SignInModel.instance:setNewShowDetail(true)
	NavigateMgr.instance:addEscape(ViewName.SignInView, slot0._onEscapeBtnClick, slot0)
	slot0:_refreshFestivalDecoration()
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

	if slot0:_getTextInputheros() ~= "" and slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = string.splitToNumber(slot2, "|")
	end

	for slot6, slot7 in ipairs(slot1) do
		if not SignInModel.instance:isHeroBirthdayGet(slot7) then
			gohelper.setSiblingBefore(slot0._godayrewarditem, slot0._gobirthdayrewarditem)

			slot0._index = slot6

			return
		end
	end
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
	gohelper.setActive(slot0._gomonthcarddayget, false)
	gohelper.setActive(slot0._gomonthcarddayget_gold, false)
	gohelper.setActive(slot0._gomonthcardget, false)
	gohelper.setActive(slot0._gonormaldaynoget, false)
	gohelper.setActive(slot0._gomonthcarddaynoget, false)
	gohelper.setActive(slot0._gomonthcarddaynoget_gold, false)
	gohelper.setActive(slot0._gomonthcardnoget, false)
	gohelper.setActive(slot0._gomonthcardpowernoget, false)
	gohelper.setActive(slot0._goget, false)
	gohelper.setActive(slot0._gonoget, true)
	gohelper.setActive(slot0._goget, false)
	gohelper.setActive(slot0._gonoget, false)
	slot0:_setMonthView()
	slot0:_onChangeToNormal()
end

function slot0._onChangeItemClick(slot0)
	slot0._index = 0

	slot0:_playAnim("idel")
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
	slot0:_setPropItems()
	slot0:_setMonthItems()

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
		gohelper.setActive(slot0._gomonthcarddayget, true)
		gohelper.setActive(slot0._gomonthcarddayget_gold, true)
		gohelper.setActive(slot0._gomonthcardget, true)
		gohelper.setActive(slot0._gonormaldaynoget, false)
		gohelper.setActive(slot0._gomonthcarddaynoget, false)
		gohelper.setActive(slot0._gomonthcarddaynoget_gold, false)
		gohelper.setActive(slot0._gomonthcardnoget, false)
		gohelper.setActive(slot0._gomonthcardpowernoget, false)
		gohelper.setActive(slot0._goget, false)
		gohelper.setActive(slot0._gonoget, true)
		slot0._normaldayrewardAni:Play("none")
		slot0._normaldayrewardAni_gold:Play("none")
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
		gohelper.setActive(slot0._goget, true)
		gohelper.setActive(slot0._gonoget, false)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtnormaldayrewardcount, 0.7)

		if slot0._gonormaldayget.activeSelf then
			slot0._normaldayrewardAni:Play("none")
			slot0._normaldayrewardAni_gold:Play("none")
		else
			gohelper.setActive(slot0._gomonthcarddayget, false)
			gohelper.setActive(slot0._gomonthcarddayget_gold, false)
			gohelper.setActive(slot0._gomonthcardget, false)
			gohelper.setActive(slot0._gomonthcardnoget, true)
			gohelper.setActive(slot0._gomonthcardpowernoget, true)
			gohelper.setActive(slot0._gomonthcarddaynoget, true)
			gohelper.setActive(slot0._gomonthcarddaynoget_gold, true)
			slot0._normaldayrewardAni:Play("lingqu")
			slot0._normaldayrewardAni_gold:Play("lingqu")
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

function slot0._setTitleInfo(slot0)
	slot1 = TimeUtil.timeToTimeStamp(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3], TimeDispatcher.DailyRefreshTime, 1, 1)

	if ServerTime.weekDayInServerLocal() >= 7 then
		slot2 = 0
	end

	UISpriteSetMgr.instance:setSignInSprite(slot0._imageweek, "date_" .. tostring(slot2))

	slot0._txtdesc.text = SignInConfig.instance:getSignDescByDate(slot1)
	slot0._txtday.text = string.format("%02d", slot0._targetDate[3])
	slot0._txtmonth.text = string.format("%02d", slot0._targetDate[2])
	slot0._txtdate.text = string.format("%s.%s", string.upper(string.sub(os.date("%B", slot1), 1, 3)), slot0._targetDate[1])

	UISpriteSetMgr.instance:setSignInSprite(slot0._imageswitchicon, SignInModel.instance:isShowBirthday() and "switch_icon1" or "switch_icon2")

	slot4, slot5 = SignInModel.instance:getAdvanceHero()

	if slot4 == 0 then
		gohelper.setActive(slot0._goroleitem, false)
	else
		gohelper.setActive(slot0._goroleitem, true)
		slot0._simagetopicon:LoadImage(ResUrl.getHeadIconSmall(HeroModel.instance:getByHeroId(slot4) and slot6.skin or HeroConfig.instance:getHeroCO(slot4).skinId))

		slot0._txtbirtime.text = slot5
		slot0._txtlimit.text = slot5 > 1 and "Days Later" or "Day Later"
	end
end

function slot0._setRewardItems(slot0)
	slot1 = SignInModel.instance:getSignBirthdayHeros(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3])

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	if slot0:_getTextInputheros() ~= "" and slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = string.splitToNumber(slot2, "|")
	end

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		if slot0._index > 0 then
			RedDotController.instance:addRedDot(slot0._gogiftreddot, RedDotEnum.DotNode.SignInBirthReward, slot1[slot0._index])
		end
	else
		RedDotController.instance:addRedDot(slot0._gogiftreddot, 0)
	end

	slot3 = false

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		for slot7, slot8 in pairs(slot1) do
			if not SignInModel.instance:isHeroBirthdayGet(slot8) then
				slot3 = true
			end
		end
	end

	gohelper.setActive(slot0._goqiehuan, slot3)

	for slot7, slot8 in pairs(slot0._nodeItems) do
		gohelper.setActive(slot8.go, false)
	end

	if #slot1 > 0 then
		for slot7 = 1, #slot1 + 1 do
			if not slot0._nodeItems[slot7] then
				slot0._nodeItems[slot7] = slot0:getUserDataTb_()
				slot0._nodeItems[slot7].go = gohelper.cloneInPlace(slot0._gonodeitem, "node" .. tostring(slot7))
				slot0._nodeItems[slot7].on = gohelper.findChild(slot0._nodeItems[slot7].go, "on")
				slot0._nodeItems[slot7].off = gohelper.findChild(slot0._nodeItems[slot7].off, "off")
			end

			gohelper.setActive(slot0._nodeItems[slot7].go, true)
			gohelper.setActive(slot0._nodeItems[slot7].on, slot0._index == slot7 - 1)
			gohelper.setActive(slot0._nodeItems[slot7].off, slot0._index ~= slot7 - 1)
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

function slot0._delaySignInRequest(slot0)
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
	gohelper.setActive(slot0._goget, true)
	gohelper.setActive(slot0._gonoget, false)
	slot0._normaldayrewardAni:Play("lingqu")
	slot0._normaldayrewardAni_gold:Play("lingqu")
	ZProj.UGUIHelper.SetColorAlpha(slot0._txtnormaldayrewardcount, 0.7)
	UIBlockMgr.instance:endBlock("signshowing")

	if slot0._startGetReward then
		return
	end

	LifeCircleController.instance:sendSignInRequest()

	slot0._startGetReward = true
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

function slot0._onWaitSwitchBirthFinished(slot0)
	UIBlockMgr.instance:endBlock("switchshowing")
end

function slot0._onCloseMonthRewardDetailClick(slot0)
	gohelper.setActive(slot0._gomonthrewarddetail, false)
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

function slot0._setBirthdayInfo(slot0)
	slot1 = SignInModel.instance:getSignBirthdayHeros(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3])

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	if slot0:_getTextInputheros() ~= "" then
		slot1 = string.splitToNumber(slot2, "|")
	end

	slot0._simagebirthdayIcon:LoadImage(ResUrl.getHeadIconSmall(HeroModel.instance:getByHeroId(slot1[slot0._index]) and slot4.skin or HeroConfig.instance:getHeroCO(slot3).skinId))

	slot7 = SignInModel.instance:getHeroBirthdayCount(slot3)

	if slot0._curDate.month == slot0._targetDate[2] then
		slot8 = SignInModel.instance:isHeroBirthdayGet(slot3)
		slot7 = slot0._curDate.year == slot0._targetDate[1] and (slot8 and slot6 or slot6 + 1) or slot8 and slot6 - 1 or slot6
	end

	if slot2 ~= "" then
		slot7 = slot0._droptimes:GetValue() + 1
	end

	slot0._txtdeco.text = string.split(HeroConfig.instance:getHeroCO(slot3).desc, "|")[slot7]

	slot0._simagesignature:LoadImage(ResUrl.getSignature(tostring(slot3)))

	slot9 = true

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot9 = SignInModel.instance:isHeroBirthdayGet(slot3)
	end

	gohelper.setActive(slot0._gogiftnoget, not slot9)
	gohelper.setActive(slot0._gogiftget, slot9)
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
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtrewardcount1, 0.5)
	else
		gohelper.setActive(slot0._gomonthget1, false)
		gohelper.setActive(slot0._gonomonthget1, false)
		slot0._month1Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthquantity1, 1)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtrewardcount1, 1)
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
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtrewardcount2, 0.5)
	else
		gohelper.setActive(slot0._gomonthget2, false)
		gohelper.setActive(slot0._gonomonthget2, false)
		slot0._month2Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthquantity2, 1)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtrewardcount2, 1)
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
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtrewardcount3, 0.5)
	else
		gohelper.setActive(slot0._gomonthget3, false)
		gohelper.setActive(slot0._gonomonthget3, false)
		slot0._month3Ani:Play("none")
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtmonthquantity3, 1)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtrewardcount3, 1)
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

function slot0._showMonthRewardInfo(slot0, slot1)
	slot2 = {
		rewardCo = SignInConfig.instance:getSignMonthReward(slot1)
	}
	slot2.rewards = string.split(slot2.rewardCo.signinBonus, "|")
	slot2.reward = string.split(slot2.rewards[1], "#")
	slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(slot2.reward[1], slot2.reward[2])

	slot0["_simagemonthicon" .. slot1]:LoadImage(slot4)

	slot0["_txtmonthquantity" .. slot1].text = slot2.rewardCo.signinaddup
	slot0["_txtrewardcount" .. slot1].text = string.format("<size=22>%s</size>%s", luaLang("multiple"), slot2.reward[3])

	table.insert(slot0._monthRewards, slot1, slot2)
end

function slot0._setPropItems(slot0)
	slot2 = {}

	for slot6 = 1, tonumber(os.date("%d", os.time({
		day = 0,
		year = slot0._targetDate[1],
		month = slot0._targetDate[2] + 1
	}))) do
		slot7 = string.splitToNumber(SignInConfig.instance:getSignRewards(slot6).signinBonus, "#")

		table.insert(slot2, {
			materilType = slot7[1],
			materilId = slot7[2],
			quantity = slot7[3],
			isIcon = true,
			parent = slot0
		})
	end

	SignInListModel.instance:setPropList(slot2)
end

function slot0._setMonthItems(slot0)
	gohelper.setActive(slot0._gomonth, true)
	slot0:_onCloneSigninMonthItem(SignInModel.instance:getShowMonthItemCo())
end

function slot0._onCloneSigninMonthItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if not slot0._monthItemTabs[slot5] then
			slot7 = {
				go = gohelper.clone(slot0._gosigninmonthitem, slot0._gomonthitem, "item" .. slot5)
			}
			slot7.anim = gohelper.findChild(slot7.go, "obj"):GetComponent(typeof(UnityEngine.Animator))
			slot7.anim.enabled = false

			gohelper.setActive(slot7.go, false)

			slot7.monthitem = MonoHelper.addNoUpdateLuaComOnceToGo(slot7.go, SignInMonthListItem, slot0)

			table.insert(slot0._monthItemTabs, slot7)
		end

		slot7.monthitem:init(slot7.go)
		slot7.monthitem:onUpdateMO(slot6)
	end

	slot0:_showSigninMonthItemEffect(slot1)
end

function slot0._showSigninMonthItemEffect(slot0, slot1)
	for slot5 = 1, #slot1 do
		function slot6()
			uv0:_showMonthItem(uv1)
		end

		TaskDispatcher.runDelay(slot6, slot0, slot5 * 0.03)
		table.insert(slot0._delayAnimTab, slot6)
	end

	TaskDispatcher.runDelay(slot0._onLineAniStart, slot0, (#slot1 + 1) * 0.1)
end

function slot0._showMonthItem(slot0, slot1)
	gohelper.setActive(slot0._monthItemTabs[slot1].go, true)

	slot0._monthItemTabs[slot1].anim.enabled = true
end

function slot0._showBirthdayRewardDetail(slot0)
	gohelper.setActive(slot0._gobirthdayrewarddetail, true)
	gohelper.setActive(slot0._btnrewarddetailclose.gameObject, true)

	slot1 = SignInModel.instance:getSignBirthdayHeros(slot0._targetDate[1], slot0._targetDate[2], slot0._targetDate[3])

	if slot0._curDate.year == slot0._targetDate[1] and slot0._curDate.month == slot0._targetDate[2] and slot0._curDate.day == slot0._targetDate[3] then
		slot1 = SignInModel.instance:getCurDayBirthdayHeros()
	end

	if slot0:_getTextInputheros() ~= "" then
		slot1 = string.splitToNumber(slot2, "|")
	end

	slot5 = SignInModel.instance:getHeroBirthdayCount(slot1[slot0._index])

	if slot0._curDate.month == slot0._targetDate[2] then
		slot6 = SignInModel.instance:isHeroBirthdayGet(slot3)
		slot5 = slot0._curDate.year == slot0._targetDate[1] and (slot6 and slot4 or slot4 + 1) or slot6 and slot4 - 1 or slot4
	end

	if slot2 ~= "" then
		slot5 = slot0._droptimes:GetValue() + 1
	end

	slot0:_hideAllRewardTipsItem()

	for slot11, slot12 in ipairs(string.split(string.split(HeroConfig.instance:getHeroCO(slot3).birthdayBonus, ";")[slot5], "|")) do
		if not slot0._rewardTipItems[slot11] then
			slot14 = {
				go = gohelper.clone(slot0._gorewarddetailitem, slot0._gorewardContent, "item" .. slot11)
			}
			slot14.icon = IconMgr.instance:getCommonItemIcon(gohelper.findChild(slot14.go, "icon"))

			table.insert(slot0._rewardTipItems, slot14)
		end

		gohelper.setActive(slot0._rewardTipItems[slot11].go, true)

		slot14 = string.split(slot12, "#")
		slot15, slot16 = ItemModel.instance:getItemConfigAndIcon(slot14[1], slot14[2])

		slot0._rewardTipItems[slot11].icon:setMOValue(slot14[1], slot14[2], slot14[3], nil, true)
		slot0._rewardTipItems[slot11].icon:setScale(0.6)
		slot0._rewardTipItems[slot11].icon:isShowQuality(false)
		slot0._rewardTipItems[slot11].icon:isShowCount(false)

		gohelper.findChildText(slot0._rewardTipItems[slot11].go, "name").text = slot15.name
		gohelper.findChildText(slot0._rewardTipItems[slot11].go, "name/quantity").text = luaLang("multiple") .. slot14[3]
	end

	slot0:_computeRewardsTipsContainerHeight(#slot7)
end

function slot0._hideAllRewardTipsItem(slot0)
	for slot4, slot5 in ipairs(slot0._rewardTipItems) do
		gohelper.setActive(slot5.go, false)
	end
end

function slot0._computeRewardsTipsContainerHeight(slot0, slot1)
	recthelper.setHeight(slot0._gocontentSize.transform, recthelper.getHeight(slot0._trstitle) + slot1 * recthelper.getHeight(slot0._gorewarddetailitem.transform) - 10)
end

function slot0._onLineAniStart(slot0)
	gohelper.setActive(slot0._gomonthleftline, true)
	gohelper.setActive(slot0._gomonthrightline, true)
end

function slot0._setRedDot(slot0)
	RedDotController.instance:addRedDot(slot0._gomonthtip1, RedDotEnum.DotNode.SignInMonthTab, 1)
	RedDotController.instance:addRedDot(slot0._gomonthtip2, RedDotEnum.DotNode.SignInMonthTab, 2)
	RedDotController.instance:addRedDot(slot0._gomonthtip3, RedDotEnum.DotNode.SignInMonthTab, 3)
end

function slot0._switchFestivalDecoration(slot0, slot1)
	if slot0._haveFestival == slot1 then
		return
	end

	slot0._haveFestival = slot1

	slot0:_refreshFestivalDecoration()
end

function slot0._refreshFestivalDecoration(slot0)
	slot1 = slot0:haveFestival()

	gohelper.setActive(slot0._gofestivaldecorationright, slot1)
	gohelper.setActive(slot0._gofestivaldecorationleft, slot1)
	gohelper.setActive(slot0._gofestivaldecorationtop, slot1)
	gohelper.setActive(slot0._gorewardicon, not slot1)
	gohelper.setActive(slot0._goeffect, slot1)
	gohelper.setActive(slot0._godayrewarditem_festivaldecorationtop, slot1)
	gohelper.setActive(slot0._godayrewarditem_gofestivaldecorationleft2, slot1)
	gohelper.setActive(slot0._gobtnchange_gofestivaldecoration, slot1)
	gohelper.setActive(slot0._gochange, not slot1)
	slot0:_setFestivalColor(slot0._txtmonth)
	slot0:_setFestivalColor(slot0._imgbias)
	slot0:_setFestivalColor(slot0._txtday)
	slot0:_setFestivalColor(slot0._txtdate)
	slot0._simagebg:LoadImage(ResUrl.getSignInBg(slot1 and "act_bg_white2" or "bg_white2"))
	slot0._simagerewardbg:LoadImage(ResUrl.getSignInBg(slot1 and "act_img_di" or "img_di"))
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._setActive_LifeCircle, slot0)
	TaskDispatcher.cancelTask(slot0._onSwitchRewardAnim, slot0)
	UIBlockHelper.instance:endBlock(uv0)

	if slot0._lifeCircleSignView then
		slot0._lifeCircleSignView:onClose()
	end

	slot0:_removeCustomEvent()
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMember(slot0, "_lifeCircleSignView")
	UIBlockMgr.instance:endBlock("signshowing")
	SignInModel.instance:setNewSwitch(false)
	SignInListModel.instance:clearPropList()
	TaskDispatcher.cancelTask(slot0._setView1Effect, slot0)
	TaskDispatcher.cancelTask(slot0._onLineAniStart, slot0)
	TaskDispatcher.cancelTask(slot0._delaySignInRequest, slot0)
	TaskDispatcher.cancelTask(slot0._showGetRewards, slot0)
	TaskDispatcher.cancelTask(slot0._onWaitSwitchBirthFinished, slot0)

	for slot4, slot5 in pairs(slot0._delayAnimTab) do
		TaskDispatcher.cancelTask(slot5, slot0)
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagemonthicon1:UnLoadImage()
	slot0._simagemonthicon2:UnLoadImage()
	slot0._simagemonthicon3:UnLoadImage()
	slot0._simagenormaldayrewardicon:UnLoadImage()
	slot0._simageorangebg:UnLoadImage()
	slot0._simagerewardbg:UnLoadImage()
	slot0._simagebirthdaybg:UnLoadImage()
	slot0._simagebirthdaybg2:UnLoadImage()
	slot0._simagebirthdayIcon:UnLoadImage()

	if slot0.viewParam and slot0.viewParam.callback then
		slot0.viewParam.callback(slot0.viewParam.callbackObj)
	end
end

function slot0.closeThis(slot0)
	uv0.super.closeThis(slot0)
end

function slot0._getTextInputheros(slot0)
	if slot0._inputheros then
		return slot0._inputheros:GetText()
	end

	return ""
end

function slot0.haveFestival(slot0, slot1)
	if slot0._haveFestival == nil or slot1 then
		slot0._haveFestival = SignInModel.instance.checkFestivalDecorationUnlock()
	end

	return slot0._haveFestival
end

function slot0._setFestivalColor(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot1, slot0:haveFestival() and "#3D201A" or "#222222")
end

function slot0._btnchangeOnClick(slot0)
	slot0:_setActive_LifeCicle(not slot0._isActiveLifeCircle)
end

function slot0._setActive_LifeCicle(slot0, slot1)
	if slot0._isActiveLifeCircle == slot1 then
		return
	end

	slot0._isActiveLifeCircle = slot1

	if slot1 then
		slot0:_refreshLifeCircleView()
	end

	if slot0._lifeCircleSignView then
		slot0:_switchLifeCircleAnsSignIn(slot1)
	else
		slot0:_setActive_LifeCircle(slot1)
	end
end

function slot0._refreshLifeCircleView(slot0)
	if not slot0._lifeCircleSignView then
		slot1 = LifeCircleSignView.New({
			parent = slot0,
			baseViewContainer = slot0.viewContainer
		})

		slot1:init(slot0.viewContainer:getResInst(SignInEnum.ResPath.lifecirclesignview, slot0._goLifeCircle))
		slot1:onOpen()

		slot0._lifeCircleSignView = slot1
	else
		slot1:onUpdateParam()
	end
end

function slot0._switchLifeCircleAnsSignIn(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._setActive_LifeCircle, slot0)
	UIBlockHelper.instance:endBlock(uv0)

	if slot1 then
		slot0:_playAnim("switch_reward")
		TaskDispatcher.runDelay(slot0._onSwitchRewardAnim, slot0, 0.16)
	else
		UIBlockHelper.instance:startBlock(uv0, 2, slot0.viewName)
		slot0:_playAnim("switch_main")
		TaskDispatcher.runDelay(slot0._setActive_LifeCircle, slot0, 0.16)
	end
end

function slot0._setActive_LifeCircle(slot0, slot1)
	gohelper.setActive(slot0._goLifeCircle, slot1 and true or false)
	gohelper.setActive(slot0._btnchangeGo, slot1)
	gohelper.setActive(slot0._btnchange2Go, not slot1)

	if slot1 then
		slot0:_switchFestivalDecoration(false)
	else
		if slot0._haveFestival ~= slot0:haveFestival(true) then
			slot0:_refreshFestivalDecoration()
		end

		UIBlockHelper.instance:endBlock(uv0)
	end
end

function slot0._checkLifeCircleRed(slot0, slot1)
	slot1.show = LifeCircleController.instance:isShowRed()

	slot1:showRedDot(RedDotEnum.Style.Normal)
end

function slot0._onSwitchRewardAnim(slot0)
	slot0:_setActive_LifeCircle(true)
end

function slot0._playAnim(slot0, slot1, slot2, slot3)
	slot0._viewAnimPlayer:Play(slot1, slot2 or function ()
	end, slot3)
end

return slot0

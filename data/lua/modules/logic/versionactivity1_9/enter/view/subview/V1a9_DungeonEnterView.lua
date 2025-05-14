module("modules.logic.versionactivity1_9.enter.view.subview.V1a9_DungeonEnterView", package.seeall)

local var_0_0 = class("V1a9_DungeonEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "logo/#simage_title")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_dec")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "logo/timebg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/timebg/#txt_time")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_enter")
	arg_1_0._btnFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Finished")
	arg_1_0._btnStore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_store")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_task")
	arg_1_0._goTaskRedDot = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_task/#go_reddot")
	arg_1_0._goEnterRedDot = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/#go_reddot")
	arg_1_0._txtStoreNum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/normal/#txt_num")
	arg_1_0._txtStoreTime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/#go_time/#txt_time")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnStore:AddClickListener(arg_2_0.onClickStoreBtn, arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0.onClickMainActivity, arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0.onClickTaskBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnStore:RemoveClickListener()
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnTask:RemoveClickListener()
end

function var_0_0.onClickStoreBtn(arg_4_0)
	VersionActivity1_9DungeonController.instance:openStoreView()
end

function var_0_0.onClickMainActivity(arg_5_0)
	VersionActivity1_9DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0.onClickTaskBtn(arg_6_0)
	VersionActivity1_9DungeonController.instance:openTaskView()
end

function var_0_0._editableInitView(arg_7_0)
	if DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_7) then
		arg_7_0._simagebg:LoadImage("singlebg/v1a9_mainactivity_singlebg/v1a9_enterview_fullbg2.png")
	else
		arg_7_0._simagebg:LoadImage("singlebg/v1a9_mainactivity_singlebg/v1a9_enterview_fullbg.png")
	end

	arg_7_0._simagetitle:LoadImage("singlebg_lang/txt_v1a9_mainactivity_singlebg/v1a9_enterview_title.png")

	arg_7_0.goEnter = arg_7_0._btnEnter.gameObject
	arg_7_0.goFinish = arg_7_0._btnFinish.gameObject
	arg_7_0.actId = VersionActivity1_9Enum.ActivityId.Dungeon
	arg_7_0.actCo = ActivityConfig.instance:getActivityCo(arg_7_0.actId)
	arg_7_0.goTaskBg = gohelper.findChild(arg_7_0.viewGO, "entrance/#btn_task/normal/bg")
	arg_7_0.goTaskIcon = gohelper.findChild(arg_7_0.viewGO, "entrance/#btn_task/normal/icon")
	arg_7_0.goTaskTxt = gohelper.findChild(arg_7_0.viewGO, "entrance/#btn_task/normal/txt_shop")
	arg_7_0.animComp = VersionActivitySubAnimatorComp.get(arg_7_0.viewGO, arg_7_0)

	RedDotController.instance:addRedDot(arg_7_0._goTaskRedDot, RedDotEnum.DotNode.V1a9DungeonTask)
	RedDotController.instance:addRedDot(arg_7_0._goEnterRedDot, RedDotEnum.DotNode.V1a9ToughBattle)
	arg_7_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_7_0.refreshStoreCurrency, arg_7_0)
	arg_7_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_7_0.onRefreshActivity, arg_7_0)
end

function var_0_0.onRefreshActivity(arg_8_0, arg_8_1)
	if arg_8_1 ~= arg_8_0.actId then
		return
	end

	arg_8_0:refreshBtnStatus()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:refreshUI()
	arg_9_0.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(arg_9_0.everyMinuteCall, arg_9_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0:refreshUI()
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0._txtdesc.text = arg_11_0.actCo.actDesc

	arg_11_0:refreshBtnStatus()
	arg_11_0:refreshRemainTime()
	arg_11_0:refreshStoreCurrency()
end

function var_0_0.refreshBtnStatus(arg_12_0)
	local var_12_0 = ActivityHelper.getActivityStatus(arg_12_0.actId)
	local var_12_1 = var_12_0 == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_12_0.goEnter, var_12_1)
	gohelper.setActive(arg_12_0.goFinish, not var_12_1)
	ZProj.UGUIHelper.SetGrayscale(arg_12_0.goTaskBg, not var_12_1)
	ZProj.UGUIHelper.SetGrayscale(arg_12_0.goTaskIcon, not var_12_1)
	ZProj.UGUIHelper.SetGrayscale(arg_12_0.goTaskTxt, not var_12_1)
	gohelper.setActive(arg_12_0._goTaskRedDot, var_12_1)
	gohelper.setActive(arg_12_0._goEnterRedDot, var_12_1)

	local var_12_2 = var_12_0 == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(arg_12_0._btnTask, not var_12_2)
	gohelper.setActive(arg_12_0._gotime, not var_12_2)
end

function var_0_0.everyMinuteCall(arg_13_0)
	arg_13_0:refreshRemainTime()
end

function var_0_0.refreshStoreCurrency(arg_14_0)
	local var_14_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a9Dungeon)
	local var_14_1 = var_14_0 and var_14_0.quantity or 0

	arg_14_0._txtStoreNum.text = GameUtil.numberDisplay(var_14_1)
end

function var_0_0.refreshRemainTime(arg_15_0)
	local var_15_0 = ActivityModel.instance:getActivityInfo()[arg_15_0.actId]:getRealEndTimeStamp() - ServerTime.now()

	arg_15_0._txttime.text = TimeUtil.SecondToActivityTimeFormat(var_15_0)

	local var_15_1 = ActivityModel.instance:getActivityInfo()[VersionActivity1_9Enum.ActivityId.DungeonStore]

	arg_15_0._txtStoreTime.text = var_15_1:getRemainTimeStr2ByEndTime(true)
end

function var_0_0.onClose(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.everyMinuteCall, arg_16_0)
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simagebg:UnLoadImage()
	arg_17_0._simagetitle:UnLoadImage()
	arg_17_0.animComp:destroy()
end

return var_0_0

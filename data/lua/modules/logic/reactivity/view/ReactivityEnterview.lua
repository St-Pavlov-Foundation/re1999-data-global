module("modules.logic.reactivity.view.ReactivityEnterview", package.seeall)

local var_0_0 = class("ReactivityEnterview", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Replay")
	arg_1_0._btnAchevement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Achevement")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Store")
	arg_1_0._txtstoretime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#btn_Store/#go_taglimit/#txt_limit")
	arg_1_0._txtNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#btn_Store/#txt_Num")
	arg_1_0._txttime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Logo/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "Logo/#txt_Descr")
	arg_1_0._btnExchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Exchange")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Enter/#image_reddot")
	arg_1_0._btnEnd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_End")
	arg_1_0._btnLock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Locked")
	arg_1_0._txtlockedtips = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#btn_Locked/txt_LockedTips")
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0.rewardItems = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnAchevement:AddClickListener(arg_2_0._onClickAchevementBtn, arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._onClickStoreBtn, arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._onClickEnter, arg_2_0)
	arg_2_0._btnreplay:AddClickListener(arg_2_0._onClickReplay, arg_2_0)
	arg_2_0._btnExchange:AddClickListener(arg_2_0._onClickExchange, arg_2_0)
	arg_2_0._btnEnd:AddClickListener(arg_2_0._onClickEnter, arg_2_0)
	arg_2_0._btnLock:AddClickListener(arg_2_0._onClickEnter, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnAchevement:RemoveClickListener()
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnreplay:RemoveClickListener()
	arg_3_0._btnExchange:RemoveClickListener()
	arg_3_0._btnEnd:RemoveClickListener()
	arg_3_0._btnLock:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_4_0.refreshUI, arg_4_0)
	arg_4_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_4_0.refreshCurrency, arg_4_0)
end

function var_0_0._onClickAchevementBtn(arg_5_0)
	if not arg_5_0.actId then
		return
	end

	local var_5_0 = ActivityConfig.instance:getActivityCo(arg_5_0.actId)
	local var_5_1 = var_5_0 and var_5_0.achievementJumpId

	JumpController.instance:jump(var_5_1)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:initRedDot()
	var_0_0.super.onOpen(arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	var_0_0.super.onClose(arg_7_0)
end

function var_0_0.initRedDot(arg_8_0)
	if arg_8_0.actId then
		return
	end

	arg_8_0.actId = VersionActivity2_5Enum.ActivityId.Reactivity

	local var_8_0 = ActivityConfig.instance:getActivityCo(arg_8_0.actId)

	RedDotController.instance:addRedDot(arg_8_0._goreddot, var_8_0.redDotId)
end

function var_0_0._onRefreshRedDot(arg_9_0)
	return
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	if arg_11_0.rewardItems then
		for iter_11_0, iter_11_1 in pairs(arg_11_0.rewardItems) do
			iter_11_1:onDestroy()
		end

		arg_11_0.rewardItems = nil
	end
end

function var_0_0.refreshUI(arg_12_0)
	local var_12_0 = ActivityConfig.instance:getActivityCo(arg_12_0.actId)

	arg_12_0._txtdesc.text = var_12_0.actDesc

	local var_12_1 = GameUtil.splitString2(var_12_0.activityBonus, true) or {}

	for iter_12_0 = 1, math.max(#var_12_1, #arg_12_0.rewardItems) do
		local var_12_2 = arg_12_0.rewardItems[iter_12_0]
		local var_12_3 = var_12_1[iter_12_0]

		if not var_12_2 then
			var_12_2 = IconMgr.instance:getCommonItemIcon(arg_12_0._gorewardcontent)
			arg_12_0.rewardItems[iter_12_0] = var_12_2
		end

		if var_12_3 then
			gohelper.setActive(var_12_2.go, true)
			var_12_2:setMOValue(var_12_3[1], var_12_3[2], var_12_3[3] or 1, nil, true)
			var_12_2:hideEquipLvAndCount()
			var_12_2:isShowCount(false)
		else
			gohelper.setActive(var_12_2.go, false)
		end
	end

	arg_12_0:refreshEnterBtn()
	arg_12_0:refreshCurrency()
	arg_12_0:refreshRemainTime()
end

function var_0_0.everySecondCall(arg_13_0)
	arg_13_0:refreshRemainTime()
end

function var_0_0.refreshEnterBtn(arg_14_0)
	local var_14_0, var_14_1, var_14_2 = ActivityHelper.getActivityStatusAndToast(arg_14_0.actId)

	gohelper.setActive(arg_14_0._btnEnter, var_14_0 == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(arg_14_0._btnEnd, var_14_0 ~= ActivityEnum.ActivityStatus.Normal and var_14_0 ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(arg_14_0._btnLock, var_14_0 == ActivityEnum.ActivityStatus.NotUnlock)

	if var_14_0 == ActivityEnum.ActivityStatus.NotUnlock then
		arg_14_0._txtlockedtips.text = ToastController.instance:getToastMsgWithTableParam(var_14_1, var_14_2)
	end

	local var_14_3 = ReactivityEnum.ActivityDefine[arg_14_0.actId]
	local var_14_4 = var_14_3 and var_14_3.storeActId

	arg_14_0.storeActId = var_14_4

	local var_14_5 = ActivityHelper.getActivityStatus(var_14_4)

	gohelper.setActive(arg_14_0._btnstore, var_14_5 == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(arg_14_0._btnExchange, var_14_5 == ActivityEnum.ActivityStatus.Normal)
end

function var_0_0.refreshCurrency(arg_15_0)
	local var_15_0 = ReactivityModel.instance:getActivityCurrencyId(arg_15_0.actId)
	local var_15_1 = CurrencyModel.instance:getCurrency(var_15_0)
	local var_15_2 = var_15_1 and var_15_1.quantity or 0

	arg_15_0._txtNum.text = GameUtil.numberDisplay(var_15_2)
end

function var_0_0._onClickEnter(arg_16_0)
	local var_16_0, var_16_1, var_16_2 = ActivityHelper.getActivityStatusAndToast(arg_16_0.actId)

	if var_16_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_16_1 then
			GameFacade.showToastWithTableParam(var_16_1, var_16_2)
		end

		return
	end

	VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0._onClickReplay(arg_17_0)
	local var_17_0 = ActivityModel.instance:getActMO(arg_17_0.actId)
	local var_17_1 = var_17_0 and var_17_0.config and var_17_0.config.storyId

	if not var_17_1 then
		logError(string.format("act id %s dot config story id", var_17_1))

		return
	end

	local var_17_2 = {}

	var_17_2.isVersionActivityPV = true

	StoryController.instance:playStory(var_17_1, var_17_2)
end

function var_0_0._onClickExchange(arg_18_0)
	ViewMgr.instance:openView(ViewName.ReactivityRuleView)
end

function var_0_0._onClickStoreBtn(arg_19_0)
	ReactivityController.instance:openReactivityStoreView(arg_19_0.actId)
end

function var_0_0.refreshRemainTime(arg_20_0)
	local var_20_0 = ActivityModel.instance:getActMO(arg_20_0.actId):getRealEndTimeStamp() - ServerTime.now()

	if var_20_0 > 0 then
		local var_20_1 = TimeUtil.SecondToActivityTimeFormat(var_20_0)

		arg_20_0._txttime.text = var_20_1
	else
		arg_20_0._txttime.text = luaLang("ended")
	end

	arg_20_0:refreshStoreTime()
end

function var_0_0.refreshStoreTime(arg_21_0)
	local var_21_0 = arg_21_0.storeActId

	if not var_21_0 then
		return
	end

	local var_21_1 = ActivityModel.instance:getActMO(var_21_0)

	if not var_21_1 then
		return
	end

	local var_21_2 = ActivityHelper.getActivityStatusAndToast(var_21_0)

	if var_21_2 ~= ActivityEnum.ActivityStatus.Normal and var_21_2 ~= ActivityEnum.ActivityStatus.NotUnlock then
		arg_21_0._txtstoretime.text = luaLang("turnback_end")
	else
		arg_21_0._txtstoretime.text = var_21_1:getRemainTimeStr2ByEndTime(true)
	end
end

return var_0_0

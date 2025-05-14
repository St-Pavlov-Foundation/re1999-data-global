module("modules.logic.versionactivity1_6.enter.view.Va1_6SeasonEnterView", package.seeall)

local var_0_0 = class("Va1_6SeasonEnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goStore = gohelper.findChild(arg_1_0.viewGO, "Right/Store")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Store/#btn_Store")
	arg_1_0._txtNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/Store/#btn_Store/#txt_Num")
	arg_1_0._txtstoretime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/Store/#go_taglimit/#txt_limit")
	arg_1_0._txttime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/LimitTime/#txt_LimitTime")
	arg_1_0._btnEnterNormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Normal")
	arg_1_0._btnEnterClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Close")
	arg_1_0._btnEnterUnOpen = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_UnOpen")
	arg_1_0._txtunlocktips = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#btn_UnOpen/#txt_Tips")
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/txtDescr")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Normal/#image_reddot")
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0.rewardItems = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._onClickStoreBtn, arg_2_0)
	arg_2_0._btnEnterNormal:AddClickListener(arg_2_0._onClickMainActivity, arg_2_0)
	arg_2_0._btnEnterClose:AddClickListener(arg_2_0._onClickMainActivity, arg_2_0)
	arg_2_0._btnEnterUnOpen:AddClickListener(arg_2_0._onClickMainActivity, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0._btnEnterNormal:RemoveClickListener()
	arg_3_0._btnEnterClose:RemoveClickListener()
	arg_3_0._btnEnterUnOpen:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.actId = Activity104Model.instance:getCurSeasonId()

	local var_4_0 = ActivityConfig.instance:getActivityCo(arg_4_0.actId)

	RedDotController.instance:addRedDot(arg_4_0._goreddot, var_4_0.redDotId)
	arg_4_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_4_0.refreshUI, arg_4_0)
	arg_4_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_4_0.refreshCurrency, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	var_0_0.super.onOpen(arg_5_0)
	arg_5_0:refreshUI()
	arg_5_0:refreshRemainTime()
end

function var_0_0.onClose(arg_6_0)
	var_0_0.super.onClose(arg_6_0)
end

function var_0_0._onRefreshRedDot(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.refreshEnterBtn(arg_9_0)
	local var_9_0, var_9_1, var_9_2 = ActivityHelper.getActivityStatusAndToast(arg_9_0.actId)

	gohelper.setActive(arg_9_0._btnEnterNormal, var_9_0 == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(arg_9_0._btnEnterClose, var_9_0 ~= ActivityEnum.ActivityStatus.Normal and var_9_0 ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(arg_9_0._btnEnterUnOpen, var_9_0 == ActivityEnum.ActivityStatus.NotUnlock)

	if var_9_0 == ActivityEnum.ActivityStatus.NotUnlock then
		arg_9_0._txtunlocktips.text = ToastController.instance:getToastMsgWithTableParam(var_9_1, var_9_2)
	end

	local var_9_3 = ActivityHelper.getActivityStatus(VersionActivity1_6Enum.ActivityId.SeasonStore)

	gohelper.setActive(arg_9_0._goStore, var_9_3 == ActivityEnum.ActivityStatus.Normal)
end

function var_0_0.refreshCurrency(arg_10_0)
	local var_10_0 = Activity104Enum.StoreUTTU[arg_10_0.actId]
	local var_10_1 = CurrencyModel.instance:getCurrency(var_10_0)
	local var_10_2 = var_10_1 and var_10_1.quantity or 0

	arg_10_0._txtNum.text = GameUtil.numberDisplay(var_10_2)
end

function var_0_0.refreshUI(arg_11_0)
	local var_11_0 = ActivityConfig.instance:getActivityCo(arg_11_0.actId)

	arg_11_0._txtdesc.text = var_11_0.actDesc

	local var_11_1 = GameUtil.splitString2(var_11_0.activityBonus, true) or {}

	for iter_11_0 = 1, math.max(#var_11_1, #arg_11_0.rewardItems) do
		local var_11_2 = arg_11_0.rewardItems[iter_11_0]
		local var_11_3 = var_11_1[iter_11_0]

		if not var_11_2 then
			var_11_2 = IconMgr.instance:getCommonItemIcon(arg_11_0._gorewardcontent)
			arg_11_0.rewardItems[iter_11_0] = var_11_2
		end

		if var_11_3 then
			gohelper.setActive(var_11_2.go, true)
			var_11_2:setMOValue(var_11_3[1], var_11_3[2], var_11_3[3] or 1, nil, true)
			var_11_2:hideEquipLvAndCount()
			var_11_2:isShowCount(false)
		else
			gohelper.setActive(var_11_2.go, false)
		end
	end

	arg_11_0:refreshEnterBtn()
	arg_11_0:refreshCurrency()
end

function var_0_0.onDestroyView(arg_12_0)
	if arg_12_0.rewardItems then
		for iter_12_0, iter_12_1 in pairs(arg_12_0.rewardItems) do
			iter_12_1:onDestroy()
		end

		arg_12_0.rewardItems = nil
	end
end

function var_0_0.everySecondCall(arg_13_0)
	arg_13_0:refreshRemainTime()
end

function var_0_0._onClickMainActivity(arg_14_0)
	Activity104Controller.instance:openSeasonMainView()
end

function var_0_0._onClickStoreBtn(arg_15_0)
	Activity104Controller.instance:openSeasonStoreView()
end

function var_0_0.refreshRemainTime(arg_16_0)
	arg_16_0:refreshMainTime()
	arg_16_0:refreshStoreTime()
end

function var_0_0.refreshMainTime(arg_17_0)
	local var_17_0 = ActivityModel.instance:getActMO(arg_17_0.actId)

	if not var_17_0 then
		arg_17_0._txttime.text = ""

		return
	end

	local var_17_1 = var_17_0:getRealEndTimeStamp() - ServerTime.now()

	if var_17_1 > 0 then
		local var_17_2 = TimeUtil.SecondToActivityTimeFormat(var_17_1)

		arg_17_0._txttime.text = var_17_2
	else
		arg_17_0._txttime.text = luaLang("ended")
	end
end

function var_0_0.refreshStoreTime(arg_18_0)
	local var_18_0 = Activity104Enum.SeasonStore[arg_18_0.actId]
	local var_18_1 = ActivityModel.instance:getActMO(var_18_0)

	if not var_18_1 then
		return
	end

	local var_18_2 = ActivityHelper.getActivityStatusAndToast(var_18_0)

	if var_18_2 ~= ActivityEnum.ActivityStatus.Normal and var_18_2 ~= ActivityEnum.ActivityStatus.NotUnlock then
		arg_18_0._txtstoretime.text = luaLang("turnback_end")
	else
		arg_18_0._txtstoretime.text = var_18_1:getRemainTimeStr2ByEndTime(true)
	end
end

return var_0_0

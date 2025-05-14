module("modules.logic.versionactivity1_7.enter.view.subview.V1a7_MarcusEnterView", package.seeall)

local var_0_0 = class("V1a7_MarcusEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Enter")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Locked")
	arg_1_0._txtLocked = gohelper.findChildText(arg_1_0.viewGO, "Right/#btn_Locked/#txt_UnLocked")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._btnEnterOnClick, arg_2_0)
	arg_2_0._btnLocked:AddClickListener(arg_2_0._btnLockedOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnLocked:RemoveClickListener()
end

function var_0_0._btnEnterOnClick(arg_4_0)
	local var_4_0 = PlayerModel.instance:getPlayinfo().userId
	local var_4_1 = PlayerPrefsKey.EnterRoleActivity .. "#" .. tostring(VersionActivity1_7Enum.ActivityId.Marcus) .. "#" .. tostring(var_4_0)
	local var_4_2 = PlayerPrefsHelper.getNumber(var_4_1, 0) == 1

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_70104) or var_4_2 then
		ActMarcusController.instance:enterActivity()

		return
	end

	local var_4_3 = OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.Act_70104)
	local var_4_4 = DungeonConfig.instance:getEpisodeDisplay(var_4_3.episodeId)

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130OpenTips, MsgBoxEnum.BoxType.Yes_No, function()
		PlayerPrefsHelper.setNumber(var_4_1, 1)
		ActMarcusController.instance:enterActivity()
	end, nil, nil, nil, nil, nil, var_4_4)
end

function var_0_0._btnLockedOnClick(arg_6_0)
	local var_6_0, var_6_1, var_6_2 = ActivityHelper.getActivityStatusAndToast(arg_6_0.actId)

	if var_6_0 == ActivityEnum.ActivityStatus.NotUnlock and var_6_1 then
		GameFacade.showToastWithTableParam(var_6_1, var_6_2)
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.actId = VersionActivity1_7Enum.ActivityId.Marcus
	arg_7_0.config = ActivityConfig.instance:getActivityCo(arg_7_0.actId)
	arg_7_0._txtDescr.text = arg_7_0.config.actDesc

	local var_7_0 = OpenHelper.getActivityUnlockTxt(arg_7_0.config.openId)

	arg_7_0._txtLocked.text = var_7_0

	arg_7_0:initRewards()

	arg_7_0.animComp = VersionActivitySubAnimatorComp.get(arg_7_0.viewGO, arg_7_0)
end

function var_0_0.onOpen(arg_8_0)
	var_0_0.super.onOpen(arg_8_0)
	arg_8_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_8_0._onActStatusChange, arg_8_0)
	arg_8_0:addEventCb(ActivityController.instance, ActivityEvent.UpdateActivity, arg_8_0._showLeftTime, arg_8_0)

	local var_8_0 = gohelper.findChild(arg_8_0._btnEnter.gameObject, "#go_reddot")

	RedDotController.instance:addRedDot(var_8_0, RedDotEnum.DotNode.PermanentRoleActivityTask, arg_8_0.actId):setRedDotTranScale(RedDotEnum.Style.Normal, 1.4, 1.4)
	arg_8_0:_freshLockStatus()
	arg_8_0:_showLeftTime()
	TaskDispatcher.runRepeat(arg_8_0._showLeftTime, arg_8_0, 1)
	arg_8_0.animComp:playOpenAnim()
end

function var_0_0.onClose(arg_9_0)
	var_0_0.super.onClose(arg_9_0)
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._showLeftTime, arg_10_0)
	arg_10_0.animComp:destroy()
end

function var_0_0.initRewards(arg_11_0)
	local var_11_0 = string.split(arg_11_0.config.activityBonus, "|")

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = string.splitToNumber(iter_11_1, "#")
		local var_11_2 = IconMgr.instance:getCommonItemIcon(arg_11_0._gorewards)

		var_11_2:setMOValue(var_11_1[1], var_11_1[2], 1)
		var_11_2:isShowCount(false)
	end
end

function var_0_0._freshLockStatus(arg_12_0)
	local var_12_0 = ActivityHelper.getActivityStatus(arg_12_0.actId)

	gohelper.setActive(arg_12_0._btnEnter, var_12_0 ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(arg_12_0._btnLocked, var_12_0 == ActivityEnum.ActivityStatus.NotUnlock)
end

function var_0_0._showLeftTime(arg_13_0)
	arg_13_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_13_0.actId)
end

function var_0_0._onActStatusChange(arg_14_0)
	arg_14_0:_freshLockStatus()
end

return var_0_0

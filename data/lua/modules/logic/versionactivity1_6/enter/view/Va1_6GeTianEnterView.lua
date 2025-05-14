module("modules.logic.versionactivity1_6.enter.view.Va1_6GeTianEnterView", package.seeall)

local var_0_0 = class("Va1_6GeTianEnterView", VersionActivityEnterBaseSubView)

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
	ActGeTianController.instance:enterActivity()
end

function var_0_0._btnLockedOnClick(arg_5_0)
	local var_5_0, var_5_1, var_5_2 = ActivityHelper.getActivityStatusAndToast(arg_5_0.actId)

	if var_5_0 == ActivityEnum.ActivityStatus.NotUnlock and var_5_1 then
		GameFacade.showToastWithTableParam(var_5_1, var_5_2)
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.actId = VersionActivity1_6Enum.ActivityId.Role2
	arg_6_0.config = ActivityConfig.instance:getActivityCo(arg_6_0.actId)
	arg_6_0._txtDescr.text = arg_6_0.config.actDesc

	local var_6_0 = OpenHelper.getActivityUnlockTxt(arg_6_0.config.openId)

	arg_6_0._txtLocked.text = var_6_0

	arg_6_0:initRewards()
end

function var_0_0.onOpen(arg_7_0)
	var_0_0.super.onOpen(arg_7_0)
	arg_7_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_7_0._onActStatusChange, arg_7_0)

	local var_7_0 = gohelper.findChild(arg_7_0._btnEnter.gameObject, "#go_reddot")

	RedDotController.instance:addRedDot(var_7_0, RedDotEnum.DotNode.V1a6RoleActivityTask, arg_7_0.actId):setRedDotTranScale(RedDotEnum.Style.Normal, 1.4, 1.4)
	arg_7_0:_freshUnlockStatus()
	arg_7_0:_showLeftTime()
end

function var_0_0.onClose(arg_8_0)
	var_0_0.super.onClose(arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0._freshUnlockStatus(arg_10_0)
	local var_10_0 = ActivityHelper.getActivityStatus(arg_10_0.actId)

	gohelper.setActive(arg_10_0._btnEnter, var_10_0 ~= ActivityEnum.ActivityStatus.NotUnlock)
	gohelper.setActive(arg_10_0._btnLocked, var_10_0 == ActivityEnum.ActivityStatus.NotUnlock)
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

function var_0_0._showLeftTime(arg_12_0)
	arg_12_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_12_0.actId)
end

function var_0_0._onActStatusChange(arg_13_0)
	arg_13_0:_freshUnlockStatus()
end

function var_0_0.everySecondCall(arg_14_0)
	arg_14_0:_showLeftTime()
end

return var_0_0

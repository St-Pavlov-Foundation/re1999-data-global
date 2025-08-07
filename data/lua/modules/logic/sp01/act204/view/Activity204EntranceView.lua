module("modules.logic.sp01.act204.view.Activity204EntranceView", package.seeall)

local var_0_0 = class("Activity204EntranceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Page1/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Page1/#txt_LimitTime")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_4_0._updateActivity, arg_4_0)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._actId = arg_6_0.viewParam and arg_6_0.viewParam.actId
	arg_6_0._entranceIds = arg_6_0.viewParam and arg_6_0.viewParam.entranceIds
	arg_6_0.actEntranceItemMap = arg_6_0:getUserDataTb_()

	arg_6_0:refresh()
	arg_6_0:checkActivityState()
	AudioMgr.instance:trigger(AudioEnum2_9.Activity204.EnterEntrance)
end

function var_0_0.refresh(arg_7_0)
	arg_7_0:refreshAllEntrances()
	arg_7_0:refreshBubbleItem()
	arg_7_0:refreshRemainTime()
	TaskDispatcher.cancelTask(arg_7_0.refreshRemainTime, arg_7_0)
	TaskDispatcher.runRepeat(arg_7_0.refreshRemainTime, arg_7_0, 1)
end

function var_0_0.refreshAllEntrances(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._entranceIds or {}) do
		local var_8_0 = gohelper.findChild(arg_8_0.viewGO, "Page1/Entrance" .. iter_8_0)
		local var_8_1 = Activity204Enum.ActId2EntranceCls[iter_8_1]

		if gohelper.isNil(var_8_0) then
			logError(string.format("缺少活动入口 index = %s actId = %s", iter_8_0, iter_8_1))
		elseif not var_8_1 then
			logError(string.format("缺少活动入口类(Activity204Enum.ActId2EntranceCls) index = %s actId = %s", iter_8_0, iter_8_1))
		else
			local var_8_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_0, var_8_1)

			var_8_2:onUpdateMO(iter_8_1)

			arg_8_0.actEntranceItemMap[iter_8_1] = var_8_2
		end
	end
end

function var_0_0.refreshBubbleItem(arg_9_0)
	local var_9_0 = Activity204Controller.instance:getBubbleActIdList()
	local var_9_1 = gohelper.findChild(arg_9_0.viewGO, "Page1/Entrance5")

	MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, Activity204BubbleItem):onUpdateMO(var_9_0)
end

function var_0_0.refreshRemainTime(arg_10_0)
	if not arg_10_0._actId then
		return
	end

	local var_10_0 = ActivityHelper.getActivityRemainTimeStr(arg_10_0._actId)

	arg_10_0._txtLimitTime.text = var_10_0
end

function var_0_0._updateActivity(arg_11_0)
	arg_11_0:checkActivityState()
	Activity204Controller.instance:getAllEntranceActInfo(arg_11_0.refresh, arg_11_0)
end

function var_0_0.checkActivityState(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.actEntranceItemMap) do
		if (iter_12_1 and iter_12_1:_getActivityStatus(iter_12_0)) == ActivityEnum.ActivityStatus.Expired then
			local var_12_0 = Activity204Enum.ActId2ViewList[iter_12_0]

			arg_12_0:checkFinishViewList(var_12_0)
		end
	end

	for iter_12_2 = Act205Enum.GameStageId.Card, Act205Enum.GameStageId.Ocean do
		if not Act205Model.instance:isGameStageOpen(iter_12_2, false) then
			local var_12_1 = Activity204Enum.Act205StageView[iter_12_2]

			arg_12_0:checkFinishViewList(var_12_1)
		end
	end
end

function var_0_0.checkFinishViewList(arg_13_0, arg_13_1)
	if arg_13_1 and #arg_13_1 > 0 then
		for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
			if ViewMgr.instance:isOpen(iter_13_1) then
				MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, var_0_0.yesCallback)

				return
			end
		end
	end
end

function var_0_0.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)
	NavigateButtonsView.homeClick()
end

function var_0_0.onClose(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0.refreshRemainTime, arg_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0

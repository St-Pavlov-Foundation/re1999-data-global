module("modules.versionactivitybase.enterview.view.new.VersionActivityEnterViewBaseTabItem", package.seeall)

local var_0_0 = class("VersionActivityEnterViewBaseTabItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	if gohelper.isNil(arg_1_1) then
		return
	end

	arg_1_0.go = arg_1_1
	arg_1_0.rectTr = arg_1_0.go:GetComponent(gohelper.Type_RectTransform)
	arg_1_0.click = gohelper.getClickWithDefaultAudio(arg_1_0.go)

	arg_1_0:_editableInitView()
	gohelper.setActive(arg_1_0.go, true)
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.index = arg_2_1
	arg_2_0.actSetting = arg_2_2
	arg_2_0.redDotUid = arg_2_2.redDotUid or 0
	arg_2_0.storeId = arg_2_2.storeId

	arg_2_0:updateActId()
	arg_2_0:afterSetData()
	TaskDispatcher.runRepeat(arg_2_0.refreshTag, arg_2_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.updateActId(arg_3_0)
	local var_3_0 = VersionActivityEnterHelper.getActId(arg_3_0.actSetting)

	if var_3_0 == arg_3_0.actId then
		return false
	end

	arg_3_0.actId = var_3_0
	arg_3_0.activityCo = ActivityConfig.instance:getActivityCo(arg_3_0.actId)

	return true
end

function var_0_0.setClickFunc(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.customClick = arg_4_1
	arg_4_0.customClickObj = arg_4_2
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_5_0.refreshTag, arg_5_0)
	arg_5_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_5_0.onRefreshActivity, arg_5_0)
	arg_5_0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, arg_5_0.refreshSelect, arg_5_0)
	arg_5_0.click:AddClickListener(arg_5_0.onClick, arg_5_0)
end

function var_0_0.removeEventListeners(arg_6_0)
	arg_6_0:removeEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_6_0.refreshTag, arg_6_0)
	arg_6_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_6_0.onRefreshActivity, arg_6_0)
	arg_6_0:removeEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, arg_6_0.refreshSelect, arg_6_0)
	arg_6_0.click:RemoveClickListener()
end

function var_0_0.onRefreshActivity(arg_7_0, arg_7_1)
	if arg_7_0.actId ~= arg_7_1 then
		return
	end

	arg_7_0:refreshTag()
end

function var_0_0.refreshSelect(arg_8_0, arg_8_1)
	arg_8_0.isSelect = arg_8_1 == arg_8_0.actId

	arg_8_0:childRefreshSelect()
end

function var_0_0.onClick(arg_9_0)
	if arg_9_0.isSelect then
		return
	end

	if arg_9_0.customClick then
		arg_9_0.customClick(arg_9_0.customClickObj, arg_9_0)

		return
	end

	local var_9_0 = arg_9_0.storeId or arg_9_0.actId
	local var_9_1, var_9_2, var_9_3 = ActivityHelper.getActivityStatusAndToast(var_9_0)

	if var_9_1 == ActivityEnum.ActivityStatus.Normal or var_9_1 == ActivityEnum.ActivityStatus.NotUnlock then
		arg_9_0.animator:Play("click", 0, 0)
		VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, arg_9_0.actId, arg_9_0)

		return
	end

	if var_9_2 then
		GameFacade.showToastWithTableParam(var_9_2, var_9_3)
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)
end

function var_0_0._editableInitView(arg_10_0)
	logError("override VersionActivityEnterViewBaseTabItem:_editableInitView")
end

function var_0_0.afterSetData(arg_11_0)
	return
end

function var_0_0.childRefreshSelect(arg_12_0)
	logError("override VersionActivityEnterViewBaseTabItem:childRefreshSelect")
end

function var_0_0.childRefreshUI(arg_13_0)
	return
end

function var_0_0.refreshTag(arg_14_0)
	return
end

function var_0_0.refreshUI(arg_15_0)
	arg_15_0:childRefreshUI()
	arg_15_0:refreshTag()
end

function var_0_0.getAnchorY(arg_16_0)
	return recthelper.getAnchorY(arg_16_0.rectTr)
end

function var_0_0.getAnchorX(arg_17_0)
	return recthelper.getAnchorX(arg_17_0.rectTr)
end

function var_0_0.getWidth(arg_18_0)
	return recthelper.getWidth(arg_18_0.rectTr)
end

function var_0_0.dispose(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0.refreshTag, arg_19_0)
end

return var_0_0

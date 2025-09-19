module("modules.logic.versionactivity2_5.challenge.view.enter.Act183BaseGroupEntranceItem", package.seeall)

local var_0_0 = class("Act183BaseGroupEntranceItem", LuaCompBase)

function var_0_0.Get(arg_1_0, arg_1_1, arg_1_2)
	return
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	var_0_0.super.ctor(arg_2_0)

	arg_2_0._index = arg_2_1
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.go = arg_3_1
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_4_0._onOpenViewFinish, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	return
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._actId = Act183Model.instance:getActivityId()
	arg_6_0._groupMo = arg_6_1
	arg_6_0._status = arg_6_1:getStatus()
	arg_6_0._groupId = arg_6_1:getGroupId()
	arg_6_0._groupType = arg_6_1:getGroupType()

	gohelper.setActive(arg_6_0.go, true)
end

function var_0_0._onOpenViewFinish(arg_7_0, arg_7_1)
	if arg_7_1 ~= ViewName.Act183MainView then
		return
	end

	arg_7_0:tryPlayUnlockAnim()
end

function var_0_0._onCloseViewFinish(arg_8_0, arg_8_1)
	arg_8_0:tryPlayUnlockAnim()
end

function var_0_0.tryPlayUnlockAnim(arg_9_0)
	if not arg_9_0:checkCanPlayUnlockAnim() then
		return
	end

	arg_9_0:startPlayUnlockAnim()
end

function var_0_0.checkCanPlayUnlockAnim(arg_10_0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.Act183MainView) then
		return
	end

	if arg_10_0._status == Act183Enum.GroupStatus.Locked then
		return
	end

	return not Act183Helper.isGroupHasPlayUnlockAnim(arg_10_0._actId, arg_10_0._groupId)
end

function var_0_0.startPlayUnlockAnim(arg_11_0)
	arg_11_0:onPlayUnlockAnimDone()
end

function var_0_0.onPlayUnlockAnimDone(arg_12_0)
	Act183Helper.savePlayUnlockAnimGroupIdInLocal(arg_12_0._actId, arg_12_0._groupId)
end

return var_0_0

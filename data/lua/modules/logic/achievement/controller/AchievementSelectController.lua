module("modules.logic.achievement.controller.AchievementSelectController", package.seeall)

local var_0_0 = class("AchievementSelectController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1)
	AchievementSelectListModel.instance:initDatas(arg_1_1)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, arg_1_0.handlePlayerInfoChanged, arg_1_0)
	AchievementController.instance:registerCallback(AchievementEvent.UpdateAchievements, arg_1_0.handleAchievementUpdated, arg_1_0)
end

function var_0_0.onCloseView(arg_2_0)
	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, arg_2_0.handlePlayerInfoChanged, arg_2_0)
	AchievementController.instance:unregisterCallback(AchievementEvent.UpdateAchievements, arg_2_0.handleAchievementUpdated, arg_2_0)
	AchievementSelectListModel.instance:release()
end

function var_0_0.setCategory(arg_3_0, arg_3_1)
	AchievementSelectListModel.instance:setTab(arg_3_1)
	arg_3_0:notifyUpdateView()
end

function var_0_0.switchGroup(arg_4_0)
	local var_4_0 = AchievementSelectListModel.instance.isGroup

	if AchievementSelectListModel.instance:checkDirty(var_4_0) then
		GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, arg_4_0.switchGroupWithoutCheck, nil, nil, arg_4_0, nil)
	else
		arg_4_0:switchGroupWithoutCheck()
	end
end

function var_0_0.switchGroupAfterSave(arg_5_0)
	arg_5_0:sendSave(arg_5_0.switchGroupWithoutCheck, arg_5_0)
end

function var_0_0.switchGroupWithoutCheck(arg_6_0)
	local var_6_0 = AchievementSelectListModel.instance.isGroup

	AchievementSelectListModel.instance:resumeToOriginSelect()

	if not var_6_0 then
		AchievementSelectListModel.instance:setTab(AchievementEnum.Type.Activity)
	end

	AchievementSelectListModel.instance:setIsSelectGroup(not var_6_0)
	arg_6_0:notifyUpdateView()
end

function var_0_0.resumeToOriginSelect(arg_7_0)
	AchievementSelectListModel.instance:resumeToOriginSelect()
	arg_7_0:notifyUpdateView()
end

function var_0_0.clearAllSelect(arg_8_0)
	AchievementSelectListModel.instance:clearAllSelect()
	arg_8_0:notifyUpdateView()
end

function var_0_0.changeGroupSelect(arg_9_0, arg_9_1)
	local var_9_0 = AchievementSelectListModel.instance:isGroupSelected(arg_9_1)
	local var_9_1 = AchievementSelectListModel.instance:getGroupSelectedCount()

	if AchievementEnum.ShowMaxGroupCount <= 1 then
		AchievementSelectListModel.instance:clearAllSelect()
	elseif not var_9_0 and var_9_1 >= AchievementEnum.ShowMaxGroupCount then
		GameFacade.showToast(ToastEnum.AchievementShowMaxGroupCount, AchievementEnum.ShowMaxGroupCount)

		return
	end

	AchievementSelectListModel.instance:setGroupSelect(arg_9_1, not var_9_0)
	arg_9_0:notifyUpdateView()
end

function var_0_0.changeSingleSelect(arg_10_0, arg_10_1)
	local var_10_0 = AchievementSelectListModel.instance:isSingleSelected(arg_10_1)
	local var_10_1 = AchievementSelectListModel.instance:getSingleSelectedCount()

	if not var_10_0 and var_10_1 >= AchievementEnum.ShowMaxSingleCount then
		GameFacade.showToast(ToastEnum.AchievementShowMaxSingleCount, AchievementEnum.ShowMaxSingleCount)

		return
	end

	AchievementSelectListModel.instance:setSingleSelect(arg_10_1, not var_10_0)
	arg_10_0:notifyUpdateView()
end

function var_0_0.handlePlayerInfoChanged(arg_11_0)
	AchievementSelectListModel.instance:decodeShowAchievement()
	arg_11_0:notifyUpdateView()
end

function var_0_0.handleAchievementUpdated(arg_12_0)
	AchievementSelectListModel.instance:refreshTabData()
	arg_12_0:notifyUpdateView()
end

function var_0_0.checkSave(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, arg_13_0.switchGroupAfterSave, arg_13_2, nil, arg_13_0, arg_13_3)
end

function var_0_0.sendSave(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0, var_14_1 = AchievementSelectListModel.instance:getSaveRequestParam()

	AchievementRpc.instance:sendShowAchievementRequest(var_14_0, var_14_1, arg_14_1, arg_14_2)
end

function var_0_0.notifyUpdateView(arg_15_0)
	arg_15_0:dispatchEvent(AchievementEvent.SelectViewUpdated)
	AchievementSelectListModel.instance:onModelUpdate()
end

function var_0_0.popUpMessageBoxIfNeedSave(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	local var_16_0 = AchievementSelectListModel.instance.isGroup

	if AchievementSelectListModel.instance:checkDirty(var_16_0) then
		GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, arg_16_1, arg_16_2, nil, arg_16_4, arg_16_5)
	elseif arg_16_3 then
		arg_16_3(arg_16_6)
	end
end

function var_0_0.isCurrentShowGroupInPlayerView(arg_17_0)
	local var_17_0 = PlayerModel.instance:getShowAchievement()
	local var_17_1, var_17_2 = AchievementUtils.decodeShowStr(var_17_0)

	if var_17_2 and tabletool.len(var_17_2) > 0 then
		return true
	end
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0

module("modules.logic.playercard.controller.PlayerCardAchievementSelectController", package.seeall)

local var_0_0 = class("PlayerCardAchievementSelectController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1)
	PlayerCardAchievementSelectListModel.instance:initDatas(arg_1_1)
end

function var_0_0.onCloseView(arg_2_0)
	PlayerCardAchievementSelectListModel.instance:release()
end

function var_0_0.changeNamePlateSelect(arg_3_0, arg_3_1)
	local var_3_0 = PlayerCardAchievementSelectListModel.instance:isSingleSelected(arg_3_1)
	local var_3_1 = PlayerCardAchievementSelectListModel.instance:getSingleSelectedCount()

	if not var_3_0 and var_3_1 >= 1 then
		GameFacade.showToast(ToastEnum.AchievementShowMaxSingleCount, 1)

		return
	end

	PlayerCardAchievementSelectListModel.instance:setSingleSelect(arg_3_1, not var_3_0)
	arg_3_0:notifyUpdateView()
end

function var_0_0.setCategory(arg_4_0, arg_4_1)
	PlayerCardAchievementSelectListModel.instance:setTab(arg_4_1)
	arg_4_0:notifyUpdateView()
end

function var_0_0.switchGroup(arg_5_0)
	local var_5_0 = PlayerCardAchievementSelectListModel.instance.isGroup

	if PlayerCardAchievementSelectListModel.instance:checkDirty(var_5_0) then
		GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, arg_5_0.switchGroupWithoutCheck, nil, nil, arg_5_0, nil)
	else
		arg_5_0:switchGroupWithoutCheck()
	end
end

function var_0_0.switchGroupAfterSave(arg_6_0)
	arg_6_0:sendSave(arg_6_0.switchGroupWithoutCheck, arg_6_0)
end

function var_0_0.switchGroupWithoutCheck(arg_7_0)
	local var_7_0 = PlayerCardAchievementSelectListModel.instance.isGroup

	PlayerCardAchievementSelectListModel.instance:resumeToOriginSelect()

	if not var_7_0 then
		PlayerCardAchievementSelectListModel.instance:setTab(AchievementEnum.Type.Activity)
	end

	PlayerCardAchievementSelectListModel.instance:setIsSelectGroup(not var_7_0)
	arg_7_0:notifyUpdateView()
end

function var_0_0.resumeToOriginSelect(arg_8_0)
	PlayerCardAchievementSelectListModel.instance:resumeToOriginSelect()
	arg_8_0:notifyUpdateView()
end

function var_0_0.clearAllSelect(arg_9_0)
	PlayerCardAchievementSelectListModel.instance:clearAllSelect()
	arg_9_0:notifyUpdateView()
end

function var_0_0.changeGroupSelect(arg_10_0, arg_10_1)
	local var_10_0 = PlayerCardAchievementSelectListModel.instance:isGroupSelected(arg_10_1)
	local var_10_1 = PlayerCardAchievementSelectListModel.instance:getGroupSelectedCount()

	if AchievementEnum.ShowMaxGroupCount <= 1 then
		PlayerCardAchievementSelectListModel.instance:clearAllSelect()
	elseif not var_10_0 and var_10_1 >= AchievementEnum.ShowMaxGroupCount then
		GameFacade.showToast(ToastEnum.AchievementShowMaxGroupCount, AchievementEnum.ShowMaxGroupCount)

		return
	end

	PlayerCardAchievementSelectListModel.instance:setGroupSelect(arg_10_1, not var_10_0)
	arg_10_0:notifyUpdateView()
end

function var_0_0.changeSingleSelect(arg_11_0, arg_11_1)
	local var_11_0 = PlayerCardAchievementSelectListModel.instance:isSingleSelected(arg_11_1)
	local var_11_1 = PlayerCardAchievementSelectListModel.instance:getSingleSelectedCount()

	if not var_11_0 and var_11_1 >= AchievementEnum.ShowMaxSingleCount then
		GameFacade.showToast(ToastEnum.AchievementShowMaxSingleCount, AchievementEnum.ShowMaxSingleCount)

		return
	end

	PlayerCardAchievementSelectListModel.instance:setSingleSelect(arg_11_1, not var_11_0)
	arg_11_0:notifyUpdateView()
end

function var_0_0.handlePlayerInfoChanged(arg_12_0)
	PlayerCardAchievementSelectListModel.instance:decodeShowAchievement()
	arg_12_0:notifyUpdateView()
end

function var_0_0.handleAchievementUpdated(arg_13_0)
	PlayerCardAchievementSelectListModel.instance:refreshTabData()
	arg_13_0:notifyUpdateView()
end

function var_0_0.checkSave(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, arg_14_0.switchGroupAfterSave, arg_14_2, nil, arg_14_0, arg_14_3)
end

function var_0_0.sendSave(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0, var_15_1 = PlayerCardAchievementSelectListModel.instance:getSaveRequestParam()

	AchievementRpc.instance:sendShowAchievementRequest(var_15_0, var_15_1, arg_15_1, arg_15_2)
end

function var_0_0.notifyUpdateView(arg_16_0)
	arg_16_0:dispatchEvent(AchievementEvent.SelectViewUpdated)
	PlayerCardAchievementSelectListModel.instance:onModelUpdate()
end

function var_0_0.popUpMessageBoxIfNeedSave(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5, arg_17_6)
	local var_17_0 = PlayerCardAchievementSelectListModel.instance.isGroup

	if PlayerCardAchievementSelectListModel.instance:checkDirty(var_17_0) then
		GameFacade.showMessageBox(MessageBoxIdDefine.AchievementSaveCheck, MsgBoxEnum.BoxType.Yes_No, arg_17_1, arg_17_2, nil, arg_17_4, arg_17_5)
	elseif arg_17_3 then
		arg_17_3(arg_17_6)
	end
end

function var_0_0.isCurrentShowGroupInPlayerView(arg_18_0)
	local var_18_0 = PlayerCardModel.instance:getShowAchievement()
	local var_18_1, var_18_2 = AchievementUtils.decodeShowStr(var_18_0)

	if var_18_2 and tabletool.len(var_18_2) > 0 then
		return true
	end
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0

module("modules.logic.sp01.odyssey.controller.OdysseyDungeonController", package.seeall)

local var_0_0 = class("OdysseyDungeonController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.openDungeonView(arg_4_0, arg_4_1)
	arg_4_0.dungeonViewParam = arg_4_1

	OdysseyRpc.instance:sendOdysseyGetInfoRequest(arg_4_0._openDungeonView, arg_4_0)
end

function var_0_0._openDungeonView(arg_5_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Odyssey
	}, function()
		ViewMgr.instance:openView(ViewName.OdysseyDungeonView, arg_5_0.dungeonViewParam)
	end)
end

function var_0_0.openDungeonInteractView(arg_7_0, arg_7_1)
	arg_7_0:dispatchEvent(OdysseyEvent.ShowInteractCloseBtn, true)
	OdysseyDungeonModel.instance:setCurInElementId(arg_7_1.config.id)
	ViewMgr.instance:openView(ViewName.OdysseyDungeonInteractView, arg_7_1)
end

function var_0_0.openDungeonMapSelectInfoView(arg_8_0, arg_8_1)
	local var_8_0 = {
		mapId = arg_8_1
	}

	ViewMgr.instance:openView(ViewName.OdysseyDungeonMapSelectInfoView, var_8_0)
end

function var_0_0.openMembersView(arg_9_0, arg_9_1)
	OdysseyMembersModel.instance:initLocalClueUnlockState()
	ViewMgr.instance:openView(ViewName.OdysseyMembersView, arg_9_1)
end

function var_0_0.openMembersTipView(arg_10_0, arg_10_1)
	ViewMgr.instance:openView(ViewName.OdysseyMembersTipView, arg_10_1)
end

function var_0_0.openLevelRewardView(arg_11_0)
	OdysseyTaskModel.instance:setCurSelectTaskTypeAndGroupId(OdysseyEnum.TaskType.LevelReward)
	OdysseyTaskModel.instance:refreshList()
	ViewMgr.instance:openView(ViewName.OdysseyLevelRewardView)
end

function var_0_0.popupRewardView(arg_12_0)
	local var_12_0, var_12_1 = arg_12_0:checkNeedPopupRewardView()

	if var_12_0 then
		local var_12_2 = {
			showAddItemList = var_12_1.showAddItemList,
			showAddOuterItemList = var_12_1.showAddOuterItemList,
			heroCurLevel = var_12_1.heroCurLevel,
			heroOldLevel = var_12_1.heroOldLevel,
			heroCurExp = var_12_1.heroCurExp,
			levelAddTalentPoint = var_12_1.levelAddTalentPoint,
			rewardAddTalentPoint = var_12_1.rewardAddTalentPoint,
			addExp = var_12_1.addExp
		}

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.OdysseyDungeonRewardView, var_12_2)
	end
end

function var_0_0.checkNeedPopupRewardView(arg_13_0)
	local var_13_0 = OdysseyItemModel.instance:getItemMoUidMap()
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if iter_13_1.addCount > 0 then
			table.insert(var_13_1, iter_13_1)
		end
	end

	local var_13_2 = OdysseyItemModel.instance:getAddOuterItemList()
	local var_13_3, var_13_4 = OdysseyModel.instance:getHeroCurLevelAndExp()
	local var_13_5, var_13_6 = OdysseyModel.instance:getHeroOldLevelAndExp()
	local var_13_7 = OdysseyTalentModel.instance:getLevelAddTalentPoint()
	local var_13_8 = OdysseyTalentModel.instance:getRewardAddTalentPoint()
	local var_13_9 = OdysseyModel.instance:getHeroAddExp()
	local var_13_10 = #var_13_1 > 0 or #var_13_2 > 0 or var_13_7 > 0 or var_13_8 > 0 or var_13_3 ~= var_13_5 or var_13_9 > 0
	local var_13_11 = {
		showAddItemList = var_13_1,
		showAddOuterItemList = var_13_2,
		heroCurLevel = var_13_3,
		heroOldLevel = var_13_5,
		heroCurExp = var_13_4,
		levelAddTalentPoint = var_13_7,
		rewardAddTalentPoint = var_13_8,
		addExp = var_13_9
	}

	return var_13_10, var_13_11
end

function var_0_0.openMythView(arg_14_0)
	ViewMgr.instance:openView(ViewName.OdysseyMythView)
end

function var_0_0.jumpToMapElement(arg_15_0, arg_15_1)
	if not OdysseyDungeonModel.instance:getElementMo(arg_15_1) then
		logError(arg_15_1 .. "事件数据不存在,请检查")

		return
	end

	OdysseyDungeonModel.instance:setJumpNeedOpenElement(arg_15_1)
	OdysseyRpc.instance:sendOdysseyMapSetCurrElementRequest(arg_15_1)
	OdysseyDungeonModel.instance:setCurInElementId(arg_15_1)
	arg_15_0:dispatchEvent(OdysseyEvent.JumpNeedOpenElement, arg_15_1)
end

function var_0_0.jumpToHeroPos(arg_16_0)
	arg_16_0:dispatchEvent(OdysseyEvent.JumpToHeroPos)
end

function var_0_0.setPlayerPrefs(arg_17_0, arg_17_1, arg_17_2)
	if string.nilorempty(arg_17_1) or not arg_17_2 then
		return
	end

	if type(arg_17_2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(arg_17_1, arg_17_2)
	else
		GameUtil.playerPrefsSetStringByUserId(arg_17_1, arg_17_2)
	end
end

function var_0_0.getPlayerPrefs(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2 or ""

	if string.nilorempty(arg_18_1) then
		return var_18_0
	end

	if type(var_18_0) == "number" then
		var_18_0 = GameUtil.playerPrefsGetNumberByUserId(arg_18_1, var_18_0)
	else
		var_18_0 = GameUtil.playerPrefsGetStringByUserId(arg_18_1, var_18_0)
	end

	return var_18_0
end

function var_0_0.setFightHeroGroup(arg_19_0)
	local var_19_0 = FightModel.instance:getFightParam()

	if not var_19_0 then
		return false
	end

	local var_19_1 = HeroGroupModel.instance:getCurGroupMO()

	if not var_19_1 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local var_19_2, var_19_3 = var_19_1:getMainList()
	local var_19_4, var_19_5 = var_19_1:getSubList()
	local var_19_6 = 0

	if var_19_1.trialDict ~= nil then
		for iter_19_0, iter_19_1 in pairs(var_19_1.trialDict) do
			var_19_6 = var_19_6 + 1
		end
	end

	if (not var_19_1.aidDict or #var_19_1.aidDict <= 0) and var_19_3 + var_19_5 + var_19_6 == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local var_19_7 = var_19_1.clothId

	var_19_0:setMySide(var_19_7, var_19_2, var_19_1:getSubList(), var_19_1:getAllHeroEquips(), nil, nil, nil, nil)

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0

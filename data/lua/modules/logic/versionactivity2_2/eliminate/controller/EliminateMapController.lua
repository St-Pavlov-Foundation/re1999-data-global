module("modules.logic.versionactivity2_2.eliminate.controller.EliminateMapController", package.seeall)

local var_0_0 = class("EliminateMapController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.enterEpisode(arg_5_0, arg_5_1)
	EliminateTeamSelectionModel.instance:setSelectedEpisodeId(arg_5_1)

	if not EliminateLevelModel.instance:selectSoliderIsUnLock() then
		var_0_0.instance:enterLevel(arg_5_1)

		return
	end

	var_0_0.instance:openEliminateSelectRoleView(arg_5_1)
end

function var_0_0.openEliminateMapView(arg_6_0, arg_6_1, arg_6_2)
	EliminateRpc.instance:sendGetMatch3WarChessFacadeInfoRequest(function()
		ViewMgr.instance:openView(ViewName.EliminateMapView, arg_6_1, arg_6_2)
	end)
end

function var_0_0.openEliminateSelectRoleView(arg_8_0, arg_8_1, arg_8_2)
	ViewMgr.instance:openView(ViewName.EliminateSelectRoleView, arg_8_1, arg_8_2)
end

function var_0_0.openEliminateSelectChessMenView(arg_9_0, arg_9_1, arg_9_2)
	ViewMgr.instance:openView(ViewName.EliminateSelectChessMenView, arg_9_1, arg_9_2)
end

function var_0_0.enterLevel(arg_10_0, arg_10_1)
	local var_10_0

	if EliminateTeamSelectionModel.instance:isPreset() then
		var_10_0 = EliminateTeamSelectionModel.instance:getPresetCharacter()
	else
		var_10_0 = EliminateTeamSelectionModel.instance:getCharacterList()[1].id
	end

	EliminateSelectChessMenListModel.instance:initList()

	local var_10_1 = EliminateSelectChessMenListModel.instance:getAutoList()

	EliminateLevelController.instance:enterLevel(arg_10_1, var_10_0, var_10_1)
end

function var_0_0.hasOnceActionKey(arg_11_0, arg_11_1)
	local var_11_0 = var_0_0._getKey(arg_11_0, arg_11_1)

	return PlayerPrefsHelper.hasKey(var_11_0)
end

function var_0_0.setOnceActionKey(arg_12_0, arg_12_1)
	local var_12_0 = var_0_0._getKey(arg_12_0, arg_12_1)

	PlayerPrefsHelper.setNumber(var_12_0, 1)
end

function var_0_0.getPrefsString(arg_13_0, arg_13_1)
	local var_13_0 = var_0_0._getKey(arg_13_0, arg_13_0)

	return (PlayerPrefsHelper.getString(var_13_0, arg_13_1 or ""))
end

function var_0_0.setPrefsString(arg_14_0, arg_14_1)
	local var_14_0 = var_0_0._getKey(arg_14_0, arg_14_0)

	return PlayerPrefsHelper.setString(var_14_0, arg_14_1)
end

function var_0_0._getKey(arg_15_0, arg_15_1)
	return (string.format("%s%s_%s_%s", PlayerPrefsKey.EliminateOnceAnim, PlayerModel.instance:getPlayinfo().userId, arg_15_0, arg_15_1))
end

var_0_0.instance = var_0_0.New()

return var_0_0

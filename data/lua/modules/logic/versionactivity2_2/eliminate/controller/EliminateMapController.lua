module("modules.logic.versionactivity2_2.eliminate.controller.EliminateMapController", package.seeall)

slot0 = class("EliminateMapController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.enterEpisode(slot0, slot1)
	EliminateTeamSelectionModel.instance:setSelectedEpisodeId(slot1)

	if not EliminateLevelModel.instance:selectSoliderIsUnLock() then
		uv0.instance:enterLevel(slot1)

		return
	end

	uv0.instance:openEliminateSelectRoleView(slot1)
end

function slot0.openEliminateMapView(slot0, slot1, slot2)
	EliminateRpc.instance:sendGetMatch3WarChessFacadeInfoRequest(function ()
		ViewMgr.instance:openView(ViewName.EliminateMapView, uv0, uv1)
	end)
end

function slot0.openEliminateSelectRoleView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.EliminateSelectRoleView, slot1, slot2)
end

function slot0.openEliminateSelectChessMenView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.EliminateSelectChessMenView, slot1, slot2)
end

function slot0.enterLevel(slot0, slot1)
	slot2 = nil

	EliminateSelectChessMenListModel.instance:initList()
	EliminateLevelController.instance:enterLevel(slot1, (not EliminateTeamSelectionModel.instance:isPreset() or EliminateTeamSelectionModel.instance:getPresetCharacter()) and EliminateTeamSelectionModel.instance:getCharacterList()[1].id, EliminateSelectChessMenListModel.instance:getAutoList())
end

function slot0.hasOnceActionKey(slot0, slot1)
	return PlayerPrefsHelper.hasKey(uv0._getKey(slot0, slot1))
end

function slot0.setOnceActionKey(slot0, slot1)
	PlayerPrefsHelper.setNumber(uv0._getKey(slot0, slot1), 1)
end

function slot0.getPrefsString(slot0, slot1)
	return PlayerPrefsHelper.getString(uv0._getKey(slot0, slot0), slot1 or "")
end

function slot0.setPrefsString(slot0, slot1)
	return PlayerPrefsHelper.setString(uv0._getKey(slot0, slot0), slot1)
end

function slot0._getKey(slot0, slot1)
	return string.format("%s%s_%s_%s", PlayerPrefsKey.EliminateOnceAnim, PlayerModel.instance:getPlayinfo().userId, slot0, slot1)
end

slot0.instance = slot0.New()

return slot0

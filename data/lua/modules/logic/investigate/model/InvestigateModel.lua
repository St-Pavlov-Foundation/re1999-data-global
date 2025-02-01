module("modules.logic.investigate.model.InvestigateModel", package.seeall)

slot0 = class("InvestigateModel", BaseModel)

function slot0.onInit(slot0)
	slot0._newClueDict = nil
	slot0._noPlayClueDict = nil
	slot0._allUnLockClues = {}
	slot0._waitFirstInit = true
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.refreshUnlock(slot0, slot1)
	if not slot1 and slot0._waitFirstInit then
		return
	end

	slot0._waitFirstInit = false

	if slot1 then
		slot0._allUnLockClues = {}

		for slot5, slot6 in ipairs(lua_investigate_info.configList) do
			if slot6.episode > 0 and DungeonModel.instance:hasPassLevel(slot6.episode) then
				table.insert(slot0._allUnLockClues, slot6.id)
			end
		end
	else
		slot2 = false

		for slot6, slot7 in ipairs(lua_investigate_info.configList) do
			if slot7.episode > 0 and slot7.entrance > 0 and not tabletool.indexOf(slot0._allUnLockClues, slot7.id) and DungeonModel.instance:hasPassLevel(slot7.episode) then
				table.insert(slot0._allUnLockClues, slot7.id)
				slot0:onGetNewId(slot7.id)

				slot2 = true
			end
		end

		if slot2 then
			slot0:_saveLocalData()
			InvestigateController.instance:dispatchEvent(InvestigateEvent.ClueUpdate)
		end
	end
end

function slot0.getAllNewIds(slot0)
	slot0:_initLocalData()

	return slot0._newClueDict
end

function slot0.getAllNoPlayIds(slot0)
	slot0:_initLocalData()

	return slot0._noPlayClueDict
end

function slot0.markAllNewIds(slot0)
	if not slot0._newClueDict[1] then
		return
	end

	slot0._newClueDict = {}

	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNew))
end

function slot0.markAllNoPlayIds(slot0)
	if not slot0._noPlayClueDict[1] then
		return
	end

	slot0._noPlayClueDict = {}

	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNoPlayAnim))
end

function slot0._initLocalData(slot0)
	if not slot0._newClueDict then
		slot0._newClueDict = {}
		slot0._noPlayClueDict = {}
		slot2 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNoPlayAnim), "")

		if not string.nilorempty(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNew), "")) then
			slot0._newClueDict = cjson.decode(slot1)
		end

		if not string.nilorempty(slot2) then
			slot0._noPlayClueDict = cjson.decode(slot2)
		end
	end
end

function slot0.onGetNewId(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.InvestigateClueView, {
			isGet = true,
			id = slot1
		})

		return
	end

	slot0:_initLocalData()
	table.insert(slot0._newClueDict, slot1)
	table.insert(slot0._noPlayClueDict, slot1)
	table.sort(slot0._newClueDict)
	table.sort(slot0._noPlayClueDict)
end

function slot0._saveLocalData(slot0)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNew), cjson.encode(slot0._newClueDict))
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNoPlayAnim), cjson.encode(slot0._noPlayClueDict))
end

function slot0.isClueUnlock(slot0, slot1)
	return tabletool.indexOf(slot0._allUnLockClues, slot1)
end

function slot0.isHaveClue(slot0)
	return slot0._allUnLockClues[1] and true or false
end

function slot0.isGetAllClue(slot0)
	return #slot0._allUnLockClues == #lua_investigate_info.configList
end

slot0.instance = slot0.New()

return slot0

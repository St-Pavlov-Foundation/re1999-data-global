module("modules.logic.seasonver.act123.controller.Season123EquipController", package.seeall)

slot0 = class("Season123EquipController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.reInit(slot0)
end

slot0.Toast_Save_Succ = 2855
slot0.Toast_Empty_Slot = 2856
slot0.Toast_TrialEquipNoChange = 40601

function slot0.onOpenView(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._isOpening = true

	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, slot0.handleHeroGroupUpdated, slot0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, slot0.handleSnapshotSaveSucc, slot0)
	Season123Controller.instance:registerCallback(Season123Event.OnEquipItemChange, slot0.handleItemChanged, slot0)
	Season123Controller.instance:registerCallback(Season123Event.OnPlayerPrefNewUpdate, slot0.handlePlayerPrefNewUpdate, slot0)
	Season123EquipItemListModel.instance:initDatas(slot1, slot2, slot3, slot4, slot5, slot6)
end

function slot0.onCloseView(slot0)
	slot0._isOpening = false

	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, slot0.handleHeroGroupUpdated, slot0)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnSnapshotSaveSucc, slot0.handleSnapshotSaveSucc, slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.OnEquipItemChange, slot0.handleItemChanged, slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.OnPlayerPrefNewUpdate, slot0.handlePlayerPrefNewUpdate, slot0)
	Season123EquipItemListModel.instance:flushRecord()
	Season123Controller.instance:dispatchEvent(Season123Event.OnPlayerPrefNewUpdate)
	Season123EquipItemListModel.instance:clear()
end

function slot0.handleHeroGroupUpdated(slot0)
	if not slot0._isOpening then
		return
	end

	Season123EquipItemListModel.instance:initPosData()
	slot0:notifyUpdateView()
end

function slot0.handleSnapshotSaveSucc(slot0, slot1)
	if not slot0._isOpening then
		return
	end

	if slot1 == ModuleEnum.HeroGroupSnapshotType.Season123 then
		Season123EquipItemListModel.instance:initPosData()
		slot0:notifyUpdateView()
	end
end

function slot0.handleItemChanged(slot0)
	if not slot0._isOpening then
		return
	end

	Season123EquipItemListModel.instance:initItemMap()
	Season123EquipItemListModel.instance:checkResetCurSelected()
	Season123EquipItemListModel.instance:initPlayerPrefs()
	Season123EquipItemListModel.instance:initPosData()
	Season123EquipItemListModel.instance:initList()
	slot0:notifyUpdateView()
end

function slot0.equipItemOnlyShow(slot0, slot1)
	slot3 = Season123EquipItemListModel.instance.curEquipMap[Season123EquipItemListModel.instance.curSelectSlot]
	slot4 = nil

	for slot8, slot9 in pairs(Season123EquipItemListModel.instance.curEquipMap) do
		if slot2 ~= slot8 and slot1 == slot9 then
			Season123EquipItemListModel.instance:unloadShowSlot(slot8)

			slot4 = slot8
		end
	end

	Season123EquipItemListModel.instance:equipShowItem(slot1)
	Season123EquipItemListModel.instance:onModelUpdate()
	slot0:dispatchEvent(Season123EquipEvent.EquipChangeCard, {
		isNew = slot3 == Season123EquipItemListModel.EmptyUid,
		unloadSlot = slot4
	})
end

function slot0.unloadItem(slot0, slot1)
	Season123EquipItemListModel.instance:unloadItem(slot1)
	slot0:notifyUpdateView()
end

function slot0.setSlot(slot0, slot1)
	Season123EquipItemListModel.instance:changeSelectSlot(slot1)
	Season123EquipItemListModel.instance:onModelUpdate()
	slot0:dispatchEvent(Season123EquipEvent.EquipChangeSlot)
end

function slot0.resumeShowSlot(slot0)
	Season123EquipItemListModel.instance:resumeSlotData()
	slot0:notifyUpdateView()
end

function slot0.checkCanSaveSlot(slot0)
	if not Season123EquipItemListModel.instance.activityId then
		return
	end

	if slot0:checkSlotUnlock() then
		GameFacade.showToast(SeasonEquipItem.Toast_Slot_Lock)

		return
	end

	if Season123EquipItemListModel.instance:isAllSlotEmpty() then
		GameFacade.showToast(uv0.Toast_Empty_Slot)

		return
	end

	if Season123EquipItemListModel.instance:curSelectIsTrialEquip() or Season123EquipItemListModel.instance:curMapIsTrialEquipMap() then
		GameFacade.showToast(uv0.Toast_TrialEquipNoChange)

		return
	end

	return true
end

function slot0.saveShowSlot(slot0)
	for slot5 = 1, Season123EquipItemListModel.instance:getEquipMaxCount(Season123EquipItemListModel.instance.curPos) do
		Season123EquipItemListModel.instance:flushSlot(slot5)
	end

	slot3 = Season123EquipItemListModel.instance:getGroupMO()

	for slot7, slot8 in pairs(Season123EquipItemListModel.instance:flushGroup()) do
		if slot8.index == Activity123Enum.MainCharPos then
			for slot13, slot14 in ipairs(slot8.equipUid) do
				slot3.activity104Equips[slot8.index].equipUid[slot13] = slot14
			end
		else
			slot3:updateActivity104PosEquips(slot8)
		end
	end

	Season123HeroGroupUtils.formation104Equips(slot3)
	slot0:syncHeroGroupMO(Season123EquipItemListModel.instance.groupIndex, slot3)
	slot0:notifyUpdateView()
end

function slot0.syncHeroGroupMO(slot0, slot1, slot2)
	HeroGroupModel.instance:saveCurGroupData()
end

function slot0.checkSlotUnlock(slot0)
	if Season123EquipItemListModel.instance.curPos ~= Season123EquipItemListModel.MainCharPos then
		return Season123EquipItemListModel.instance:getShowUnlockSlotCount() <= 0
	else
		for slot5 = Season123EquipItemListModel.HeroMaxPos, 1, -1 do
			if Season123EquipItemListModel.instance:isEquipCardPosUnlock(slot5, slot1) then
				return false
			end
		end

		return true
	end
end

function slot0.checkHeroGroupCardExist(slot0, slot1)
	if not Season123Model.instance:getActInfo(slot1) then
		return
	end

	for slot8, slot9 in pairs(slot2.heroGroupSnapshot) do
		if slot0:checkSingleHeroGroupExist(slot9, slot8, Season123Model.instance:getAllItemMo(slot1) or {}, slot1) then
			logNormal("group [" .. tostring(slot8) .. "] need resync!")
			slot0:syncHeroGroupMO(slot8, slot9)
		end
	end
end

function slot0.checkSingleHeroGroupExist(slot0, slot1, slot2, slot3, slot4)
	if not slot1 then
		return false
	end

	slot5 = false

	for slot9, slot10 in pairs(slot1.activity104Equips) do
		for slot14, slot15 in pairs(slot10.equipUid) do
			if slot15 ~= Season123EquipItemListModel.EmptyUid and slot3[slot15] == nil then
				logNormal(string.format("empty card [%s] found in group [%s] pos [%s]", slot15, tostring(slot2), tostring(slot9)))

				slot10.equipUid[slot14] = Season123EquipItemListModel.EmptyUid
				slot5 = true
			end
		end
	end

	return slot5
end

function slot0.exchangeEquip(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if not HeroGroupModel.instance:getCurGroupMO() then
		return
	end

	for slot13, slot14 in pairs(slot8.activity104Equips) do
		if slot14.index == slot1 then
			slot14.equipUid[slot2] = slot6 or 0
		end

		if slot14.index == slot4 then
			slot14.equipUid[slot5] = slot3 or 0
		end
	end

	slot0:syncHeroGroupMO(slot7, slot8)
	slot0:notifyUpdateView()
end

function slot0.handlePlayerPrefNewUpdate(slot0)
	if Season123EquipItemListModel.instance.recordNew then
		Season123EquipItemListModel.instance.recordNew:initLocalSave()
	end

	slot0:notifyUpdateView()
end

function slot0.notifyUpdateView(slot0)
	Season123EquipItemListModel.instance:onModelUpdate()
	slot0:dispatchEvent(Season123EquipEvent.EquipUpdate)
end

function slot0.setSelectTag(slot0, slot1)
	if Season123EquipItemListModel.instance.tagModel then
		Season123EquipItemListModel.instance.tagModel:selectTagIndex(slot1)
		Season123EquipItemListModel.instance:initList()
	end
end

function slot0.getFilterModel(slot0)
	return Season123EquipItemListModel.instance.tagModel
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0

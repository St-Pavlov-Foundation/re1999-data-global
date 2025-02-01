module("modules.logic.seasonver.act123.controller.Season123EquipHeroController", package.seeall)

slot0 = class("Season123EquipHeroController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.reInit(slot0)
end

slot0.Toast_Save_Succ = 2855

function slot0.onOpenView(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._isOpening = true
	slot0._callback = slot4
	slot0._callbackObj = slot5

	Season123Controller.instance:registerCallback(Season123Event.OnEquipItemChange, slot0.handleItemChanged, slot0)
	Season123Controller.instance:registerCallback(Season123Event.OnPlayerPrefNewUpdate, slot0.handlePlayerPrefNewUpdate, slot0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, slot0.handleSnapshotSaveSucc, slot0)

	slot7 = nil

	if HeroGroupModel.instance:getCurGroupMO() and slot6.activity104Equips and slot6.activity104Equips[Activity123Enum.MainCharPos] then
		slot7 = tabletool.copy(slot6.activity104Equips[Activity123Enum.MainCharPos].equipUid)
	end

	Season123EquipHeroItemListModel.instance:initDatas(slot1, slot2, slot3, slot7)
end

function slot0.onCloseView(slot0)
	slot0._isOpening = false

	Season123Controller.instance:unregisterCallback(Season123Event.OnEquipItemChange, slot0.handleItemChanged, slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.OnPlayerPrefNewUpdate, slot0.handlePlayerPrefNewUpdate, slot0)
	Season123Controller.instance:unregisterCallback(Season123Event.OnSnapshotSaveSucc, slot0.handleSnapshotSaveSucc, slot0)
	Season123EquipHeroItemListModel.instance:flushRecord()
	Season123Controller.instance:dispatchEvent(Season123Event.OnPlayerPrefNewUpdate)
	Season123EquipHeroItemListModel.instance:clear()
end

function slot0.handleSnapshotSaveSucc(slot0, slot1)
	if not slot0._isOpening then
		return
	end

	if slot1 == ModuleEnum.HeroGroupSnapshotType.Season123 then
		if slot0._callback then
			if slot0._callbackObj then
				slot0._callback(slot0._callbackObj, slot1)
			else
				slot0._callback(slot1)
			end
		end

		slot0:notifyUpdateView()
	end
end

function slot0.handleItemChanged(slot0)
	if not slot0._isOpening then
		return
	end

	Season123EquipHeroItemListModel.instance:initItemMap()
	Season123EquipHeroItemListModel.instance:checkResetCurSelected()
	Season123EquipHeroItemListModel.instance:initPlayerPrefs()
	Season123EquipHeroItemListModel.instance:initPosData()
	Season123EquipHeroItemListModel.instance:initList()
	slot0:notifyUpdateView()
end

function slot0.equipItemOnlyShow(slot0, slot1)
	slot3 = Season123EquipHeroItemListModel.instance.curEquipMap[Season123EquipHeroItemListModel.instance.curSelectSlot]
	slot4 = nil

	for slot8, slot9 in pairs(Season123EquipHeroItemListModel.instance.curEquipMap) do
		if slot2 ~= slot8 and slot1 == slot9 then
			Season123EquipHeroItemListModel.instance:unloadShowSlot(slot8)

			slot4 = slot8
		end
	end

	Season123EquipHeroItemListModel.instance:equipShowItem(slot1)
	Season123EquipHeroItemListModel.instance:onModelUpdate()
	slot0:dispatchEvent(Season123EquipEvent.EquipChangeCard, {
		isNew = slot3 == Season123EquipHeroItemListModel.EmptyUid,
		unloadSlot = slot4
	})
end

function slot0.unloadItem(slot0, slot1)
	Season123EquipHeroItemListModel.instance:unloadItem(slot1)
	slot0:notifyUpdateView()
end

function slot0.setSlot(slot0, slot1)
	Season123EquipHeroItemListModel.instance:changeSelectSlot(slot1)
	Season123EquipHeroItemListModel.instance:onModelUpdate()
	slot0:dispatchEvent(Season123EquipEvent.EquipChangeSlot)
end

function slot0.resumeShowSlot(slot0)
	Season123EquipHeroItemListModel.instance:resumeSlotData()
	slot0:notifyUpdateView()
end

function slot0.checkCanSaveSlot(slot0)
	if not Season123EquipHeroItemListModel.instance.activityId then
		return
	end

	if slot0:checkSlotUnlock() then
		GameFacade.showToast(SeasonEquipItem.Toast_Slot_Lock)

		return
	end

	return true
end

function slot0.saveShowSlot(slot0)
	for slot5 = 1, Season123EquipHeroItemListModel.instance:getEquipMaxCount(Season123EquipHeroItemListModel.instance.curPos) do
		Season123EquipHeroItemListModel.instance:flushSlot(slot5)
	end

	slot2 = Season123EquipHeroItemListModel.instance:getEquipedCards()

	if HeroGroupModel.instance:getCurGroupMO() and slot3.activity104Equips and slot3.activity104Equips[Activity123Enum.MainCharPos] then
		for slot7, slot8 in ipairs(slot2) do
			slot3.activity104Equips[Activity123Enum.MainCharPos].equipUid[slot7] = slot2[slot7] or Activity123Enum.EmptyUid
		end

		HeroGroupModel.instance:saveCurGroupData()
	end
end

function slot0.checkSlotUnlock(slot0)
	if Season123EquipHeroItemListModel.instance.curPos ~= Season123EquipHeroItemListModel.MainCharPos then
		return Season123EquipHeroItemListModel.instance:getShowUnlockSlotCount() <= 0
	else
		for slot5 = Season123EquipHeroItemListModel.HeroMaxPos, 1, -1 do
			if Season123Model.instance:isSeasonStagePosUnlock(Season123EquipHeroItemListModel.instance.activityId, Season123EquipHeroItemListModel.instance.stage, slot5, slot1) then
				return false
			end
		end

		return true
	end
end

function slot0.handlePlayerPrefNewUpdate(slot0)
	if Season123EquipHeroItemListModel.instance.recordNew then
		Season123EquipHeroItemListModel.instance.recordNew:initLocalSave()
	end

	slot0:notifyUpdateView()
end

function slot0.notifyUpdateView(slot0)
	Season123EquipHeroItemListModel.instance:onModelUpdate()
	slot0:dispatchEvent(Season123EquipEvent.EquipUpdate)
end

function slot0.setSelectTag(slot0, slot1)
	if Season123EquipHeroItemListModel.instance.tagModel then
		Season123EquipHeroItemListModel.instance.tagModel:selectTagIndex(slot1)
		Season123EquipHeroItemListModel.instance:initList()
	end
end

function slot0.getFilterModel(slot0)
	return Season123EquipHeroItemListModel.instance.tagModel
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0

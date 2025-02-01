module("modules.logic.season.controller.Activity104EquipController", package.seeall)

slot0 = class("Activity104EquipController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.reInit(slot0)
end

slot0.Toast_Save_Succ = 2855
slot0.Toast_Empty_Slot = 2856
slot0.Toast_TrialEquipNoChange = 40601

function slot0.onOpenView(slot0, slot1, slot2, slot3, slot4)
	slot0._isOpening = true

	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, slot0.handleHeroGroupUpdated, slot0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, slot0.handleSnapshotSaveSucc, slot0)
	Activity104Controller.instance:registerCallback(Activity104Event.GetAct104ItemChange, slot0.handleItemChanged, slot0)
	Activity104Controller.instance:registerCallback(Activity104Event.OnPlayerPrefNewUpdate, slot0.handlePlayerPrefNewUpdate, slot0)
	Activity104EquipItemListModel.instance:initDatas(slot1, slot2, slot3, slot4)
end

function slot0.onCloseView(slot0)
	slot0._isOpening = false

	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, slot0.handleHeroGroupUpdated, slot0)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnSnapshotSaveSucc, slot0.handleSnapshotSaveSucc, slot0)
	Activity104Controller.instance:unregisterCallback(Activity104Event.GetAct104ItemChange, slot0.handleItemChanged, slot0)
	Activity104Controller.instance:unregisterCallback(Activity104Event.OnPlayerPrefNewUpdate, slot0.handlePlayerPrefNewUpdate, slot0)
	Activity104EquipItemListModel.instance:flushRecord()
	Activity104Controller.instance:dispatchEvent(Activity104Event.OnPlayerPrefNewUpdate)
	Activity104EquipItemListModel.instance:clear()
end

function slot0.handleHeroGroupUpdated(slot0)
	if not slot0._isOpening then
		return
	end

	Activity104EquipItemListModel.instance:initPosData()
	slot0:notifyUpdateView()
end

function slot0.handleSnapshotSaveSucc(slot0, slot1)
	if not slot0._isOpening then
		return
	end

	if slot1 == ModuleEnum.HeroGroupType.Season then
		Activity104EquipItemListModel.instance:initPosData()
		slot0:notifyUpdateView()
	end
end

function slot0.handleItemChanged(slot0)
	if not slot0._isOpening then
		return
	end

	Activity104EquipItemListModel.instance:initItemMap()
	Activity104EquipItemListModel.instance:checkResetCurSelected()
	Activity104EquipItemListModel.instance:initPlayerPrefs()
	Activity104EquipItemListModel.instance:initPosData()
	Activity104EquipItemListModel.instance:initList()
	slot0:notifyUpdateView()
end

function slot0.equipItemOnlyShow(slot0, slot1)
	slot3 = Activity104EquipItemListModel.instance.curEquipMap[Activity104EquipItemListModel.instance.curSelectSlot]
	slot4 = nil

	for slot8, slot9 in pairs(Activity104EquipItemListModel.instance.curEquipMap) do
		if slot2 ~= slot8 and slot1 == slot9 then
			Activity104EquipItemListModel.instance:unloadShowSlot(slot8)

			slot4 = slot8
		end
	end

	Activity104EquipItemListModel.instance:equipShowItem(slot1)
	Activity104EquipItemListModel.instance:onModelUpdate()
	slot0:dispatchEvent(Activity104EquipEvent.EquipChangeCard, {
		isNew = slot3 == Activity104EquipItemListModel.EmptyUid,
		unloadSlot = slot4
	})
end

function slot0.unloadItem(slot0, slot1)
	Activity104EquipItemListModel.instance:unloadItem(slot1)
	slot0:notifyUpdateView()
end

function slot0.setSlot(slot0, slot1)
	Activity104EquipItemListModel.instance:changeSelectSlot(slot1)
	Activity104EquipItemListModel.instance:onModelUpdate()
	slot0:dispatchEvent(Activity104EquipEvent.EquipChangeSlot)
end

function slot0.resumeShowSlot(slot0)
	Activity104EquipItemListModel.instance:resumeSlotData()
	slot0:notifyUpdateView()
end

function slot0.checkCanSaveSlot(slot0)
	if not Activity104EquipItemListModel.instance.activityId then
		return
	end

	if slot0:checkSlotUnlock() then
		GameFacade.showToast(SeasonEquipItem.Toast_Slot_Lock)

		return
	end

	if Activity104EquipItemListModel.instance:isAllSlotEmpty() then
		GameFacade.showToast(uv0.Toast_Empty_Slot)

		return
	end

	if Activity104EquipItemListModel.instance:curSelectIsTrialEquip() or Activity104EquipItemListModel.instance:curMapIsTrialEquipMap() then
		GameFacade.showToast(uv0.Toast_TrialEquipNoChange)

		return
	end

	return true
end

function slot0.saveShowSlot(slot0)
	for slot5 = 1, Activity104EquipItemListModel.instance:getEquipMaxCount(Activity104EquipItemListModel.instance.curPos) do
		Activity104EquipItemListModel.instance:flushSlot(slot5)
	end

	slot3 = Activity104EquipItemListModel.instance:getGroupMO()

	for slot7, slot8 in pairs(Activity104EquipItemListModel.instance:flushGroup()) do
		slot3:updateActivity104PosEquips(slot8)
	end

	slot0:syncHeroGroupMO(Activity104EquipItemListModel.instance.groupIndex, slot3)
	slot0:notifyUpdateView()
end

function slot0.syncHeroGroupMO(slot0, slot1, slot2)
	HeroGroupModel.instance:saveCurGroupData()
end

function slot0.checkSlotUnlock(slot0)
	if Activity104EquipItemListModel.instance.curPos ~= Activity104EquipItemListModel.MainCharPos then
		return Activity104EquipItemListModel.instance:getShowUnlockSlotCount() <= 0
	else
		for slot5 = Activity104EquipItemListModel.HeroMaxPos, 1, -1 do
			if Activity104Model.instance:isSeasonPosUnlock(Activity104EquipItemListModel.instance.activityId, Activity104EquipItemListModel.instance.groupIndex, slot5, slot1) then
				return false
			end
		end

		return true
	end
end

function slot0.checkHeroGroupCardExist(slot0, slot1)
	for slot7, slot8 in pairs(Activity104Model.instance:getAllHeroGroupSnapshot(slot1)) do
		if slot0:checkSingleHeroGroupExist(slot8, slot7, Activity104Model.instance:getAllItemMo(slot1) or {}, slot1) then
			logNormal("group [" .. tostring(slot7) .. "] need resync!")
			slot0:syncHeroGroupMO(slot7, slot8)
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
			if slot15 ~= Activity104EquipItemListModel.EmptyUid and slot3[slot15] == nil then
				logNormal(string.format("empty card [%s] found in group [%s] pos [%s]", slot15, tostring(slot2), tostring(slot9)))

				slot10.equipUid[slot14] = Activity104EquipItemListModel.EmptyUid
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

	for slot13, slot14 in pairs(slot9) do
		slot8:updateActivity104PosEquips(slot14)
	end

	slot0:syncHeroGroupMO(slot7, slot8)
	slot0:notifyUpdateView()
end

function slot0.handlePlayerPrefNewUpdate(slot0)
	if Activity104EquipItemListModel.instance.recordNew then
		Activity104EquipItemListModel.instance.recordNew:initLocalSave()
	end

	slot0:notifyUpdateView()
end

function slot0.notifyUpdateView(slot0)
	Activity104EquipItemListModel.instance:onModelUpdate()
	slot0:dispatchEvent(Activity104EquipEvent.EquipUpdate)
end

function slot0.setSelectTag(slot0, slot1)
	if Activity104EquipItemListModel.instance.tagModel then
		Activity104EquipItemListModel.instance.tagModel:selectTagIndex(slot1)
		Activity104EquipItemListModel.instance:initList()
	end
end

function slot0.getFilterModel(slot0)
	return Activity104EquipItemListModel.instance.tagModel
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0

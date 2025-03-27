module("modules.logic.tower.view.bosstower.TowerBossSelectView", package.seeall)

slot0 = class("TowerBossSelectView", BaseView)

function slot0.onInitView(slot0)
	slot0.bossContainer = gohelper.findChild(slot0.viewGO, "root/bosscontainer")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.LocalKeyChange, slot0.onLocalKeyChange, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.onTowerTaskUpdated, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerUpdate, slot0.onTowerUpdate, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.LocalKeyChange, slot0.onLocalKeyChange, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.onTowerTaskUpdated, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerUpdate, slot0.onTowerUpdate, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mln_day_night)
	slot0:refreshView()
end

function slot0.onTowerTaskUpdated(slot0)
	slot0:refreshTask()
end

function slot0.onTowerUpdate(slot0)
	slot0:refreshView()
end

function slot0.onLocalKeyChange(slot0)
	if slot0.itemList then
		for slot4, slot5 in ipairs(slot0.itemList) do
			slot5:refreshTag()
		end
	end
end

function slot0.refreshView(slot0)
	slot0:refreshBossList()
	slot0:refreshTime()
end

function slot0.refreshBossList(slot0)
	slot0:initBossList()

	if #TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open) > 1 then
		table.sort(slot1, SortUtil.keyLower("towerId"))
	end

	for slot5, slot6 in ipairs(slot0.itemList) do
		slot6:updateItem(slot1 and slot1[slot5])
	end
end

function slot0.initBossList(slot0)
	if slot0.itemList then
		return
	end

	slot0.itemList = {}

	for slot4 = 1, 3 do
		slot0.itemList[slot4] = slot0:createItem(slot4)
	end
end

function slot0.createItem(slot0, slot1)
	return MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(slot0.viewContainer:getSetting().otherRes.itemRes, gohelper.findChild(slot0.bossContainer, string.format("boss%s", slot1))), TowerBossSelectItem)
end

function slot0.refreshTime(slot0)
	slot2, slot3 = nil

	for slot7, slot8 in pairs(TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)) do
		if slot8.status == TowerEnum.TowerStatus.Open and (slot2 == nil or slot8.nextTime < slot2) then
			slot3 = slot8.towerId
			slot2 = slot8.nextTime
		end
	end

	for slot7, slot8 in ipairs(slot0.itemList) do
		slot8:refreshTime(slot3)
	end
end

function slot0.refreshTask(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5:refreshTask()
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

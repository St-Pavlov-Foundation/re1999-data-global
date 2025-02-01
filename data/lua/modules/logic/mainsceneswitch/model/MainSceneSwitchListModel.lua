module("modules.logic.mainsceneswitch.model.MainSceneSwitchListModel", package.seeall)

slot0 = class("MainSceneSwitchListModel", MixScrollModel)

function slot0._getSceneList(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(lua_scene_switch.configList) do
		if slot7.id == MainSceneSwitchModel.instance:getCurSceneId() then
			table.insert(slot2, 1, slot7)
		else
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.initList(slot0)
	slot0:setList(slot0:_getSceneList())
end

function slot0.getFirstUnlockSceneIndex(slot0)
	for slot5, slot6 in ipairs(slot0:_getSceneList()) do
		if slot6.defaultUnlock ~= 1 and ItemModel.instance:getItemCount(slot6.itemId) > 0 then
			return slot5
		end
	end

	return 0
end

function slot0.clearList(slot0)
	slot0._selectedCellIndex = nil
	slot0._cellInfoList = nil

	slot0:clear()
end

function slot0.getSelectedCellIndex(slot0)
	return slot0._selectedCellIndex
end

function slot0.selectCellIndex(slot0, slot1)
	slot0._selectedCellIndex = slot1

	slot0:refreshScroll()
end

function slot0.refreshScroll(slot0)
	for slot4, slot5 in ipairs(slot0._scrollViews) do
		slot5:refreshScroll()
	end
end

function slot0.getInfoList(slot0, slot1)
	slot0._cellInfoList = slot0._cellInfoList or {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		slot8 = slot0._cellInfoList[slot6] or SLFramework.UGUI.MixCellInfo.New(MainSceneSwitchEnum.ItemTypeUnSelected, MainSceneSwitchEnum.ItemHeight, slot6)

		if slot6 == slot0._selectedCellIndex then
			slot8.type = MainSceneSwitchEnum.ItemTypeSelected
			slot8.lineLength = MainSceneSwitchEnum.ItemHeight
		else
			slot8.type = MainSceneSwitchEnum.ItemTypeUnSelected
			slot8.lineLength = MainSceneSwitchEnum.ItemUnSelectedHeight
		end

		slot0._cellInfoList[slot6] = slot8
	end

	return slot0._cellInfoList
end

slot0.instance = slot0.New()

return slot0

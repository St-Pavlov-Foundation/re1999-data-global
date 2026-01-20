-- chunkname: @modules/logic/mainsceneswitch/model/MainSceneSwitchListModel.lua

module("modules.logic.mainsceneswitch.model.MainSceneSwitchListModel", package.seeall)

local MainSceneSwitchListModel = class("MainSceneSwitchListModel", MixScrollModel)

function MainSceneSwitchListModel:_getSceneList()
	local curSceneId = MainSceneSwitchModel.instance:getCurSceneId()
	local list = {}

	for i, v in ipairs(lua_scene_switch.configList) do
		if v.id == curSceneId then
			table.insert(list, 1, v)
		else
			table.insert(list, v)
		end
	end

	return list
end

function MainSceneSwitchListModel:initList()
	local list = self:_getSceneList()

	self:setList(list)
end

function MainSceneSwitchListModel:getFirstUnlockSceneIndex()
	local list = self:_getSceneList()

	for i, v in ipairs(list) do
		if v.defaultUnlock ~= 1 and ItemModel.instance:getItemCount(v.itemId) > 0 then
			return i
		end
	end

	return 0
end

function MainSceneSwitchListModel:clearList()
	self._selectedCellIndex = nil
	self._cellInfoList = nil

	self:clear()
end

function MainSceneSwitchListModel:getSelectedCellIndex()
	return self._selectedCellIndex
end

function MainSceneSwitchListModel:selectCellIndex(index)
	self._selectedCellIndex = index

	self:refreshScroll()
end

function MainSceneSwitchListModel:refreshScroll()
	for _, scrollView in ipairs(self._scrollViews) do
		scrollView:refreshScroll()
	end
end

function MainSceneSwitchListModel:getInfoList(scrollGO)
	self._cellInfoList = self._cellInfoList or {}

	local list = self:getList()

	for i, mo in ipairs(list) do
		local mixCellInfo = self._cellInfoList[i] or SLFramework.UGUI.MixCellInfo.New(MainSceneSwitchEnum.ItemTypeUnSelected, MainSceneSwitchEnum.ItemHeight, i)

		if i == self._selectedCellIndex then
			mixCellInfo.type = MainSceneSwitchEnum.ItemTypeSelected
			mixCellInfo.lineLength = MainSceneSwitchEnum.ItemHeight
		else
			mixCellInfo.type = MainSceneSwitchEnum.ItemTypeUnSelected
			mixCellInfo.lineLength = MainSceneSwitchEnum.ItemUnSelectedHeight
		end

		self._cellInfoList[i] = mixCellInfo
	end

	return self._cellInfoList
end

MainSceneSwitchListModel.instance = MainSceneSwitchListModel.New()

return MainSceneSwitchListModel

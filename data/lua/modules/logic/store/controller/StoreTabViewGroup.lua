-- chunkname: @modules/logic/store/controller/StoreTabViewGroup.lua

module("modules.logic.store.controller.StoreTabViewGroup", package.seeall)

local StoreTabViewGroup = class("StoreTabViewGroup", TabViewGroup)

function StoreTabViewGroup:onOpen()
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)

	local defaultTabId = self.viewParam and type(self.viewParam) == "table" and self.viewParam.defaultTabIds and self.viewParam.defaultTabIds[self._tabContainerId] or 1

	self:_openTabView(defaultTabId)
end

function StoreTabViewGroup:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId == self._tabContainerId then
		self:_openTabView(tabId)
	end
end

function StoreTabViewGroup:_openTabView(tabId)
	self:_closeTabView()

	self._curTabId = tabId

	if self._tabAbLoaders[self._curTabId] then
		self:_setVisible(self._curTabId, true)
		self._tabViews[self._curTabId]:onOpenInternal()
	else
		local loader = MultiAbLoader.New()

		self._tabAbLoaders[self._curTabId] = loader

		local tabRes = self.viewContainer:getSetting().tabRes

		for _, config in pairs(lua_store_recommend.configDict) do
			if config.isCustomLoad == 1 and config.prefab == self._curTabId then
				tabRes[self._tabContainerId][config.prefab] = {
					string.format("ui/viewres/%s.prefab", config.res)
				}
				self._tabViews[self._curTabId] = _G[config.className].New()
				self._tabViews[self._curTabId].config = config
			end
		end

		local curTabRes = tabRes and tabRes[self._tabContainerId] and tabRes[self._tabContainerId][self._curTabId]

		if curTabRes then
			UIBlockMgr.instance:startBlock(self._UIBlockKey)
			loader:setPathList(curTabRes)
			loader:startLoad(self._finishCallback, self)
		else
			logError(string.format("TabView no res: tabContainerId_%d, tabId_%d", self._tabContainerId, self._curTabId))
		end
	end
end

return StoreTabViewGroup

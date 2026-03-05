-- chunkname: @modules/logic/stat/controller/StatViewController.lua

module("modules.logic.stat.controller.StatViewController", package.seeall)

local StatViewController = class("StatViewController")

function StatViewController:init()
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, self.onTouchScreenDown, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, self.onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.BeforeOpenTabView, self.onBeforeOpenTabView, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnChangeChapterList, self.onChangeChapterType, self)
	ExploreController.instance:registerCallback(ExploreEvent.OnChapterClick, self.onExploreChapterClick, self)
	SummonController.instance:registerCallback(SummonEvent.onSummonTabSet, self.onSwitchPool, self)
	CharacterController.instance:registerCallback(CharacterEvent.OnSwitchSkin, self.onSwitchSkin, self)

	self.viewHandleDict = {
		[ViewName.SummonADView] = self.handleSummonTabView,
		[ViewName.StoreView] = self.handleStoreTabView,
		[ViewName.DungeonView] = self.handleDungeonView,
		[ViewName.DungeonMapView] = self.handleDungeonMapView,
		[ViewName.V1a4_BossRushLevelDetail] = self.handleV1a4_BossRushLevelDetail,
		[ViewName.OptionalChargeView] = self.handleOptionalChargeView,
		[ViewName.VersionActivity2_0EnterView] = self.handleVersionActivityEnterView,
		[ViewName.V3a2_BossRush_LevelDetailView] = self.handleBossRushLevelDetailView
	}
end

function StatViewController:onChangeChapterType(type)
	self:_handleDungeonView(type)
end

function StatViewController:onSwitchPool()
	local viewName = ViewName.SummonADView
	local poolCo = SummonMainModel.instance:getCurPool()
	local chineseName = string.format("%s-%s", StatViewNameEnum.ChineseViewName[viewName] or viewName, poolCo.nameCn)

	self:track(chineseName, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:onTouchScreenDown()
	if UIBlockMgr.instance:isBlock() then
		return
	end

	local viewName = self:getLastOpenView()

	if viewName then
		self.startView = viewName
	end
end

function StatViewController:getLastOpenView()
	self.materialName = nil

	local viewNameList = ViewMgr.instance:getOpenViewNameList()

	for i = #viewNameList, 1, -1 do
		local viewName = viewNameList[i]

		if not self:isIgnoreView(viewName) then
			if self:isTipView(viewName) then
				self.materialName = self:getMaterialName()
			else
				return viewName
			end
		end
	end
end

function StatViewController:onOpenView(viewName, viewParam)
	if not StatViewNameEnum.NeedTrackViewDict[viewName] then
		return
	end

	if tabletool.indexOf(StatViewNameEnum.NeedListenTabSwitchList, viewName) then
		return
	end

	local handle = self.viewHandleDict[viewName]

	handle = handle or self.defaultViewHandle

	handle(self, viewName, viewParam)
end

function StatViewController:onBeforeOpenTabView(paramTab)
	local viewName = paramTab.viewName
	local tabGroupView = paramTab.tabGroupView
	local tabView = paramTab.tabView

	if tabGroupView:getTabContainerId() ~= StatViewNameEnum.TabViewContainerID[viewName] then
		return
	end

	local handle = self.viewHandleDict[viewName]

	handle = handle or self.defaultTabViewHandle

	handle(self, viewName, tabView)
end

function StatViewController:defaultViewHandle(viewName, viewParam)
	self:track(StatViewNameEnum.ChineseViewName[viewName] or viewName, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:defaultTabViewHandle(viewName, tabView)
	local tabViewCnName = StatViewNameEnum.TabViewName[tabView.__cname] or StatViewNameEnum.TabViewName[tabView.class]

	tabViewCnName = tabViewCnName or self:_findTabViewChildCnName(tabView)

	local chineseName = string.format("%s-%s", StatViewNameEnum.ChineseViewName[viewName] or viewName, tabViewCnName or tabView.__cname)

	self:track(chineseName, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:_findTabViewChildCnName(tabView)
	if tabView and tabView._views and #tabView._views > 0 then
		for _, view in ipairs(tabView._views) do
			if StatViewNameEnum.TabViewName[view.__cname] then
				return StatViewNameEnum.TabViewName[view.__cname]
			end
		end
	end

	return nil
end

function StatViewController:handleBossRushLevelDetailView(viewName, tabView)
	local viewContainer = ViewMgr.instance:getContainer(viewName)

	if not viewContainer then
		return
	end

	local stageCO = viewContainer.viewParam and viewContainer.viewParam.stageCO
	local chineseName = string.format("%s-%s", StatViewNameEnum.ChineseViewName[viewName] or viewName, stageCO and stageCO.name or "")

	self:track(chineseName, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:handleVersionActivityEnterView(viewName, tabView)
	local viewContainer = ViewMgr.instance:getContainer(viewName)

	if not viewContainer then
		logError("not open " .. tostring(viewName))

		return
	end

	local activityId = viewContainer.activityId
	local activityCo = ActivityConfig.instance:getActivityCo(activityId)
	local chineseName = string.format("%s-%s", StatViewNameEnum.ChineseViewName[viewName] or viewName, activityCo and activityCo.name or tabView.__cname)

	self:track(chineseName, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:handleStoreTabView(viewName, tabView)
	local viewContainer = ViewMgr.instance:getContainer(viewName)

	if not viewContainer then
		logError("not open store view ?")

		return
	end

	local tabId = viewContainer:getSelectFirstTabId()

	if string.nilorempty(tabId) then
		return
	end

	local storeConfig = StoreConfig.instance:getTabConfig(tabId)

	self:track(storeConfig.name, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:handleSummonTabView(viewName, tabView)
	local poolCo = SummonMainModel.instance:getCurPool()
	local chineseName = string.format("%s-%s", StatViewNameEnum.ChineseViewName[viewName] or viewName, poolCo.nameCn)

	self:track(chineseName, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:handleDungeonView(viewName)
	self:_handleDungeonView(DungeonModel.instance.curChapterType)
end

function StatViewController:_handleDungeonView(type)
	local preName = StatViewNameEnum.ChineseViewName[ViewName.DungeonView] .. "-"

	if DungeonModel.instance:chapterListIsNormalType(type) then
		self:track(preName .. StatViewNameEnum.DungeonViewName.Story, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsRoleStory(type) then
		self:track(preName .. StatViewNameEnum.DungeonViewName.RoleStory, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsResType(type) then
		self:track(preName .. StatViewNameEnum.DungeonViewName.Res, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsBreakType(type) then
		self:track(preName .. StatViewNameEnum.DungeonViewName.Break, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsWeekWalkType(type) then
		self:track(preName .. StatViewNameEnum.DungeonViewName.WeekWalkName, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsPermanent(type) then
		self:track(preName .. StatViewNameEnum.DungeonViewName.Permanent, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)

		return
	end
end

function StatViewController:onExploreChapterClick(index)
	local chapterCoList = DungeonConfig.instance:getExploreChapterList()
	local chapterCo = chapterCoList[index]

	self:track(string.format("%s-%s-%s", StatViewNameEnum.ChineseViewName[ViewName.DungeonView], StatViewNameEnum.DungeonViewName.ExploreName, chapterCo.name), StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:handleDungeonMapView(viewName, viewParam)
	local chapterId = viewParam.chapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

	self:track(string.format("%s-%s", StatViewNameEnum.ChineseViewName[viewName], chapterCo.name), StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:handleV1a4_BossRushLevelDetail(viewName, viewParam)
	local stageCo = viewParam.stageCO
	local name = (StatViewNameEnum.ChineseViewName[viewName] or viewName) .. " - " .. stageCo.name

	self:track(name, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:handleOptionalChargeView(viewName, viewParam)
	local chargeGoodsCfg = viewParam and viewParam.config
	local name = chargeGoodsCfg and chargeGoodsCfg.name

	self:track(name, StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:onSwitchSkin(skinCo, viewName)
	self:track((StatViewNameEnum.ChineseViewName[viewName] or viewName) .. "-" .. (skinCo and skinCo.name or ""), StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

function StatViewController:isIgnoreView(viewName)
	return tabletool.indexOf(StatViewNameEnum.IgnoreViewList, viewName) ~= nil
end

function StatViewController:isTipView(viewName)
	return viewName == StatViewNameEnum.MaterialTipView
end

function StatViewController:getMaterialName()
	local viewContainer = ViewMgr.instance:getContainer(StatViewNameEnum.MaterialTipView)
	local viewParam = viewContainer.viewParam
	local config = ItemConfig.instance:getItemConfig(viewParam.type, viewParam.id)

	return config.name
end

function StatViewController:track(viewName, startView, materialName)
	StatController.instance:track(StatEnum.EventName.EnterView, {
		[StatEnum.EventProperties.ViewName] = viewName,
		[StatEnum.EventProperties.StartViewName] = startView,
		[StatEnum.EventProperties.MaterialViewName] = materialName or ""
	})
end

function StatViewController:trackViewName(chineseViewNameStr)
	self:track(chineseViewNameStr or "", StatViewNameEnum.ChineseViewName[self.startView] or self.startView, self.materialName)
end

StatViewController.instance = StatViewController.New()

return StatViewController

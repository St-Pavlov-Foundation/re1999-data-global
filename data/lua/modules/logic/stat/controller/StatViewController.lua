module("modules.logic.stat.controller.StatViewController", package.seeall)

slot0 = class("StatViewController")

function slot0.init(slot0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, slot0.onTouchScreenDown, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, slot0.onOpenView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.BeforeOpenTabView, slot0.onBeforeOpenTabView, slot0)
	DungeonController.instance:registerCallback(DungeonEvent.OnChangeChapterList, slot0.onChangeChapterType, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnChapterClick, slot0.onExploreChapterClick, slot0)
	SummonController.instance:registerCallback(SummonEvent.onSummonTabSet, slot0.onSwitchPool, slot0)
	CharacterController.instance:registerCallback(CharacterEvent.OnSwitchSkin, slot0.onSwitchSkin, slot0)

	slot0.viewHandleDict = {
		[ViewName.SummonADView] = slot0.handleSummonTabView,
		[ViewName.StoreView] = slot0.handleStoreTabView,
		[ViewName.DungeonView] = slot0.handleDungeonView,
		[ViewName.DungeonMapView] = slot0.handleDungeonMapView,
		[ViewName.V1a4_BossRushLevelDetail] = slot0.handleV1a4_BossRushLevelDetail,
		[ViewName.OptionalChargeView] = slot0.handleOptionalChargeView,
		[ViewName.VersionActivity2_0EnterView] = slot0.handleVersionActivityEnterView
	}
end

function slot0.onChangeChapterType(slot0, slot1)
	slot0:_handleDungeonView(slot1)
end

function slot0.onSwitchPool(slot0)
	slot0:track(string.format("%s-%s", StatViewNameEnum.ChineseViewName[ViewName.SummonADView] or slot1, SummonMainModel.instance:getCurPool().nameCn), StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)
end

function slot0.onTouchScreenDown(slot0)
	if UIBlockMgr.instance:isBlock() then
		return
	end

	if slot0:getLastOpenView() then
		slot0.startView = slot1
	end
end

function slot0.getLastOpenView(slot0)
	slot0.materialName = nil

	for slot5 = #ViewMgr.instance:getOpenViewNameList(), 1, -1 do
		if not slot0:isIgnoreView(slot1[slot5]) then
			if slot0:isTipView(slot6) then
				slot0.materialName = slot0:getMaterialName()
			else
				return slot6
			end
		end
	end
end

function slot0.onOpenView(slot0, slot1, slot2)
	if not StatViewNameEnum.NeedTrackViewDict[slot1] then
		return
	end

	if tabletool.indexOf(StatViewNameEnum.NeedListenTabSwitchList, slot1) then
		return
	end

	slot0.viewHandleDict[slot1] or slot0.defaultViewHandle(slot0, slot1, slot2)
end

function slot0.onBeforeOpenTabView(slot0, slot1)
	slot4 = slot1.tabView

	if slot1.tabGroupView:getTabContainerId() ~= StatViewNameEnum.TabViewContainerID[slot1.viewName] then
		return
	end

	slot0.viewHandleDict[slot2] or slot0.defaultTabViewHandle(slot0, slot2, slot4)
end

function slot0.defaultViewHandle(slot0, slot1, slot2)
	slot0:track(StatViewNameEnum.ChineseViewName[slot1] or slot1, StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)
end

function slot0.defaultTabViewHandle(slot0, slot1, slot2)
	slot0:track(string.format("%s-%s", StatViewNameEnum.ChineseViewName[slot1] or slot1, StatViewNameEnum.TabViewName[slot2.__cname] or StatViewNameEnum.TabViewName[slot2.class] or slot2.__cname), StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)
end

function slot0.handleVersionActivityEnterView(slot0, slot1, slot2)
	if not ViewMgr.instance:getContainer(slot1) then
		logError("not open " .. tostring(slot1))

		return
	end

	slot5 = ActivityConfig.instance:getActivityCo(slot3.activityId)

	slot0:track(string.format("%s-%s", StatViewNameEnum.ChineseViewName[slot1] or slot1, slot5 and slot5.name or slot2.__cname), StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)
end

function slot0.handleStoreTabView(slot0, slot1, slot2)
	if not ViewMgr.instance:getContainer(slot1) then
		logError("not open store view ?")

		return
	end

	if string.nilorempty(slot3:getSelectFirstTabId()) then
		return
	end

	slot0:track(StoreConfig.instance:getTabConfig(slot4).name, StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)
end

function slot0.handleSummonTabView(slot0, slot1, slot2)
	slot0:track(string.format("%s-%s", StatViewNameEnum.ChineseViewName[slot1] or slot1, SummonMainModel.instance:getCurPool().nameCn), StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)
end

function slot0.handleDungeonView(slot0, slot1)
	slot0:_handleDungeonView(DungeonModel.instance.curChapterType)
end

function slot0._handleDungeonView(slot0, slot1)
	if DungeonModel.instance:chapterListIsNormalType(slot1) then
		slot0:track(StatViewNameEnum.ChineseViewName[ViewName.DungeonView] .. "-" .. StatViewNameEnum.DungeonViewName.Story, StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsRoleStory(slot1) then
		slot0:track(slot2 .. StatViewNameEnum.DungeonViewName.RoleStory, StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsResType(slot1) then
		slot0:track(slot2 .. StatViewNameEnum.DungeonViewName.Res, StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsBreakType(slot1) then
		slot0:track(slot2 .. StatViewNameEnum.DungeonViewName.Break, StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsWeekWalkType(slot1) then
		slot0:track(slot2 .. StatViewNameEnum.DungeonViewName.WeekWalkName, StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)

		return
	end

	if DungeonModel.instance:chapterListIsPermanent(slot1) then
		slot0:track(slot2 .. StatViewNameEnum.DungeonViewName.Permanent, StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)

		return
	end
end

function slot0.onExploreChapterClick(slot0, slot1)
	slot0:track(string.format("%s-%s-%s", StatViewNameEnum.ChineseViewName[ViewName.DungeonView], StatViewNameEnum.DungeonViewName.ExploreName, DungeonConfig.instance:getExploreChapterList()[slot1].name), StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)
end

function slot0.handleDungeonMapView(slot0, slot1, slot2)
	slot0:track(string.format("%s-%s", StatViewNameEnum.ChineseViewName[slot1], DungeonConfig.instance:getChapterCO(slot2.chapterId).name), StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)
end

function slot0.handleV1a4_BossRushLevelDetail(slot0, slot1, slot2)
	slot0:track((StatViewNameEnum.ChineseViewName[slot1] or slot1) .. " - " .. slot2.stageCO.name, StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)
end

function slot0.handleOptionalChargeView(slot0, slot1, slot2)
	slot3 = slot2 and slot2.config

	slot0:track(slot3 and slot3.name, StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)
end

function slot0.onSwitchSkin(slot0, slot1, slot2)
	slot0:track((StatViewNameEnum.ChineseViewName[slot2] or slot2) .. "-" .. (slot1 and slot1.name or ""), StatViewNameEnum.ChineseViewName[slot0.startView] or slot0.startView, slot0.materialName)
end

function slot0.isIgnoreView(slot0, slot1)
	return tabletool.indexOf(StatViewNameEnum.IgnoreViewList, slot1) ~= nil
end

function slot0.isTipView(slot0, slot1)
	return slot1 == StatViewNameEnum.MaterialTipView
end

function slot0.getMaterialName(slot0)
	slot2 = ViewMgr.instance:getContainer(StatViewNameEnum.MaterialTipView).viewParam

	return ItemConfig.instance:getItemConfig(slot2.type, slot2.id).name
end

function slot0.track(slot0, slot1, slot2, slot3)
	StatController.instance:track(StatEnum.EventName.EnterView, {
		[StatEnum.EventProperties.ViewName] = slot1,
		[StatEnum.EventProperties.StartViewName] = slot2,
		[StatEnum.EventProperties.MaterialViewName] = slot3 or ""
	})
end

slot0.instance = slot0.New()

return slot0

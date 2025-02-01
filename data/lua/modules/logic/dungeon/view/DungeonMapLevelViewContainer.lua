module("modules.logic.dungeon.view.DungeonMapLevelViewContainer", package.seeall)

slot0 = class("DungeonMapLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, DungeonMapLevelView.New())
	table.insert(slot1, DungeonMapLevelRewardView.New())
	table.insert(slot1, TabViewGroup.New(1, "anim/#go_righttop"))
	table.insert(slot1, TabViewGroup.New(2, "anim/top_left"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.Power
			})
		}
	elseif slot1 == 2 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.Normal and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Dungeon)
		}, HelpEnum.HelpId.Dungeon)

		slot0._navigateButtonView:setOverrideClose(slot0._overrideClose, slot0)
		slot0._navigateButtonView:setAnimEnabled(false)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetOnCloseViewAudio(0)
	DungeonModel.instance:setLastSelectMode(nil, )
end

function slot0._overrideClose(slot0)
	if ViewMgr.instance:isOpen(ViewName.DungeonView) or ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchMainView) then
		ViewMgr.instance:closeView(ViewName.DungeonMapView, false, true)
		ViewMgr.instance:closeView(ViewName.DungeonMapLevelView, false, true)

		return
	end

	module_views_preloader.DungeonViewPreload(function ()
		DungeonController.instance:openDungeonView(nil, true)
		ViewMgr.instance:closeView(ViewName.DungeonMapView, false, true)
		ViewMgr.instance:closeView(ViewName.DungeonMapLevelView, false, true)
	end)
end

function slot0.refreshHelp(slot0)
	if slot0._navigateButtonView then
		slot0._navigateButtonView:setParam({
			true,
			true,
			DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.Normal and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Dungeon)
		})
	end
end

return slot0

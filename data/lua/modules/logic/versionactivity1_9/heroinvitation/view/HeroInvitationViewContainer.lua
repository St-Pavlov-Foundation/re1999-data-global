module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationViewContainer", package.seeall)

slot0 = class("HeroInvitationViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "Right/#scroll_RoleList"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes.itemRes
	slot2.cellClass = HeroInvitationItem
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.lineCount = 1
	slot2.cellWidth = 204
	slot2.cellHeight = 528
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0
	slot0.scrollView = LuaListScrollViewWithAnimator.New(HeroInvitationListModel.instance, slot2)

	table.insert(slot1, slot0.scrollView)
	table.insert(slot1, HeroInvitationView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function slot0.getScrollView(slot0)
	return slot0.scrollView
end

return slot0

module("modules.logic.social.view.SocialViewContainer", package.seeall)

slot0 = class("SocialViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SocialView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot1, TabViewGroup.New(2, "container/tabviews"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	elseif slot1 == 2 then
		return {
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Friend), slot0:getFriendsScrollParam()),
				LuaMixScrollView.New(SocialMessageListModel.instance, slot0:getMessageListScrollParam()),
				SocialFriendsView.New()
			}),
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Recommend), slot0:getRecommendScrollParam()),
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Search), slot0:getSearchScrollParam()),
				SocialSearchView.New()
			}),
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Request), slot0:getRequestScrollParam()),
				SocialRequestView.New()
			}),
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Black), slot0:getBlackListScrollParam()),
				SocialBlackListView.New()
			})
		}
	end
end

function slot0.getFriendsScrollParam(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_has/left/hasscrollview"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = SocialFriendItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 555
	slot1.cellHeight = 152
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 10
	slot1.startSpace = 8

	return slot1
end

function slot0.getRequestScrollParam(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "scrollview"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[2]
	slot1.cellClass = SocialRequestItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1560
	slot1.cellHeight = 160
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 24

	return slot1
end

function slot0.getRecommendScrollParam(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "container/#go_recommend/scrollview"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[3]
	slot1.cellClass = SocialSearchItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1560
	slot1.cellHeight = 160
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 24

	return slot1
end

function slot0.getSearchScrollParam(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "container/#go_searchresults/scrollview"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[3]
	slot1.cellClass = SocialSearchItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1560
	slot1.cellHeight = 160
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 24

	return slot1
end

function slot0.getBlackListScrollParam(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_has/scrollview"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[4]
	slot1.cellClass = SocialBlackListItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 2
	slot1.cellWidth = 755
	slot1.cellHeight = 160
	slot1.cellSpaceH = 6
	slot1.cellSpaceV = 1.5

	return slot1
end

function slot0.getMessageListScrollParam(slot0)
	slot1 = MixScrollParam.New()
	slot1.scrollGOPath = "#go_has/right/#go_message/#scroll_message"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[5]
	slot1.cellClass = SocialMessageItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1

	return slot1
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

return slot0

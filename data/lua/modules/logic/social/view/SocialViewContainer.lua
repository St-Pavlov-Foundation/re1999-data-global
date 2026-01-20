-- chunkname: @modules/logic/social/view/SocialViewContainer.lua

module("modules.logic.social.view.SocialViewContainer", package.seeall)

local SocialViewContainer = class("SocialViewContainer", BaseViewContainer)

function SocialViewContainer:buildViews()
	local views = {}

	table.insert(views, SocialView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "container/tabviews"))

	return views
end

function SocialViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	elseif tabContainerId == 2 then
		local friendsScrollParam = self:getFriendsScrollParam()
		local requestScrollParam = self:getRequestScrollParam()
		local recommendScrollParam = self:getRecommendScrollParam()
		local searchScrollParam = self:getSearchScrollParam()
		local blackListScrollParam = self:getBlackListScrollParam()
		local messageListScrollParam = self:getMessageListScrollParam()

		return {
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Friend), friendsScrollParam),
				LuaMixScrollView.New(SocialMessageListModel.instance, messageListScrollParam),
				SocialFriendsView.New()
			}),
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Recommend), recommendScrollParam),
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Search), searchScrollParam),
				SocialSearchView.New()
			}),
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Request), requestScrollParam),
				SocialRequestView.New()
			}),
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Black), blackListScrollParam),
				SocialBlackListView.New()
			})
		}
	end
end

function SocialViewContainer:getFriendsScrollParam()
	local friendsScrollParam = ListScrollParam.New()

	friendsScrollParam.scrollGOPath = "#go_has/left/hasscrollview"
	friendsScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	friendsScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	friendsScrollParam.cellClass = SocialFriendItem
	friendsScrollParam.scrollDir = ScrollEnum.ScrollDirV
	friendsScrollParam.lineCount = 1
	friendsScrollParam.cellWidth = 555
	friendsScrollParam.cellHeight = 152
	friendsScrollParam.cellSpaceH = 0
	friendsScrollParam.cellSpaceV = 10
	friendsScrollParam.startSpace = 8

	return friendsScrollParam
end

function SocialViewContainer:getRequestScrollParam()
	local requestScrollParam = ListScrollParam.New()

	requestScrollParam.scrollGOPath = "scrollview"
	requestScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	requestScrollParam.prefabUrl = self._viewSetting.otherRes[2]
	requestScrollParam.cellClass = SocialRequestItem
	requestScrollParam.scrollDir = ScrollEnum.ScrollDirV
	requestScrollParam.lineCount = 1
	requestScrollParam.cellWidth = 1560
	requestScrollParam.cellHeight = 160
	requestScrollParam.cellSpaceH = 0
	requestScrollParam.cellSpaceV = 24

	return requestScrollParam
end

function SocialViewContainer:getRecommendScrollParam()
	local recommendScrollParam = ListScrollParam.New()

	recommendScrollParam.scrollGOPath = "container/#go_recommend/scrollview"
	recommendScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	recommendScrollParam.prefabUrl = self._viewSetting.otherRes[3]
	recommendScrollParam.cellClass = SocialSearchItem
	recommendScrollParam.scrollDir = ScrollEnum.ScrollDirV
	recommendScrollParam.lineCount = 1
	recommendScrollParam.cellWidth = 1560
	recommendScrollParam.cellHeight = 160
	recommendScrollParam.cellSpaceH = 0
	recommendScrollParam.cellSpaceV = 24

	return recommendScrollParam
end

function SocialViewContainer:getSearchScrollParam()
	local searchScrollParam = ListScrollParam.New()

	searchScrollParam.scrollGOPath = "container/#go_searchresults/scrollview"
	searchScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	searchScrollParam.prefabUrl = self._viewSetting.otherRes[3]
	searchScrollParam.cellClass = SocialSearchItem
	searchScrollParam.scrollDir = ScrollEnum.ScrollDirV
	searchScrollParam.lineCount = 1
	searchScrollParam.cellWidth = 1560
	searchScrollParam.cellHeight = 160
	searchScrollParam.cellSpaceH = 0
	searchScrollParam.cellSpaceV = 24

	return searchScrollParam
end

function SocialViewContainer:getBlackListScrollParam()
	local blackListScrollParam = ListScrollParam.New()

	blackListScrollParam.scrollGOPath = "#go_has/scrollview"
	blackListScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	blackListScrollParam.prefabUrl = self._viewSetting.otherRes[4]
	blackListScrollParam.cellClass = SocialBlackListItem
	blackListScrollParam.scrollDir = ScrollEnum.ScrollDirV
	blackListScrollParam.lineCount = 2
	blackListScrollParam.cellWidth = 755
	blackListScrollParam.cellHeight = 160
	blackListScrollParam.cellSpaceH = 6
	blackListScrollParam.cellSpaceV = 1.5

	return blackListScrollParam
end

function SocialViewContainer:getMessageListScrollParam()
	local messageListScrollParam = MixScrollParam.New()

	messageListScrollParam.scrollGOPath = "#go_has/right/#go_message/#scroll_message"
	messageListScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	messageListScrollParam.prefabUrl = self._viewSetting.otherRes[5]
	messageListScrollParam.cellClass = SocialMessageItem
	messageListScrollParam.scrollDir = ScrollEnum.ScrollDirV
	messageListScrollParam.lineCount = 1

	return messageListScrollParam
end

function SocialViewContainer:switchTab(tabId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabId)
end

return SocialViewContainer

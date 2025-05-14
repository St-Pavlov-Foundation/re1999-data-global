module("modules.logic.social.view.SocialViewContainer", package.seeall)

local var_0_0 = class("SocialViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SocialView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(2, "container/tabviews"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	elseif arg_2_1 == 2 then
		local var_2_0 = arg_2_0:getFriendsScrollParam()
		local var_2_1 = arg_2_0:getRequestScrollParam()
		local var_2_2 = arg_2_0:getRecommendScrollParam()
		local var_2_3 = arg_2_0:getSearchScrollParam()
		local var_2_4 = arg_2_0:getBlackListScrollParam()
		local var_2_5 = arg_2_0:getMessageListScrollParam()

		return {
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Friend), var_2_0),
				LuaMixScrollView.New(SocialMessageListModel.instance, var_2_5),
				SocialFriendsView.New()
			}),
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Recommend), var_2_2),
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Search), var_2_3),
				SocialSearchView.New()
			}),
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Request), var_2_1),
				SocialRequestView.New()
			}),
			MultiView.New({
				LuaListScrollView.New(SocialListModel.instance:getModel(SocialEnum.Type.Black), var_2_4),
				SocialBlackListView.New()
			})
		}
	end
end

function var_0_0.getFriendsScrollParam(arg_3_0)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "#go_has/left/hasscrollview"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_0.prefabUrl = arg_3_0._viewSetting.otherRes[1]
	var_3_0.cellClass = SocialFriendItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirV
	var_3_0.lineCount = 1
	var_3_0.cellWidth = 555
	var_3_0.cellHeight = 152
	var_3_0.cellSpaceH = 0
	var_3_0.cellSpaceV = 10
	var_3_0.startSpace = 8

	return var_3_0
end

function var_0_0.getRequestScrollParam(arg_4_0)
	local var_4_0 = ListScrollParam.New()

	var_4_0.scrollGOPath = "scrollview"
	var_4_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_4_0.prefabUrl = arg_4_0._viewSetting.otherRes[2]
	var_4_0.cellClass = SocialRequestItem
	var_4_0.scrollDir = ScrollEnum.ScrollDirV
	var_4_0.lineCount = 1
	var_4_0.cellWidth = 1560
	var_4_0.cellHeight = 160
	var_4_0.cellSpaceH = 0
	var_4_0.cellSpaceV = 24

	return var_4_0
end

function var_0_0.getRecommendScrollParam(arg_5_0)
	local var_5_0 = ListScrollParam.New()

	var_5_0.scrollGOPath = "container/#go_recommend/scrollview"
	var_5_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_5_0.prefabUrl = arg_5_0._viewSetting.otherRes[3]
	var_5_0.cellClass = SocialSearchItem
	var_5_0.scrollDir = ScrollEnum.ScrollDirV
	var_5_0.lineCount = 1
	var_5_0.cellWidth = 1560
	var_5_0.cellHeight = 160
	var_5_0.cellSpaceH = 0
	var_5_0.cellSpaceV = 24

	return var_5_0
end

function var_0_0.getSearchScrollParam(arg_6_0)
	local var_6_0 = ListScrollParam.New()

	var_6_0.scrollGOPath = "container/#go_searchresults/scrollview"
	var_6_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_6_0.prefabUrl = arg_6_0._viewSetting.otherRes[3]
	var_6_0.cellClass = SocialSearchItem
	var_6_0.scrollDir = ScrollEnum.ScrollDirV
	var_6_0.lineCount = 1
	var_6_0.cellWidth = 1560
	var_6_0.cellHeight = 160
	var_6_0.cellSpaceH = 0
	var_6_0.cellSpaceV = 24

	return var_6_0
end

function var_0_0.getBlackListScrollParam(arg_7_0)
	local var_7_0 = ListScrollParam.New()

	var_7_0.scrollGOPath = "#go_has/scrollview"
	var_7_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_7_0.prefabUrl = arg_7_0._viewSetting.otherRes[4]
	var_7_0.cellClass = SocialBlackListItem
	var_7_0.scrollDir = ScrollEnum.ScrollDirV
	var_7_0.lineCount = 2
	var_7_0.cellWidth = 755
	var_7_0.cellHeight = 160
	var_7_0.cellSpaceH = 6
	var_7_0.cellSpaceV = 1.5

	return var_7_0
end

function var_0_0.getMessageListScrollParam(arg_8_0)
	local var_8_0 = MixScrollParam.New()

	var_8_0.scrollGOPath = "#go_has/right/#go_message/#scroll_message"
	var_8_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_8_0.prefabUrl = arg_8_0._viewSetting.otherRes[5]
	var_8_0.cellClass = SocialMessageItem
	var_8_0.scrollDir = ScrollEnum.ScrollDirV
	var_8_0.lineCount = 1

	return var_8_0
end

function var_0_0.switchTab(arg_9_0, arg_9_1)
	arg_9_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_9_1)
end

return var_0_0

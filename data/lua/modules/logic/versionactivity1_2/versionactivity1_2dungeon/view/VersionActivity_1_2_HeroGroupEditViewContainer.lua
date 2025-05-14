module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_HeroGroupEditViewContainer", package.seeall)

local var_0_0 = class("VersionActivity_1_2_HeroGroupEditViewContainer", HeroGroupEditViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_rolecontainer/#scroll_card"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = HeroGroupEditItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 5
	var_1_0.cellWidth = 200
	var_1_0.cellHeight = 440
	var_1_0.cellSpaceH = 12
	var_1_0.cellSpaceV = 10
	var_1_0.startSpace = 37

	local var_1_1 = {}

	for iter_1_0 = 1, 15 do
		var_1_1[iter_1_0] = math.ceil((iter_1_0 - 1) % 5) * 0.03
	end

	return {
		VersionActivity_1_2_HeroGroupEditView.New(),
		LuaListScrollViewWithAnimator.New(HeroGroupEditListModel.instance, var_1_0, var_1_1),
		arg_1_0:getQuickEditScroll(),
		CommonRainEffectView.New("bg/#go_raincontainer"),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0._overrideClose(arg_2_0)
	if ViewMgr.instance:isOpen(ViewName.CharacterLevelUpView) then
		ViewMgr.instance:closeView(ViewName.CharacterLevelUpView, nil, true)
	elseif ViewMgr.instance:isOpen(ViewName.VersionActivity_1_2_HeroGroupEditView) then
		ViewMgr.instance:closeView(ViewName.VersionActivity_1_2_HeroGroupEditView, nil, true)
	end
end

return var_0_0

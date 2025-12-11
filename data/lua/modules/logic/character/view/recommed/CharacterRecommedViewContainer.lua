module("modules.logic.character.view.recommed.CharacterRecommedViewContainer", package.seeall)

local var_0_0 = class("CharacterRecommedViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._recommedView = CharacterRecommedView.New()
	arg_1_0._heroView = CharacterRecommedHeroView.New()

	local var_1_0 = {}

	table.insert(var_1_0, arg_1_0._heroView)
	table.insert(var_1_0, arg_1_0._recommedView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(2, "right/#go_scroll"))
	table.insert(var_1_0, TabViewGroup.New(3, "#go_changehero"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end

	if arg_2_1 == 2 then
		return {
			CharacterRecommedGroupView.New(),
			CharacterDevelopGoalsView.New()
		}
	end

	if arg_2_1 == 3 then
		local var_2_0 = {}

		arg_2_0:_addCharacterChangeHeroView(var_2_0)

		return var_2_0
	end
end

function var_0_0.onContainerInit(arg_3_0)
	arg_3_0.viewParam.defaultTabIds = {}
	arg_3_0.viewParam.defaultTabIds[2] = arg_3_0.viewParam.defaultTabId or CharacterRecommedEnum.TabSubType.RecommedGroup
end

function var_0_0._addCharacterChangeHeroView(arg_4_0, arg_4_1)
	local var_4_0 = {}

	table.insert(var_4_0, CharacterRecommedChangeHeroView.New())

	local var_4_1 = ListScrollParam.New()

	var_4_1.scrollGOPath = "#scroll_hero"
	var_4_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_4_1.prefabUrl = arg_4_0._viewSetting.otherRes[3]
	var_4_1.cellClass = CharacterRecommedChangeHeroItem
	var_4_1.scrollDir = ScrollEnum.ScrollDirV
	var_4_1.lineCount = 3
	var_4_1.cellWidth = 150
	var_4_1.cellHeight = 150
	var_4_1.cellSpaceH = 0
	var_4_1.cellSpaceV = 0

	local var_4_2 = LuaListScrollView.New(CharacterRecommedHeroListModel.instance, var_4_1)

	table.insert(var_4_0, var_4_2)

	arg_4_1[1] = MultiView.New(var_4_0)
end

function var_0_0.playCloseTransition(arg_5_0)
	arg_5_0._recommedView:playViewAnimPlayer(CharacterRecommedEnum.AnimName.Close, arg_5_0.onPlayCloseTransitionFinish, arg_5_0)
end

function var_0_0.cutTab(arg_6_0, arg_6_1)
	arg_6_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_6_1)

	arg_6_0.viewParam.defaultTabId = arg_6_1
end

function var_0_0.getGroupItemRes(arg_7_0)
	local var_7_0 = arg_7_0._viewSetting.otherRes[1]

	return arg_7_0:getRes(var_7_0)
end

function var_0_0.getGoalsItemRes(arg_8_0)
	local var_8_0 = arg_8_0._viewSetting.otherRes[2]

	return arg_8_0:getRes(var_8_0)
end

function var_0_0.getHeroIconRes(arg_9_0)
	local var_9_0 = arg_9_0._viewSetting.otherRes[3]

	return arg_9_0:getRes(var_9_0)
end

function var_0_0.getEquipIconRes(arg_10_0)
	local var_10_0 = arg_10_0._viewSetting.otherRes[4]

	return arg_10_0:getRes(var_10_0)
end

return var_0_0

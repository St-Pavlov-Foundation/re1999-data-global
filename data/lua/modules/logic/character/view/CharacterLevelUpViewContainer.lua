module("modules.logic.character.view.CharacterLevelUpViewContainer", package.seeall)

local var_0_0 = class("CharacterLevelUpViewContainer", BaseViewContainer)
local var_0_1 = 130

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "anim/lv/#go_Lv/#scroll_Num"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "anim/lv/#go_Lv/#scroll_Num/Viewport/Content/#go_Item"
	var_1_0.cellClass = CharacterLevelItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirH
	var_1_0.lineCount = 1
	var_1_0.cellWidth = var_0_1
	var_1_0.cellHeight = 120
	var_1_0.startSpace = 280
	var_1_0.endSpace = 280
	arg_1_0.characterLevelUpView = CharacterLevelUpView.New()

	return {
		arg_1_0.characterLevelUpView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		LuaListScrollView.New(CharacterLevelListModel.instance, var_1_0)
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = CurrencyEnum.CurrencyType
	local var_2_1 = {
		var_2_0.Gold,
		var_2_0.HeroExperience
	}

	return {
		CurrencyView.New(var_2_1, arg_2_0._onCurrencyClick, arg_2_0, true)
	}
end

function var_0_0._onCurrencyClick(arg_3_0)
	CharacterController.instance:dispatchEvent(CharacterEvent.levelUpViewClick)
end

function var_0_0.setWaitHeroLevelUpRefresh(arg_4_0, arg_4_1)
	arg_4_0._waitHeroLevelUpRefresh = arg_4_1
end

function var_0_0.getWaitHeroLevelUpRefresh(arg_5_0)
	return arg_5_0._waitHeroLevelUpRefresh
end

function var_0_0.setLocalUpLevel(arg_6_0, arg_6_1)
	arg_6_0.localUpLevel = arg_6_1
end

function var_0_0.getLocalUpLevel(arg_7_0)
	return arg_7_0.localUpLevel
end

function var_0_0.onContainerClose(arg_8_0)
	arg_8_0:setWaitHeroLevelUpRefresh(false)
	arg_8_0:setLocalUpLevel()
end

function var_0_0.getLevelItemWidth(arg_9_0)
	return var_0_1
end

function var_0_0.playCloseTransition(arg_10_0, arg_10_1)
	if GuideModel.instance:getDoingGuideId() == 108 then
		arg_10_0:onPlayCloseTransitionFinish()
	else
		var_0_0.super.playCloseTransition(arg_10_0, arg_10_1)
	end
end

return var_0_0

module("modules.logic.character.view.CharacterTalentStyleViewContainer", package.seeall)

local var_0_0 = class("CharacterTalentStyleViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "go_style/#scroll_style"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "go_style/#item_style"
	var_1_0.cellClass = CharacterTalentStyleItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 212
	var_1_0.cellHeight = 212
	var_1_0.cellSpaceV = -45

	local var_1_1 = LuaListScrollView.New(TalentStyleListModel.instance, var_1_0)

	arg_1_0._view = CharacterTalentStyleView.New()

	return {
		var_1_1,
		arg_1_0._view,
		TabViewGroup.New(1, "#go_leftbtns"),
		TabViewGroup.New(2, "#go_rightbtns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = CharacterTalentStyleNavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TalentStyleViewHelp)

		arg_2_0.navigateView:setOverrideClose(arg_2_0.overrideCloseFunc, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	elseif arg_2_1 == 2 then
		local var_2_0 = CurrencyEnum.CurrencyType.Gold
		local var_2_1 = CurrencyView.New({
			var_2_0
		})

		var_2_1.foreHideBtn = true

		return {
			var_2_1
		}
	end
end

function var_0_0.overrideCloseFunc(arg_3_0)
	if arg_3_0._view then
		arg_3_0._view:playCloseAnim()
	else
		arg_3_0:closeThis()
	end
end

function var_0_0.getNavigateView(arg_4_0)
	return arg_4_0.navigateView
end

return var_0_0

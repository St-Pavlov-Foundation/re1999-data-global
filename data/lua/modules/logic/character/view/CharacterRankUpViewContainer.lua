module("modules.logic.character.view.CharacterRankUpViewContainer", package.seeall)

local var_0_0 = class("CharacterRankUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {
		CharacterRankUpView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
	local var_1_1 = HelpShowView.New()

	var_1_1:setHelpId(HelpEnum.HelpId.CharacterRankUp)
	var_1_1:setDelayTime(0.5)
	table.insert(var_1_0, var_1_1)

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.CharacterRankUp)

		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			var_2_0
		}, HelpEnum.HelpId.CharacterRankUp)

		return {
			arg_2_0._navigateButtonView
		}
	end

	if arg_2_1 == 2 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.Gold
			})
		}
	end
end

function var_0_0.refreshHelp(arg_3_0)
	if arg_3_0._navigateButtonView then
		local var_3_0 = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.CharacterRankUp)

		arg_3_0._navigateButtonView:setParam({
			true,
			true,
			var_3_0
		})
	end
end

return var_0_0

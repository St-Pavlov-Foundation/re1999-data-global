module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingViewContainer", package.seeall)

local var_0_0 = class("V1a5BuildingViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a5BuildingView.New(),
		TabViewGroup.New(1, "#go_BackBtns"),
		TabViewGroup.New(2, "#go_topright")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		var_2_0:setHelpId(HelpEnum.HelpId.Dungeon1_5BuildingHelp)

		return {
			var_2_0
		}
	elseif arg_2_1 == 2 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.V1a5DungeonBuild
			})
		}
	end
end

function var_0_0.playOpenTransition(arg_3_0)
	SLFramework.AnimatorPlayer.Get(arg_3_0.viewGO):Play("v1a5_buildingview_open", arg_3_0.onPlayOpenTransitionFinish, arg_3_0)
end

return var_0_0

module("modules.logic.survival.view.shelter.SurvivalMainViewContainer", package.seeall)

local var_0_0 = class("SurvivalMainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalMainView.New(),
		ShelterSceneUnitView.New(),
		SurvivalMainViewButton.New(),
		SurvivalMainViewCurrency.New(),
		SurvivalBubbleView.New(),
		SurvivalMapTalentView.New("go_normalroot/"),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		var_2_0:setOverrideClose(arg_2_0.defaultOverrideCloseClick, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0.defaultOverrideCloseClick(arg_3_0)
	SurvivalController.instance:exitMap()
	SurvivalStatHelper.instance:statBtnClick("OnClose", "SurvivalMainView")
end

function var_0_0.setMainViewVisible(arg_4_0, arg_4_1)
	arg_4_0:_setVisible(arg_4_1)
end

return var_0_0

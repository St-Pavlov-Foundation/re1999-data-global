module("modules.logic.survival.view.map.SurvivalMapMainViewContainer", package.seeall)

local var_0_0 = class("SurvivalMapMainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalMapMainView.New(),
		SurvivalMapUnitView.New(),
		SurvivalShrinkView.New(),
		SurvivalMapUseItemView.New(),
		SurvivalMapTreeOpenFogView.New(),
		SurvivalHeroHealthView.New(),
		SurvivalMapRadarView.New(),
		SurvivalMapBubbleView.New(),
		SurvivalMapGMPosView.New(),
		SurvivalMapTalentView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.Survival)

		var_2_0:setOverrideClose(arg_2_0.defaultOverrideCloseClick, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0.setCloseFunc(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._closeFunc = arg_3_1
	arg_3_0._closeObj = arg_3_2
end

function var_0_0.defaultOverrideCloseClick(arg_4_0)
	SurvivalStatHelper.instance:statBtnClick("onClose", "SurvivalMapMainView")

	if arg_4_0._closeFunc then
		arg_4_0._closeFunc(arg_4_0._closeObj)

		return
	end

	if SurvivalMapHelper.instance:isInFlow() then
		SurvivalMapHelper.instance:fastDoFlow()

		return
	end

	SurvivalController.instance:exitMap()
end

return var_0_0

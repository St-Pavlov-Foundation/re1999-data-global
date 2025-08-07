module("modules.logic.sp01.odyssey.view.OdysseyDungeonViewContainer", package.seeall)

local var_0_0 = class("OdysseyDungeonViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.odysseyDungeonSceneElements = OdysseyDungeonSceneElements.New()
	arg_1_0.odysseyDungeonView = OdysseyDungeonView.New()
	arg_1_0.odysseyDungeonSceneView = OdysseyDungeonSceneView.New()
	arg_1_0.odysseyDungeonMapSelectView = OdysseyDungeonMapSelectView.New()

	return {
		arg_1_0.odysseyDungeonSceneView,
		arg_1_0.odysseyDungeonSceneElements,
		arg_1_0.odysseyDungeonMapSelectView,
		arg_1_0.odysseyDungeonView,
		TabViewGroup.New(1, "root/#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.OdysseyDungeon)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.setOverrideCloseClick(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.navigateView:setOverrideClose(arg_3_1, arg_3_2)
end

function var_0_0.getDungeonSceneView(arg_4_0)
	return arg_4_0.odysseyDungeonSceneView
end

function var_0_0.getDungeonSceneElementsView(arg_5_0)
	return arg_5_0.odysseyDungeonSceneElements
end

function var_0_0.getDungeonView(arg_6_0)
	return arg_6_0.odysseyDungeonView
end

function var_0_0.getDungeonMapSelectView(arg_7_0)
	return arg_7_0.odysseyDungeonMapSelectView
end

function var_0_0.getNavigateButtonsView(arg_8_0)
	return arg_8_0.navigateView
end

return var_0_0

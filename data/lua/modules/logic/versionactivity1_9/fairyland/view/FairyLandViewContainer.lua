module("modules.logic.versionactivity1_9.fairyland.view.FairyLandViewContainer", package.seeall)

local var_0_0 = class("FairyLandViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, FairyLandPuzzles.New())
	table.insert(var_1_0, FairyLandView.New())

	arg_1_0.elements = FairyLandElements.New()

	table.insert(var_1_0, arg_1_0.elements)
	table.insert(var_1_0, FairyLandStairs.New())

	arg_1_0.scene = FairyLandScene.New()

	table.insert(var_1_0, arg_1_0.scene)
	table.insert(var_1_0, FairyLandDialogView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_LeftTop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.getElement(arg_3_0, arg_3_1)
	if arg_3_0.elements then
		return arg_3_0.elements:getElementByType(arg_3_1)
	end
end

function var_0_0._setVisible(arg_4_0, arg_4_1)
	var_0_0.super._setVisible(arg_4_0, arg_4_1)

	if arg_4_0.scene then
		arg_4_0.scene:setSceneVisible(arg_4_1)
	end
end

return var_0_0

module("modules.logic.sp01.odyssey.view.OdysseyDungeonInteractViewContainer", package.seeall)

local var_0_0 = class("OdysseyDungeonInteractViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.odysseyDungeonInteractFightView = OdysseyDungeonInteractFightView.New()

	table.insert(var_1_0, arg_1_0.odysseyDungeonInteractFightView)
	table.insert(var_1_0, OdysseyDungeonInteractView.New())

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
end

function var_0_0.getInteractFightView(arg_3_0)
	return arg_3_0.odysseyDungeonInteractFightView
end

return var_0_0

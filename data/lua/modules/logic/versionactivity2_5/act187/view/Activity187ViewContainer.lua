module("modules.logic.versionactivity2_5.act187.view.Activity187ViewContainer", package.seeall)

local var_0_0 = class("Activity187ViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._act187View = Activity187View.New()
	arg_1_0._act187PaintView = Activity187PaintingView.New()

	table.insert(var_1_0, arg_1_0._act187View)
	table.insert(var_1_0, arg_1_0._act187PaintView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0._overrideClose, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._overrideClose(arg_3_0)
	arg_3_0._act187View:onBtnEsc()
end

function var_0_0.setPaintingViewDisplay(arg_4_0, arg_4_1)
	arg_4_0._act187View:setPaintingViewDisplay(arg_4_1)
end

function var_0_0.isShowPaintView(arg_5_0)
	return arg_5_0._act187View.isShowPaintView
end

return var_0_0

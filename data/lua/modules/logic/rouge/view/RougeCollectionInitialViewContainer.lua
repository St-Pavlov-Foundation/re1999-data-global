module("modules.logic.rouge.view.RougeCollectionInitialViewContainer", package.seeall)

local var_0_0 = class("RougeCollectionInitialViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._collectionInitialView = RougeCollectionInitialView.New()

	return {
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_rougemapdetailcontainer"),
		arg_1_0._collectionInitialView
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0._navigateButtonView
		}
	elseif arg_2_1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

function var_0_0.setActiveBlock(arg_3_0, arg_3_1)
	arg_3_0._collectionInitialView:setActiveBlock(arg_3_1)
end

function var_0_0.getScrollViewGo(arg_4_0)
	return arg_4_0._collectionInitialView:getScrollViewGo()
end

return var_0_0

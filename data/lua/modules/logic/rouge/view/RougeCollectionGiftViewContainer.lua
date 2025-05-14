module("modules.logic.rouge.view.RougeCollectionGiftViewContainer", package.seeall)

local var_0_0 = class("RougeCollectionGiftViewContainer", BaseViewContainer)
local var_0_1 = 1

function var_0_0.buildViews(arg_1_0)
	arg_1_0._collectionGiftView = RougeCollectionGiftView.New()

	return {
		arg_1_0._collectionGiftView,
		TabViewGroup.New(var_0_1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == var_0_1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

function var_0_0.getScrollRect(arg_3_0)
	return arg_3_0._collectionGiftView:getScrollRect()
end

function var_0_0.getScrollViewGo(arg_4_0)
	return arg_4_0._collectionGiftView:getScrollViewGo()
end

function var_0_0.setActiveBlock(arg_5_0, arg_5_1)
	arg_5_0._collectionInitialView:setActiveBlock(arg_5_1)
end

return var_0_0

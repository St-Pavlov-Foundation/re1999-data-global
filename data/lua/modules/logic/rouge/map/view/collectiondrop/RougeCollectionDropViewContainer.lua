module("modules.logic.rouge.map.view.collectiondrop.RougeCollectionDropViewContainer", package.seeall)

local var_0_0 = class("RougeCollectionDropViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeCollectionDropView.New())
	table.insert(var_1_0, TabViewGroup.New(2, "layout/#go_rougemapdetailcontainer"))

	return var_1_0
end

function var_0_0.playCloseTransition(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0.onPlayCloseTransitionFinish, arg_2_0, RougeMapEnum.CollectionChangeAnimDuration)
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return var_0_0

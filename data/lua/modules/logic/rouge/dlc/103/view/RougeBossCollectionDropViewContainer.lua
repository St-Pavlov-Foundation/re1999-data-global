module("modules.logic.rouge.dlc.103.view.RougeBossCollectionDropViewContainer", package.seeall)

local var_0_0 = class("RougeBossCollectionDropViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeBossCollectionDropView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(2, "layout/#go_rougemapdetailcontainer"))

	local var_1_1 = HelpShowView.New()

	var_1_1:setHelpId(HelpEnum.HelpId.RougeBossCollectionDropHelp)
	table.insert(var_1_0, var_1_1)

	return var_1_0
end

function var_0_0.playCloseTransition(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0.onPlayCloseTransitionFinish, arg_2_0, RougeMapEnum.CollectionChangeAnimDuration)
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		return {
			NavigateButtonsView.New({
				false,
				false,
				true
			}, HelpEnum.HelpId.RougeBossCollectionDropHelp)
		}
	elseif arg_3_1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return var_0_0

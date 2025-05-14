module("modules.logic.rouge.view.RougeTalentTreeViewContainer", package.seeall)

local var_0_0 = class("RougeTalentTreeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._treeview = RougeTalentTreeView.New()
	arg_1_0._poolview = RougeTalentTreeBranchPool.New(arg_1_0._viewSetting.otherRes.branchitem)
	arg_1_0._tabview = TabViewGroup.New(2, "#go_talenttree")

	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, arg_1_0._tabview)
	table.insert(var_1_0, arg_1_0._treeview)
	table.insert(var_1_0, arg_1_0._poolview)

	return var_1_0
end

function var_0_0.getPoolView(arg_2_0)
	return arg_2_0._poolview
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_3_0._navigateButtonView:setCloseCheck(arg_3_0.defaultOverrideCloseCheck, arg_3_0)

		return {
			arg_3_0._navigateButtonView
		}
	elseif arg_3_1 == 2 then
		local var_3_0 = {}
		local var_3_1 = RougeConfig1.instance:season()
		local var_3_2 = RougeTalentConfig.instance:getTalentNum(var_3_1)

		for iter_3_0 = 1, var_3_2 do
			table.insert(var_3_0, RougeTalentTreeBranchView.New())
		end

		return var_3_0
	end
end

function var_0_0.getTabView(arg_4_0)
	return arg_4_0._tabview
end

function var_0_0.defaultOverrideCloseCheck(arg_5_0)
	RougeController.instance:dispatchEvent(RougeEvent.exitTalentView)

	local var_5_0 = 0.5

	function arg_5_0._closeCallback()
		arg_5_0._navigateButtonView:_reallyClose()
		RougeController.instance:dispatchEvent(RougeEvent.reallyExitTalentView)
	end

	TaskDispatcher.runDelay(arg_5_0._closeCallback, arg_5_0, var_5_0)
end

return var_0_0

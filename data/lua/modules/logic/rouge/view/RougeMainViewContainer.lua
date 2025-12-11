module("modules.logic.rouge.view.RougeMainViewContainer", package.seeall)

local var_0_0 = class("RougeMainViewContainer", BaseViewContainer)
local var_0_1 = 1

function var_0_0.buildViews(arg_1_0)
	return {
		RougeMainView.New(),
		RougeBaseDLCViewComp.New(),
		TabViewGroup.New(var_0_1, "#go_lefttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == var_0_1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		var_2_0:setHelpId(HelpEnum.HelpId.RougeMainViewHelp)

		return {
			var_2_0
		}
	end
end

function var_0_0.onContainerClose(arg_3_0)
	if not ViewMgr.instance:getContainer(ViewName.DungeonView) then
		return
	end
end

return var_0_0

module("modules.logic.versionactivity2_5.challenge.view.dungeon.Act183DungeonViewContainer", package.seeall)

local var_0_0 = class("Act183DungeonViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_topleft"))

	arg_1_0._mainView = Act183DungeonView.New()

	table.insert(var_1_0, arg_1_0._mainView)
	table.insert(var_1_0, Act183DungeonView_Animation.New())
	table.insert(var_1_0, Act183DungeonView_Detail.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = arg_2_0:_getHelpId()

		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			var_2_0 ~= nil
		}, var_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._getHelpId(arg_3_0)
	local var_3_0 = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Act183EnterDungeon)
	local var_3_1 = HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Act183Repress)

	if var_3_0 and var_3_1 then
		return HelpEnum.HelpId.Act183DungeonAndRepress
	elseif var_3_1 ~= var_3_0 then
		if var_3_1 then
			return HelpEnum.HelpId.Act183Repress
		else
			return HelpEnum.HelpId.Act183EnterDungeon
		end
	end
end

function var_0_0.getMainView(arg_4_0)
	return arg_4_0._mainView
end

function var_0_0.refreshHelpId(arg_5_0)
	local var_5_0 = arg_5_0:_getHelpId()

	if var_5_0 ~= nil then
		arg_5_0.navigateView:setHelpId(var_5_0)
	end
end

function var_0_0.onContainerInit(arg_6_0)
	arg_6_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_6_0.refreshHelpId, arg_6_0)
end

return var_0_0

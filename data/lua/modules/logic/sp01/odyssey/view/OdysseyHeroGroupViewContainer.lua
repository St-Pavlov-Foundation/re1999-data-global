module("modules.logic.sp01.odyssey.view.OdysseyHeroGroupViewContainer", package.seeall)

local var_0_0 = class("OdysseyHeroGroupViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, OdysseyHeroGroupView.New())
	table.insert(var_1_0, OdysseyHeroListView.New())
	table.insert(var_1_0, OdysseySuitListView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(var_1_0, CheckActivityEndView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.OdysseyHeroGroup, arg_2_0._closeCallback, arg_2_0._closeHomeCallback, nil, arg_2_0)

		arg_2_0.navigateView:setCloseCheck(arg_2_0.defaultOverrideCloseCheck, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._closeCallback(arg_3_0)
	arg_3_0:closeThis()

	if arg_3_0:handleVersionActivityCloseCall() then
		return
	end

	MainController.instance:enterMainScene(true, false)
end

function var_0_0._closeHomeCallback(arg_4_0)
	arg_4_0:closeThis()
	MainController.instance:enterMainScene(true, false)
end

function var_0_0.handleVersionActivityCloseCall(arg_5_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		return true
	end

	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

return var_0_0

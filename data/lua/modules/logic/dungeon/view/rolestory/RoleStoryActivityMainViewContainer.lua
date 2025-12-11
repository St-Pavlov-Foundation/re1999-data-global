module("modules.logic.dungeon.view.rolestory.RoleStoryActivityMainViewContainer", package.seeall)

local var_0_0 = class("RoleStoryActivityMainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.actView = RoleStoryActivityView.New()
	arg_1_0.challengeView = RoleStoryActivityChallengeView.New()
	arg_1_0.mainView = RoleStoryActivityMainView.New()

	table.insert(var_1_0, RoleStoryActivityBgView.New())
	table.insert(var_1_0, RoleStoryItemRewardView.New())
	table.insert(var_1_0, arg_1_0.mainView)
	table.insert(var_1_0, arg_1_0.actView)
	table.insert(var_1_0, arg_1_0.challengeView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_topright"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0._navigateButtonsView:setOverrideClose(arg_2_0.overrideClose, arg_2_0)

		return {
			arg_2_0._navigateButtonsView
		}
	end

	local var_2_0 = {
		{
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
		}
	}

	arg_2_0.currencyView = CurrencyView.New(var_2_0)
	arg_2_0.currencyView.foreHideBtn = true

	return {
		arg_2_0.currencyView
	}
end

function var_0_0.refreshCurrency(arg_3_0, arg_3_1)
	arg_3_0.currencyView:setCurrencyType(arg_3_1)
end

function var_0_0.overrideClose(arg_4_0)
	if not arg_4_0.mainView._showActView then
		RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ChangeMainViewShow, true)

		return
	end

	ViewMgr.instance:closeView(arg_4_0.viewName, nil, true)
end

function var_0_0.onContainerClose(arg_5_0)
	if arg_5_0:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function var_0_0.playAnim(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0:__getAnimatorPlayer()

	if not gohelper.isNil(var_6_0) then
		var_6_0:Play(arg_6_1, arg_6_2, arg_6_3)
	end
end

function var_0_0.playOpenTransition(arg_7_0)
	local var_7_0 = {}

	if arg_7_0.mainView._showActView then
		var_7_0.anim = "open"
		var_7_0.duration = 0.67
	else
		var_7_0.anim = "challenge"
		var_7_0.duration = 0.6
	end

	var_0_0.super.playOpenTransition(arg_7_0, var_7_0)
end

function var_0_0._setVisible(arg_8_0, arg_8_1)
	var_0_0.super._setVisible(arg_8_0, arg_8_1)

	if arg_8_0.mainView then
		arg_8_0.mainView:onSetVisible()
	end
end

function var_0_0.getVisible(arg_9_0)
	return arg_9_0._isVisible
end

return var_0_0

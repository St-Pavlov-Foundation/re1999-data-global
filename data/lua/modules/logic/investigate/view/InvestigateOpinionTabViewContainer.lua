module("modules.logic.investigate.view.InvestigateOpinionTabViewContainer", package.seeall)

local var_0_0 = class("InvestigateOpinionTabViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, InvestigateOpinionTabView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_topleft"))

	arg_1_0._tabViewGroupFit = TabViewGroupFit.New(2, "root/#go_container")

	arg_1_0._tabViewGroupFit:keepCloseVisible(true)
	arg_1_0._tabViewGroupFit:setTabCloseFinishCallback(arg_1_0._onTabCloseFinish, arg_1_0)
	arg_1_0._tabViewGroupFit:setTabOpenFinishCallback(arg_1_0._onTabOpenFinish, arg_1_0)
	table.insert(var_1_0, arg_1_0._tabViewGroupFit)

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end

	if arg_2_1 == 2 then
		arg_2_0._commonView = InvestigateOpinionCommonView.New()
		arg_2_0._commonExtendView = InvestigateOpinionCommonView.New()

		arg_2_0._commonExtendView:setInExtendView(true)

		arg_2_0._opinionView = InvestigateOpinionView.New()
		arg_2_0._opinionExtendView = InvestigateOpinionExtendView.New()

		return {
			MultiView.New({
				arg_2_0._commonView,
				arg_2_0._opinionView
			}),
			MultiView.New({
				arg_2_0._commonExtendView,
				arg_2_0._opinionExtendView
			})
		}
	end
end

function var_0_0.getCurTabId(arg_3_0)
	return arg_3_0._tabViewGroupFit:getCurTabId()
end

function var_0_0.switchTab(arg_4_0, arg_4_1)
	arg_4_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_4_1)
end

function var_0_0._onTabCloseFinish(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._closeTabId = arg_5_1

	arg_5_0._tabViewGroupFit:setTabAlpha(arg_5_1, 1)
end

function var_0_0._onTabOpenFinish(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._openTabId = arg_6_1

	if arg_6_0._closeTabId == arg_6_0._openTabId then
		return
	end

	if arg_6_1 == 1 then
		gohelper.setAsFirstSibling(arg_6_2.viewGO)

		if arg_6_0._closeTabId then
			arg_6_0._opinionExtendView:playAnim("gone", arg_6_0._onAnimDone, arg_6_0)
		end
	else
		gohelper.setAsLastSibling(arg_6_2.viewGO)
		arg_6_0._opinionExtendView:playAnim("into", arg_6_0._onAnimDone, arg_6_0)
	end
end

function var_0_0._onAnimDone(arg_7_0)
	if arg_7_0._openTabId == 1 then
		arg_7_0._tabViewGroupFit:setTabAlpha(2, 0)
	else
		arg_7_0._tabViewGroupFit:setTabAlpha(1, 0)
	end
end

return var_0_0

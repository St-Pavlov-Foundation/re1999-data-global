module("modules.logic.room.view.trade.RoomTradeViewContainer", package.seeall)

local var_0_0 = class("RoomTradeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomTradeView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(2, "root/panel"))
	table.insert(var_1_0, TabViewGroup.New(3, "#go_topright"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	elseif arg_2_1 == 2 then
		arg_2_0._dailyOrderView = RoomDailyOrderView.New()
		arg_2_0._wholesaleView = RoomWholesaleView.New()

		return {
			MultiView.New({
				arg_2_0._dailyOrderView
			}),
			MultiView.New({
				arg_2_0._wholesaleView
			})
		}
	elseif arg_2_1 == 3 then
		arg_2_0._currencyView = CurrencyView.New({
			RoomTradeModel.instance:getCurrencyType()
		})
		arg_2_0._currencyView.foreHideBtn = true

		return {
			arg_2_0._currencyView
		}
	end
end

function var_0_0._overrideCloseFunc(arg_3_0)
	ManufactureController.instance:resetCameraOnCloseView()
	ViewMgr.instance:closeView(arg_3_0.viewName)
end

function var_0_0.selectTabView(arg_4_0, arg_4_1)
	arg_4_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_4_1)
end

function var_0_0.playCloseTransition(arg_5_0)
	arg_5_0:getAnimatorPlayer():Play(UIAnimationName.Close, arg_5_0.onCloseAnimDone, arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_close)
end

function var_0_0.getAnimatorPlayer(arg_6_0)
	if not arg_6_0._animatorPlayer then
		arg_6_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_6_0.viewGO)
	end

	return arg_6_0._animatorPlayer
end

function var_0_0.playAnim(arg_7_0, arg_7_1)
	if not arg_7_0._animator then
		arg_7_0._animator = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_7_0._animator:Play(arg_7_1, 0, 0)
	arg_7_0._animator:Update(0)
end

function var_0_0.onCloseAnimDone(arg_8_0)
	arg_8_0:onPlayCloseTransitionFinish()
end

function var_0_0.onContainerInit(arg_9_0)
	if arg_9_0.viewParam then
		local var_9_0 = arg_9_0.viewParam.defaultTab

		arg_9_0.viewParam.defaultTabIds = {}
		arg_9_0.viewParam.defaultTabIds[2] = var_9_0
	end
end

return var_0_0

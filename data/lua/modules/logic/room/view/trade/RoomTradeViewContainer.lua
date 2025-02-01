module("modules.logic.room.view.trade.RoomTradeViewContainer", package.seeall)

slot0 = class("RoomTradeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomTradeView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot1, TabViewGroup.New(2, "root/panel"))
	table.insert(slot1, TabViewGroup.New(3, "#go_topright"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0.navigateView:setOverrideClose(slot0._overrideCloseFunc, slot0)

		return {
			slot0.navigateView
		}
	elseif slot1 == 2 then
		slot0._dailyOrderView = RoomDailyOrderView.New()
		slot0._wholesaleView = RoomWholesaleView.New()

		return {
			MultiView.New({
				slot0._dailyOrderView
			}),
			MultiView.New({
				slot0._wholesaleView
			})
		}
	elseif slot1 == 3 then
		slot0._currencyView = CurrencyView.New({
			RoomTradeModel.instance:getCurrencyType()
		})
		slot0._currencyView.foreHideBtn = true

		return {
			slot0._currencyView
		}
	end
end

function slot0._overrideCloseFunc(slot0)
	ManufactureController.instance:resetCameraOnCloseView()
	ViewMgr.instance:closeView(slot0.viewName)
end

function slot0.selectTabView(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

function slot0.playCloseTransition(slot0)
	slot0:getAnimatorPlayer():Play(UIAnimationName.Close, slot0.onCloseAnimDone, slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_close)
end

function slot0.getAnimatorPlayer(slot0)
	if not slot0._animatorPlayer then
		slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	end

	return slot0._animatorPlayer
end

function slot0.playAnim(slot0, slot1)
	if not slot0._animator then
		slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	slot0._animator:Play(slot1, 0, 0)
	slot0._animator:Update(0)
end

function slot0.onCloseAnimDone(slot0)
	slot0:onPlayCloseTransitionFinish()
end

function slot0.onContainerInit(slot0)
	if slot0.viewParam then
		slot0.viewParam.defaultTabIds = {
			[2] = slot0.viewParam.defaultTab
		}
	end
end

return slot0

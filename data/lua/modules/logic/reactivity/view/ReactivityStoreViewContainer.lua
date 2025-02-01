module("modules.logic.reactivity.view.ReactivityStoreViewContainer", package.seeall)

slot0 = class("ReactivityStoreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ReactivityStoreView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end

	if slot1 == 2 then
		slot3 = CurrencyView.New({
			ReactivityModel.instance:getActivityCurrencyId(slot0.viewParam.actId),
			CurrencyEnum.CurrencyType.ReactivityCurrency
		})
		slot3.foreHideBtn = true

		return {
			slot3
		}
	end
end

function slot0.playOpenTransition(slot0)
	slot0:startViewOpenBlock()
	slot0.viewGO:GetComponent(typeof(UnityEngine.Animation)):Play("activitystore_open")
	TaskDispatcher.runDelay(slot0.onPlayOpenTransitionFinish, slot0, 0.5)
end

function slot0.playCloseTransition(slot0)
	slot0:startViewCloseBlock()
	slot0.viewGO:GetComponent(typeof(UnityEngine.Animation)):Play("activitystore_close")
	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, 0.167)
end

return slot0

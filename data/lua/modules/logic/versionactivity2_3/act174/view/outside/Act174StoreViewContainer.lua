module("modules.logic.versionactivity2_3.act174.view.outside.Act174StoreViewContainer", package.seeall)

slot0 = class("Act174StoreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Act174StoreView.New(),
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
		slot0._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.V2a3DouQuQu
		})

		slot0._currencyView:setOpenCallback(slot0._onCurrencyOpen, slot0)

		return {
			slot0._currencyView
		}
	end
end

function slot0._onCurrencyOpen(slot0)
	slot1 = slot0._currencyView:getCurrencyItem(1)

	gohelper.setActive(slot1.btn, false)
	gohelper.setActive(slot1.click, true)
	recthelper.setAnchorX(slot1.txt.transform, 313)
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

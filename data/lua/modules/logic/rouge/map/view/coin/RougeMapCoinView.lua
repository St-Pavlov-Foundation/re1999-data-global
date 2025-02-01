module("modules.logic.rouge.map.view.coin.RougeMapCoinView", package.seeall)

slot0 = class("RougeMapCoinView", BaseView)

function slot0.onInitView(slot0)
	slot0.goCoinContainer = gohelper.findChild(slot0.viewGO, "#go_coincontainer")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.goCoin = slot0.viewContainer:getResInst(RougeEnum.ResPath.CoinView, slot0.goCoinContainer)
	slot0._txtcoinnum = gohelper.findChildText(slot0.goCoin, "#txt_coinnum")
	slot0.coinVx = gohelper.findChild(slot0.goCoin, "#go_vx_vitality")

	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfoCoin, slot0.refreshUI, slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshCoin()
end

function slot0.refreshCoin(slot0)
	if RougeModel.instance:getRougeInfo() then
		if not slot0.preCoin then
			slot0._txtcoinnum.text = slot1.coin
			slot0.preCoin = slot1.coin
		else
			if slot1.coin == slot0.preCoin then
				slot0._txtcoinnum.text = slot1.coin
				slot0.preCoin = slot1.coin

				return
			end

			slot0:killTween()

			slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot0.preCoin, slot1.coin, RougeMapEnum.CoinChangeDuration, slot0.frameCallback, slot0.doneCallback, slot0)

			gohelper.setActive(slot0.coinVx, true)
			AudioMgr.instance:trigger(AudioEnum.UI.CoinChange)
		end
	end
end

function slot0.frameCallback(slot0, slot1)
	slot1 = math.ceil(slot1)
	slot0._txtcoinnum.text = slot1
	slot0.preCoin = slot1
end

function slot0.doneCallback(slot0)
	gohelper.setActive(slot0.coinVx, false)

	slot0.tweenId = nil
end

function slot0.killTween(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

function slot0.onClose(slot0)
	slot0:killTween()

	if RougeModel.instance:getRougeInfo() then
		slot0.preCoin = slot1.coin
	end
end

function slot0.onDestroyView(slot0)
	slot0:killTween()
end

return slot0

module("modules.logic.rouge.map.view.coin.RougeMapCoinView", package.seeall)

local var_0_0 = class("RougeMapCoinView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goCoinContainer = gohelper.findChild(arg_1_0.viewGO, "#go_coincontainer")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.goCoin = arg_4_0.viewContainer:getResInst(RougeEnum.ResPath.CoinView, arg_4_0.goCoinContainer)
	arg_4_0._txtcoinnum = gohelper.findChildText(arg_4_0.goCoin, "#txt_coinnum")
	arg_4_0.coinVx = gohelper.findChild(arg_4_0.goCoin, "#go_vx_vitality")

	arg_4_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfoCoin, arg_4_0.refreshUI, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshUI()
end

function var_0_0.refreshUI(arg_6_0)
	arg_6_0:refreshCoin()
end

function var_0_0.refreshCoin(arg_7_0)
	local var_7_0 = RougeModel.instance:getRougeInfo()

	if var_7_0 then
		if not arg_7_0.preCoin then
			arg_7_0._txtcoinnum.text = var_7_0.coin
			arg_7_0.preCoin = var_7_0.coin
		else
			if var_7_0.coin == arg_7_0.preCoin then
				arg_7_0._txtcoinnum.text = var_7_0.coin
				arg_7_0.preCoin = var_7_0.coin

				return
			end

			arg_7_0:killTween()

			arg_7_0.tweenId = ZProj.TweenHelper.DOTweenFloat(arg_7_0.preCoin, var_7_0.coin, RougeMapEnum.CoinChangeDuration, arg_7_0.frameCallback, arg_7_0.doneCallback, arg_7_0)

			gohelper.setActive(arg_7_0.coinVx, true)
			AudioMgr.instance:trigger(AudioEnum.UI.CoinChange)
		end
	end
end

function var_0_0.frameCallback(arg_8_0, arg_8_1)
	arg_8_1 = math.ceil(arg_8_1)
	arg_8_0._txtcoinnum.text = arg_8_1
	arg_8_0.preCoin = arg_8_1
end

function var_0_0.doneCallback(arg_9_0)
	gohelper.setActive(arg_9_0.coinVx, false)

	arg_9_0.tweenId = nil
end

function var_0_0.killTween(arg_10_0)
	if arg_10_0.tweenId then
		ZProj.TweenHelper.KillById(arg_10_0.tweenId)

		arg_10_0.tweenId = nil
	end
end

function var_0_0.onClose(arg_11_0)
	arg_11_0:killTween()

	local var_11_0 = RougeModel.instance:getRougeInfo()

	if var_11_0 then
		arg_11_0.preCoin = var_11_0.coin
	end
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0:killTween()
end

return var_0_0

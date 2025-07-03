module("modules.logic.fight.view.rouge.FightViewRougeCoin", package.seeall)

local var_0_0 = class("FightViewRougeCoin", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._coinText = gohelper.findChildText(arg_1_0.viewGO, "#txt_num")
	arg_1_0._addCoinEffect = gohelper.findChild(arg_1_0.viewGO, "obtain")
	arg_1_0._minCoinEffect = gohelper.findChild(arg_1_0.viewGO, "without")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ResonanceLevel, arg_2_0._onResonanceLevel, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.PolarizationLevel, arg_2_0._onPolarizationLevel, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RougeCoinChange, arg_2_0._onRougeCoinChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RespBeginFight, arg_2_0._onRespBeginFight, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onRefreshViewParam(arg_5_0)
	return
end

function var_0_0._onRespBeginFight(arg_6_0)
	arg_6_0:_refreshCoin()
end

function var_0_0._onResonanceLevel(arg_7_0)
	arg_7_0:_refreshCoin()
end

function var_0_0._onPolarizationLevel(arg_8_0)
	arg_8_0:_refreshCoin()
end

function var_0_0._cancelCoinTimer(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._hideCoinEffect, arg_9_0)
end

function var_0_0._hideCoinEffect(arg_10_0)
	gohelper.setActive(arg_10_0._addCoinEffect, false)
	gohelper.setActive(arg_10_0._minCoinEffect, false)
end

function var_0_0._onRougeCoinChange(arg_11_0, arg_11_1)
	arg_11_0:_cancelCoinTimer()
	arg_11_0:_refreshCoin()
	TaskDispatcher.runDelay(arg_11_0._hideCoinEffect, arg_11_0, 0.6)

	if arg_11_1 > 0 then
		gohelper.setActive(arg_11_0._addCoinEffect, true)
		gohelper.setActive(arg_11_0._minCoinEffect, false)
	else
		gohelper.setActive(arg_11_0._addCoinEffect, false)
		gohelper.setActive(arg_11_0._minCoinEffect, true)
	end
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:_refreshCoin()
end

function var_0_0._refreshData(arg_13_0)
	arg_13_0:_refreshCoin()
end

function var_0_0._refreshCoin(arg_14_0)
	local var_14_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local var_14_1 = var_14_0 and var_14_0.type == DungeonEnum.EpisodeType.Rouge

	gohelper.setActive(arg_14_0.viewGO, var_14_1)

	arg_14_0._coinText.text = FightModel.instance:getRougeExData(FightEnum.ExIndexForRouge.Coin)

	if var_14_1 then
		FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.RougeCoin)
	else
		FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.RougeCoin)
	end
end

function var_0_0.onClose(arg_15_0)
	arg_15_0:_cancelCoinTimer()
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0

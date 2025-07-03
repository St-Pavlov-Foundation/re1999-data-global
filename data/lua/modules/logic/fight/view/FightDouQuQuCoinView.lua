module("modules.logic.fight.view.FightDouQuQuCoinView", package.seeall)

local var_0_0 = class("FightDouQuQuCoinView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.coinText = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_CoinCnt1")
	arg_1_0.changeText = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_num")
	arg_1_0.addEffect = gohelper.findChild(arg_1_0.viewGO, "root/#add")
	arg_1_0.subEffect = gohelper.findChild(arg_1_0.viewGO, "root/#subtract")

	gohelper.setActive(arg_1_0.addEffect, false)
	gohelper.setActive(arg_1_0.subEffect, false)

	arg_1_0.changeText.text = ""
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.UpdateFightParam, arg_2_0.onUpdateFightParam)
end

function var_0_0.onUpdateFightParam(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_1 ~= FightParamData.ParamKey.ACT191_COIN then
		return
	end

	arg_3_0.changeText.text = -arg_3_4

	gohelper.setActive(arg_3_0.subEffect, false)
	gohelper.setActive(arg_3_0.subEffect, true)
	arg_3_0:com_registSingleTimer(arg_3_0.hideEffect, 1)
	arg_3_0:com_scrollNumTween(arg_3_0.coinText, arg_3_2, arg_3_3, 0.5)
end

function var_0_0.hideEffect(arg_4_0)
	gohelper.setActive(arg_4_0.subEffect, false)

	arg_4_0.changeText.text = ""
end

function var_0_0.refreshData(arg_5_0)
	local var_5_0 = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_COIN]

	arg_5_0.coinText.text = var_5_0
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshData()
end

return var_0_0

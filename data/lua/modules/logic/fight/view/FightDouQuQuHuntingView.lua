module("modules.logic.fight.view.FightDouQuQuHuntingView", package.seeall)

local var_0_0 = class("FightDouQuQuHuntingView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.huntingText = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_num")
	arg_1_0.addEffect = gohelper.findChild(arg_1_0.viewGO, "root/#add")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.UpdateFightParam, arg_2_0.onUpdateFightParam)

	arg_2_0.tweenComp = arg_2_0:addComponent(FightTweenComponent)
end

function var_0_0.onUpdateFightParam(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_1 ~= FightParamData.ParamKey.ACT191_HUNTING then
		return
	end

	arg_3_0:com_killTween(arg_3_0.tweenId)
	arg_3_0.tweenComp:DOTweenFloat(arg_3_2, arg_3_3, 0.5, arg_3_0.onFrame, nil, arg_3_0)

	if arg_3_4 > 0 then
		gohelper.setActive(arg_3_0.addEffect, false)
		gohelper.setActive(arg_3_0.addEffect, true)
		arg_3_0:com_registSingleTimer(arg_3_0.hideEffect, 1)
	end
end

function var_0_0.onFrame(arg_4_0, arg_4_1)
	arg_4_1 = math.ceil(arg_4_1)

	arg_4_0:refreshData(arg_4_1)
end

function var_0_0.hideEffect(arg_5_0)
	gohelper.setActive(arg_5_0.addEffect, false)
end

function var_0_0.refreshData(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 < arg_6_0.maxValue and "#D97373" or "#65B96F"

	arg_6_0.huntingText.text = string.format("<%s>%s</color>/%s", var_6_0, arg_6_1, arg_6_0.maxValue)
end

function var_0_0.onOpen(arg_7_0)
	transformhelper.setLocalScale(arg_7_0.viewGO.transform, 0.8, 0.8, 0.8)
	recthelper.setAnchorX(arg_7_0.viewGO.transform, 15)

	arg_7_0.maxValue = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191].minNeedHuntValue

	local var_7_0 = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_HUNTING]

	arg_7_0:refreshData(var_7_0)
end

return var_0_0

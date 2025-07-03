module("modules.logic.versionactivity2_7.act191.view.item.Act191BossHpItem", package.seeall)

local var_0_0 = class("Act191BossHpItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.hpImg = gohelper.findChildImage(arg_1_1, "Root/bossHp/Alpha/bossHp/mask/container/imgHp")
	arg_1_0.signRoot = gohelper.findChild(arg_1_1, "Root/bossHp/Alpha/bossHp/mask/container/imgHp/imgSignHpContainer")
	arg_1_0.signItem = gohelper.findChild(arg_1_1, "Root/bossHp/Alpha/bossHp/mask/container/imgHp/imgSignHpContainer/imgSignHpItem")
	arg_1_0.hpEffect = gohelper.findChild(arg_1_1, "Root/bossHp/Alpha/bossHp/#hpeffect")

	gohelper.setActive(arg_1_0.hpEffect, false)
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.onStart(arg_3_0)
	arg_3_0.data = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Act191]
	arg_3_0.curRate = (FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_CUR_HP_RATE] or 0) / 1000
	arg_3_0.bgWidth = recthelper.getWidth(arg_3_0.signRoot.transform)
	arg_3_0.halfWidth = arg_3_0.bgWidth / 2
	arg_3_0.itemDataList = GameUtil.splitString2(arg_3_0.data.bloodReward, true)

	arg_3_0:refreshItems()
	TaskDispatcher.runDelay(arg_3_0.openAnimFinish, arg_3_0, 1)
end

function var_0_0.openAnimFinish(arg_4_0)
	arg_4_0.tweenId = ZProj.TweenHelper.DOTweenFloat(1, arg_4_0.curRate, 0.3, arg_4_0.frameCallback, arg_4_0.tweenDone, arg_4_0, nil, EaseType.Linear)
end

function var_0_0.frameCallback(arg_5_0, arg_5_1)
	arg_5_0.hpImg.fillAmount = arg_5_1
end

function var_0_0.tweenDone(arg_6_0)
	arg_6_0.tweenId = nil
end

function var_0_0.refreshItems(arg_7_0)
	gohelper.CreateObjList(arg_7_0, arg_7_0.onItemShow, arg_7_0.itemDataList, arg_7_0.signRoot, arg_7_0.signItem)
	gohelper.setActive(arg_7_0.signItem, false)
end

function var_0_0.onItemShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChild(arg_8_1, "unfinish")
	local var_8_1 = gohelper.findChild(arg_8_1, "finished")
	local var_8_2 = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_MIN_HP_RATE]
	local var_8_3 = arg_8_2[1]

	if var_8_2 <= var_8_3 then
		gohelper.setActive(var_8_0, false)
		gohelper.setActive(var_8_1, true)
	else
		gohelper.setActive(var_8_0, true)
		gohelper.setActive(var_8_1, false)
	end

	local var_8_4 = var_8_3 / 1000 * arg_8_0.bgWidth - arg_8_0.halfWidth

	recthelper.setAnchorX(arg_8_1.transform, var_8_4)
end

function var_0_0.onDestroy(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.openAnimFinish, arg_9_0)

	if arg_9_0.tweenId then
		ZProj.TweenHelper.KillById(arg_9_0.tweenId)

		arg_9_0.tweenId = nil
	end
end

return var_0_0

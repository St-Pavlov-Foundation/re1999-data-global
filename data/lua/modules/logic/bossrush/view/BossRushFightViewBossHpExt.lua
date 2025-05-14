module("modules.logic.bossrush.view.BossRushFightViewBossHpExt", package.seeall)

local var_0_0 = class("BossRushFightViewBossHpExt", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtmyblood = gohelper.findChildText(arg_1_0.viewGO, "#txt_myblood")
	arg_1_0._txtbloodnum = gohelper.findChildText(arg_1_0.viewGO, "#txt_bloodnum")
	arg_1_0._txtbloodnum.text = ""
end

function var_0_0.onRefreshViewParam(arg_2_0, arg_2_1)
	arg_2_0._parentGo = arg_2_1
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0._isInitedInfinitBlood = false

	gohelper.setSiblingAfter(arg_3_0.viewGO, arg_3_0._parentGo)
	arg_3_0:_setMyBossBlood(BossRushModel.instance:getBossCurHP(), BossRushModel.instance:getBossCurMaxHP())
	BossRushController.instance:registerCallback(BossRushEvent.OnBossDeadSumChange, arg_3_0._onBossDeadSumChange, arg_3_0)
	BossRushController.instance:registerCallback(BossRushEvent.OnHpChange, arg_3_0._onHpChange, arg_3_0)
end

function var_0_0.onClose(arg_4_0)
	BossRushController.instance:unregisterCallback(BossRushEvent.OnHpChange, arg_4_0._onHpChange, arg_4_0)
	BossRushController.instance:unregisterCallback(BossRushEvent.OnBossDeadSumChange, arg_4_0._onBossDeadSumChange, arg_4_0)

	arg_4_0._isInitedInfinitBlood = false
end

function var_0_0._onBossDeadSumChange(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:_setBossDeadNum(arg_5_2)
end

function var_0_0._onHpChange(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = BossRushModel.instance:getBossCurMaxHP()

	arg_6_0:_setMyBossBlood(arg_6_2, var_6_0)
end

function var_0_0._setMyBossBlood(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = BossRushModel.instance:getBossBloodCount()
	local var_7_1 = BossRushModel.instance:getBossBloodMaxCount()
	local var_7_2 = string.format("%.2f%%", arg_7_1 / arg_7_2 * 100)

	if var_7_0 == 1 and arg_7_1 == 0 and not arg_7_0._isInitedInfinitBlood then
		arg_7_0:_setBossDeadNum(0)

		arg_7_0._isInitedInfinitBlood = true
	end

	arg_7_0._txtmyblood.text = string.format("%s/%s (%s) %s/%s", arg_7_1, arg_7_2, var_7_2, math.max(0, var_7_0 - 1), math.max(0, var_7_1 - 1))
end

function var_0_0._setBossDeadNum(arg_8_0, arg_8_1)
	arg_8_0._txtbloodnum.text = string.format("<color=#FFFF00>(x%s)</color>", arg_8_1)
end

return var_0_0

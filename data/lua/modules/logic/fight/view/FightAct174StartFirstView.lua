module("modules.logic.fight.view.FightAct174StartFirstView", package.seeall)

local var_0_0 = class("FightAct174StartFirstView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._playerFirst = gohelper.findChild(arg_1_0.viewGO, "titlebg/#simage_player")
	arg_1_0._enemyFirst = gohelper.findChild(arg_1_0.viewGO, "titlebg/#simage_enemy")
	arg_1_0._title = gohelper.findChild(arg_1_0.viewGO, "titlebg/#simage_title")
	arg_1_0._title1 = gohelper.findChild(arg_1_0.viewGO, "titlebg/#simage_title1")
	arg_1_0._playerPoint = gohelper.findChildText(arg_1_0.viewGO, "player/#txt_num")
	arg_1_0._playPointEffect = gohelper.findChildText(arg_1_0.viewGO, "player/#txt_eff")
	arg_1_0._enemyPoint = gohelper.findChildText(arg_1_0.viewGO, "enemy/#txt_num")
	arg_1_0._enemyPointEffect = gohelper.findChildText(arg_1_0.viewGO, "enemy/#txt_eff")
	arg_1_0._titlebgGo = gohelper.findChild(arg_1_0.viewGO, "titlebg")
	arg_1_0._ttitlebgAnimator = arg_1_0._titlebgGo:GetComponent(gohelper.Type_Animator)
end

function var_0_0.onConstructor(arg_2_0, arg_2_1)
	arg_2_0.actEffectData = arg_2_1
end

function var_0_0.onOpen(arg_3_0)
	local var_3_0 = arg_3_0.actEffectData.reserveId == "1"

	arg_3_0:com_registTimer(arg_3_0.disposeSelf, FightEnum.PerformanceTime.DouQuQuXianHouShou)

	local var_3_1 = string.splitToNumber(arg_3_0.actEffectData.reserveStr, "#")
	local var_3_2 = var_3_0 and var_3_1[1] or var_3_1[2]

	arg_3_0._playerPoint.text = var_3_2
	arg_3_0._playPointEffect.text = var_3_2

	local var_3_3 = not var_3_0 and var_3_1[1] or var_3_1[2]

	arg_3_0._enemyPoint.text = var_3_3
	arg_3_0._enemyPointEffect.text = var_3_3

	arg_3_0._ttitlebgAnimator:Play(var_3_0 and "player" or "enemy", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_dice)
end

return var_0_0

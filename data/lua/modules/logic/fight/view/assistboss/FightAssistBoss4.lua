module("modules.logic.fight.view.assistboss.FightAssistBoss4", package.seeall)

local var_0_0 = class("FightAssistBoss4", FightAssistBossBase)

function var_0_0.setPrefabPath(arg_1_0)
	arg_1_0.prefabPath = "ui/viewres/assistboss/boss4.prefab"
end

function var_0_0.initView(arg_2_0)
	var_0_0.super.initView(arg_2_0)

	arg_2_0.goCanUseFrame = gohelper.findChild(arg_2_0.viewGo, "head/canuse_frame")
	arg_2_0.goBg = gohelper.findChild(arg_2_0.viewGo, "head/bg")
	arg_2_0.pointList = {}

	arg_2_0:createPointItem(gohelper.findChild(arg_2_0.viewGo, "head/point1"))
	arg_2_0:createPointItem(gohelper.findChild(arg_2_0.viewGo, "head/point2"))
	arg_2_0:createPointItem(gohelper.findChild(arg_2_0.viewGo, "head/point3"))
end

function var_0_0.addEvents(arg_3_0)
	var_0_0.super.addEvents(arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_3_0.onBuffUpdate, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnMySideRoundEnd, arg_3_0.onMySideRoundEnd, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_3_0.stageChange, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_3_0.onSkillPlayFinish, arg_3_0)
end

function var_0_0.createPointItem(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getUserDataTb_()

	var_4_0.go = arg_4_1
	var_4_0.goUsing = gohelper.findChild(arg_4_1, "canuse")
	var_4_0.goOver = gohelper.findChild(arg_4_1, "over")
	var_4_0.energyImage = gohelper.findChildImage(arg_4_1, "energybg/energy")
	var_4_0.goFull = gohelper.findChild(arg_4_1, "full")
	var_4_0.energyImage.fillAmount = 0

	table.insert(arg_4_0.pointList, var_4_0)
	arg_4_0:resetPointItem(var_4_0)

	return var_4_0
end

function var_0_0.resetPointItem(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_1.goFull, false)
	gohelper.setActive(arg_5_1.goUsing, false)
	gohelper.setActive(arg_5_1.goOver, false)
end

function var_0_0.refreshPower(arg_6_0)
	arg_6_0:killTween()

	local var_6_0, var_6_1 = FightDataHelper.paTaMgr:getAssistBossServerPower()
	local var_6_2 = arg_6_0:getBeforePowerRate()
	local var_6_3 = var_6_0 / var_6_1

	arg_6_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_6_2, var_6_3, FightAssistBossBase.Duration, arg_6_0.onBoss4FrameCallback, arg_6_0.onTweenDone, arg_6_0, nil, EaseType.Linear)

	arg_6_0:refreshOver()
	arg_6_0:refreshUsing()
	arg_6_0:refreshHeadImageColor()
	arg_6_0:refreshCanUse()
end

function var_0_0.getBeforePowerRate(arg_7_0)
	return 0 + arg_7_0.pointList[1].energyImage.fillAmount / 2 + arg_7_0.pointList[2].energyImage.fillAmount / 2
end

function var_0_0.onBoss4FrameCallback(arg_8_0, arg_8_1)
	local var_8_0

	if arg_8_1 <= 0.5 then
		var_8_0 = 1
	else
		var_8_0 = 2
		arg_8_1 = arg_8_1 - 0.5
	end

	arg_8_1 = arg_8_1 * 2

	local var_8_1 = arg_8_0.pointList[var_8_0]

	var_8_1.energyImage.fillAmount = arg_8_1

	gohelper.setActive(var_8_1.goFull, arg_8_1 >= 1)
end

function var_0_0.onTweenDone(arg_9_0)
	local var_9_0, var_9_1 = FightDataHelper.paTaMgr:getAssistBossServerPower()
	local var_9_2 = var_9_0 / var_9_1
	local var_9_3 = var_9_2

	if var_9_2 <= 0.5 then
		var_9_3 = var_9_3 * 2
	else
		var_9_3 = 1
	end

	arg_9_0.pointList[1].energyImage.fillAmount = var_9_3

	gohelper.setActive(arg_9_0.pointList[1].goFull, var_9_3 >= 1)

	local var_9_4 = (var_9_2 - 0.5) * 2

	arg_9_0.pointList[2].energyImage.fillAmount = math.max(var_9_4, 0)

	gohelper.setActive(arg_9_0.pointList[2].goFull, var_9_4 >= 1)
end

function var_0_0.refreshOver(arg_10_0)
	local var_10_0 = arg_10_0:checkIsOver()

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.pointList) do
		gohelper.setActive(iter_10_1.goOver, var_10_0)
	end
end

function var_0_0.refreshUsing(arg_11_0)
	local var_11_0 = FightDataHelper.paTaMgr:getUseCardCount()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.pointList) do
		gohelper.setActive(iter_11_1.goUsing, iter_11_0 <= var_11_0)
	end
end

var_0_0.OverColor = Color(0.7058823529411765, 0.7058823529411765, 0.7058823529411765)

function var_0_0.refreshHeadImageColor(arg_12_0)
	local var_12_0 = arg_12_0:checkIsOver()

	ZProj.UGUIHelper.SetGrayscale(arg_12_0.goBg, var_12_0)

	arg_12_0.headImage.color = var_12_0 and var_0_0.OverColor or Color.white
end

function var_0_0.refreshCanUse(arg_13_0)
	gohelper.setActive(arg_13_0.goCanUseFrame, arg_13_0:canUseSkill() ~= nil)
end

function var_0_0.canUseSkill(arg_14_0)
	local var_14_0 = var_0_0.super.canUseSkill(arg_14_0)

	if not var_14_0 then
		return
	end

	if arg_14_0:checkIsOver() then
		return
	end

	return var_14_0
end

function var_0_0.refreshCD(arg_15_0)
	return
end

var_0_0.OverBuffId = 12410011

function var_0_0.checkIsOver(arg_16_0)
	local var_16_0 = FightDataHelper.entityMgr:getAssistBoss()

	return var_16_0 and var_16_0:hasBuffId(var_0_0.OverBuffId)
end

function var_0_0.onBuffUpdate(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = FightDataHelper.entityMgr:getAssistBoss()

	if not var_17_0 then
		return
	end

	if var_17_0.uid ~= arg_17_1 then
		return
	end

	arg_17_0:refreshOver()
	arg_17_0:refreshHeadImageColor()
	arg_17_0:refreshCanUse()

	if arg_17_2 == FightEnum.EffectType.BUFFADD and arg_17_3 == var_0_0.OverBuffId then
		AudioMgr.instance:trigger(20247004)
	end
end

function var_0_0.refreshSpecialPoint(arg_18_0)
	local var_18_0 = arg_18_0.pointList[3]

	if arg_18_0:checkIsOver() then
		gohelper.setActive(var_18_0.goOver, true)
		gohelper.setActive(var_18_0.goFull, false)

		var_18_0.energyImage.fillAmount = 0

		return
	end

	local var_18_1, var_18_2 = FightDataHelper.paTaMgr:getAssistBossServerPower()
	local var_18_3 = var_18_1 == var_18_2

	var_18_0.energyImage.fillAmount = var_18_3 and 1 or 0

	gohelper.setActive(var_18_0.goFull, var_18_3)
	gohelper.setActive(var_18_0.goOver, false)
end

function var_0_0.onSkillPlayFinish(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = FightDataHelper.paTaMgr:getBossSkillInfoList()
	local var_19_1 = var_19_0 and var_19_0[3]

	if (var_19_1 and var_19_1.skillId) == arg_19_2 then
		arg_19_0:refreshSpecialPoint()
	end
end

function var_0_0.stageChange(arg_20_0)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		arg_20_0:refreshSpecialPoint()
	end
end

function var_0_0.onMySideRoundEnd(arg_21_0)
	return arg_21_0:refreshSpecialPoint()
end

function var_0_0.playAssistBossCard(arg_22_0)
	if var_0_0.super.playAssistBossCard(arg_22_0) then
		AudioMgr.instance:trigger(20247003)
	end
end

return var_0_0

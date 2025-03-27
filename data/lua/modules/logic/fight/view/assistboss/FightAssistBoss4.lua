module("modules.logic.fight.view.assistboss.FightAssistBoss4", package.seeall)

slot0 = class("FightAssistBoss4", FightAssistBossBase)

function slot0.setPrefabPath(slot0)
	slot0.prefabPath = "ui/viewres/assistboss/boss4.prefab"
end

function slot0.initView(slot0)
	uv0.super.initView(slot0)

	slot0.goCanUseFrame = gohelper.findChild(slot0.viewGo, "head/canuse_frame")
	slot0.goBg = gohelper.findChild(slot0.viewGo, "head/bg")
	slot0.pointList = {}

	slot0:createPointItem(gohelper.findChild(slot0.viewGo, "head/point1"))
	slot0:createPointItem(gohelper.findChild(slot0.viewGo, "head/point2"))
	slot0:createPointItem(gohelper.findChild(slot0.viewGo, "head/point3"))
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0.onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnMySideRoundEnd, slot0.onMySideRoundEnd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.StageChanged, slot0.stageChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0.onSkillPlayFinish, slot0)
end

function slot0.createPointItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.goUsing = gohelper.findChild(slot1, "canuse")
	slot2.goOver = gohelper.findChild(slot1, "over")
	slot2.energyImage = gohelper.findChildImage(slot1, "energybg/energy")
	slot2.goFull = gohelper.findChild(slot1, "full")
	slot2.energyImage.fillAmount = 0

	table.insert(slot0.pointList, slot2)
	slot0:resetPointItem(slot2)

	return slot2
end

function slot0.resetPointItem(slot0, slot1)
	gohelper.setActive(slot1.goFull, false)
	gohelper.setActive(slot1.goUsing, false)
	gohelper.setActive(slot1.goOver, false)
end

function slot0.refreshPower(slot0)
	slot0:killTween()

	slot1, slot2 = FightDataHelper.paTaMgr:getAssistBossServerPower()
	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot0:getBeforePowerRate(), slot1 / slot2, FightAssistBossBase.Duration, slot0.onBoss4FrameCallback, slot0.onTweenDone, slot0, nil, EaseType.Linear)

	slot0:refreshOver()
	slot0:refreshUsing()
	slot0:refreshHeadImageColor()
	slot0:refreshCanUse()
end

function slot0.getBeforePowerRate(slot0)
	return 0 + slot0.pointList[1].energyImage.fillAmount / 2 + slot0.pointList[2].energyImage.fillAmount / 2
end

function slot0.onBoss4FrameCallback(slot0, slot1)
	slot2 = nil

	if slot1 <= 0.5 then
		slot2 = 1
	else
		slot2 = 2
		slot1 = slot1 - 0.5
	end

	slot1 = slot1 * 2
	slot3 = slot0.pointList[slot2]
	slot3.energyImage.fillAmount = slot1

	gohelper.setActive(slot3.goFull, slot1 >= 1)
end

function slot0.onTweenDone(slot0)
	slot1, slot2 = FightDataHelper.paTaMgr:getAssistBossServerPower()
	slot3 = slot1 / slot2
	slot4 = slot3 <= 0.5 and slot3 * 2 or 1
	slot0.pointList[1].energyImage.fillAmount = slot4

	gohelper.setActive(slot0.pointList[1].goFull, slot4 >= 1)

	slot4 = (slot3 - 0.5) * 2
	slot0.pointList[2].energyImage.fillAmount = math.max(slot4, 0)

	gohelper.setActive(slot0.pointList[2].goFull, slot4 >= 1)
end

function slot0.refreshOver(slot0)
	for slot5, slot6 in ipairs(slot0.pointList) do
		gohelper.setActive(slot6.goOver, slot0:checkIsOver())
	end
end

function slot0.refreshUsing(slot0)
	for slot5, slot6 in ipairs(slot0.pointList) do
		gohelper.setActive(slot6.goUsing, slot5 <= FightDataHelper.paTaMgr:getUseCardCount())
	end
end

slot0.OverColor = Color(0.7058823529411765, 0.7058823529411765, 0.7058823529411765)

function slot0.refreshHeadImageColor(slot0)
	slot1 = slot0:checkIsOver()

	ZProj.UGUIHelper.SetGrayscale(slot0.goBg, slot1)

	slot0.headImage.color = slot1 and uv0.OverColor or Color.white
end

function slot0.refreshCanUse(slot0)
	gohelper.setActive(slot0.goCanUseFrame, slot0:canUseSkill() ~= nil)
end

function slot0.canUseSkill(slot0)
	if not uv0.super.canUseSkill(slot0) then
		return
	end

	if slot0:checkIsOver() then
		return
	end

	return slot1
end

function slot0.refreshCD(slot0)
end

slot0.OverBuffId = 12410011

function slot0.checkIsOver(slot0)
	return FightDataHelper.entityMgr:getAssistBoss() and slot1:hasBuffId(uv0.OverBuffId)
end

function slot0.onBuffUpdate(slot0, slot1, slot2, slot3, slot4)
	if not FightDataHelper.entityMgr:getAssistBoss() then
		return
	end

	if slot5.uid ~= slot1 then
		return
	end

	slot0:refreshOver()
	slot0:refreshHeadImageColor()
	slot0:refreshCanUse()

	if slot2 == FightEnum.EffectType.BUFFADD and slot3 == uv0.OverBuffId then
		AudioMgr.instance:trigger(20247004)
	end
end

function slot0.refreshSpecialPoint(slot0)
	slot1 = slot0.pointList[3]

	if slot0:checkIsOver() then
		gohelper.setActive(slot1.goOver, true)
		gohelper.setActive(slot1.goFull, false)

		slot1.energyImage.fillAmount = 0

		return
	end

	slot2, slot3 = FightDataHelper.paTaMgr:getAssistBossServerPower()
	slot4 = slot2 == slot3
	slot1.energyImage.fillAmount = slot4 and 1 or 0

	gohelper.setActive(slot1.goFull, slot4)
	gohelper.setActive(slot1.goOver, false)
end

function slot0.onSkillPlayFinish(slot0, slot1, slot2, slot3, slot4)
	slot6 = FightDataHelper.paTaMgr:getBossSkillInfoList() and slot5[3]

	if (slot6 and slot6.skillId) == slot2 then
		slot0:refreshSpecialPoint()
	end
end

function slot0.stageChange(slot0)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Normal then
		slot0:refreshSpecialPoint()
	end
end

function slot0.onMySideRoundEnd(slot0)
	return slot0:refreshSpecialPoint()
end

function slot0.playAssistBossCard(slot0)
	if uv0.super.playAssistBossCard(slot0) then
		AudioMgr.instance:trigger(20247003)
	end
end

return slot0

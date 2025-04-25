module("modules.logic.fight.view.assistboss.FightAssistBoss3", package.seeall)

slot0 = class("FightAssistBoss3", FightAssistBossBase)

function slot0.setPrefabPath(slot0)
	slot0.prefabPath = "ui/viewres/assistboss/boss3.prefab"
end

function slot0.initView(slot0)
	uv0.super.initView(slot0)

	slot0.goStage1 = gohelper.findChild(slot0.viewGo, "head/stage1")
	slot0.goStage2 = gohelper.findChild(slot0.viewGo, "head/stage2")
	slot0.goStage3 = gohelper.findChild(slot0.viewGo, "head/stage3")
	slot0.stageList = slot0:getUserDataTb_()
	slot0.stageList[1] = slot0.goStage1
	slot0.stageList[2] = slot0.goStage2
	slot0.stageList[3] = slot0.goStage3
	slot0.goEnergy3 = gohelper.findChild(slot0.viewGo, "energy_3")
	slot0.goEnergy4 = gohelper.findChild(slot0.viewGo, "energy_4")
	slot0.imageEnergy3 = gohelper.findChildImage(slot0.viewGo, "energy_3/go_energy")
	slot0.imageEnergy4 = gohelper.findChildImage(slot0.viewGo, "energy_4/go_energy")
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSwitchAssistBossSkill, slot0.onSwitchAssistBossSkill, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSwitchAssistBossSpine, slot0.onSwitchAssistBossSpine, slot0)
end

function slot0.refreshUI(slot0)
	uv0.super.refreshUI(slot0)
	slot0:refreshEnergyType()
end

function slot0.refreshEnergyType(slot0)
	gohelper.setActive(slot0.goEnergy3, #FightDataHelper.paTaMgr:getBossSkillInfoList() == 3)
	gohelper.setActive(slot0.goEnergy4, slot2 == 4)
end

function slot0.onSwitchAssistBossSkill(slot0)
	slot0:refreshEnergyType()
	slot0:refreshPower()
	slot0:refreshCD()
end

slot0.StageThresholdValue1 = 25
slot0.StageThresholdValue2 = 50
slot0.StageThresholdValue3 = 100

function slot0.refreshPower(slot0)
	uv0.super.refreshPower(slot0)

	slot3 = slot0.imageEnergy3

	if (FightDataHelper.paTaMgr:getBossSkillInfoList() and #slot1) == 4 then
		slot3 = slot0.imageEnergy4
	end

	slot4, slot5 = FightDataHelper.paTaMgr:getAssistBossPower()

	slot0:setFillAmount(slot3, slot4 / slot5)

	slot6 = 0

	for slot10, slot11 in ipairs(slot0.stageList) do
		gohelper.setActive(slot11, slot10 == (slot4 < uv0.StageThresholdValue1 and 0 or slot4 < uv0.StageThresholdValue2 and 1 or slot4 < uv0.StageThresholdValue3 and 2 or 3))
	end
end

function slot0.onSwitchAssistBossSpine(slot0)
	slot0:refreshHeadImage()
end

return slot0

module("modules.logic.fight.view.assistboss.FightAssistBoss1", package.seeall)

slot0 = class("FightAssistBoss1", FightAssistBossBase)

function slot0.setPrefabPath(slot0)
	slot0.prefabPath = "ui/viewres/assistboss/boss1.prefab"
end

function slot0.initView(slot0)
	uv0.super.initView(slot0)

	slot0.energyImage = gohelper.findChildImage(slot0.viewGo, "head/energy")
	slot0.goEffect1 = gohelper.findChild(slot0.viewGo, "head/dec2")
	slot0.goEffect2 = gohelper.findChild(slot0.viewGo, "head/vx_eff")
end

function slot0.refreshPower(slot0)
	uv0.super.refreshPower(slot0)

	slot1, slot2 = FightDataHelper.paTaMgr:getAssistBossPower()

	slot0:setFillAmount(slot0.energyImage, slot1 / slot2)
	slot0:refreshEffect()
end

function slot0.refreshCD(slot0)
	uv0.super.refreshCD(slot0)
	slot0:refreshEffect()
end

function slot0.refreshEffect(slot0)
	slot1 = true

	if not FightDataHelper.paTaMgr:getCurUseSkillInfo() then
		slot1 = false

		gohelper.setActive(slot0.goEffect1, slot1)
		gohelper.setActive(slot0.goEffect2, slot1)

		return
	end

	slot1 = not slot0:checkInCd()

	gohelper.setActive(slot0.goEffect1, slot1)
	gohelper.setActive(slot0.goEffect2, slot1)
end

return slot0

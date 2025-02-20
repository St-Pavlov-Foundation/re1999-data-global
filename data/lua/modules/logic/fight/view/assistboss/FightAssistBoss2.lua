module("modules.logic.fight.view.assistboss.FightAssistBoss2", package.seeall)

slot0 = class("FightAssistBoss2", FightAssistBossBase)

function slot0.setPrefabPath(slot0)
	slot0.prefabPath = "ui/viewres/assistboss/boss2.prefab"
end

slot0.MaxPower = 6

function slot0.initView(slot0)
	uv0.super.initView(slot0)

	slot0.goPowerList = slot0:getUserDataTb_()

	for slot4 = 1, uv0.MaxPower do
		table.insert(slot0.goPowerList, gohelper.findChild(slot0.viewGo, string.format("go_energy/%s/light", slot4)))
	end
end

function slot0.refreshPower(slot0)
	uv0.super.refreshPower(slot0)

	for slot5 = 1, uv0.MaxPower do
		gohelper.setActive(slot0.goPowerList[slot5], slot5 <= FightDataHelper.paTaMgr:getAssistBossPower())
	end
end

function slot0.onPowerChange(slot0, slot1, slot2, slot3, slot4)
	uv0.super.onPowerChange(slot0, slot1, slot2, slot3, slot4)

	if slot3 < slot4 then
		FightAudioMgr.instance:playAudio(20232001)
	end
end

return slot0

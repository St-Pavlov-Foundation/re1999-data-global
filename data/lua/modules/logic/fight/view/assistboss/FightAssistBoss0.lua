module("modules.logic.fight.view.assistboss.FightAssistBoss0", package.seeall)

slot0 = class("FightAssistBoss0", FightAssistBossBase)

function slot0.setPrefabPath(slot0)
	slot0.prefabPath = "ui/viewres/assistboss/boss0.prefab"
end

function slot0.initView(slot0)
	slot0.txtValue = gohelper.findChildText(slot0.viewGo, "txt_value")
	slot0.txtCD = gohelper.findChildText(slot0.viewGo, "txt_cd")
	slot0.goCDMask = gohelper.findChild(slot0.viewGo, "go_cdmask")
	slot0.click = gohelper.findChildClickWithDefaultAudio(slot0.viewGo, "image")

	slot0.click:AddClickListener(slot0.onClickSelf, slot0)
end

function slot0.onClickSelf(slot0)
	slot0:playAssistBossCard()
end

function slot0.refreshPower(slot0)
	uv0.super.refreshPower(slot0)

	slot0.txtValue.text = FightDataHelper.paTaMgr:getAssistBossPower()
end

function slot0.refreshCD(slot0)
	slot1 = FightDataHelper.paTaMgr:getCurCD()
	slot0.txtCD.text = string.format("CD:%s", slot1)

	gohelper.setActive(slot0.goCDMask, slot1 and slot1 > 0)
end

function slot0.destroy(slot0)
	if slot0.click then
		slot0.click:RemoveClickListener()
	end

	uv0.super.destroy(slot0)
end

return slot0

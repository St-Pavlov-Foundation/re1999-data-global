module("modules.logic.rouge.dlc.101.view.RougeHeroBaseStressItem", package.seeall)

slot0 = class("RougeHeroBaseStressItem", LuaCompBase)
slot0.AssetUrl = FightNameUIStressMgr.PrefabPath

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0.gostress = slot1
	slot0.blueText = gohelper.findChildText(slot1, "#txt_stress")
	slot0.goBlue = gohelper.findChild(slot1, "blue")
	slot0.goRed = gohelper.findChild(slot1, "red")

	gohelper.setActive(gohelper.findChild(slot1, "broken"), false)
	gohelper.setActive(gohelper.findChild(slot1, "staunch"), false)

	slot0.status2GoDict = slot0:getUserDataTb_()
	slot0.status2GoDict[FightEnum.Status.Positive] = slot0.goBlue
	slot0.status2GoDict[FightEnum.Status.Negative] = slot0.goRed
end

function slot0.onUpdateDLC(slot0, slot1)
	slot0:refreshUI(slot1)
end

function slot0.refreshUI(slot0, slot1)
	slot2 = slot0:getCurStress(slot1)

	gohelper.setActive(slot0.gostress, slot1 ~= nil and slot2 ~= nil)

	if not slot2 then
		return
	end

	slot0.blueText.text = slot2
	slot0.status = FightHelper.getStressStatus(slot2)

	for slot6, slot7 in pairs(slot0.status2GoDict) do
		gohelper.setActive(slot7, slot6 == slot0.status)
	end
end

function slot0.getCurStress(slot0, slot1)
	if not RougeModel.instance:getTeamInfo():getHeroInfo(slot1 and slot1.heroId) then
		return
	end

	return slot3:getStressValue()
end

return slot0

module("modules.logic.fight.view.assistboss.FightAssistBoss5", package.seeall)

slot0 = class("FightAssistBoss5", FightAssistBossBase)

function slot0.setPrefabPath(slot0)
	slot0.prefabPath = "ui/viewres/assistboss/boss5.prefab"
end

slot0.State = {
	Clicked = 3,
	CantClick = 1,
	CanClick = 2,
	SuZhen = 4
}
slot0.MaxPower = 5

function slot0.initView(slot0)
	uv0.super.initView(slot0)

	slot0.pointList = {}

	for slot4 = 1, uv0.MaxPower do
		slot0:createPointItem(slot4)
	end

	slot0.goBgLevel1 = gohelper.findChild(slot0.viewGo, "head/bg/level1")
	slot0.goBgLevel2 = gohelper.findChild(slot0.viewGo, "head/bg/level2")
	slot0.goBgLevel3 = gohelper.findChild(slot0.viewGo, "head/bg/level3")
	slot0.goEffectLevel2 = gohelper.findChild(slot0.viewGo, "head/level2_eff")
	slot0.goEffectLevel3 = gohelper.findChild(slot0.viewGo, "head/level3_eff")
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PowerMaxChange, slot0.onPowerMaxChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AddMagicCircile, slot0.refreshPower, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.DeleteMagicCircile, slot0.refreshPower, slot0)
end

function slot0.onPowerMaxChange(slot0, slot1, slot2)
	if not FightDataHelper.entityMgr:getAssistBoss() then
		return
	end

	if slot3.uid ~= slot1 then
		return
	end

	if slot2 ~= FightEnum.PowerType.AssistBoss then
		return
	end

	slot0:refreshPower()
end

function slot0.createPointItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot3 = gohelper.findChild(slot0.viewGo, "head/point" .. slot1)
	slot2.go = slot3
	slot2.goEnergy1 = gohelper.findChild(slot3, "energy1")
	slot2.goEnergy2 = gohelper.findChild(slot3, "energy2")
	slot2.goEnergy1Full = gohelper.findChild(slot2.goEnergy1, "dark")
	slot2.goEnergy1Light = gohelper.findChild(slot2.goEnergy1, "light")
	slot2.goEnergy2Full = gohelper.findChild(slot2.goEnergy2, "light")

	table.insert(slot0.pointList, slot2)

	return slot2
end

function slot0.refreshPower(slot0)
	slot0:initRefreshFunc()

	slot1 = slot0:getCurState()

	slot0:refreshBg(slot1)
	slot0:refreshEffect(slot1)
	slot0:refreshPointActive()

	if slot0.refreshFuncDict[slot1] then
		slot2(slot0)
	end

	slot0:refreshHeadImageColor()
end

function slot0.initRefreshFunc(slot0)
	if not slot0.refreshFuncDict then
		slot0.refreshFuncDict = {
			[uv0.State.CantClick] = slot0.refreshCantClickUI,
			[uv0.State.CanClick] = slot0.refreshCanClickUI,
			[uv0.State.Clicked] = slot0.refreshClickedUI,
			[uv0.State.SuZhen] = slot0.refreshSuZhenUI
		}
	end
end

function slot0.getCurState(slot0)
	if FightModel.instance:getMagicCircleInfo() and slot1.magicCircleId == 1251001 then
		return uv0.State.SuZhen
	end

	if FightDataHelper.paTaMgr:getUseCardCount() and slot2 > 0 then
		return uv0.State.Clicked
	end

	if not FightDataHelper.paTaMgr:getCurUseSkillInfo() then
		return uv0.State.CantClick
	end

	if FightDataHelper.paTaMgr:getNeedPower(slot3) <= FightDataHelper.paTaMgr:getAssistBossPower() then
		return uv0.State.CanClick
	end

	return uv0.State.CantClick
end

function slot0.refreshBg(slot0, slot1)
	gohelper.setActive(slot0.goBgLevel1, slot1 == uv0.State.CantClick)
	gohelper.setActive(slot0.goBgLevel2, slot1 == uv0.State.CanClick or slot1 == uv0.State.Clicked)
	gohelper.setActive(slot0.goBgLevel3, slot1 == uv0.State.SuZhen)
end

function slot0.refreshEffect(slot0, slot1)
	gohelper.setActive(slot0.goEffectLevel2, slot1 == uv0.State.CanClick or slot1 == uv0.State.Clicked)
	gohelper.setActive(slot0.goEffectLevel3, slot1 == uv0.State.SuZhen)
end

function slot0.refreshPointActive(slot0)
	slot1, slot2 = FightDataHelper.paTaMgr:getAssistBossServerPower()

	for slot6, slot7 in ipairs(slot0.pointList) do
		gohelper.setActive(slot7.go, slot6 <= math.min(uv0.MaxPower, slot2))
	end
end

function slot0.refreshCantClickUI(slot0)
	for slot5, slot6 in ipairs(slot0.pointList) do
		gohelper.setActive(slot6.goEnergy1, true)
		gohelper.setActive(slot6.goEnergy2, false)
		gohelper.setActive(slot6.goEnergy1Light, false)
		gohelper.setActive(slot6.goEnergy1Full, slot5 <= FightDataHelper.paTaMgr:getAssistBossServerPower())
	end
end

function slot0.refreshCanClickUI(slot0)
	for slot5, slot6 in ipairs(slot0.pointList) do
		gohelper.setActive(slot6.goEnergy1, true)
		gohelper.setActive(slot6.goEnergy2, false)
		gohelper.setActive(slot6.goEnergy1Light, false)
		gohelper.setActive(slot6.goEnergy1Full, slot5 <= FightDataHelper.paTaMgr:getAssistBossServerPower())
	end
end

function slot0.refreshClickedUI(slot0)
	slot1 = FightDataHelper.paTaMgr:getAssistBossServerPower()

	for slot5, slot6 in ipairs(slot0.pointList) do
		gohelper.setActive(slot6.goEnergy1, true)
		gohelper.setActive(slot6.goEnergy2, false)
		gohelper.setActive(slot6.goEnergy1Light, slot5 <= slot1)
		gohelper.setActive(slot6.goEnergy1Full, slot5 <= slot1)
	end
end

function slot0.refreshSuZhenUI(slot0)
	for slot5, slot6 in ipairs(slot0.pointList) do
		gohelper.setActive(slot6.goEnergy1, false)
		gohelper.setActive(slot6.goEnergy2, true)
		gohelper.setActive(slot6.goEnergy2Full, slot5 <= FightDataHelper.paTaMgr:getAssistBossServerPower())
	end
end

function slot0.refreshCD(slot0)
	if slot0:getCurState() == uv0.State.SuZhen then
		gohelper.setActive(slot0.goCD, false)
		slot0:refreshHeadImageColor()

		return
	end

	uv0.super.refreshCD(slot0)
end

function slot0.refreshHeadImageColor(slot0)
	if slot0:getCurState() == uv0.State.SuZhen then
		slot0.headImage.color = Color.white

		return
	end

	uv0.super.refreshHeadImageColor(slot0)
end

function slot0.refreshHeadImage(slot0)
	slot0.headSImage:LoadImage(ResUrl.monsterHeadIcon(6304101), slot0.onImageLoaded, slot0)
end

function slot0.onImageLoaded(slot0)
	slot0.headImage:SetNativeSize()
end

return slot0

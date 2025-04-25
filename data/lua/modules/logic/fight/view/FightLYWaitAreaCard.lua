module("modules.logic.fight.view.FightLYWaitAreaCard", package.seeall)

slot0 = class("FightLYWaitAreaCard", UserDataDispose)
slot0.LY_CardPath = "ui/viewres/fight/fight_liangyuecardview.prefab"
slot0.LY_MAXPoint = 6

function slot0.Create(slot0)
	slot1 = uv0.New()

	slot1:init(slot0)

	return slot1
end

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.loaded = false
	slot0.goContainer = slot1
	slot0.LYLoader = PrefabInstantiate.Create(slot0.goContainer)

	slot0.LYLoader:startLoad(uv0.LY_CardPath, slot0.onLoadLYCardDone, slot0)
end

function slot0.onLoadLYCardDone(slot0, slot1)
	slot0.loaded = true
	slot0.LY_instanceGo = slot0.LYLoader:getInstGO()
	slot0.rectTr = slot0.LY_instanceGo:GetComponent(gohelper.Type_RectTransform)
	slot5 = gohelper.Type_Animator
	slot0.animator = gohelper.findChildComponent(slot0.LY_instanceGo, "current", slot5)
	slot0.LY_goCardBack = gohelper.findChild(slot0.LY_instanceGo, "current/back")

	gohelper.setActive(slot0.LY_goCardBack, true)

	slot0.goSkillList = slot0:getUserDataTb_()

	for slot5 = 1, 3 do
		table.insert(slot0.goSkillList, gohelper.findChild(slot0.LY_goCardBack, tostring(slot5)))
	end

	slot0.LY_pointItemList = {}

	for slot5 = 1, uv0.LY_MAXPoint do
		slot6 = slot0:getUserDataTb_()
		slot6.go = gohelper.findChild(slot0.LY_instanceGo, "current/font/energy/" .. slot5)
		slot6.goRed = gohelper.findChild(slot6.go, "red")
		slot6.goBlue = gohelper.findChild(slot6.go, "green")
		slot6.goBoth = gohelper.findChild(slot6.go, "both")
		slot6.animator = slot6.go:GetComponent(gohelper.Type_Animator)

		table.insert(slot0.LY_pointItemList, slot6)
	end

	slot0:refreshLYCard()
	slot0:setAnchorX(slot0.recordAnchorX)
	slot0:setScale(slot0.scale)
	slot0:addEventCb(FightController.instance, FightEvent.LY_HadRedAndBluePointChange, slot0.onPointChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.LY_PointAreaSizeChange, slot0.refreshLYCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.LY_TriggerCountSkill, slot0.onTriggerSkill, slot0)
end

function slot0.onPointChange(slot0, slot1, slot2)
	if not slot0.loaded then
		return
	end

	if not FightDataHelper.LYDataMgr:getPointList() then
		gohelper.setActive(slot0.goContainer, false)

		return
	end

	gohelper.setActive(slot0.goContainer, true)
	slot0:resetAllPoint()

	for slot9 = 1, slot4 do
		slot11 = (FightViewRedAndBlueArea.PointIndexList[math.min(math.max(0, FightDataHelper.LYDataMgr.LYPointAreaSize), uv0.LY_MAXPoint) + 1] or {})[slot9] and slot0.LY_pointItemList[slot10]

		gohelper.setActive(slot11.go, true)
		gohelper.setActive(slot11.goRed, slot3[slot9] == FightEnum.CardColor.Red)
		gohelper.setActive(slot11.goBlue, slot12 == FightEnum.CardColor.Blue)
		gohelper.setActive(slot11.goBoth, slot12 == FightEnum.CardColor.Both)

		if slot2 < slot9 and slot12 and slot12 ~= FightEnum.CardColor.None then
			slot11.animator:Play("active", 0, 0)
		else
			slot11.animator:Play("empty", 0, 0)
		end
	end
end

function slot0.resetAllPoint(slot0)
	for slot4 = 1, uv0.LY_MAXPoint do
		gohelper.setActive(slot0.LY_pointItemList[slot4].go, false)
	end
end

function slot0.onSkillPlayFinish(slot0, slot1, slot2)
	if slot0.waitSkillId == slot2 then
		FightDataHelper.LYDataMgr:refreshPointList(true)
		slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0.onSkillPlayFinish, slot0)

		slot0.waitSkillId = nil

		if slot0.loaded then
			slot0:refreshLYCard()
			AudioMgr.instance:trigger(20250501)
			slot0.animator:Play("rotate_02", 0, 0)
		end
	end
end

function slot0.onTriggerSkill(slot0, slot1, slot2, slot3)
	slot0.waitSkillId = slot3

	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0.onSkillPlayFinish, slot0)

	if not slot0.loaded then
		return
	end

	for slot7, slot8 in ipairs(slot0.goSkillList) do
		gohelper.setActive(slot8, false)
	end

	if slot1 == slot2 then
		gohelper.setActive(slot0.goSkillList[1], true)
	elseif slot1 < slot2 then
		gohelper.setActive(slot0.goSkillList[2], true)
	else
		gohelper.setActive(slot0.goSkillList[3], true)
	end

	slot0.animator:Play("rotate_01", 0, 0)
	AudioMgr.instance:trigger(20250500)
end

function slot0.refreshLYCard(slot0)
	if not slot0.loaded then
		return
	end

	if not FightDataHelper.LYDataMgr:getPointList() then
		gohelper.setActive(slot0.goContainer, false)

		return
	end

	gohelper.setActive(slot0.goContainer, true)

	for slot6 = 1, uv0.LY_MAXPoint do
		slot7 = slot0.LY_pointItemList[slot6]

		if FightDataHelper.LYDataMgr.LYPointAreaSize < slot6 then
			gohelper.setActive(slot7.go, false)

			break
		end

		gohelper.setActive(slot7.go, true)
		gohelper.setActive(slot7.goRed, slot1[slot6] == FightEnum.CardColor.Red)
		gohelper.setActive(slot7.goBlue, slot8 == FightEnum.CardColor.Blue)
		gohelper.setActive(slot7.goBoth, slot8 == FightEnum.CardColor.Both)
	end
end

function slot0.resetState(slot0)
	slot0.animator:Play("rotate_02", 0, 1)
end

function slot0.playAnim(slot0, slot1)
	slot0.animator:Play(slot1, 0, 0)
end

function slot0.setAnchorX(slot0, slot1)
	slot0.recordAnchorX = slot1 or 0

	if not slot0.loaded then
		return
	end

	recthelper.setAnchorX(slot0.rectTr, slot0.recordAnchorX)
end

function slot0.setScale(slot0, slot1)
	slot0.scale = slot1 or 1

	if not slot0.loaded then
		return
	end

	transformhelper.setLocalScale(slot0.rectTr, slot0.scale, slot0.scale, slot0.scale)
end

function slot0.dispose(slot0)
	if slot0.LYLoader then
		slot0.LYLoader:dispose()

		slot0.LYLoader = nil
	end

	slot0:__onDispose()
end

return slot0

module("modules.logic.gm.controller.GMFightController", package.seeall)

slot0 = class("GMFightController", BaseController)

function slot0.ctor(slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, slot0._onExitScene, slot0)
end

function slot0._onExitScene(slot0)
	slot0.buffTypeId = nil
end

function slot0.startStatBuffType(slot0, slot1)
	slot0.buffTypeId = slot1

	for slot8, slot9 in pairs(GameSceneMgr.instance:getCurScene().entityMgr:getTagUnitDict(SceneTag.UnitMonster)) do
		slot0:addStatBuffTypeByEntity(slot9)
	end

	for slot9, slot10 in pairs(slot3:getTagUnitDict(SceneTag.UnitPlayer)) do
		slot0:addStatBuffTypeByEntity(slot10)
	end
end

function slot0.addStatBuffTypeByEntity(slot0, slot1)
	if slot1.nameUI then
		MonoHelper.addLuaComOnceToGo(slot2:getGO(), FightGmNameUIComp, slot1):startStatBuffType(slot0.buffTypeId)
	end
end

function slot0.stopStatBuffType(slot0)
	slot0.buffTypeId = nil

	for slot7, slot8 in pairs(GameSceneMgr.instance:getCurScene().entityMgr:getTagUnitDict(SceneTag.UnitMonster)) do
		slot0:stopStatBuffTypeByEntity(slot8)
	end

	for slot8, slot9 in pairs(slot2:getTagUnitDict(SceneTag.UnitPlayer)) do
		slot0:stopStatBuffTypeByEntity(slot9)
	end
end

function slot0.stopStatBuffTypeByEntity(slot0, slot1)
	if slot1.nameUI and MonoHelper.getLuaComFromGo(slot2:getGO(), FightGmNameUIComp) then
		slot4:stopStatBuffType()
	end
end

function slot0.statingBuffType(slot0)
	return slot0.buffTypeId ~= nil
end

slot0.instance = slot0.New()

return slot0

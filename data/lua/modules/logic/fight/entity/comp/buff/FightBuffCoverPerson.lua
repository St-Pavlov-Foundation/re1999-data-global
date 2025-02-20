module("modules.logic.fight.entity.comp.buff.FightBuffCoverPerson", package.seeall)

slot0 = class("FightBuffCoverPerson")
slot1 = {
	2,
	3,
	5,
	10
}

function slot0.onBuffStart(slot0, slot1, slot2)
	slot0.entity = slot1
	slot0.buffMO = slot2
	slot0._celebrityCharm = slot0:_calcCelebrityCharm()
	slot0._useCelebrityCharm = 0

	FightController.instance:registerCallback(FightEvent.AddPlayOperationData, slot0._onAddPlayOperationData, slot0)
	FightController.instance:registerCallback(FightEvent.OnResetCard, slot0._onResetCard, slot0)
	FightController.instance:registerCallback(FightEvent.RespBeginRound, slot0._respBeginRound, slot0)
	FightController.instance:registerCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
end

function slot0._removeEvents(slot0)
	FightController.instance:unregisterCallback(FightEvent.AddPlayOperationData, slot0._onAddPlayOperationData, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnResetCard, slot0._onResetCard, slot0)
	FightController.instance:unregisterCallback(FightEvent.RespBeginRound, slot0._respBeginRound, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
end

function slot0._onAddPlayOperationData(slot0, slot1)
	if slot1.operType ~= FightEnum.CardOpType.PlayCard then
		return
	end

	if slot1.belongToEntityId ~= slot0.entity.id then
		return
	end

	slot2 = slot1.skillId
	slot3 = lua_skill.configDict[slot2].name

	if uv0[slot0.entity:getMO():getSkillLv(slot2) or 1] + slot0._useCelebrityCharm <= slot0._celebrityCharm then
		slot0._useCelebrityCharm = slot0._useCelebrityCharm + slot5

		slot1:copyCard()
	end
end

function slot0._onResetCard(slot0)
	slot0._useCelebrityCharm = 0
end

function slot0._respBeginRound(slot0)
	slot0._useCelebrityCharm = 0
end

function slot0._onStageChange(slot0, slot1)
	if slot1 == FightEnum.Stage.Card or slot1 == FightEnum.Stage.AutoCard then
		slot0._useCelebrityCharm = 0
		slot0._celebrityCharm = slot0:_calcCelebrityCharm()
	end
end

function slot0.onBuffEnd(slot0)
	slot0:_removeEvents()
end

function slot0.reset(slot0)
	slot0:_removeEvents()
end

function slot0.dispose(slot0)
	slot0:_removeEvents()
end

function slot0._calcCelebrityCharm(slot0)
	slot4 = slot0.entity:getMO()
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.getBuffDic(slot6)) do
		if (lua_skill_buff.configDict[slot6.buffId] and lua_skill_bufftype.configDict[slot7.typeId]).id == FightEnum.BuffTypeId_CelebrityCharm then
			slot1 = 0 + 1
		end
	end

	return slot1
end

return slot0

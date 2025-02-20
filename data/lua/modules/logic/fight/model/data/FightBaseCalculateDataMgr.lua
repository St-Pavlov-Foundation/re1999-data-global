module("modules.logic.fight.model.data.FightBaseCalculateDataMgr", package.seeall)

slot0 = FightDataBase("FightBaseCalculateDataMgr")

function slot0.ctor(slot0)
	slot0._type2FuncName = {}
end

function slot0.playStepProto(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = FightStepMO.New()

		slot8:init(slot7, true)
		table.insert(slot2, slot8)
	end

	for slot6, slot7 in ipairs(slot2) do
		slot0:playStepData(slot7)
	end
end

function slot0.playStepData(slot0, slot1)
	if slot1.actType == FightEnum.ActType.SKILL or slot1.actType == FightEnum.ActType.EFFECT then
		for slot5, slot6 in ipairs(slot1.actEffectMOs) do
			slot0:playActEffectData(slot6)
		end
	elseif slot1.actType == FightEnum.ActType.CHANGEWAVE then
		slot0:playChangeWave()
	elseif slot1.actType == FightEnum.ActType.CHANGEHERO then
		slot0:playChangeHero(slot1)
	end
end

function slot0.playActEffectData(slot0, slot1)
	if not slot0._type2FuncName[slot1.effectType] then
		slot0._type2FuncName[slot1.effectType] = slot0["playEffect" .. slot1.effectType] or slot0.playUndefineEffect
	end

	if slot0:isPerformanceData() then
		slot1:setDone()
		xpcall(slot2, uv0.ingoreLogError, slot0, slot1)
	else
		xpcall(slot2, __G__TRACKBACK__, slot0, slot1)
	end
end

function slot0.ingoreLogError(slot0)
end

return slot0

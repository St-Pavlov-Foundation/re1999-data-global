module("modules.logic.fight.model.data.FightStageMgr", package.seeall)

slot0 = class("FightStageMgr")
slot0.StageType = {
	Normal = GameUtil.getEnumId(),
	Replay = GameUtil.getEnumId(),
	Enter = GameUtil.getEnumId(),
	Play = GameUtil.getEnumId(),
	End = GameUtil.getEnumId()
}
slot0.FightStateType = {
	Auto = GameUtil.getEnumId()
}
slot0.OperateStateType = {
	Discard = GameUtil.getEnumId(),
	DiscardEffect = GameUtil.getEnumId(),
	SeasonChangeHero = GameUtil.getEnumId(),
	BindContract = GameUtil.getEnumId()
}
slot1 = {
	[slot6] = slot5
}

for slot5, slot6 in pairs(slot0.StageType) do
	-- Nothing
end

function slot0.ctor(slot0)
	slot0.stages = {}
	slot0.operateStates = {}
	slot0.operateParam = {}
	slot0.fightStates = {}
	slot0.enterFinish = false
end

function slot0.getStages(slot0)
	return slot0.stages
end

function slot0.getCurStage(slot0)
	return slot0.stages[#slot0.stages]
end

function slot0.getCurOperateState(slot0)
	return slot0.operateStates[#slot0.operateStates]
end

function slot0.getCurOperateParam(slot0)
	return slot0.operateParam[#slot0.operateParam]
end

function slot0.enterStage(slot0, slot1)
	for slot5 = #slot0.stages, 1, -1 do
		if slot1 == slot0.stages[slot5] then
			return
		end
	end

	table.insert(slot0.stages, slot1)
	FightController.instance:dispatchEvent(FightEvent.EnterStage, slot1)
end

function slot0.exitStage(slot0, slot1)
	slot2 = nil

	for slot6 = #slot0.stages, 1, -1 do
		if slot1 == slot0.stages[slot6] then
			slot2 = slot6

			break
		end
	end

	if not slot2 then
		return
	end

	if slot2 ~= #slot0.stages then
		logError("退出阶段,但是栈结构被打乱了,请检查代码,退出的stage:" .. uv0[slot1])
	end

	table.remove(slot0.stages, slot2)

	if slot1 == uv1.StageType.Enter then
		slot0.enterFinish = true
	end

	FightController.instance:dispatchEvent(FightEvent.ExitStage, slot1)
end

function slot0.enterFightState(slot0, slot1)
	table.insert(slot0.fightStates, slot1)
	FightController.instance:dispatchEvent(FightEvent.EnterFightState, slot1)
end

function slot0.exitFightState(slot0, slot1)
	slot2 = nil

	for slot6 = #slot0.fightStates, 1, -1 do
		if slot1 == slot0.fightStates[slot6] then
			slot2 = slot6
		end
	end

	if not slot2 then
		return
	end

	table.remove(slot0.fightStates, slot2)
	FightController.instance:dispatchEvent(FightEvent.ExitFightState, slot1)
end

function slot0.enterOperateState(slot0, slot1, slot2)
	table.insert(slot0.operateStates, slot1)
	table.insert(slot0.operateParam, slot2 or 0)
	FightController.instance:dispatchEvent(FightEvent.EnterOperateState, slot1)
end

function slot0.exitOperateState(slot0, slot1)
	slot2 = nil

	for slot6 = #slot0.operateStates, 1, -1 do
		if slot1 == slot0.operateStates[slot6] then
			slot2 = slot6
		end
	end

	if not slot2 then
		return
	end

	table.remove(slot0.operateStates, slot2)
	table.remove(slot0.operateParam, slot2)
	FightController.instance:dispatchEvent(FightEvent.ExitOperateState, slot1)
end

function slot0.isEmptyOperateState(slot0)
	return #slot0.operateStates == 0
end

function slot0.inFightState(slot0, slot1)
	for slot5 = #slot0.fightStates, 1, -1 do
		if slot1 == slot0.fightStates[slot5] then
			return true
		end
	end
end

function slot0.isNormalStage(slot0)
	return slot0.stages[#slot0.stages] == uv0.StageType.Normal
end

function slot0.inAutoFightState(slot0)
	return slot0:inFightState(uv0.FightStateType.Auto)
end

function slot0.isFree(slot0)
	if not slot0:isNormalStage() then
		return
	end

	if slot0:inAutoFightState() then
		return
	end

	if not slot0:isEmptyOperateState() then
		return
	end

	return true
end

function slot0.enterFinished(slot0)
	return slot0.enterFinish
end

function slot0.isBaseStage(slot0)
	return slot0:getCurStage() == uv0.StageType.Normal or slot1 == uv0.StageType.Replay
end

return slot0

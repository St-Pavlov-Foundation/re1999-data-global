module("modules.logic.fight.model.data.FightStageMgr", package.seeall)

slot0 = FightDataClass("FightStageMgr")
slot0.StageType = {
	Normal = GameUtil.getEnumId(),
	Play = GameUtil.getEnumId(),
	End = GameUtil.getEnumId()
}
slot0.PlayType = {
	ClothSkill = 2,
	Normal = 1
}
slot0.FightStateType = {
	Enter = GameUtil.getEnumId(),
	Auto = GameUtil.getEnumId(),
	Replay = GameUtil.getEnumId(),
	DouQuQu = GameUtil.getEnumId(),
	Season2AutoChangeHero = GameUtil.getEnumId(),
	Distribute1Card = GameUtil.getEnumId(),
	OperationView2PlayView = GameUtil.getEnumId(),
	SendOperation2Server = GameUtil.getEnumId(),
	PlaySeasonChangeHero = GameUtil.getEnumId()
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

function slot0.onConstructor(slot0)
	slot0.stages = {}
	slot0.stageParam = {}
	slot0.operateStates = {}
	slot0.operateParam = {}
	slot0.fightStates = {}
	slot0.fightStateParam = {}
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

function slot0.enterStage(slot0, slot1, slot2)
	for slot6 = #slot0.stages, 1, -1 do
		if slot1 == slot0.stages[slot6] then
			slot0.stageParam[slot6] = slot2 or 0

			return
		end
	end

	table.insert(slot0.stages, slot1)
	table.insert(slot0.stageParam, slot2 or 0)
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

	return table.remove(slot0.stageParam, slot2)
end

function slot0.enterFightState(slot0, slot1, slot2)
	table.insert(slot0.fightStates, slot1)

	slot2 = slot2 or 0

	table.insert(slot0.fightStateParam, slot2)
	FightController.instance:dispatchEvent(FightEvent.EnterFightState, slot1, slot2)
end

function slot0.exitFightState(slot0, slot1)
	slot2 = nil

	for slot6 = #slot0.fightStates, 1, -1 do
		if slot1 == slot0.fightStates[slot6] then
			slot2 = slot6

			break
		end
	end

	if not slot2 then
		return
	end

	table.remove(slot0.fightStates, slot2)
	FightController.instance:dispatchEvent(FightEvent.ExitFightState, slot1, table.remove(slot0.fightStateParam, slot2))
end

function slot0.enterOperateState(slot0, slot1, slot2)
	table.insert(slot0.operateStates, slot1)

	slot2 = slot2 or 0

	table.insert(slot0.operateParam, slot2)
	FightController.instance:dispatchEvent(FightEvent.EnterOperateState, slot1, slot2)
end

function slot0.exitOperateState(slot0, slot1)
	slot2 = nil

	for slot6 = #slot0.operateStates, 1, -1 do
		if slot1 == slot0.operateStates[slot6] then
			slot2 = slot6

			break
		end
	end

	if not slot2 then
		return
	end

	table.remove(slot0.operateStates, slot2)
	FightController.instance:dispatchEvent(FightEvent.ExitOperateState, slot1, table.remove(slot0.operateParam, slot2))
end

function slot0.isEmptyOperateState(slot0, slot1)
	if #slot0.operateStates == 0 then
		return true
	end

	for slot5, slot6 in ipairs(slot0.operateStates) do
		if not slot1 or not slot1[slot6] then
			return false
		end
	end

	return true
end

function slot0.inOperateState(slot0, slot1, slot2)
	if slot2 and slot2[slot1] then
		return false
	end

	for slot6 = #slot0.operateStates, 1, -1 do
		if slot1 == slot0.operateStates[slot6] then
			return true
		end
	end
end

function slot0.inFightState(slot0, slot1, slot2)
	if slot2 and slot2[slot1] then
		return false
	end

	for slot6 = #slot0.fightStates, 1, -1 do
		if slot1 == slot0.fightStates[slot6] then
			return true
		end
	end
end

function slot0.isNormalStage(slot0)
	return slot0:getCurStage() == uv0.StageType.Normal
end

function slot0.isPlayStage(slot0)
	return slot0:getCurStage() == uv0.StageType.Play
end

function slot0.inAutoFightState(slot0)
	return slot0:inFightState(uv0.FightStateType.Auto)
end

function slot0.isFree(slot0, slot1, slot2)
	if slot0:inReplay() then
		return
	end

	if not slot0:isNormalStage() then
		return
	end

	if slot0:inAutoFightState() then
		return
	end

	if slot0:inFightState(uv0.FightStateType.OperationView2PlayView) then
		return
	end

	if slot0:inFightState(uv0.FightStateType.SendOperation2Server) then
		return
	end

	if slot0:inFightState(uv0.FightStateType.Enter) then
		return
	end

	if slot0:inFightState(uv0.FightStateType.DouQuQu, slot2) then
		return
	end

	if not slot0:isEmptyOperateState(slot1) then
		return
	end

	if #slot0.dataMgr.operationMgr.operationStates > 0 then
		return
	end

	return true
end

function slot0.inReplay(slot0)
	return slot0:inFightState(uv0.FightStateType.Replay)
end

return slot0

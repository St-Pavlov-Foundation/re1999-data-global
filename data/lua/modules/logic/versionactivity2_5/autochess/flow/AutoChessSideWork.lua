module("modules.logic.versionactivity2_5.autochess.flow.AutoChessSideWork", package.seeall)

slot0 = class("AutoChessSideWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.flowCnt = 1
	slot0.seqFlow = FlowSequence.New()

	slot0.seqFlow:registerDoneListener(slot0.onDone, slot0)

	slot0.effectList = slot1

	slot0:initSideWork()
end

function slot0.onStart(slot0, slot1)
	slot0.seqFlow:start(slot1)
end

function slot0.onStop(slot0)
	slot0.seqFlow:stop()
end

function slot0.onResume(slot0)
	slot0.seqFlow:resume()
end

function slot0.onReset(slot0)
	slot0.seqFlow:reset()
end

function slot0.onDestroy(slot0)
	slot0.seqFlow:unregisterDoneListener(slot0.onDone, slot0)
	slot0.seqFlow:destroy()

	slot0.seqFlow = nil
	slot0.effectList = nil
end

function slot0.initSideWork(slot0)
	for slot4, slot5 in ipairs(slot0.effectList) do
		if slot5.effectType == AutoChessEnum.EffectType.NextFightStep then
			slot0:recursion(slot5.nextFightStep)
		else
			slot0.seqFlow:addWork(AutoChessEffectWork.New(slot5))
		end
	end
end

function slot0.recursion(slot0, slot1)
	if slot1.actionType == AutoChessEnum.ActionType.ChessMove then
		slot2 = FlowParallel.New()

		for slot6, slot7 in ipairs(slot1.effect) do
			if slot7.effectType == AutoChessEnum.EffectType.ChessMove then
				slot2:addWork(AutoChessEffectWork.New(slot7))
			else
				logError("异常:棋子移动Action下面不该有其他类型Effect")
			end
		end

		slot0.seqFlow:addWork(slot2)
	else
		slot2 = nil

		if slot1.actionType == AutoChessEnum.ActionType.ChessSkill then
			slot0.seqFlow:addWork(AutoChessSkillWork.New(slot1))

			if lua_auto_chess_skill.configDict[tonumber(slot1.reasonId)] and not string.nilorempty(slot4.skilleffID) then
				slot2 = string.splitToNumber(slot5, "#")
			end
		end

		for slot6, slot7 in ipairs(slot1.effect) do
			if slot7.effectType == AutoChessEnum.EffectType.NextFightStep then
				slot0:recursion(slot7.nextFightStep)
			else
				slot0.seqFlow:addWork(AutoChessEffectWork.New(slot7))

				if slot2 and slot7.effectType == slot2[2] then
					slot8:markSkillEffect(slot2[1])
				end
			end
		end
	end
end

return slot0

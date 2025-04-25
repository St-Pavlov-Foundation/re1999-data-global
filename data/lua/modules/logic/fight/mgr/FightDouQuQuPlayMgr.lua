module("modules.logic.fight.mgr.FightDouQuQuPlayMgr", package.seeall)

slot0 = class("FightDouQuQuPlayMgr", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0:com_registMsg(FightMsgId.MaybeCrashed, slot0._onMaybeCrashed)
end

function slot0._onMaybeCrashed(slot0)
	FightSystem.instance:dispose()
	FightModel.instance:clearRecordMO()
	FightController.instance:exitFightScene()
end

function slot0._onPlayDouQuQu(slot0, slot1)
	if FightDataModel.instance.douQuQuMgr.isGM then
		slot3 = slot2.gmProto
		slot8 = slot3.fight
		slot9 = slot3.startRound

		slot0:com_registFlowSequence():registWork(FightWorkDouQuQuGMEnter, slot8, slot9, slot3.index)

		for slot8, slot9 in ipairs(slot3.round) do
			slot4:registWork(FightWorkDouQuQuOneRound, slot9)
			slot4:registWork(FightWorkDelayTimer, 0.1)
		end

		slot4:registWork(FightWorkDouQuQuGMEnd)
		slot4:start()
	elseif slot2.isGMStartIndex then
		slot4 = {}

		for slot8, slot9 in ipairs(slot2.playIndexTab) do
			table.insert(slot4, slot9)
		end

		slot0._douQuQuFlow = slot0:com_registFlowSequence()
		slot5 = slot0._douQuQuFlow

		for slot9, slot10 in ipairs(slot4) do
			slot5:registWork(FightWorkDouQuQuGMForceIndexEnter, slot10, slot9 ~= 1 or slot1)
			slot5:registWork(FightWorkDouQuQuRound)
			slot5:registWork(FightWorkDelayTimer, 0.1)
			slot5:registWork(FightWorkRecordDouQuQuData)
			slot5:registWork(FightWorkDouQuQuClear)
		end

		slot5:registWork(FightWorkDouQuQuEnd)
		slot5:start()
	else
		slot4 = {}

		for slot8, slot9 in ipairs(slot2.playIndexTab) do
			table.insert(slot4, slot9)
		end

		slot0._douQuQuFlow = slot0:com_registFlowSequence()
		slot5 = slot0._douQuQuFlow

		for slot9, slot10 in ipairs(slot4) do
			slot5:registWork(FightWorkDouQuQuEnter, slot10, slot9 ~= 1 or slot1)
			slot5:registWork(FightWorkDouQuQuRound)
			slot5:registWork(FightWorkDelayTimer, 0.1)
			slot5:registWork(FightWorkRecordDouQuQuData)
			slot5:registWork(FightWorkDouQuQuClear)
			slot5:registWork(FightWorkDouQuQuStat)
		end

		slot5:registWork(FightWorkDouQuQuEnd)
		slot5:start()
	end
end

function slot0._onGMDouQuQuSkip2IndexRound(slot0, slot1, slot2)
	if slot0._douQuQuFlow then
		slot0._douQuQuFlow:disposeSelf()
	end

	slot3 = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.ChapterId].value)
	slot4 = DungeonConfig.instance:getChapterEpisodeCOList(slot3)
	slot5 = slot4[math.random(1, #slot4)]

	FightMgr.instance:playGMDouQuQuStart(slot3, slot5.id, slot5.battleId, slot1, slot2)
end

function slot0.onDestructor(slot0)
end

return slot0

module("modules.logic.versionactivity2_5.autochess.flow.AutoChessSkillWork", package.seeall)

slot0 = class("AutoChessSkillWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.step = slot1
end

function slot0.onStart(slot0, slot1)
	if not (AutoChessEntityMgr.instance:tryGetEntity(slot0.step.fromId) or slot2:getLeaderEntity(slot0.step.fromId)) then
		slot0:finishWork()

		return
	end

	slot4 = nil
	slot5 = 0
	slot6 = 0

	if (not slot3.warZone or lua_auto_chess_skill.configDict[tonumber(slot0.step.reasonId)]) and lua_auto_chess_master_skill.configDict[tonumber(slot0.step.reasonId)] then
		if not string.nilorempty(slot4.skillaction) then
			slot5 = slot3:skillAnim(slot4.skillaction)
		end

		if slot4.useeffect ~= 0 then
			slot7 = lua_auto_chess_effect.configDict[slot4.useeffect]
			slot6 = slot7.duration

			slot3.effectComp:playEffect(slot7.id)
		end
	end

	if math.max(slot5, slot6) == 0 then
		slot0:finishWork()
	else
		TaskDispatcher.runDelay(slot0.finishWork, slot0, slot5)
	end
end

function slot0.onStop(slot0)
	TaskDispatcher.cancelTask(slot0.finishWork, slot0)
end

function slot0.onResume(slot0)
	slot0:finishWork()
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0.finishWork, slot0)

	slot0.effect = nil
end

function slot0.finishWork(slot0)
	slot0:onDone(true)
end

return slot0

module("modules.logic.fight.mgr.FightEntrustedWorkMgr", package.seeall)

slot0 = class("FightEntrustedWorkMgr", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0._workList = {}

	slot0:com_registMsg(FightMsgId.EntrustFightWork, slot0._onEntrustFightWork)
	slot0:com_registFightEvent(FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish)
end

function slot0._onEntrustFightWork(slot0, slot1)
	table.insert(slot0._workList, slot1)
	slot0:com_replyMsg(FightMsgId.EntrustFightWork, true)
end

function slot0._onRoundSequenceFinish(slot0)
	for slot4 = #slot0._workList, 1, -1 do
		if slot0._workList[slot4].IS_DISPOSED then
			table.remove(slot0._workList, slot4)
		end
	end
end

function slot0.onDestructor(slot0)
	for slot4 = #slot0._workList, 1, -1 do
		slot5 = slot0._workList[slot4]
		slot5.FIGHT_WORK_ENTRUSTED = nil

		slot5:disposeSelf()
	end
end

return slot0

module("modules.logic.fight.system.work.FightWorkPlayerFinisherSkillChange", package.seeall)

slot0 = class("FightWorkPlayerFinisherSkillChange", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendMsg(FightMsgId.RefreshPlayerFinisherSkill)
	slot0:onDone(true)
end

return slot0

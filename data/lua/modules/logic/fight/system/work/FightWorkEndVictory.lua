module("modules.logic.fight.system.work.FightWorkEndVictory", package.seeall)

slot0 = class("FightWorkEndVictory", BaseWork)

function slot0.onStart(slot0)
	for slot5, slot6 in ipairs(FightHelper.getAllEntitys()) do
		if slot6.nameUI then
			slot6.nameUI:setActive(false)
		end
	end

	slot0:onDone(true)
end

return slot0

module("modules.logic.fight.system.work.FightWorkEndLose", package.seeall)

slot0 = class("FightWorkEndLose", BaseWork)

function slot0.onStart(slot0)
	for slot5, slot6 in ipairs(FightHelper.getAllEntitys()) do
		if slot6.nameUI then
			slot6.nameUI:setActive(false)
		end
	end

	slot0:onDone(true)
end

return slot0

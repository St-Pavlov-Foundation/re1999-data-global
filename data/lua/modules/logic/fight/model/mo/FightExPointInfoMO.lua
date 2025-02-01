module("modules.logic.fight.model.mo.FightExPointInfoMO", package.seeall)

slot0 = pureTable("FightExPointInfoMO")

function slot0.init(slot0, slot1)
	slot0.uid = slot1.uid
	slot0.exPoint = slot1.exPoint
	slot0.powerInfos = slot1.powerInfos

	if slot1.HasField then
		if slot1:HasField("currentHp") then
			slot0.currentHp = slot1.currentHp
		end
	else
		slot0.currentHp = slot1.currentHp
	end
end

return slot0

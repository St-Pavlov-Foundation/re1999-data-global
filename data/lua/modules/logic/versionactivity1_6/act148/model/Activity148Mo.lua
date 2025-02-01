module("modules.logic.versionactivity1_6.act148.model.Activity148Mo", package.seeall)

slot0 = pureTable("Activity148Mo")

function slot0.init(slot0, slot1, slot2)
	slot0._lv = slot2
	slot0._type = slot1
end

function slot0.getLevel(slot0)
	return slot0._lv
end

function slot0.updateByServerData(slot0, slot1)
	slot0._lv = slot1.level
end

return slot0

module("modules.logic.versionactivity1_6.act149.model.Activity149Mo", package.seeall)

slot0 = class("Activity149Mo")

function slot0.ctor(slot0, slot1, slot2)
	slot0.id = slot1
	slot0._activityId = slot2
	slot0.cfg = slot0:getAct149EpisodeCfg(slot1)
end

function slot0.getAct149EpisodeCfg(slot0, slot1)
	return Activity149Config.instance:getAct149EpisodeCfg(slot1)
end

return slot0

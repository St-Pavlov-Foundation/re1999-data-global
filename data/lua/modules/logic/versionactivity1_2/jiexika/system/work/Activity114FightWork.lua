module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114FightWork", package.seeall)

slot0 = class("Activity114FightWork", Activity114BaseWork)

function slot0.onStart(slot0, slot1)
	ViewMgr.instance:closeView(ViewName.Activity114EmptyView, true, true)
	Activity114Controller.instance:enterActivityFight(Activity114Config.instance:getEventCoById(Activity114Model.instance.id, slot0.context.eventId).config.battleId)
	slot0:onDone(true)
end

return slot0

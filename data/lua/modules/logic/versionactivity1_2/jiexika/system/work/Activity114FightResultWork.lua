module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114FightResultWork", package.seeall)

slot0 = class("Activity114FightResultWork", Activity114BaseWork)

function slot0.onStart(slot0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnFightResult, slot0.onFightResult, slot0)
end

function slot0.onFightResult(slot0, slot1)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnFightResult, slot0.onFightResult, slot0)

	slot0.context.result = slot1

	if slot0.context.type == Activity114Enum.EventType.KeyDay then
		slot0.context.storyId = slot1 == Activity114Enum.Result.Success and slot0.context.eventCo.config.successStoryId or slot0.context.eventCo.config.failureStoryId
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnFightResult, slot0.onFightResult, slot0)
	uv0.super.clearWork(slot0)
end

return slot0

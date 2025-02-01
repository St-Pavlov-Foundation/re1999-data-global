module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114OpenTransitionViewWork", package.seeall)

slot0 = class("Activity114OpenTransitionViewWork", Activity114OpenViewWork)

function slot0.ctor(slot0, slot1)
	slot0._transitionId = slot1
end

function slot0.getTransitionId(slot0)
	return slot0._transitionId
end

function slot0.onStart(slot0, slot1)
	if not slot0:getTransitionId() then
		slot0:onDone(true)

		return
	end

	slot0.context.transitionId = slot2
	slot3, slot4 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, slot0.context.transitionId)

	if string.nilorempty(slot4) then
		slot0.context.transitionId = nil

		slot0:onDone(true)

		return
	end

	slot0._viewName = ViewName.Activity114TransitionView

	uv0.super.onStart(slot0, slot1)
end

return slot0

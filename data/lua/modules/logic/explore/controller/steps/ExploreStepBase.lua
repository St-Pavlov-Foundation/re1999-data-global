module("modules.logic.explore.controller.steps.ExploreStepBase", package.seeall)

slot0 = class("ExploreStepBase")

function slot0.ctor(slot0, slot1)
	slot0._data = slot1

	slot0:onInit()
end

function slot0.onInit(slot0)
end

function slot0.onStart(slot0)
	slot0:onDone()
end

function slot0.onDone(slot0)
	slot0:onDestory()

	return ExploreStepController.instance:onStepEnd()
end

function slot0.onDestory(slot0)
	slot0._data = nil
end

return slot0

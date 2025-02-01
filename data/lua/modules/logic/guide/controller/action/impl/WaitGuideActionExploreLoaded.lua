module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreLoaded", package.seeall)

slot0 = class("WaitGuideActionExploreLoaded", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	if ExploreModel.instance.isRoleInitDone and not slot0:_checkIsNoDone() then
		return
	end

	ExploreController.instance:registerCallback(ExploreEvent.HeroResInitDone, slot0.onHeroInitDone, slot0)
end

function slot0.onHeroInitDone(slot0)
	if not slot0:_checkIsNoDone() then
		return
	end

	ExploreController.instance:unregisterCallback(ExploreEvent.HeroResInitDone, slot0.onHeroInitDone, slot0)
end

function slot0._checkIsNoDone(slot0)
	if not string.nilorempty(slot0.actionParam) and ExploreModel.instance:getMapId() ~= tonumber(slot0.actionParam) then
		return true
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroResInitDone, slot0.onHeroInitDone, slot0)
end

return slot0

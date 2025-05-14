module("modules.logic.explore.controller.trigger.ExploreTriggerGuide", package.seeall)

local var_0_0 = class("ExploreTriggerGuide", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1)
	arg_1_0._guideId = tonumber(arg_1_1)

	local var_1_0 = GuideModel.instance:getById(arg_1_0._guideId)

	if var_1_0 and var_1_0.isFinish or not var_1_0 then
		if not var_1_0 then
			logError("指引没有接？？？")
		end

		arg_1_0:onDone(true)

		return
	end

	local var_1_1 = ExploreController.instance:getMap():getHero()

	if var_1_1:isMoving() then
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Guide)
		ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, arg_1_0.beginGuide, arg_1_0)
		var_1_1:stopMoving()
	else
		arg_1_0:beginGuide()
	end
end

function var_0_0.beginGuide(arg_2_0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Guide)
	ExploreController.instance:dispatchEvent(ExploreEvent.ExploreTriggerGuide, arg_2_0._guideId)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, arg_3_0.beginGuide, arg_3_0)
end

return var_0_0

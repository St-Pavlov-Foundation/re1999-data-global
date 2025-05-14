module("modules.logic.explore.controller.steps.ExploreSpikeStep", package.seeall)

local var_0_0 = class("ExploreSpikeStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data.triggerInteractId
	local var_1_1 = ExploreController.instance:getMap():getUnit(var_1_0)

	GameSceneMgr.instance:getCurScene().stat:onTriggerSpike(var_1_0)
	ExploreModel.instance:addChallengeCount()

	if not var_1_1 or var_1_1:getUnitType() ~= ExploreEnum.ItemType.Spike then
		arg_1_0:onDone()

		return
	end

	ViewMgr.instance:closeView(ViewName.ExploreEnterView)
	ExploreMapModel.instance:updatHeroPos(arg_1_0._data.x, arg_1_0._data.y, 0)
	ExploreHeroFallAnimFlow.instance:begin(arg_1_0._data, var_1_0)
	arg_1_0:onDone()
end

return var_0_0

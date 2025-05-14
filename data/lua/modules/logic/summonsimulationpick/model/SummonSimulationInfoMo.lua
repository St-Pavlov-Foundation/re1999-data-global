module("modules.logic.summonsimulationpick.model.SummonSimulationInfoMo", package.seeall)

local var_0_0 = pureTable("SummonSimulationInfoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.activityId = 0
	arg_1_0.leftTimes = 0
	arg_1_0.saveHeroIds = {}
	arg_1_0.currentHeroIds = {}
	arg_1_0.isSelect = false
	arg_1_0.saveIndex = 0
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.activityId = arg_2_1.activityId
	arg_2_0.leftTimes = arg_2_1.leftTimes
	arg_2_0.saveHeroIds = arg_2_1.savedHeroIds
	arg_2_0.currentHeroIds = arg_2_1.currHeroIds
	arg_2_0.isSelect = arg_2_1.isSelect

	local var_2_0 = SummonSimulationPickModel.instance:getActivityMaxSummonCount(arg_2_0.activityId)

	arg_2_0.maxCount = var_2_0

	local var_2_1 = arg_2_2 and 0 or 1

	arg_2_0.saveIndex = math.max(0, var_2_0 - arg_2_1.leftTimes - var_2_1)

	SummonModel.sortResultByHeroIds(arg_2_0.currentHeroIds)
	SummonModel.sortResultByHeroIds(arg_2_0.saveHeroIds)
end

function var_0_0.haveSaveCurrent(arg_3_0)
	return arg_3_0.saveIndex == arg_3_0.maxCount - arg_3_0.leftTimes or arg_3_0.saveIndex == 0 or #arg_3_0.currentHeroIds <= 0
end

function var_0_0.haveSelect(arg_4_0)
	if arg_4_0.leftTimes == arg_4_0.maxCount - 1 then
		return true
	elseif arg_4_0.leftTimes == 0 then
		return false
	else
		return arg_4_0:haveSaveCurrent()
	end
end

return var_0_0

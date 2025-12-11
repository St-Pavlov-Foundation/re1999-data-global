module("modules.logic.necrologiststory.model.NecrologistStoryModel", package.seeall)

local var_0_0 = class("NecrologistStoryModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.storyGroupClientMos = {}
	arg_1_0._curStoryGroupId = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.storyGroupClientMos = {}
	arg_2_0._curStoryGroupId = nil
end

function var_0_0.getCurStoryMO(arg_3_0)
	return arg_3_0:getStoryMO(arg_3_0._curStoryGroupId)
end

function var_0_0.getStoryMO(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = arg_4_0.storyGroupClientMos[arg_4_1]

	if not var_4_0 then
		var_4_0 = NecrologistStoryMO.New()

		var_4_0:init(arg_4_1)

		arg_4_0.storyGroupClientMos[arg_4_1] = var_4_0
	end

	arg_4_0._curStoryGroupId = arg_4_1

	return var_4_0
end

function var_0_0.getGameMO(arg_5_0, arg_5_1)
	return arg_5_0:getMOById(arg_5_1)
end

function var_0_0.getMOById(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getById(arg_6_1)

	if not var_6_0 then
		local var_6_1 = NecrologistStoryEnum.RoleStoryId2MOCls[arg_6_1]

		var_6_0 = (_G[var_6_1] or NecrologistStoryGameBaseMO).New()

		var_6_0:init(arg_6_1)
		arg_6_0:addAtLast(var_6_0)
	end

	return var_6_0
end

function var_0_0.updateStoryInfos(arg_7_0, arg_7_1)
	for iter_7_0 = 1, #arg_7_1 do
		arg_7_0:updateStoryInfo(arg_7_1[iter_7_0])
	end
end

function var_0_0.updateStoryInfo(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.storyId
	local var_8_1 = arg_8_0:getMOById(var_8_0)

	if not var_8_1 then
		return
	end

	var_8_1:updateInfo(arg_8_1)
end

function var_0_0.saveGameData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0:getById(arg_9_1)

	if not var_9_0 then
		return
	end

	var_9_0:saveData(arg_9_2, arg_9_3)
end

function var_0_0.isReviewCanShow(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getGameMO(arg_10_1)

	if not var_10_0 then
		return false
	end

	local var_10_1 = NecrologistStoryConfig.instance:getPlotListByStoryId(arg_10_1)
	local var_10_2 = false

	if var_10_1 then
		for iter_10_0, iter_10_1 in ipairs(var_10_1) do
			if var_10_0:isStoryFinish(iter_10_1.id) then
				var_10_2 = true

				break
			end
		end
	end

	return var_10_2
end

var_0_0.instance = var_0_0.New()

return var_0_0

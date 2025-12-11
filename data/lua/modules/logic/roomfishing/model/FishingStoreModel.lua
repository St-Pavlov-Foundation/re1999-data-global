module("modules.logic.roomfishing.model.FishingStoreModel", package.seeall)

local var_0_0 = class("FishingStoreModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.getStoreGroupMO(arg_3_0)
	return (StoreModel.instance:getStoreMO(StoreEnum.StoreId.RoomFishingStore))
end

function var_0_0.checkUpdateStoreActivity(arg_4_0)
	local var_4_0
	local var_4_1 = arg_4_0:getStoreGroupMO()
	local var_4_2 = var_4_1 and var_4_1:getGoodsList() or {}

	for iter_4_0, iter_4_1 in pairs(var_4_2) do
		local var_4_3 = iter_4_1.config.activityId

		if not var_4_0 then
			if var_4_3 ~= 0 then
				var_4_0 = var_4_3
			end
		elseif var_4_0 ~= var_4_3 then
			logError(string.format("FishingStoreModel.checkUpdateStoreActivity error, actId inconsistent：%s", var_4_3))

			return var_4_3
		end
	end

	return var_4_0
end

var_0_0.instance = var_0_0.New()

return var_0_0

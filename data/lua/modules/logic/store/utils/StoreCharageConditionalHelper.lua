local var_0_0 = {}

var_0_0._conditionFunction = nil

function var_0_0._getFuncDict()
	if not var_0_0._conditionFunction then
		var_0_0._conditionFunction = {
			HasHero = function(arg_2_0, arg_2_1)
				local var_2_0
				local var_2_1 = arg_2_1 and arg_2_1.maxProgress or 1

				if arg_2_1 and not string.nilorempty(arg_2_1.listenerParam) then
					var_2_0 = string.splitToNumber(arg_2_1.listenerParam, "#")
				end

				if var_2_0 then
					local var_2_2 = 0

					for iter_2_0, iter_2_1 in ipairs(var_2_0) do
						local var_2_3 = HeroModel.instance:getByHeroId(iter_2_1)

						if var_2_3 and var_2_3:isOwnHero() then
							var_2_2 = var_2_2 + 1
						end

						if var_2_1 <= var_2_2 then
							return true
						end
					end
				end

				return false
			end
		}
	end

	return var_0_0._conditionFunction
end

function var_0_0.isCharageCondition(arg_3_0)
	local var_3_0 = StoreConfig.instance:findChargeConditionalConfigByGoodsId(arg_3_0)

	if var_3_0 then
		local var_3_1 = var_3_0.listenerType
		local var_3_2 = var_0_0._getFuncDict()[var_3_1]

		if var_3_2 then
			return var_3_2(arg_3_0, var_3_0)
		else
			logError(string.format("goodsId:%s taskid:%s can not find linstnerType function", arg_3_0, var_3_0.goodsId))
		end

		return false
	end

	return true
end

function var_0_0.isCharageTaskFinish(arg_4_0)
	local var_4_0 = StoreConfig.instance:getChargeGoodsConfig(arg_4_0, true)

	if var_4_0 and var_4_0.taskid ~= 0 then
		local var_4_1 = TaskModel.instance:getTaskById(tonumber(var_4_0.taskid))

		if var_4_1 and var_4_1:isFinished() and var_4_1:isClaimed() then
			return true
		end
	end

	return false
end

function var_0_0.isCharageTaskNotFinish(arg_5_0)
	local var_5_0 = StoreConfig.instance:getChargeGoodsConfig(arg_5_0, true)

	if var_5_0 and var_5_0.taskid ~= 0 then
		local var_5_1 = TaskModel.instance:getTaskById(tonumber(var_5_0.taskid))

		if not var_5_1 or not var_5_1:isFinished() or not var_5_1:isClaimed() then
			return true
		end
	end

	return false
end

function var_0_0.isHasCanFinishGoodsTask(arg_6_0)
	local var_6_0 = StoreModel.instance:getGoodsMO(arg_6_0)

	if var_6_0 and var_6_0.buyCount > 0 and var_0_0.isCharageTaskNotFinish(arg_6_0) and var_0_0.isCharageCondition(arg_6_0) then
		return true
	end

	return false
end

return var_0_0

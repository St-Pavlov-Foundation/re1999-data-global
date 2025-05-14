module("modules.logic.battlepass.model.BpTaskModel", package.seeall)

local var_0_0 = class("BpTaskModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.serverTaskModel = BaseModel.New()
	arg_1_0.showQuickFinishTask = false
	arg_1_0.haveTurnBackTask = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.haveTurnBackTask = false
	arg_2_0.showQuickFinishTask = false

	arg_2_0.serverTaskModel:clear()
end

function var_0_0.onGetInfo(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_1 = BpConfig.instance:getTaskCO(iter_3_1.id)

		if var_3_1 then
			local var_3_2 = TaskMo.New()

			var_3_2:init(iter_3_1, var_3_1)
			table.insert(var_3_0, var_3_2)
		else
			logError("Bp task config not find:" .. tostring(iter_3_1.id))
		end
	end

	arg_3_0.serverTaskModel:setList(var_3_0)
	arg_3_0:sortList()
	arg_3_0:_checkRedDot()
end

function var_0_0.sortList(arg_4_0)
	arg_4_0.serverTaskModel:sort(function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_0.finishCount > 0 and 3 or arg_5_0.progress >= arg_5_0.config.maxProgress and 1 or 2
		local var_5_1 = arg_5_1.finishCount > 0 and 3 or arg_5_1.progress >= arg_5_1.config.maxProgress and 1 or 2

		if var_5_0 ~= var_5_1 then
			return var_5_0 < var_5_1
		else
			if arg_5_0.config.sortId ~= arg_5_1.config.sortId then
				return arg_5_0.config.sortId < arg_5_1.config.sortId
			end

			return arg_5_0.config.id < arg_5_1.config.id
		end
	end)
	arg_4_0:onModelUpdate()
end

function var_0_0._checkRedDot(arg_6_0)
	local var_6_0 = BpModel.instance:isWeeklyScoreFull()
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.serverTaskModel:getList()) do
		if iter_6_1.config.bpId == BpModel.instance.id then
			if iter_6_1.progress >= iter_6_1.config.maxProgress and iter_6_1.finishCount == 0 then
				local var_6_2 = iter_6_1.config.loopType

				if var_6_2 == 5 then
					var_6_2 = 3
				end

				if not var_6_0 or var_6_0 and var_6_2 == 3 then
					var_6_1 = var_6_1 + 1
				end
			end

			if iter_6_1.config.turnbackTask then
				arg_6_0.haveTurnBackTask = true
			end
		end
	end

	arg_6_0.showQuickFinishTask = var_6_1 >= 1
end

function var_0_0.getHaveRedDot(arg_7_0, arg_7_1)
	if arg_7_1 == 3 then
		return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BattlePassTask, 3) or RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BattlePassTask, 5)
	else
		return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BattlePassTask, arg_7_1)
	end
end

function var_0_0.updateInfo(arg_8_0, arg_8_1)
	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if iter_8_1.type == TaskEnum.TaskType.BattlePass then
			local var_8_1 = arg_8_0.serverTaskModel:getById(iter_8_1.id)

			if var_8_1 then
				var_8_1:update(iter_8_1)
			else
				local var_8_2 = BpConfig.instance:getTaskCO(iter_8_1.id)

				if var_8_2 then
					local var_8_3 = TaskMo.New()

					var_8_3:init(iter_8_1, var_8_2)
					arg_8_0.serverTaskModel:addAtLast(var_8_3)
				else
					logError("Bp task config not find:" .. tostring(iter_8_1.id))
				end
			end

			var_8_0 = true
		end
	end

	if var_8_0 then
		arg_8_0:sortList()
		arg_8_0:_checkRedDot()
	end

	return var_8_0
end

function var_0_0.deleteInfo(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		local var_9_1 = arg_9_0.serverTaskModel:getById(iter_9_1)

		if var_9_1 then
			var_9_0[iter_9_1] = var_9_1
		end
	end

	for iter_9_2, iter_9_3 in pairs(var_9_0) do
		arg_9_0.serverTaskModel:remove(iter_9_3)
	end

	local var_9_2 = next(var_9_0) and true or false

	if var_9_2 then
		arg_9_0:sortList()
		arg_9_0:_checkRedDot()
	end

	return var_9_2
end

function var_0_0.refreshListView(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = arg_10_0.serverTaskModel:getList()

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_2 = iter_10_1.config.loopType

		if var_10_2 == 5 then
			var_10_2 = 3
		end

		if iter_10_1.config.bpId == BpModel.instance.id and var_10_2 == arg_10_1 then
			local var_10_3 = BpConfig.instance.taskPreposeIds
			local var_10_4 = true

			if var_10_3[iter_10_1.config.id] then
				for iter_10_2 in pairs(var_10_3[iter_10_1.config.id]) do
					local var_10_5 = arg_10_0.serverTaskModel:getById(iter_10_2)

					if var_10_5 and var_10_5.finishCount == 0 then
						var_10_4 = false

						break
					end
				end
			end

			if var_10_4 then
				table.insert(var_10_0, iter_10_1)
			end
		end
	end

	arg_10_0:setList(var_10_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0

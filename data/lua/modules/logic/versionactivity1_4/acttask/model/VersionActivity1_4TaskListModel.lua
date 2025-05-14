module("modules.logic.versionactivity1_4.acttask.model.VersionActivity1_4TaskListModel", package.seeall)

local var_0_0 = class("VersionActivity1_4TaskListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.sortTaskMoList(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.actId = arg_3_1

	local var_3_0 = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, arg_3_1)
	local var_3_1 = {}
	local var_3_2 = {}
	local var_3_3 = {}

	arg_3_0.allTaskFinish = true

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if iter_3_1.config.page == arg_3_2 then
			local var_3_4 = true

			if not string.nilorempty(iter_3_1.config.prepose) then
				local var_3_5 = string.split(iter_3_1.config.prepose, "#")

				for iter_3_2, iter_3_3 in ipairs(var_3_5) do
					if not TaskModel.instance:isTaskFinish(iter_3_1.type, tonumber(iter_3_3)) then
						var_3_4 = false

						break
					end
				end
			end

			if var_3_4 then
				if iter_3_1.finishCount >= iter_3_1.config.maxFinishCount then
					table.insert(var_3_3, iter_3_1)
				elseif iter_3_1.hasFinished then
					table.insert(var_3_1, iter_3_1)
				else
					table.insert(var_3_2, iter_3_1)
				end
			end
		end

		if iter_3_1.finishCount < iter_3_1.config.maxFinishCount then
			arg_3_0.allTaskFinish = false
		end
	end

	table.sort(var_3_1, var_0_0._sortFunc)
	table.sort(var_3_2, var_0_0._sortFunc)
	table.sort(var_3_3, var_0_0._sortFunc)

	arg_3_0.taskMoList = {}

	tabletool.addValues(arg_3_0.taskMoList, var_3_1)
	tabletool.addValues(arg_3_0.taskMoList, var_3_2)
	tabletool.addValues(arg_3_0.taskMoList, var_3_3)
	arg_3_0:refreshList()
end

function var_0_0.checkTaskRedByPage(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.ActivityDungeon, arg_4_1)

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1.config.page == arg_4_2 then
			local var_4_1 = true

			if not string.nilorempty(iter_4_1.config.prepose) then
				local var_4_2 = string.split(iter_4_1.config.prepose, "#")

				for iter_4_2, iter_4_3 in ipairs(var_4_2) do
					if not TaskModel.instance:isTaskFinish(iter_4_1.type, tonumber(iter_4_3)) then
						var_4_1 = false

						break
					end
				end
			end

			if var_4_1 and iter_4_1.finishCount < iter_4_1.config.maxFinishCount and iter_4_1.hasFinished then
				return true
			end
		end
	end

	return false
end

function var_0_0._sortFunc(arg_5_0, arg_5_1)
	return arg_5_0.id < arg_5_1.id
end

function var_0_0.refreshList(arg_6_0)
	if arg_6_0:getFinishTaskCount() > 1 then
		local var_6_0 = tabletool.copy(arg_6_0.taskMoList)

		table.insert(var_6_0, 1, {
			getAll = true
		})
		arg_6_0:setList(var_6_0)
	else
		arg_6_0:setList(arg_6_0.taskMoList)
	end
end

function var_0_0.getFinishTaskCount(arg_7_0)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.taskMoList) do
		if iter_7_1.hasFinished and iter_7_1.finishCount < iter_7_1.config.maxFinishCount then
			var_7_0 = var_7_0 + 1
		end
	end

	return var_7_0
end

function var_0_0.getFinishTaskActivityCount(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.taskMoList) do
		if iter_8_1.hasFinished and iter_8_1.finishCount < iter_8_1.config.maxFinishCount then
			var_8_0 = var_8_0 + iter_8_1.config.activity
		end
	end

	return var_8_0
end

function var_0_0.getGetRewardTaskCount(arg_9_0)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.taskMoList) do
		if iter_9_1.finishCount >= iter_9_1.config.maxFinishCount then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function var_0_0.getKeyRewardMo(arg_10_0)
	return
end

function var_0_0.getActId(arg_11_0)
	return arg_11_0.actId
end

var_0_0.instance = var_0_0.New()

return var_0_0

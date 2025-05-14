module("modules.common.others.UICloneComponent", package.seeall)

local var_0_0 = class("UICloneComponent", UserDataDispose)

function var_0_0.ctor(arg_1_0)
	arg_1_0:__onInit()

	arg_1_0.create_data = arg_1_0:getUserDataTb_()
end

function var_0_0.createObjList(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8)
	if type(arg_2_3) == "number" then
		local var_2_0 = arg_2_3

		arg_2_3 = {}

		for iter_2_0 = 1, var_2_0 do
			table.insert(arg_2_3, iter_2_0)
		end
	end

	if not arg_2_4 then
		logError("没有传入格子父节点")

		return
	end

	if not arg_2_5 then
		logError("没有传入格子模型")

		return
	end

	if arg_2_7 then
		local var_2_1 = arg_2_0:getUserDataTb_()

		var_2_1.total_num = #arg_2_3
		var_2_1.delay_time = arg_2_7 or 0.01
		var_2_1.create_count = arg_2_8 or 1
		var_2_1.cur_count = 0
		var_2_1.class = arg_2_1
		var_2_1.callback = arg_2_2
		var_2_1.data = arg_2_3
		var_2_1.parent_obj = arg_2_4
		var_2_1.model_obj = arg_2_5
		var_2_1.component = arg_2_6
		var_2_1.start_time = Time.realtimeSinceStartup

		table.insert(arg_2_0.create_data, var_2_1)
		TaskDispatcher.runRepeat(arg_2_0._detectCloneState, arg_2_0, 0.01)
	else
		gohelper.CreateObjList(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	end
end

function var_0_0._detectCloneState(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.create_data) do
		if Time.realtimeSinceStartup - iter_3_1.start_time >= iter_3_1.delay_time then
			iter_3_1.start_time = Time.realtimeSinceStartup

			if iter_3_1.cur_count < iter_3_1.total_num then
				local var_3_0 = iter_3_1.cur_count + 1

				iter_3_1.cur_count = iter_3_1.cur_count + iter_3_1.create_count

				if iter_3_1.cur_count > iter_3_1.total_num then
					iter_3_1.cur_count = iter_3_1.total_num
				end

				local var_3_1 = iter_3_1.cur_count

				gohelper.CreateObjList(iter_3_1.class, iter_3_1.callback, iter_3_1.data, iter_3_1.parent_obj, iter_3_1.model_obj, iter_3_1.component, var_3_0, var_3_1)
			end
		end
	end

	for iter_3_2 = #arg_3_0.create_data, 1, -1 do
		local var_3_2 = arg_3_0.create_data[iter_3_2]

		if var_3_2.cur_count >= var_3_2.total_num then
			table.remove(arg_3_0.create_data, iter_3_2)
		end
	end

	if #arg_3_0.create_data == 0 then
		TaskDispatcher.cancelTask(arg_3_0._detectCloneState, arg_3_0)
	end
end

function var_0_0.releaseSelf(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._detectCloneState, arg_4_0)
	arg_4_0:__onDispose()
end

return var_0_0

module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianInteractMgr", package.seeall)

local var_0_0 = class("YaXianInteractMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._list = {}
	arg_1_0._dict = {}
end

function var_0_0.add(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.id

	arg_2_0:remove(var_2_0)

	arg_2_0._dict[var_2_0] = arg_2_1

	table.insert(arg_2_0._list, arg_2_1)
end

function var_0_0.remove(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._dict[arg_3_1]

	if var_3_0 then
		arg_3_0._dict[arg_3_1] = nil

		for iter_3_0, iter_3_1 in ipairs(arg_3_0._list) do
			if iter_3_1 == var_3_0 then
				table.remove(arg_3_0._list, iter_3_0)
				iter_3_1:dispose()

				return true
			end
		end
	end

	return false
end

function var_0_0.getList(arg_4_0)
	return arg_4_0._list
end

function var_0_0.get(arg_5_0, arg_5_1)
	if arg_5_0._dict then
		return arg_5_0._dict[arg_5_1]
	end

	return nil
end

function var_0_0.removeAll(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._list) do
		iter_6_1:dispose()
	end

	arg_6_0._list = {}
	arg_6_0._dict = {}
end

function var_0_0.dispose(arg_7_0)
	if arg_7_0._list then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._list) do
			iter_7_1:dispose()
		end

		arg_7_0._list = nil
		arg_7_0._dict = nil
	end
end

return var_0_0

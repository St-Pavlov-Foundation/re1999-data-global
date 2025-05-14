module("modules.logic.versionactivity1_3.va3chess.game.Va3ChessInteractMgr", package.seeall)

local var_0_0 = class("Va3ChessInteractMgr")

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

function var_0_0.getMainPlayer(arg_6_0, arg_6_1)
	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._list) do
		if iter_6_1.objType == Va3ChessEnum.InteractType.Player then
			return iter_6_1
		elseif arg_6_1 and iter_6_1.objType == Va3ChessEnum.InteractType.AssistPlayer then
			var_6_0 = var_6_0 or iter_6_1
		end
	end

	return var_6_0
end

function var_0_0.removeAll(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._list) do
		iter_7_1:dispose()
	end

	arg_7_0._list = {}
	arg_7_0._dict = {}
end

function var_0_0.sortRenderOrder(arg_8_0, arg_8_1)
	if arg_8_0.config and arg_8_1.config then
		local var_8_0 = Va3ChessEnum.Res2SortOrder[arg_8_0.config.avatar] or 0
		local var_8_1 = Va3ChessEnum.Res2SortOrder[arg_8_1.config.avatar] or 0

		if var_8_0 ~= var_8_1 then
			return var_8_0 < var_8_1
		end
	end

	return arg_8_0.id < arg_8_1.id
end

function var_0_0.getRenderOrder(arg_9_0)
	if arg_9_0.config then
		return Va3ChessEnum.Res2SortOrder[arg_9_0.config.avatar] or 0
	end

	return 0
end

function var_0_0.dispose(arg_10_0)
	if arg_10_0._list then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._list) do
			iter_10_1:dispose()
		end

		arg_10_0._list = nil
		arg_10_0._dict = nil
	end
end

return var_0_0

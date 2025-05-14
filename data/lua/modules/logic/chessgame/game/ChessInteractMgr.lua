module("modules.logic.chessgame.game.ChessInteractMgr", package.seeall)

local var_0_0 = class("ChessInteractMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._list = {}
	arg_1_0._dict = {}
	arg_1_0._showList = {}
end

function var_0_0.add(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.id

	arg_2_0:remove(var_2_0)

	arg_2_0._dict[var_2_0] = arg_2_1

	table.insert(arg_2_0._list, arg_2_1)

	if arg_2_1:isShow() and arg_2_1:checkHaveAvatarPath() then
		table.insert(arg_2_0._showList, arg_2_1)
	end
end

function var_0_0.remove(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._dict[arg_3_1]

	if var_3_0 then
		arg_3_0._dict[arg_3_1] = nil

		for iter_3_0, iter_3_1 in ipairs(arg_3_0._list) do
			if iter_3_1 == var_3_0 then
				table.remove(arg_3_0._list, iter_3_0)
				table.remove(arg_3_0._showList, iter_3_0)
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

function var_0_0.hideCompById(arg_6_0, arg_6_1)
	if arg_6_0._dict and arg_6_0._dict[arg_6_1] then
		arg_6_0._dict[arg_6_1]:hideSelf()
	end
end

function var_0_0.getMainPlayer(arg_7_0)
	local var_7_0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._list) do
		if iter_7_1.objType == ChessGameEnum.InteractType.Role then
			return iter_7_1
		end
	end

	return var_7_0
end

function var_0_0.removeAll(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._list) do
		iter_8_1:dispose()
	end

	arg_8_0._list = {}
	arg_8_0._dict = {}
	arg_8_0._showList = {}
end

function var_0_0.checkCompleletedLoaded(arg_9_0, arg_9_1)
	arg_9_0._checkDict = arg_9_0._checkDict or {}

	table.insert(arg_9_0._checkDict, arg_9_1)

	if #arg_9_0._checkDict == #arg_9_0._showList then
		arg_9_0:_onAllInteractLoadCompleleted()
	end
end

function var_0_0._onAllInteractLoadCompleleted(arg_10_0)
	arg_10_0._checkDict = nil

	local var_10_0 = arg_10_0:getMainPlayer()

	if var_10_0 then
		var_10_0:getHandler():calCanWalkArea()
	end
end

function var_0_0.dispose(arg_11_0)
	if arg_11_0._list then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0._list) do
			iter_11_1:dispose()
		end

		arg_11_0._list = nil
		arg_11_0._dict = nil
	end
end

return var_0_0

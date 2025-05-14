module("modules.logic.social.model.SocialListModel", package.seeall)

local var_0_0 = class("SocialListModel")

function var_0_0.ctor(arg_1_0)
	arg_1_0._models = {}
end

function var_0_0.reInit(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0._models) do
		iter_2_1:clear()
	end
end

function var_0_0.getModel(arg_3_0, arg_3_1)
	if not arg_3_0._models[arg_3_1] then
		arg_3_0._models[arg_3_1] = ListScrollModel.New()
	end

	return arg_3_0._models[arg_3_1]
end

function var_0_0.setModelList(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:getModel(arg_4_1)
	local var_4_1 = {}

	if arg_4_2 then
		for iter_4_0, iter_4_1 in pairs(arg_4_2) do
			table.insert(var_4_1, iter_4_1)
		end
	end

	if arg_4_1 == SocialEnum.Type.Friend then
		table.sort(var_4_1, var_0_0.sortFriend)
	else
		table.sort(var_4_1, var_0_0.sort)
	end

	var_4_0:setList(var_4_1)
end

function var_0_0.sortFriendList(arg_5_0)
	arg_5_0:getModel(SocialEnum.Type.Friend):sort(var_0_0.sortFriend)
end

function var_0_0.sortFriend(arg_6_0, arg_6_1)
	local var_6_0 = SocialMessageModel.instance:getUnReadLastMsgTime(arg_6_0.userId)
	local var_6_1 = SocialMessageModel.instance:getUnReadLastMsgTime(arg_6_1.userId)

	if var_6_0 ~= 0 and var_6_1 ~= 0 then
		return var_6_1 < var_6_0
	elseif var_6_0 ~= 0 or var_6_1 ~= 0 then
		return var_6_0 ~= 0
	else
		return var_0_0.sort(arg_6_0, arg_6_1)
	end
end

function var_0_0.sort(arg_7_0, arg_7_1)
	local var_7_0 = tonumber(arg_7_0.time)
	local var_7_1 = tonumber(arg_7_1.time)

	if var_7_0 == 0 and var_7_1 ~= 0 then
		return true
	elseif var_7_1 == 0 and var_7_0 ~= 0 then
		return false
	end

	if var_7_1 < var_7_0 then
		return true
	elseif var_7_0 < var_7_1 then
		return false
	end

	if arg_7_0.level > arg_7_1.level then
		return true
	elseif arg_7_0.level < arg_7_1.level then
		return false
	end

	if tonumber(arg_7_0.userId) < tonumber(arg_7_1.userId) then
		return true
	elseif tonumber(arg_7_0.userId) > tonumber(arg_7_1.userId) then
		return false
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0

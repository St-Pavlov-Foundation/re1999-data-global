module("modules.logic.reddot.model.RedDotModel", package.seeall)

local var_0_0 = class("RedDotModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._dotInfos = {}
	arg_1_0._dotTree = {}
	arg_1_0._latestExpireTime = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._dotInfos = {}
	arg_2_0._dotTree = {}
end

function var_0_0._setDotTree(arg_3_0)
	local var_3_0 = RedDotConfig.instance:getRedDotsCO()

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		local var_3_1 = string.splitToNumber(iter_3_1.parent, "#")

		for iter_3_2, iter_3_3 in pairs(var_3_1) do
			if not arg_3_0._dotTree[iter_3_3] then
				arg_3_0._dotTree[iter_3_3] = {}
			end

			if not tabletool.indexOf(arg_3_0._dotTree[iter_3_3], iter_3_1.id) then
				table.insert(arg_3_0._dotTree[iter_3_3], iter_3_1.id)
			end
		end
	end
end

function var_0_0.setRedDotInfo(arg_4_0, arg_4_1)
	arg_4_0:_setDotTree()

	local var_4_0 = SocialMessageModel.instance:getMessageUnreadRedDotGroup()

	table.insert(arg_4_1, var_4_0)

	arg_4_0._latestExpireTime = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_1 = RedDotGroupMo.New()

		var_4_1:init(iter_4_1)

		arg_4_0._dotInfos[tonumber(iter_4_1.defineId)] = var_4_1
	end

	arg_4_0:_recountLastestExpireTime()
end

function var_0_0.updateRedDotInfo(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if not arg_5_0._dotInfos[tonumber(iter_5_1.defineId)] then
			local var_5_0 = RedDotGroupMo.New()

			var_5_0:init(iter_5_1)

			arg_5_0._dotInfos[tonumber(iter_5_1.defineId)] = var_5_0
		else
			arg_5_0._dotInfos[tonumber(iter_5_1.defineId)]:_resetDotInfo(iter_5_1)
		end
	end

	arg_5_0:_recountLastestExpireTime()
end

function var_0_0._recountLastestExpireTime(arg_6_0)
	arg_6_0._latestExpireTime = 0

	for iter_6_0, iter_6_1 in pairs(arg_6_0._dotInfos) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1.infos) do
			if iter_6_3.time > 0 and iter_6_3.time > ServerTime.now() then
				if arg_6_0._latestExpireTime > 0 then
					arg_6_0._latestExpireTime = arg_6_0._latestExpireTime > iter_6_3.time and iter_6_3.time or arg_6_0._latestExpireTime
				else
					arg_6_0._latestExpireTime = iter_6_3.time
				end
			end
		end
	end
end

function var_0_0.getLatestExpireTime(arg_7_0)
	return arg_7_0._latestExpireTime
end

function var_0_0.getRedDotInfo(arg_8_0, arg_8_1)
	return arg_8_0._dotInfos[arg_8_1]
end

function var_0_0._getAssociateRedDots(arg_9_0, arg_9_1)
	local var_9_0 = {}

	table.insert(var_9_0, arg_9_1)

	local function var_9_1(arg_10_0)
		local var_10_0 = arg_9_0:getDotParents(arg_10_0)

		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			table.insert(var_9_0, iter_10_1)
			var_9_1(iter_10_1)
		end
	end

	if #arg_9_0:getDotParents(arg_9_1) > 0 then
		var_9_1(arg_9_1)
	end

	return var_9_0
end

function var_0_0.getDotParents(arg_11_0, arg_11_1)
	local var_11_0 = RedDotConfig.instance:getRedDotCO(arg_11_1)

	if not var_11_0 or var_11_0.parent == "" then
		return {}
	end

	return (string.splitToNumber(var_11_0.parent, "#"))
end

function var_0_0.getDotChilds(arg_12_0, arg_12_1)
	local var_12_0 = {}

	local function var_12_1(arg_13_0)
		if not arg_12_0._dotTree[arg_13_0] or #arg_12_0._dotTree[arg_13_0] == 0 then
			if not tabletool.indexOf(var_12_0, arg_13_0) then
				table.insert(var_12_0, arg_13_0)
			end
		else
			for iter_13_0, iter_13_1 in pairs(arg_12_0._dotTree[arg_13_0]) do
				if not arg_12_0._dotTree[iter_13_1] or #arg_12_0._dotTree[iter_13_1] == 0 then
					if not tabletool.indexOf(var_12_0, iter_13_1) then
						table.insert(var_12_0, iter_13_1)
					end
				else
					var_12_1(iter_13_1)
				end
			end
		end
	end

	var_12_1(arg_12_1)

	return var_12_0
end

function var_0_0.isDotShow(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0._dotInfos[arg_14_1] then
		local var_14_0 = arg_14_0:getDotChilds(arg_14_1)

		for iter_14_0, iter_14_1 in pairs(var_14_0) do
			if arg_14_0._dotInfos[iter_14_1] then
				for iter_14_2, iter_14_3 in pairs(arg_14_0._dotInfos[iter_14_1].infos) do
					if iter_14_3.value > 0 then
						return true
					end
				end
			end
		end

		return false
	elseif arg_14_0._dotInfos[arg_14_1].infos[arg_14_2] then
		for iter_14_4, iter_14_5 in pairs(arg_14_0._dotInfos[arg_14_1].infos) do
			if iter_14_5.uid == arg_14_2 then
				return iter_14_5.value > 0
			end
		end

		return false
	else
		if not arg_14_0._dotInfos[arg_14_1].infos[arg_14_2] then
			return false
		end

		return arg_14_0._dotInfos[arg_14_1].infos[arg_14_2].value > 0
	end

	return false
end

function var_0_0.getDotInfo(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0._dotInfos[arg_15_1] then
		if arg_15_0._dotInfos[arg_15_1][arg_15_2] then
			return arg_15_0._dotInfos[arg_15_1][arg_15_2]
		else
			return arg_15_0._dotInfos[arg_15_1]
		end
	end

	return nil
end

function var_0_0.getDotInfoCount(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_2 or not arg_16_0._dotInfos[arg_16_1] or not arg_16_0._dotInfos[arg_16_1].infos[arg_16_2] then
		return 0
	end

	return arg_16_0._dotInfos[arg_16_1].infos[arg_16_2].value
end

var_0_0.instance = var_0_0.New()

return var_0_0

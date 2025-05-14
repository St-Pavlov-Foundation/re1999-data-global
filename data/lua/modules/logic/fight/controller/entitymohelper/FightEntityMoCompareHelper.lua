module("modules.logic.fight.controller.entitymohelper.FightEntityMoCompareHelper", package.seeall)

local var_0_0 = _M

var_0_0.DeepMaxStack = 100
var_0_0.CompareFilterAttrDict = {
	stanceDic = true,
	playCardExPoint = true,
	buffFeaturesSplit = true,
	_playCardAddExpoint = true,
	isOnlyData = true,
	_last_clone_mo = true,
	moveCardExPoint = true,
	passiveSkillDic = true,
	_combineCardAddExpoint = true,
	custom_refreshNameUIOp = true,
	stanceIndex = true,
	__cname = true,
	skillList = true,
	_moveCardAddExpoint = true
}

function var_0_0.compareEntityMo(arg_1_0, arg_1_1)
	var_0_0.initCompareHandleDict()

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		if not var_0_0.CompareFilterAttrDict[iter_1_0] and not (var_0_0.compareHandleDict[iter_1_0] or var_0_0.defaultTableDeepCompare)(iter_1_1, arg_1_1[iter_1_0]) then
			return false
		end
	end

	return true
end

function var_0_0.initCompareHandleDict()
	if not var_0_0.compareHandleDict then
		var_0_0.compareHandleDict = {
			buffModel = var_0_0.defaultTableDeepCompare,
			_powerInfos = var_0_0.defaultTableDeepCompare,
			summonedInfo = var_0_0.summonedInfoCompare,
			attrMO = var_0_0.attrMoCompare
		}
	end
end

function var_0_0.defaultCompare(arg_3_0, arg_3_1)
	if arg_3_0 == arg_3_1 then
		return true
	end

	if not arg_3_0 or not arg_3_1 then
		return false
	end

	local var_3_0 = type(arg_3_0)

	if var_3_0 ~= type(arg_3_1) then
		return false
	end

	if var_3_0 == "table" then
		return var_0_0.defaultTableCompare(arg_3_0, arg_3_1)
	end

	return arg_3_0 == arg_3_1
end

var_0_0.CompareStatus = {
	CompareFinish = 2,
	WaitCompare = 1
}

function var_0_0._innerTableCompare(arg_4_0, arg_4_1)
	if arg_4_0 == arg_4_1 then
		return var_0_0.CompareStatus.CompareFinish, true
	end

	if not arg_4_0 or not arg_4_1 then
		return var_0_0.CompareStatus.CompareFinish, false
	end

	if type(arg_4_0) ~= type(arg_4_1) then
		return var_0_0.CompareStatus.CompareFinish, false
	end

	return var_0_0.CompareStatus.WaitCompare, true
end

function var_0_0.defaultTableCompare(arg_5_0, arg_5_1)
	local var_5_0, var_5_1 = var_0_0._innerTableCompare(arg_5_0, arg_5_1)

	if var_5_0 == var_0_0.CompareStatus.CompareFinish then
		return var_5_1
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		if not var_0_0.CompareFilterAttrDict[iter_5_0] and iter_5_1 ~= arg_5_0[iter_5_0] then
			return false
		end
	end

	return true
end

function var_0_0.defaultTableDeepCompare(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_2 = arg_6_2 or 0

	if arg_6_2 > var_0_0.DeepMaxStack then
		logError("stackoverflow")

		return true, arg_6_3
	end

	local var_6_0, var_6_1 = var_0_0._innerTableCompare(arg_6_0, arg_6_1)

	if var_6_0 == var_0_0.CompareStatus.CompareFinish then
		return var_6_1, arg_6_3
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0) do
		local var_6_2 = arg_6_3 and arg_6_3 .. iter_6_0 or iter_6_0

		if not var_0_0.CompareFilterAttrDict[iter_6_0] then
			local var_6_3 = arg_6_1[iter_6_0]
			local var_6_4 = type(iter_6_1)

			if var_6_4 ~= type(var_6_3) then
				return false, var_6_2
			end

			if var_6_4 == "table" then
				local var_6_5, var_6_6 = var_0_0.defaultTableDeepCompare(iter_6_1, var_6_3, arg_6_2 + 1, var_6_2)

				var_6_2 = var_6_6

				if not var_6_5 then
					return false, var_6_2
				end
			elseif iter_6_1 ~= var_6_3 then
				return false, var_6_2
			end
		end
	end

	return true
end

function var_0_0.summonedInfoCompare(arg_7_0, arg_7_1)
	local var_7_0, var_7_1 = var_0_0._innerTableCompare(arg_7_0, arg_7_1)

	if var_7_0 == var_0_0.CompareStatus.CompareFinish then
		return var_7_1
	end

	local var_7_2 = arg_7_0.getDataDic and arg_7_0:getDataDic()
	local var_7_3 = arg_7_1.getDataDic and arg_7_1:getDataDic()

	return var_0_0.defaultTableDeepCompare(var_7_2, var_7_3)
end

function var_0_0.attrMoCompare(arg_8_0, arg_8_1)
	local var_8_0, var_8_1 = var_0_0._innerTableCompare(arg_8_0, arg_8_1)

	if var_8_0 == var_0_0.CompareStatus.CompareFinish then
		return var_8_1
	end

	if arg_8_0.hp ~= arg_8_1.hp then
		return false
	end

	if arg_8_0.multiHpIdx ~= arg_8_1.multiHpIdx then
		return false
	end

	if arg_8_0.multiHpNum ~= arg_8_1.multiHpNum then
		return false
	end

	return true
end

return var_0_0

module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.model.V2a7_SelfSelectSix_PickChoiceListModel", package.seeall)

local var_0_0 = class("V2a7_SelfSelectSix_PickChoiceListModel", MixScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._selectIdList = {}
	arg_1_0._selectIdMap = {}
	arg_1_0._pickChoiceMap = {}
	arg_1_0.maxSelectCount = nil
	arg_1_0._lastUnLock = nil
	arg_1_0._lastUnlockEpisodeId = nil
	arg_1_0._allPass = false
	arg_1_0._arrcount = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.initData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:onInit()
	arg_3_0:initList(arg_3_1)

	arg_3_0.maxSelectCount = arg_3_2 or 1
end

function var_0_0.initList(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = {}

	arg_4_0._arrcount = #arg_4_1

	local var_4_1 = true

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_2 = {}
		local var_4_3 = string.split(iter_4_1, ":")
		local var_4_4 = {}

		if var_4_3[2] and #var_4_3[2] > 0 then
			var_4_4 = string.splitToNumber(var_4_3[2], ",")
			arg_4_0._pickChoiceMap[tonumber(var_4_3[1])] = var_4_4
		end

		var_4_2.episodeId = tonumber(var_4_3[1])
		var_4_2.heroIdList = var_4_4

		local var_4_5 = DungeonModel.instance:hasPassLevel(var_4_2.episodeId)

		var_4_2.isUnlock = var_4_5

		if var_4_5 then
			arg_4_0._lastUnLock = iter_4_0
		else
			var_4_1 = false
		end

		if not var_4_5 and not arg_4_0._lastUnlockEpisodeId then
			arg_4_0._lastUnlockEpisodeId = var_4_2.episodeId
		end

		if iter_4_0 == #arg_4_1 and var_4_1 then
			arg_4_0._lastUnlockEpisodeId = var_4_2.episodeId
		end

		table.insert(var_4_0, {
			isTitle = true,
			episodeId = var_4_2.episodeId,
			isUnlock = var_4_5
		})
		table.insert(var_4_0, var_4_2)

		arg_4_0._allPass = var_4_1
	end

	arg_4_0:setList(var_4_0)
end

function var_0_0.getLastUnlockIndex(arg_5_0)
	return arg_5_0._lastUnLock
end

function var_0_0.getLastUnlockEpisodeId(arg_6_0)
	return arg_6_0._lastUnlockEpisodeId, arg_6_0._allPass
end

function var_0_0.getArrCount(arg_7_0)
	return arg_7_0._arrcount
end

function var_0_0.setSelectId(arg_8_0, arg_8_1)
	if not arg_8_0._selectIdList then
		return
	end

	if arg_8_0._selectIdMap[arg_8_1] then
		arg_8_0._selectIdMap[arg_8_1] = nil

		tabletool.removeValue(arg_8_0._selectIdList, arg_8_1)
	else
		arg_8_0._selectIdMap[arg_8_1] = true

		table.insert(arg_8_0._selectIdList, arg_8_1)
	end
end

function var_0_0.clearAllSelect(arg_9_0)
	arg_9_0._selectIdMap = {}
	arg_9_0._selectIdList = {}
end

function var_0_0.getSelectIds(arg_10_0)
	return arg_10_0._selectIdList
end

function var_0_0.getSelectCount(arg_11_0)
	if arg_11_0._selectIdList then
		return #arg_11_0._selectIdList
	end

	return 0
end

function var_0_0.getMaxSelectCount(arg_12_0)
	return arg_12_0.maxSelectCount
end

function var_0_0.isHeroIdSelected(arg_13_0, arg_13_1)
	if arg_13_0._selectIdMap then
		return arg_13_0._selectIdMap[arg_13_1] ~= nil
	end

	return false
end

function var_0_0.getInfoList(arg_14_0, arg_14_1)
	arg_14_0._mixCellInfo = {}

	local var_14_0 = arg_14_0:getList()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = iter_14_1.isTitle
		local var_14_2 = var_14_1 and 0 or 1
		local var_14_3 = var_14_1 and 66 or 200
		local var_14_4 = SLFramework.UGUI.MixCellInfo.New(var_14_2, var_14_3, nil)

		table.insert(arg_14_0._mixCellInfo, var_14_4)
	end

	return arg_14_0._mixCellInfo
end

var_0_0.instance = var_0_0.New()

return var_0_0

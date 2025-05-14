module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotModel", package.seeall)

local var_0_0 = class("V1a6_CachotModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._rogueStateInfo = nil
	arg_1_0._rogueInfo = nil
	arg_1_0._goodsInfos = nil
	arg_1_0._rogueEndingInfo = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.getRogueStateInfo(arg_3_0)
	return arg_3_0._rogueStateInfo
end

function var_0_0.getRogueInfo(arg_4_0)
	return arg_4_0._rogueInfo
end

function var_0_0.getGoodsInfos(arg_5_0)
	return arg_5_0._goodsInfos
end

function var_0_0.getTeamInfo(arg_6_0)
	if not arg_6_0._rogueInfo then
		return
	end

	return arg_6_0._rogueInfo.teamInfo
end

function var_0_0.getRogueEndingInfo(arg_7_0)
	return arg_7_0._rogueEndingInfo
end

function var_0_0.clearRogueInfo(arg_8_0)
	arg_8_0._rogueInfo = nil

	V1a6_CachotRoomModel.instance:clear()
end

function var_0_0.updateRogueStateInfo(arg_9_0, arg_9_1)
	arg_9_0._rogueStateInfo = arg_9_0._rogueStateInfo or RogueStateInfoMO.New()

	arg_9_0._rogueStateInfo:init(arg_9_1)
	V1a6_CachotStatController.instance:recordInitHeroGroup()
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateRogueStateInfo)
end

function var_0_0.isInRogue(arg_10_0)
	if arg_10_0._rogueInfo then
		return not arg_10_0._rogueInfo.isFinish
	end

	return arg_10_0._rogueStateInfo and arg_10_0._rogueStateInfo.start
end

function var_0_0.updateRogueInfo(arg_11_0, arg_11_1)
	arg_11_0._rogueInfo = arg_11_0._rogueInfo or RogueInfoMO.New()

	arg_11_0._rogueInfo:init(arg_11_1)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateRogueInfo)
end

function var_0_0.updateTeamInfo(arg_12_0, arg_12_1)
	arg_12_0._rogueInfo:updateTeamInfo(arg_12_1)
end

function var_0_0.updateGroupBoxStar(arg_13_0, arg_13_1)
	arg_13_0._rogueInfo.teamInfo:updateGroupBoxStar(arg_13_1)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateGroupBoxStar)
end

function var_0_0.updateGoodsInfos(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	arg_14_0._goodsInfos = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		local var_14_0 = RogueGoodsInfoMO.New()

		var_14_0:init(iter_14_1)
		table.insert(arg_14_0._goodsInfos, var_14_0)
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateGoodsInfos)
end

function var_0_0.updateCollectionsInfos(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	arg_15_0._rogueInfo = arg_15_0._rogueInfo or RogueInfoMO.New()

	arg_15_0._rogueInfo:updateCollections(arg_15_1)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateCollectionsInfo)
end

function var_0_0.updateRogueEndingInfo(arg_16_0, arg_16_1)
	arg_16_0._rogueEndingInfo = arg_16_0._rogueEndingInfo or RogueEndingInfoMO.New()

	arg_16_0._rogueEndingInfo:init(arg_16_1)
end

function var_0_0.clearRogueEndingInfo(arg_17_0)
	arg_17_0._rogueEndingInfo = nil
end

function var_0_0.setChangeLifes(arg_18_0, arg_18_1)
	arg_18_0._changeLifes = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		local var_18_0 = RogueHeroLifeMO.New()

		var_18_0:init(iter_18_1)
		table.insert(arg_18_0._changeLifes, var_18_0)
	end
end

function var_0_0.getChangeLifes(arg_19_0)
	return arg_19_0._changeLifes
end

function var_0_0.isReallyOpen(arg_20_0)
	if ActivityModel.instance:getActMO(V1a6_CachotEnum.ActivityId):isOpen() then
		local var_20_0 = ActivityConfig.instance:getActivityCo(V1a6_CachotEnum.ActivityId).openId

		return var_20_0 and var_20_0 ~= 0 and OpenModel.instance:isFunctionUnlock(var_20_0)
	end
end

function var_0_0.isOnline(arg_21_0)
	return ActivityModel.instance:getActMO(V1a6_CachotEnum.ActivityId) and ActivityHelper.getActivityStatus(V1a6_CachotEnum.ActivityId, true) == ActivityEnum.ActivityStatus.Normal
end

var_0_0.instance = var_0_0.New()

return var_0_0

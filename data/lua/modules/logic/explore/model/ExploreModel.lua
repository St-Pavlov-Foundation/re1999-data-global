module("modules.logic.explore.model.ExploreModel", package.seeall)

local var_0_0 = class("ExploreModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()

	arg_2_0.isFirstEnterMap = ExploreEnum.EnterMode.Normal
	arg_2_0.isJumpToExplore = false
end

function var_0_0.clearData(arg_3_0)
	arg_3_0._heroControlDict = {}
	arg_3_0._stepPause = false
	arg_3_0.isReseting = false
	arg_3_0._useItemUid = 0
	arg_3_0.isRoleInitDone = false
	arg_3_0.isShowingResetBoxMessage = false
	arg_3_0.mapId = 0
	arg_3_0.challengeCount = 0
	arg_3_0.unLockAreaIds = {}
	arg_3_0._interactInfosDic = {}

	ExploreCounterModel.instance:reInit()
end

function var_0_0.isHeroInControl(arg_4_0, arg_4_1)
	if arg_4_1 then
		return not arg_4_0._heroControlDict[arg_4_1]
	end

	return not next(arg_4_0._heroControlDict)
end

function var_0_0.setHeroControl(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2 = arg_5_2 or ExploreEnum.HeroLock.All

	if arg_5_1 then
		if arg_5_2 == ExploreEnum.HeroLock.All then
			arg_5_0._heroControlDict = {}
		else
			arg_5_0._heroControlDict[arg_5_2] = nil
		end
	else
		arg_5_0._heroControlDict[arg_5_2] = true

		if arg_5_0.isShowingResetBoxMessage then
			arg_5_0.isShowingResetBoxMessage = false

			ViewMgr.instance:closeView(ViewName.MessageBoxView)
		end
	end
end

function var_0_0.setStepPause(arg_6_0, arg_6_1)
	if arg_6_0._stepPause == arg_6_1 then
		return
	end

	arg_6_0._stepPause = arg_6_1

	if not arg_6_1 then
		ExploreStepController.instance:startStep()
	end
end

function var_0_0.getStepPause(arg_7_0)
	return arg_7_0._stepPause
end

function var_0_0.getMapId(arg_8_0)
	return arg_8_0.mapId
end

function var_0_0.getNowMapEpisodeId(arg_9_0)
	return ExploreConfig.instance:getEpisodeId(arg_9_0.mapId)
end

function var_0_0.addChallengeCount(arg_10_0)
	arg_10_0.challengeCount = arg_10_0.challengeCount + 1
end

function var_0_0.getChallengeCount(arg_11_0)
	return arg_11_0.challengeCount
end

function var_0_0.updateExploreInfo(arg_12_0, arg_12_1)
	arg_12_0:clearData()

	local var_12_0 = arg_12_1.exploreMap

	arg_12_0.mapId = var_12_0.mapId
	arg_12_0.challengeCount = var_12_0.challengeCount

	for iter_12_0, iter_12_1 in ipairs(var_12_0.interacts) do
		arg_12_0:updateInteractInfo(iter_12_1, var_12_0.mapId)
	end

	for iter_12_2, iter_12_3 in ipairs(var_12_0.areaIds) do
		arg_12_0.unLockAreaIds[iter_12_3] = true
	end

	ExploreBackpackModel.instance:updateItems(arg_12_1.exploreItems, true)
	ExploreMapModel.instance:updatHeroPos(var_12_0.posx, var_12_0.posy, var_12_0.dir)

	ExploreMapModel.instance.moveNodes = var_12_0.moveNodes

	arg_12_0:setUseItemUid(arg_12_1.useItemUid)
	ExploreController.instance:dispatchEvent(ExploreEvent.UnitInteractInfoChange)
end

function var_0_0.updateInteractInfo(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_2 = arg_13_2 or arg_13_0.mapId

	arg_13_0:getInteractInfo(arg_13_1.id, arg_13_2):initNO(arg_13_1)

	if arg_13_3 then
		ExploreController.instance:dispatchEvent(ExploreEvent.UnitInteractInfoChange)
	end
end

function var_0_0.updateInteractStatus(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0:getInteractInfo(arg_14_2, arg_14_1):updateStatus(arg_14_3)
end

function var_0_0.updateInteractStatus2(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0:getInteractInfo(arg_15_2, arg_15_1):updateStatus2(arg_15_3)
end

function var_0_0.updateInteractStep(arg_16_0, arg_16_1)
	arg_16_0:getInteractInfo(arg_16_1.id, arg_16_1.mapId).step = arg_16_1.step
end

function var_0_0.getInteractInfo(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2 = arg_17_2 or arg_17_0.mapId
	arg_17_0._interactInfosDic[arg_17_2] = arg_17_0._interactInfosDic[arg_17_2] or {}

	if arg_17_0._interactInfosDic[arg_17_2][arg_17_1] == nil then
		local var_17_0 = ExploreInteractInfoMO.New()

		var_17_0:init(arg_17_1)

		arg_17_0._interactInfosDic[arg_17_2][arg_17_1] = var_17_0
	end

	return arg_17_0._interactInfosDic[arg_17_2][arg_17_1]
end

function var_0_0.hasInteractInfo(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2 = arg_18_2 or arg_18_0.mapId
	arg_18_0._interactInfosDic[arg_18_2] = arg_18_0._interactInfosDic[arg_18_2] or {}

	return arg_18_0._interactInfosDic[arg_18_2][arg_18_1] ~= nil
end

function var_0_0.getAllInteractInfo(arg_19_0, arg_19_1)
	arg_19_1 = arg_19_1 or arg_19_0.mapId

	return arg_19_0._interactInfosDic[arg_19_1]
end

function var_0_0.getUseItemUid(arg_20_0)
	return arg_20_0._useItemUid
end

function var_0_0.setUseItemUid(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0._useItemUid

	arg_21_0._useItemUid = arg_21_1

	if var_21_0 ~= arg_21_0._useItemUid and not arg_21_2 then
		ExploreController.instance:dispatchEvent(ExploreEvent.UseItemChanged, arg_21_0._useItemUid)
	end
end

function var_0_0.getCarryUnit(arg_22_0)
	local var_22_0 = arg_22_0:getUseItemUid()
	local var_22_1 = ExploreController.instance:getMap():getUnit(tonumber(var_22_0), true)

	if not isTypeOf(var_22_1, ExplorePipePotUnit) then
		return nil
	end

	return var_22_1
end

function var_0_0.isUseItemOrUnit(arg_23_0, arg_23_1)
	return arg_23_0._useItemUid == arg_23_1 or tonumber(arg_23_0._useItemUid) == arg_23_1
end

function var_0_0.hasUseItemOrUnit(arg_24_0)
	return arg_24_0._useItemUid ~= 0 and arg_24_0._useItemUid ~= "0"
end

function var_0_0.isAreaShow(arg_25_0, arg_25_1)
	if not arg_25_1 or arg_25_1 == 0 then
		return true
	end

	return arg_25_0.unLockAreaIds[arg_25_1] or false
end

var_0_0.instance = var_0_0.New()

return var_0_0

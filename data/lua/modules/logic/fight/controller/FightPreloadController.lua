module("modules.logic.fight.controller.FightPreloadController", package.seeall)

local var_0_0 = class("FightPreloadController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._preloadSequence = nil
	arg_1_0._firstSequence = arg_1_0:_buildFirstFlow()
	arg_1_0._secondSequence = arg_1_0:_buildSecondFlow()
	arg_1_0._allResLoadFlow = FlowSequence.New()

	arg_1_0._allResLoadFlow:addWork(arg_1_0:_buildFirstFlow(true))
	arg_1_0._allResLoadFlow:addWork(arg_1_0:_buildSecondFlow())

	arg_1_0._reconnectSequence = arg_1_0:_buildReconnectFlow()
	arg_1_0._context = {
		callback = arg_1_0._onPreloadOneFinish,
		callbackObj = arg_1_0
	}
end

function var_0_0._buildFirstFlow(arg_2_0, arg_2_1)
	local var_2_0 = FlowSequence.New()

	var_2_0:addWork(FightPreloadTimelineFirstWork.New())
	var_2_0:addWork(FightPreloadTimelineRefWork.New())
	var_2_0:addWork(FightRoundPreloadEffectWork.New())
	var_2_0:addWork(FightPreloadFirstMonsterSpineWork.New())
	var_2_0:addWork(FightPreloadHeroGroupSpineWork.New())
	var_2_0:addWork(FightPreloadViewWork.New())

	if not arg_2_1 then
		var_2_0:addWork(FightPreloadDoneWork.New())
	end

	var_2_0:addWork(FightPreloadRoleCardWork.New())
	var_2_0:addWork(FightPreloadCameraAni.New({}))
	var_2_0:addWork(FightPreloadEntityAni.New())
	var_2_0:addWork(FightPreloadRolesTimeline.New())
	var_2_0:addWork(FightPreloadOthersWork.New())
	var_2_0:addWork(FightPreloadEffectWork.New())

	return var_2_0
end

function var_0_0._buildSecondFlow(arg_3_0)
	local var_3_0 = FlowSequence.New()

	var_3_0:addWork(FightPreloadCompareSpineWork.New())
	var_3_0:addWork(FightPreloadTimelineFirstWork.New())
	var_3_0:addWork(FightPreloadSpineWork.New())
	var_3_0:addWork(FightPreloadRoleCardByRealDataWork.New())
	var_3_0:addWork(FightPreloadOthersWork.New())
	var_3_0:addWork(FightPreloadViewWork.New())
	var_3_0:addWork(FightPreloadCameraAni.New())
	var_3_0:addWork(FightPreloadEntityAni.New())
	var_3_0:addWork(FightPreloadRolesTimeline.New())
	var_3_0:addWork(FightPreloadEffectWork.New())
	var_3_0:addWork(FightPreloadDoneWork.New())
	var_3_0:addWork(FightPreloadCardInitWork.New())
	var_3_0:addWork(FightPreloadWaitReplayWork.New())
	var_3_0:addWork(FightPreloadRoleEffectWork.New())

	return var_3_0
end

function var_0_0._buildReconnectFlow(arg_4_0)
	local var_4_0 = FlowSequence.New()

	var_4_0:addWork(FightPreloadTimelineFirstWork.New())
	var_4_0:addWork(FightPreloadSpineWork.New())
	var_4_0:addWork(FightPreloadRoleCardWork.New())
	var_4_0:addWork(FightPreloadOthersWork.New())
	var_4_0:addWork(FightPreloadViewWork.New())
	var_4_0:addWork(FightPreloadCameraAni.New())
	var_4_0:addWork(FightPreloadEntityAni.New())
	var_4_0:addWork(FightPreloadRolesTimeline.New())
	var_4_0:addWork(FightPreloadEffectWork.New())
	var_4_0:addWork(FightPreloadDoneWork.New())
	var_4_0:addWork(FightPreloadCardInitWork.New())
	var_4_0:addWork(FightPreloadWaitReplayWork.New())
	var_4_0:addWork(FightPreloadRoleEffectWork.New())

	return var_4_0
end

function var_0_0.reInit(arg_5_0)
	arg_5_0:dispose()
end

function var_0_0.isPreloading(arg_6_0)
	return arg_6_0._preloadSequence and arg_6_0._preloadSequence.status == WorkStatus.Running
end

function var_0_0.hasPreload(arg_7_0, arg_7_1)
	return arg_7_0._battleId == arg_7_1 and arg_7_0._preloadSequence and arg_7_0._preloadSequence.status == WorkStatus.Done
end

function var_0_0.preloadFirst(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	arg_8_0:_startPreload(arg_8_0._firstSequence, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
end

function var_0_0.preloadSecond(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	if FightModel.instance:getBattleId() ~= arg_9_0._battleId then
		arg_9_0:dispose()
		arg_9_0:_startPreload(arg_9_0._allResLoadFlow, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	else
		arg_9_0:_startPreload(arg_9_0._secondSequence, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	end
end

function var_0_0.preloadReconnect(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	arg_10_0:_startPreload(arg_10_0._reconnectSequence, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
end

function var_0_0._startPreload(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
	arg_11_0:__onInit()

	if arg_11_0._preloadSequence and arg_11_0._preloadSequence.status == WorkStatus.Running then
		arg_11_0._preloadSequence:stop()
	end

	arg_11_0._assetItemDict = arg_11_0._assetItemDict or arg_11_0:getUserDataTb_()
	arg_11_0._battleId = arg_11_2
	arg_11_0._preloadSequence = arg_11_1

	arg_11_0._preloadSequence:registerDoneListener(arg_11_0._onPreloadDone, arg_11_0)
	arg_11_0._preloadSequence:start(arg_11_0:_getContext(arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7))
end

function var_0_0._getContext(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	arg_12_0._context.battleId = arg_12_1
	arg_12_0._context.myModelIds = arg_12_2
	arg_12_0._context.mySkinIds = arg_12_3
	arg_12_0._context.enemyModelIds = arg_12_4
	arg_12_0._context.enemySkinIds = arg_12_5
	arg_12_0._context.subSkinIds = arg_12_6

	return arg_12_0._context
end

function var_0_0.dispose(arg_13_0)
	arg_13_0._battleId = nil

	if arg_13_0._preloadSequence then
		arg_13_0._preloadSequence:stop()
		arg_13_0._preloadSequence:unregisterDoneListener(arg_13_0._onPreloadDone, arg_13_0)

		arg_13_0._preloadSequence = nil
	end

	FightEffectPool.dispose()
	FightSpineMatPool.dispose()
	FightSpinePool.dispose()

	if arg_13_0._assetItemDict then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._assetItemDict) do
			iter_13_1:Release()
		end

		arg_13_0._assetItemDict = nil
	end

	arg_13_0.roleCardAssetItemDict = nil
	arg_13_0.timelineRefAssetItemDict = nil

	arg_13_0:cacheFirstPreloadSpine()

	arg_13_0._context.timelineDict = nil

	ZProj.SkillTimelineAssetHelper.ClearAssetJson()
	arg_13_0:__onDispose()
end

function var_0_0._onPreloadDone(arg_14_0)
	FightController.instance:dispatchEvent(FightEvent.OnPreloadFinish)
end

function var_0_0._onPreloadOneFinish(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.ResPath

	if not arg_15_0._assetItemDict[var_15_0] then
		arg_15_0._assetItemDict[var_15_0] = arg_15_1

		arg_15_1:Retain()
	end
end

function var_0_0.addRoleCardAsset(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.ResPath

	arg_16_0.roleCardAssetItemDict = arg_16_0.roleCardAssetItemDict or {}
	arg_16_0.roleCardAssetItemDict[var_16_0] = arg_16_1
end

function var_0_0.releaseRoleCardAsset(arg_17_0)
	if not arg_17_0.roleCardAssetItemDict then
		return
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0.roleCardAssetItemDict) do
		arg_17_0.roleCardAssetItemDict[iter_17_0] = nil
		arg_17_0._assetItemDict[iter_17_0] = nil

		iter_17_1:Release()
	end

	arg_17_0.roleCardAssetItemDict = nil
end

function var_0_0.addTimelineRefAsset(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.ResPath

	arg_18_0.timelineRefAssetItemDict = arg_18_0.timelineRefAssetItemDict or {}
	arg_18_0.timelineRefAssetItemDict[var_18_0] = arg_18_1
end

function var_0_0.releaseTimelineRefAsset(arg_19_0)
	if not arg_19_0.timelineRefAssetItemDict then
		return
	end

	for iter_19_0, iter_19_1 in pairs(arg_19_0.timelineRefAssetItemDict) do
		arg_19_0.timelineRefAssetItemDict[iter_19_0] = nil
		arg_19_0._assetItemDict[iter_19_0] = nil

		iter_19_1:Release()
	end

	arg_19_0.timelineRefAssetItemDict = nil
end

function var_0_0.getFightAssetItem(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._assetItemDict[arg_20_1]

	if var_20_0 then
		return var_20_0
	end

	logWarn(arg_20_1 .. " need preload")
end

function var_0_0.releaseAsset(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._assetItemDict and arg_21_0._assetItemDict[arg_21_1]

	if var_21_0 then
		var_21_0:Release()

		arg_21_0._assetItemDict[arg_21_1] = nil
	end
end

function var_0_0.cacheFirstPreloadSpine(arg_22_0, arg_22_1)
	if arg_22_1 then
		arg_22_0.cachePreloadSpine = {}

		for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
			arg_22_0.cachePreloadSpine[iter_22_1[1]] = iter_22_1[2]
		end
	else
		arg_22_0.cachePreloadSpine = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

module("modules.logic.tower.model.TowerPermanentModel", package.seeall)

local var_0_0 = class("TowerPermanentModel", MixScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:initDataInfo()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:initDataInfo()

	arg_2_0.curPassLayer = 0
	arg_2_0.lastPassLayer = 0
	arg_2_0.localCurPassLayer = -1
end

function var_0_0.initDataInfo(arg_3_0)
	arg_3_0.permanentMoList = {}
	arg_3_0.ItemType = 1
	arg_3_0.PermanentInfoMap = {}
	arg_3_0.defaultStage = 1
	arg_3_0.curSelectStage = 1
	arg_3_0.curSelectLayer = 1
	arg_3_0.curSelectEpisodeId = 0
	arg_3_0.realSelectMap = {}
end

function var_0_0.cleanData(arg_4_0)
	arg_4_0:initDataInfo()
end

function var_0_0.initDefaultSelectStage(arg_5_0, arg_5_1)
	arg_5_0.curPassLayer = arg_5_1 and arg_5_1.passLayerId or 0

	if arg_5_0.curPassLayer == 0 then
		arg_5_0.defaultStage = 1
		arg_5_0.curSelectLayer = 1
	else
		local var_5_0, var_5_1 = arg_5_0:getNewtStageAndLayer()

		arg_5_0.defaultStage = var_5_0
		arg_5_0.curSelectLayer = var_5_1
	end

	arg_5_0.curSelectStage = arg_5_0.defaultStage
	arg_5_0.realSelectMap[arg_5_0.curSelectStage] = arg_5_0.curSelectLayer
end

function var_0_0.getNewtStageAndLayer(arg_6_0)
	local var_6_0 = 1
	local var_6_1 = 1
	local var_6_2 = TowerConfig.instance:getPermanentEpisodeCo(arg_6_0.curPassLayer)
	local var_6_3 = TowerConfig.instance:getPermanentEpisodeCo(arg_6_0.curPassLayer + 1)

	if not var_6_2 then
		logError("该层配置为空，请检查：" .. arg_6_0.curPassLayer)

		return var_6_0, var_6_1
	end

	if not var_6_3 then
		var_6_0 = var_6_2.stageId
		var_6_1 = arg_6_0:getPassLayerIndex()
	elseif var_6_2.stageId ~= var_6_3.stageId then
		if arg_6_0:checkStageIsOnline(var_6_3.stageId) then
			var_6_0 = var_6_3.stageId
			var_6_1 = 1
		else
			var_6_0 = var_6_2.stageId
			var_6_1 = arg_6_0:getPassLayerIndex()
		end
	else
		var_6_0 = var_6_2.stageId
		var_6_1 = arg_6_0:getPassLayerIndex() + 1
	end

	return var_6_0, var_6_1
end

function var_0_0.getPassLayerIndex(arg_7_0)
	return TowerConfig.instance:getPermanentEpisodeCo(arg_7_0.curPassLayer).index
end

function var_0_0.getStageCount(arg_8_0)
	return arg_8_0.defaultStage
end

function var_0_0.checkhasLockTip(arg_9_0)
	return #arg_9_0.permanentMoList > arg_9_0.defaultStage
end

function var_0_0.InitData(arg_10_0)
	local var_10_0 = TowerModel.instance:getCurPermanentMo()

	arg_10_0:initDefaultSelectStage(var_10_0)

	arg_10_0.permanentMoList = {}

	for iter_10_0 = 1, arg_10_0.defaultStage do
		local var_10_1 = arg_10_0.PermanentInfoMap[iter_10_0]

		if not var_10_1 then
			var_10_1 = TowerPermanentMo.New()
			arg_10_0.PermanentInfoMap[iter_10_0] = var_10_1
		end

		local var_10_2 = TowerConfig.instance:getPermanentEpisodeStageCoList(iter_10_0)

		var_10_1:init(iter_10_0, var_10_2)
		table.insert(arg_10_0.permanentMoList, var_10_1)
	end

	local var_10_3 = arg_10_0.defaultStage + 1
	local var_10_4 = TowerConfig.instance:getPermanentEpisodeStageCoList(var_10_3)
	local var_10_5 = TowerConfig.instance:getTowerPermanentTimeCo(var_10_3)

	if var_10_4 or var_10_5 then
		local var_10_6 = TowerPermanentMo.New()

		arg_10_0.PermanentInfoMap[var_10_3] = var_10_6

		var_10_6:init(var_10_3, {})
		table.insert(arg_10_0.permanentMoList, var_10_6)
	end

	arg_10_0:setList(arg_10_0.permanentMoList)
end

function var_0_0.initStageUnFoldState(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 or arg_11_0:getCurSelectStage()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.permanentMoList) do
		iter_11_1:setIsUnFold(iter_11_1.stage == var_11_0)
	end
end

function var_0_0.getInfoList(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = arg_12_0:getList()

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = iter_12_1:getIsUnFold()
		local var_12_3 = SLFramework.UGUI.MixCellInfo.New(arg_12_0.ItemType, iter_12_1:getStageHeight(var_12_2), iter_12_0)

		table.insert(var_12_0, var_12_3)
	end

	return var_12_0
end

function var_0_0.getCurContentTotalHeight(arg_13_0)
	local var_13_0 = arg_13_0:getList()
	local var_13_1 = 0

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_2 = iter_13_1:getIsUnFold()

		var_13_1 = var_13_1 + iter_13_1:getStageHeight(iter_13_1:getIsUnFold(var_13_2))
	end

	return var_13_1
end

function var_0_0.setCurSelectStage(arg_14_0, arg_14_1)
	arg_14_0.curSelectStage = arg_14_1
	arg_14_0.curSelectLayer = arg_14_0.realSelectMap[arg_14_1] or 1
	arg_14_0.curSelectEpisodeId = 0
end

function var_0_0.getCurSelectStage(arg_15_0)
	return arg_15_0.curSelectStage
end

function var_0_0.setCurSelectLayer(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.realSelectMap = {}
	arg_16_0.realSelectMap[arg_16_2] = arg_16_1
	arg_16_0.curSelectLayer = arg_16_1
	arg_16_0.curSelectEpisodeId = 0
end

function var_0_0.getCurSelectLayer(arg_17_0)
	return arg_17_0.curSelectLayer
end

function var_0_0.getRealSelectStage(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.realSelectMap) do
		if iter_18_0 then
			return iter_18_0, iter_18_1
		end
	end
end

function var_0_0.setCurSelectEpisodeId(arg_19_0, arg_19_1)
	arg_19_0.curSelectEpisodeId = arg_19_1
end

function var_0_0.getCurSelectEpisodeId(arg_20_0)
	return arg_20_0.curSelectEpisodeId
end

function var_0_0.checkLayerSubEpisodeFinish(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = TowerModel.instance:getCurPermanentMo():getLayerSubEpisodeList(arg_21_1, true) or {}

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if iter_21_1.episodeId == arg_21_2 then
			return iter_21_1.status == TowerEnum.PassEpisodeState.Pass, iter_21_1
		end
	end

	return false
end

function var_0_0.getFirstUnFinishEipsode(arg_22_0, arg_22_1)
	local var_22_0 = TowerModel.instance:getCurPermanentMo():getLayerSubEpisodeList(arg_22_1, true) or {}

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if iter_22_1.status == TowerEnum.PassEpisodeState.NotPass then
			return iter_22_1, iter_22_0
		end
	end
end

function var_0_0.checkLayerUnlock(arg_23_0, arg_23_1)
	local var_23_0 = TowerModel.instance:getCurPermanentMo()
	local var_23_1 = arg_23_1.preLayerId

	if var_23_1 == 0 then
		return true
	else
		return var_23_1 <= var_23_0.passLayerId
	end
end

function var_0_0.getCurPermanentPassLayer(arg_24_0)
	return TowerModel.instance:getCurPermanentMo().passLayerId or 0
end

function var_0_0.getCurPassEpisodeId(arg_25_0)
	local var_25_0 = TowerModel.instance:getCurPermanentMo()
	local var_25_1 = var_25_0.passLayerId or 0
	local var_25_2 = var_25_1 + 1
	local var_25_3 = TowerConfig.instance:getPermanentEpisodeCo(var_25_2)

	if var_25_3 and var_25_3.isElite == 1 then
		local var_25_4 = string.splitToNumber(var_25_3.episodeIds, "|")

		for iter_25_0, iter_25_1 in ipairs(var_25_4) do
			local var_25_5 = var_25_0:getSubEpisodeMoByEpisodeId(iter_25_1)

			if var_25_5 and var_25_5.status == TowerEnum.PassEpisodeState.Pass then
				return iter_25_1
			end
		end
	end

	local var_25_6 = TowerConfig.instance:getPermanentEpisodeCo(var_25_1)

	if not var_25_6 then
		return 0
	end

	if var_25_6.isElite == 1 then
		local var_25_7 = string.splitToNumber(var_25_6.episodeIds, "|")

		return var_25_7[#var_25_7]
	else
		return tonumber(var_25_6.episodeIds)
	end
end

function var_0_0.setLastPassLayer(arg_26_0, arg_26_1)
	arg_26_0.lastPassLayer = arg_26_1
end

function var_0_0.setLocalPassLayer(arg_27_0, arg_27_1)
	arg_27_0.localCurPassLayer = arg_27_1
end

function var_0_0.getLocalPassLayer(arg_28_0)
	return arg_28_0.localCurPassLayer
end

function var_0_0.isNewPassLayer(arg_29_0)
	local var_29_0 = TowerModel.instance:getCurPermanentMo()

	return var_29_0.passLayerId == arg_29_0.lastPassLayer and var_29_0.passLayerId > arg_29_0.localCurPassLayer
end

function var_0_0.isNewStage(arg_30_0)
	local var_30_0 = TowerModel.instance:getCurPermanentMo()
	local var_30_1 = TowerConfig.instance:getPermanentEpisodeCo(var_30_0.passLayerId)

	if arg_30_0.defaultStage > var_30_1.stageId and arg_30_0:isNewPassLayer() then
		return true, arg_30_0.defaultStage, var_30_1.stageId
	end

	return false, arg_30_0.defaultStage, var_30_1.stageId
end

function var_0_0.checkStageIsOnline(arg_31_0, arg_31_1)
	local var_31_0 = TowerConfig.instance:getTowerPermanentTimeCo(arg_31_1)

	if string.nilorempty(var_31_0.time) then
		return true
	else
		local var_31_1 = string.splitToNumber(var_31_0.time, "-")
		local var_31_2 = TimeUtil.timeToTimeStamp(var_31_1[1], var_31_1[2], var_31_1[3], TimeDispatcher.DailyRefreshTime) - ServerTime.now()

		if var_31_2 <= 0 then
			return true
		else
			return false, var_31_2
		end
	end
end

function var_0_0.getCurUnfoldStage(arg_32_0)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0.permanentMoList) do
		if iter_32_1.isUnFold then
			return iter_32_1.stage
		end
	end

	return arg_32_0.curSelectStage
end

function var_0_0.checkNewLayerIsElite(arg_33_0)
	local var_33_0 = (TowerModel.instance:getCurPermanentMo().passLayerId or 0) + 1
	local var_33_1 = TowerConfig.instance:getPermanentEpisodeCo(var_33_0)

	if not var_33_1 then
		return false
	end

	return var_33_1.isElite == 1
end

function var_0_0.localMopUpSaveKey(arg_34_0)
	return TowerEnum.LocalPrefsKey.OpenMopUpViewWithFullTicket
end

function var_0_0.checkCanShowMopUpReddot(arg_35_0)
	if not TowerController.instance:isOpen() then
		return false
	end

	local var_35_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)
	local var_35_1 = TowerModel.instance:getCurPermanentMo()

	if not var_35_1 then
		return false
	end

	if not (var_35_1.passLayerId >= tonumber(var_35_0)) then
		return false
	end

	local var_35_2 = TimeUtil.getDayFirstLoginRed(TowerEnum.LocalPrefsKey.MopUpDailyRefresh)
	local var_35_3 = TowerModel.instance:getMopUpTimes()
	local var_35_4 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)

	if var_35_2 and var_35_3 == tonumber(var_35_4) then
		return true
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0

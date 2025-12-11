module("modules.logic.survival.model.map.SurvivalMapModel", package.seeall)

local var_0_0 = class("SurvivalMapModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.showToastList = {}
	arg_1_0._targetPos = nil
	arg_1_0._showTargetPos = nil
	arg_1_0._sceneMo = nil
	arg_1_0.curUseItem = nil
	arg_1_0.result = SurvivalEnum.MapResult.None
	arg_1_0.showCostTime = 0
	arg_1_0.searchChangeItems = nil
	arg_1_0.resultData = SurvivalResultMo.New()
	arg_1_0._initGroupMo = SurvivalInitGroupModel.New()
	arg_1_0.isSearchRemove = false
	arg_1_0.save_mapScale = 1 - (SurvivalConst.MapCameraParams.DefaultDis - SurvivalConst.MapCameraParams.MinDis) / (SurvivalConst.MapCameraParams.MaxDis - SurvivalConst.MapCameraParams.MinDis)
	arg_1_0.isFightEnter = false
	arg_1_0.guideSpBlockPos = nil
	arg_1_0._cacheHexPoints = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.getCacheHexNode(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_1 or 1

	if not arg_3_0._cacheHexPoints[arg_3_1] then
		arg_3_0._cacheHexPoints[arg_3_1] = SurvivalHexNode.New()
	end

	return arg_3_0._cacheHexPoints[arg_3_1]
end

function var_0_0.getInitGroup(arg_4_0)
	return arg_4_0._initGroupMo
end

function var_0_0.getCurMapCo(arg_5_0)
	return arg_5_0._sceneMo.sceneCo
end

function var_0_0.getCurMapId(arg_6_0)
	return arg_6_0._sceneMo.mapId
end

function var_0_0.setSceneData(arg_7_0, arg_7_1)
	arg_7_0.showToastList = {}
	arg_7_0._targetPos = nil
	arg_7_0._showTargetPos = nil
	arg_7_0.curUseItem = nil
	arg_7_0.showCostTime = 0
	arg_7_0.isSearchRemove = false
	arg_7_0.result = SurvivalEnum.MapResult.None

	if not arg_7_0._sceneMo then
		arg_7_0._sceneMo = SurvivalSceneMo.New()
	end

	arg_7_0._sceneMo:init(arg_7_1)

	local var_7_0 = arg_7_0._sceneMo.teamInfo.heros
	local var_7_1 = arg_7_0._sceneMo.teamInfo.npcId
	local var_7_2 = table.concat(var_7_0, "#") .. "|" .. table.concat(var_7_1, "#")

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.SurvivalTeamSave, var_7_2)
	SurvivalEquipRedDotHelper.instance:checkRed()
end

function var_0_0.getSceneMo(arg_8_0)
	return arg_8_0._sceneMo
end

function var_0_0.isInFog(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._sceneMo.player

	return not SurvivalHelper.instance:isHaveNode(var_9_0.explored, arg_9_1)
end

function var_0_0.addExploredPoint(arg_10_0, arg_10_1)
	if not arg_10_0._sceneMo then
		return
	end

	local var_10_0 = arg_10_0._sceneMo.player

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		SurvivalHelper.instance:addNodeToDict(var_10_0.explored, iter_10_1)
	end
end

function var_0_0.removeExploredPoint(arg_11_0, arg_11_1)
	if not arg_11_0._sceneMo then
		return
	end

	local var_11_0 = arg_11_0._sceneMo.player

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		SurvivalHelper.instance:removeNodeToDict(var_11_0.explored, iter_11_1)
	end
end

function var_0_0.isInFog2(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._sceneMo.player

	return not SurvivalHelper.instance:isHaveNode(var_12_0.canExplored, arg_12_1)
end

function var_0_0.addExploredPoint2(arg_13_0, arg_13_1)
	if not arg_13_0._sceneMo then
		return
	end

	local var_13_0 = arg_13_0._sceneMo.player
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		if not SurvivalHelper.instance:isHaveNode(var_13_0.canExplored, iter_13_1) then
			SurvivalHelper.instance:addNodeToDict(var_13_0.canExplored, iter_13_1)
			table.insert(var_13_1, iter_13_1)
		end
	end

	SurvivalMapHelper.instance:updateCloudShow(true, var_13_1, true)
end

function var_0_0.removeExploredPoint2(arg_14_0, arg_14_1)
	if not arg_14_0._sceneMo then
		return
	end

	local var_14_0 = arg_14_0._sceneMo.player
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if SurvivalHelper.instance:isHaveNode(var_14_0.canExplored, iter_14_1) then
			SurvivalHelper.instance:removeNodeToDict(var_14_0.canExplored, iter_14_1)
			table.insert(var_14_1, iter_14_1)
		end
	end

	SurvivalMapHelper.instance:updateCloudShow(true, var_14_1, false)
end

function var_0_0.isInMiasma(arg_15_0)
	if not arg_15_0._sceneMo then
		return false
	end

	local var_15_0 = SurvivalShelterModel.instance:getWeekInfo()

	return arg_15_0._sceneMo:getBlockTypeByPos(arg_15_0._sceneMo.player.pos) == SurvivalEnum.UnitSubType.Miasma and var_15_0:getAttr(SurvivalEnum.AttrType.Vehicle_Miasma) == 0
end

function var_0_0.setMoveToTarget(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._targetPos = arg_16_1
	arg_16_0._targetPath = arg_16_2
end

function var_0_0.setShowTarget(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._showTargetPos = arg_17_1

	if not arg_17_1 then
		if arg_17_2 then
			SurvivalMapHelper.instance:getScene().path:setDelayHide()
		else
			SurvivalMapHelper.instance:getScene().path:setPathListShow()
		end
	end
end

function var_0_0.canWalk(arg_18_0, arg_18_1)
	if arg_18_0.result ~= SurvivalEnum.MapResult.None then
		return false
	end

	if arg_18_0._sceneMo.panel then
		if arg_18_1 and ViewHelper.instance:checkViewOnTheTop(ViewName.SurvivalMapMainView, {
			ViewName.SurvivalToastView
		}) then
			arg_18_0._sceneMo.panel = nil

			logError("当前面板缓存异常，自动清空！！！")

			return true
		end

		return false
	end

	local var_18_0 = SurvivalShelterModel.instance:getWeekInfo():getBag(SurvivalEnum.ItemSource.Map)

	if var_18_0.totalMass > var_18_0.maxWeightLimit + SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.AttrWeight) then
		if arg_18_1 then
			GameFacade.showToast(ToastEnum.SurvivalNoMoveWeight)
		end

		return false
	end

	return true
end

function var_0_0.getTargetPos(arg_19_0)
	if not arg_19_0:canWalk() then
		return
	end

	return arg_19_0._targetPos, arg_19_0._targetPath
end

function var_0_0.getShowTargetPos(arg_20_0)
	if not arg_20_0:canWalk() then
		return
	end

	return arg_20_0._showTargetPos
end

function var_0_0.getSelectMapId(arg_21_0)
	local var_21_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_21_1 = var_0_0.instance:getInitGroup()

	return var_21_0.mapInfos[var_21_1.selectMapIndex + 1].mapId
end

var_0_0.instance = var_0_0.New()

return var_0_0

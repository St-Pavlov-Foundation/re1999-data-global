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
	arg_1_0.resultData = SurvivalResultMo.New()
	arg_1_0._initGroupMo = SurvivalInitGroupModel.New()
	arg_1_0.isSearchRemove = false
	arg_1_0.save_mapScale = 0.6
	arg_1_0.isHealthSub = false
	arg_1_0.isFightLvUp = false
	arg_1_0.isGetTalent = false
	arg_1_0.isFightEnter = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.getInitGroup(arg_3_0)
	return arg_3_0._initGroupMo
end

function var_0_0.getCurMapCo(arg_4_0)
	return arg_4_0._sceneMo.sceneCo
end

function var_0_0.getCurMapId(arg_5_0)
	return arg_5_0._sceneMo.mapId
end

function var_0_0.setSceneData(arg_6_0, arg_6_1)
	arg_6_0.showToastList = {}
	arg_6_0._targetPos = nil
	arg_6_0._showTargetPos = nil
	arg_6_0.curUseItem = nil
	arg_6_0.showCostTime = 0
	arg_6_0.isSearchRemove = false
	arg_6_0.result = SurvivalEnum.MapResult.None

	if not arg_6_0._sceneMo then
		arg_6_0._sceneMo = SurvivalSceneMo.New()
	end

	arg_6_0._sceneMo:init(arg_6_1)

	local var_6_0 = arg_6_0._sceneMo.teamInfo.heros
	local var_6_1 = arg_6_0._sceneMo.teamInfo.npcId
	local var_6_2 = table.concat(var_6_0, "#") .. "|" .. table.concat(var_6_1, "#")

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.SurvivalTeamSave, var_6_2)
	SurvivalEquipRedDotHelper.instance:checkRed()
end

function var_0_0.getSceneMo(arg_7_0)
	return arg_7_0._sceneMo
end

function var_0_0.isInFog(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._sceneMo.player

	return not tabletool.indexOf(var_8_0.explored, arg_8_1)
end

function var_0_0.addExploredPoint(arg_9_0, arg_9_1)
	if not arg_9_0._sceneMo then
		return
	end

	local var_9_0 = arg_9_0._sceneMo.player

	tabletool.addValues(var_9_0.explored, arg_9_1)
end

function var_0_0.setMoveToTarget(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._targetPos = arg_10_1
	arg_10_0._targetPath = arg_10_2
end

function var_0_0.setShowTarget(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._showTargetPos = arg_11_1

	if not arg_11_1 then
		if arg_11_2 then
			SurvivalMapHelper.instance:getScene().path:setDelayHide()
		else
			SurvivalMapHelper.instance:getScene().path:setPathListShow()
		end
	end
end

function var_0_0.canWalk(arg_12_0, arg_12_1)
	if arg_12_0.result ~= SurvivalEnum.MapResult.None then
		return false
	end

	if arg_12_0._sceneMo.panel then
		if arg_12_1 and ViewHelper.instance:checkViewOnTheTop(ViewName.SurvivalMapMainView, {
			ViewName.SurvivalToastView
		}) then
			arg_12_0._sceneMo.panel = nil

			logError("当前面板缓存异常，自动清空！！！")

			return true
		end

		return false
	end

	if arg_12_0._sceneMo.bag.totalMass > arg_12_0._sceneMo.bag.maxWeightLimit + SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.AttrWeight) then
		if arg_12_1 then
			GameFacade.showToast(ToastEnum.SurvivalNoMoveWeight)
		end

		return false
	end

	return true
end

function var_0_0.getTargetPos(arg_13_0)
	if not arg_13_0:canWalk() then
		return
	end

	return arg_13_0._targetPos, arg_13_0._targetPath
end

function var_0_0.getShowTargetPos(arg_14_0)
	if not arg_14_0:canWalk() then
		return
	end

	return arg_14_0._showTargetPos
end

var_0_0.instance = var_0_0.New()

return var_0_0

module("modules.logic.scene.shelter.entity.SurvivalShelterMonsterEntity", package.seeall)

local var_0_0 = class("SurvivalShelterMonsterEntity", SurvivalShelterUnitEntity)
local var_0_1 = "survival/effects/prefab/v2a8_scene_smoke_02.prefab"
local var_0_2 = "survival/effects/prefab/v2a8_scene_zhandou.prefab"
local var_0_3 = 3

function var_0_0.Create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = SurvivalShelterModel.instance:getNeedShowFightSuccess()
	local var_1_1, var_1_2 = SurvivalMapHelper.instance:getLocalShelterEntityPosAndDir(arg_1_0, arg_1_1, true)

	if var_1_0 then
		var_1_1 = SurvivalShelterModel.instance:getPlayerMo().pos
	end

	if not var_1_1 then
		logError(string.format("not find shelterFight random pos, shelterFightId:%s", arg_1_1))

		return
	end

	local var_1_3 = gohelper.create3d(arg_1_2, string.format("shelterFightId_%s%s", arg_1_1, tostring(var_1_1)))
	local var_1_4, var_1_5, var_1_6 = SurvivalHelper.instance:hexPointToWorldPoint(var_1_1.q, var_1_1.r)
	local var_1_7 = var_1_3.transform

	transformhelper.setLocalPos(var_1_7, var_1_4, var_1_5, var_1_6)
	transformhelper.setLocalRotation(var_1_7, 0, var_1_2 * 60, 0)

	local var_1_8 = {
		unitType = arg_1_0,
		unitId = arg_1_1,
		pos = var_1_1,
		dir = var_1_2
	}

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_3, var_0_0, var_1_8)
end

function var_0_0.onCtor(arg_2_0, arg_2_1)
	arg_2_0.pos = arg_2_1.pos
	arg_2_0.dir = arg_2_1.dir
	arg_2_0.ponitRange = {}

	SurvivalHelper.instance:addNodeToDict(arg_2_0.ponitRange, arg_2_0.pos)

	local var_2_0 = lua_survival_shelter_intrude_fight.configDict[arg_2_0.unitId]

	if var_2_0 and var_2_0.gridType == SurvivalEnum.ShelterGridType.Triangle then
		local var_2_1 = (arg_2_0.dir + 1) % 6
		local var_2_2 = (arg_2_0.dir + 2) % 6
		local var_2_3 = arg_2_0.pos + SurvivalEnum.DirToPos[var_2_1]
		local var_2_4 = arg_2_0.pos + SurvivalEnum.DirToPos[var_2_2]

		SurvivalHelper.instance:addNodeToDict(arg_2_0.ponitRange, var_2_3)
		SurvivalHelper.instance:addNodeToDict(arg_2_0.ponitRange, var_2_4)
	end
end

function var_0_0.onStart(arg_3_0)
	arg_3_0.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function var_0_0.onInit(arg_4_0)
	arg_4_0:showModel()
end

function var_0_0.showModel(arg_5_0)
	if not gohelper.isNil(arg_5_0.goModel) then
		return
	end

	if arg_5_0._loader then
		return
	end

	arg_5_0._loader = PrefabInstantiate.Create(arg_5_0.go)

	local var_5_0 = arg_5_0:getResPath()

	if string.nilorempty(var_5_0) then
		return
	end

	arg_5_0._loader:startLoad(var_5_0, arg_5_0._onResLoadEnd, arg_5_0)
end

function var_0_0._onResLoadEnd(arg_6_0)
	local var_6_0 = arg_6_0._loader:getInstGO()
	local var_6_1 = var_6_0.transform

	arg_6_0.goModel = var_6_0

	local var_6_2 = arg_6_0:getScale()

	transformhelper.setLocalScale(var_6_1, var_6_2, var_6_2, var_6_2)
	gohelper.addChild(arg_6_0.trans.parent.gameObject, arg_6_0.goModel)

	local var_6_3, var_6_4, var_6_5 = arg_6_0:getCenterPos()

	transformhelper.setLocalPos(var_6_1, var_6_3, var_6_4, var_6_5)
	gohelper.addChildPosStay(arg_6_0.go, arg_6_0.goModel)
	transformhelper.setLocalRotation(var_6_1, 0, 0, 0)
	arg_6_0:onLoadedEnd()
end

function var_0_0.getResPath(arg_7_0)
	local var_7_0 = lua_survival_shelter_intrude_fight.configDict[arg_7_0.unitId]

	if not var_7_0 then
		return nil
	end

	return var_7_0.model
end

function var_0_0.getScale(arg_8_0)
	local var_8_0 = lua_survival_shelter_intrude_fight.configDict[arg_8_0.unitId]

	return var_8_0 and var_8_0.scale * 0.01 or 1
end

function var_0_0._onResLoadEnd(arg_9_0)
	local var_9_0 = arg_9_0._loader:getInstGO()
	local var_9_1 = var_9_0.transform

	arg_9_0.goModel = var_9_0

	local var_9_2 = arg_9_0:getScale()

	transformhelper.setLocalScale(var_9_1, var_9_2, var_9_2, var_9_2)
	gohelper.addChild(arg_9_0.trans.parent.gameObject, arg_9_0.goModel)

	local var_9_3, var_9_4, var_9_5 = arg_9_0:getCenterPos()

	transformhelper.setLocalPos(var_9_1, var_9_3, var_9_4, var_9_5)
	gohelper.addChildPosStay(arg_9_0.go, arg_9_0.goModel)
	transformhelper.setLocalRotation(var_9_1, 0, 0, 0)
	arg_9_0:onLoadedEnd()
end

function var_0_0.needUI(arg_10_0)
	return true
end

function var_0_0.getCenterPos(arg_11_0)
	local var_11_0 = arg_11_0.ponitRange
	local var_11_1 = 0
	local var_11_2 = 0
	local var_11_3 = 0
	local var_11_4 = 0

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			local var_11_5, var_11_6, var_11_7 = SurvivalHelper.instance:hexPointToWorldPoint(iter_11_3.q, iter_11_3.r)

			var_11_1 = var_11_1 + var_11_5
			var_11_2 = var_11_2 + var_11_6
			var_11_3 = var_11_3 + var_11_7
			var_11_4 = var_11_4 + 1
		end
	end

	if var_11_4 > 0 then
		local var_11_8 = var_11_1 / var_11_4
		local var_11_9 = var_11_2 / var_11_4
		local var_11_10 = var_11_3 / var_11_4

		return var_11_8, var_11_9, var_11_10
	end

	return 0, 0, 0
end

function var_0_0.checkClick(arg_12_0, arg_12_1)
	return SurvivalHelper.instance:isHaveNode(arg_12_0.ponitRange, arg_12_1)
end

function var_0_0.isInPlayerPos(arg_13_0)
	local var_13_0 = SurvivalMapHelper.instance:getScene()

	if not var_13_0 then
		return false
	end

	return var_13_0.unit:getPlayer():isInPosList(arg_13_0.ponitRange)
end

function var_0_0.getEffectPath(arg_14_0)
	if SurvivalShelterModel.instance:getNeedShowFightSuccess() then
		return var_0_2
	end

	return var_0_1
end

function var_0_0.onEffectLoadedEnd(arg_15_0)
	if gohelper.isNil(arg_15_0._goEffect) then
		return
	end

	local var_15_0 = arg_15_0._goEffect.transform
	local var_15_1 = arg_15_0:getScale()

	transformhelper.setLocalScale(var_15_0, var_15_1, var_15_1, var_15_1)

	if SurvivalShelterModel.instance:getNeedShowFightSuccess() then
		transformhelper.setLocalPos(var_15_0, 0, -0.35, 0)
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_fight)
		TaskDispatcher.runDelay(arg_15_0._showSuccessFinish, arg_15_0, var_0_3)
	end
end

function var_0_0._showSuccessFinish(arg_16_0)
	SurvivalShelterModel.instance:setNeedShowFightSuccess(false, nil)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.BossFightSuccessShowFinish)
end

function var_0_0.onDestroy(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._showSuccessFinish, arg_17_0)
	var_0_0.super.onDestroy(arg_17_0)
end

function var_0_0.addEventListeners(arg_18_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnDecreeVoteStart, arg_18_0._onDecreeVoteStart, arg_18_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnDecreeVoteEnd, arg_18_0._onDecreeVoteEnd, arg_18_0)
end

function var_0_0.removeEventListeners(arg_19_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnDecreeVoteStart, arg_19_0._onDecreeVoteStart, arg_19_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnDecreeVoteEnd, arg_19_0._onDecreeVoteEnd, arg_19_0)
end

function var_0_0._onDecreeVoteStart(arg_20_0)
	arg_20_0:setVisible(false)
end

function var_0_0._onDecreeVoteEnd(arg_21_0)
	arg_21_0:setVisible(true)
end

return var_0_0

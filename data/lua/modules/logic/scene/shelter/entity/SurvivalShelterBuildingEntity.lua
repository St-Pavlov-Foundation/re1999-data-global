module("modules.logic.scene.shelter.entity.SurvivalShelterBuildingEntity", package.seeall)

local var_0_0 = class("SurvivalShelterBuildingEntity", SurvivalShelterUnitEntity)

function var_0_0.Create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = SurvivalConfig.instance:getShelterMapCo():getBuildingById(arg_1_1)
	local var_1_1 = gohelper.create3d(arg_1_2, tostring(var_1_0.pos))
	local var_1_2, var_1_3, var_1_4 = SurvivalHelper.instance:hexPointToWorldPoint(var_1_0.pos.q, var_1_0.pos.r)
	local var_1_5 = var_1_1.transform

	transformhelper.setLocalPos(var_1_5, var_1_2, var_1_3, var_1_4)
	transformhelper.setLocalRotation(var_1_5, 0, var_1_0.dir * 60, 0)

	local var_1_6 = {
		unitType = arg_1_0,
		unitId = arg_1_1,
		buildingCo = var_1_0
	}

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_1, var_0_0, var_1_6)
end

function var_0_0.onCtor(arg_2_0, arg_2_1)
	arg_2_0.buildingCo = arg_2_1.buildingCo
	arg_2_0.pos = arg_2_0.buildingCo.pos
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

	arg_5_0._loader = MultiAbLoader.New()

	local var_5_0, var_5_1 = arg_5_0:getResPath()

	arg_5_0._loader:addPath(var_5_0)
	arg_5_0._loader:addPath(var_5_1)
	arg_5_0._loader:startLoad(arg_5_0._onResLoadEnd, arg_5_0)
end

function var_0_0.getResPath(arg_6_0)
	local var_6_0 = SurvivalConfig.instance:getBuildingConfig(arg_6_0.buildingCo.cfgId, 1)

	return arg_6_0.buildingCo.assetPath, string.format("survival/buiding/v2a8/%s.prefab", var_6_0.ruins)
end

function var_0_0._onResLoadEnd(arg_7_0)
	local var_7_0, var_7_1 = arg_7_0:getResPath()
	local var_7_2 = arg_7_0._loader:getAssetItem(var_7_0)

	if var_7_2 then
		local var_7_3 = var_7_2:GetResource(var_7_0)

		arg_7_0.goModel = gohelper.clone(var_7_3, arg_7_0.go, "model")

		arg_7_0:initTrans(arg_7_0.goModel.transform)
	end

	local var_7_4 = arg_7_0._loader:getAssetItem(var_7_1)

	if var_7_4 then
		local var_7_5 = var_7_4:GetResource(var_7_1)

		arg_7_0.goRuins = gohelper.clone(var_7_5, arg_7_0.go, "ruins")

		arg_7_0:initTrans(arg_7_0.goRuins.transform)
	end

	arg_7_0:onLoadedEnd()
end

function var_0_0.initTrans(arg_8_0, arg_8_1)
	transformhelper.setLocalPos(arg_8_1, 0, 0, 0)
	transformhelper.setLocalRotation(arg_8_1, 0, 0, 0)
	transformhelper.setLocalScale(arg_8_1, 1, 1, 1)
end

function var_0_0.canShow(arg_9_0)
	local var_9_0 = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfo(arg_9_0.unitId)

	return var_9_0 and var_9_0:isBuild() or false
end

function var_0_0.setVisible(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._isVisible == arg_10_1 and not arg_10_2 then
		return
	end

	arg_10_0._isVisible = arg_10_1

	gohelper.setActive(arg_10_0.goModel, arg_10_0._isVisible)
	gohelper.setActive(arg_10_0.goRuins, not arg_10_0._isVisible)
	arg_10_0:onChangeEntity()
end

function var_0_0.checkClick(arg_11_0, arg_11_1)
	return arg_11_0.buildingCo:isInRange(arg_11_1)
end

function var_0_0.needUI(arg_12_0)
	return true
end

function var_0_0.getCenterPos(arg_13_0)
	local var_13_0 = arg_13_0.buildingCo.ponitRange
	local var_13_1 = 0
	local var_13_2 = 0
	local var_13_3 = 0
	local var_13_4 = 0

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		for iter_13_2, iter_13_3 in pairs(iter_13_1) do
			local var_13_5, var_13_6, var_13_7 = SurvivalHelper.instance:hexPointToWorldPoint(iter_13_3.q, iter_13_3.r)

			var_13_1 = var_13_1 + var_13_5
			var_13_2 = var_13_2 + var_13_6
			var_13_3 = var_13_3 + var_13_7
			var_13_4 = var_13_4 + 1
		end
	end

	if var_13_4 > 0 then
		local var_13_8 = var_13_1 / var_13_4
		local var_13_9 = var_13_2 / var_13_4
		local var_13_10 = var_13_3 / var_13_4

		return var_13_8, var_13_9, var_13_10
	end

	return 0, 0, 0
end

function var_0_0.showBuildEffect(arg_14_0)
	ViewMgr.instance:closeAllPopupViews()

	local var_14_0, var_14_1, var_14_2 = arg_14_0:getCenterPos()

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(var_14_0, var_14_1, var_14_2), 0.5, arg_14_0._showBuildEffect, arg_14_0)
end

function var_0_0._showBuildEffect(arg_15_0)
	local var_15_0 = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfo(arg_15_0.unitId)

	if not var_15_0 then
		return
	end

	local var_15_1 = var_15_0.level > 1

	arg_15_0._effectDelayTime = 1
	arg_15_0._effectAudioId = var_15_1 and AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_transmit or AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_build

	local var_15_2 = var_15_1 and SurvivalEnum.UnitEffectPath.Transfer2 or SurvivalEnum.UnitEffectPath.CreateUnit

	arg_15_0:loadEffect(var_15_2)
end

function var_0_0.loadEffect(arg_16_0, arg_16_1)
	if not arg_16_0.buildEffect then
		local var_16_0, var_16_1, var_16_2 = arg_16_0:getCenterPos()
		local var_16_3 = gohelper.create3d(arg_16_0.go, "effect")

		transformhelper.setPos(var_16_3.transform, var_16_0, 0, var_16_2)
		transformhelper.setEulerAngles(var_16_3.transform, 0, 0, 0)

		arg_16_0.buildEffect = PrefabInstantiate.Create(var_16_3)
	else
		arg_16_0.buildEffect:dispose()
	end

	arg_16_0.buildEffect:startLoad(arg_16_1, arg_16_0._onBuildEffectLoaded, arg_16_0)
end

function var_0_0._onBuildEffectLoaded(arg_17_0)
	if arg_17_0._effectAudioId then
		AudioMgr.instance:trigger(arg_17_0._effectAudioId)
	end

	if arg_17_0._effectDelayTime then
		TaskDispatcher.runDelay(arg_17_0._onBuildEffectPlayFinish, arg_17_0, arg_17_0._effectDelayTime)
	else
		arg_17_0:_onBuildEffectPlayFinish()
	end
end

function var_0_0._onBuildEffectPlayFinish(arg_18_0)
	arg_18_0._effectDelayTime = nil

	if arg_18_0.buildEffect then
		arg_18_0.buildEffect:dispose()
	end

	arg_18_0:updateEntity(true)
end

function var_0_0.updateEntity(arg_19_0, arg_19_1)
	if arg_19_0._effectDelayTime then
		return
	end

	var_0_0.super.updateEntity(arg_19_0, arg_19_1)
end

function var_0_0.onDestroy(arg_20_0)
	arg_20_0._effectDelayTime = nil

	TaskDispatcher.cancelTask(arg_20_0._onBuildEffectPlayFinish, arg_20_0)
	var_0_0.super.onDestroy(arg_20_0)
end

return var_0_0

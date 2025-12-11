module("modules.logic.scene.survival.util.SurvivalSceneAmbientUtil", package.seeall)

local var_0_0 = class("SurvivalSceneAmbientUtil")
local var_0_1 = UnityEngine.Shader
local var_0_2 = RoomSceneAmbientComp.ShaderIDMap

function var_0_0._onLightLoaded(arg_1_0, arg_1_1, arg_1_2)
	if not arg_1_1 then
		return
	end

	local var_1_0 = arg_1_1:GetComponentsInChildren(typeof(UnityEngine.Light))

	for iter_1_0 = 0, var_1_0.Length - 1 do
		local var_1_1 = var_1_0[iter_1_0]

		if var_1_1.type == UnityEngine.LightType.Directional then
			arg_1_0._light = var_1_1
			arg_1_0._lightTrans = arg_1_0._light.transform

			break
		end
	end

	if not arg_1_0._light then
		logError("没有平行光")
	end

	arg_1_0._sceneAmbient = arg_1_1:GetComponentInChildren(typeof(ZProj.SceneAmbient))
	arg_1_0._sceneAmbientData = arg_1_0._sceneAmbient and arg_1_0._sceneAmbient.data
	arg_1_0._matFogPlane = arg_1_0._sceneAmbient and arg_1_0._sceneAmbient.matFogPlane
	arg_1_0._matFogParticle = arg_1_0._sceneAmbient and arg_1_0._sceneAmbient.matFogParticle

	arg_1_0:initData()
	arg_1_0:updateSceneAmbient(arg_1_2)
end

function var_0_0.disable(arg_2_0)
	arg_2_0:killTween()

	arg_2_0._light = nil
	arg_2_0._lightTrans = nil
	arg_2_0._data = nil
	arg_2_0._fromData = nil
	arg_2_0._toData = nil
	arg_2_0._configs = nil
end

local var_0_3 = {
	"sur_day3",
	"sur_day",
	"sur_day2",
	"sur_night"
}

function var_0_0.initData(arg_3_0)
	arg_3_0._configs = {}
	arg_3_0._tempV2 = Vector2()
	arg_3_0._tempV4 = Vector4()
	arg_3_0._tempColor = Color()

	for iter_3_0, iter_3_1 in ipairs(var_0_3) do
		local var_3_0 = RoomConfig.instance:getSceneAmbientConfig(iter_3_1)

		if not var_3_0 then
			logError("配置不存在" .. iter_3_1)
		else
			table.insert(arg_3_0._configs, var_3_0)
		end
	end
end

function var_0_0.TrV2(arg_4_0, arg_4_1)
	arg_4_0._tempV2:Set(unpack(arg_4_1))

	return arg_4_0._tempV2
end

function var_0_0.TrV4(arg_5_0, arg_5_1)
	arg_5_0._tempV4:Set(unpack(arg_5_1))

	return arg_5_0._tempV4
end

function var_0_0.V4(arg_6_0, ...)
	arg_6_0._tempV4:Set(...)

	return arg_6_0._tempV4
end

function var_0_0.TrColor(arg_7_0, arg_7_1)
	arg_7_0._tempColor:Set(unpack(arg_7_1))

	return arg_7_0._tempColor
end

function var_0_0.updateSceneAmbient(arg_8_0, arg_8_1)
	if arg_8_1 == nil then
		arg_8_1 = SurvivalMapHelper:isInShelterScene()
	end

	if arg_8_1 then
		arg_8_0._data = arg_8_0._configs[1]

		arg_8_0:applyData()
	else
		if not arg_8_0._configs or not arg_8_0._configs[2] then
			return
		end

		arg_8_0:calcData()

		if not arg_8_0._data then
			arg_8_0._data = arg_8_0:simpleCopy(arg_8_0._toData, arg_8_0._data)

			arg_8_0:applyData()
		else
			arg_8_0._fromData = arg_8_0:simpleCopy(arg_8_0._data, arg_8_0._fromData)

			arg_8_0:killTween()

			arg_8_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, SurvivalConst.PlayerMoveSpeed, arg_8_0._onTweenFrame, arg_8_0._onTweenEnd, arg_8_0, nil, EaseType.Linear)
		end
	end
end

function var_0_0.applyData(arg_9_0)
	arg_9_0:applyShaher()
	arg_9_0:applyAmbient()
	arg_9_0:applyLight()
	arg_9_0:applyFog()
end

function var_0_0.killTween(arg_10_0)
	if not arg_10_0._tweenId then
		return
	end

	ZProj.TweenHelper.KillById(arg_10_0._tweenId)

	arg_10_0._tweenId = nil
end

function var_0_0._onTweenFrame(arg_11_0, arg_11_1)
	arg_11_0._data = arg_11_0:lerpVal(arg_11_1, arg_11_0._fromData, arg_11_0._toData, arg_11_0._data)

	arg_11_0:applyData()
end

function var_0_0._onTweenEnd(arg_12_0)
	arg_12_0._tweenId = nil
end

function var_0_0.calcData(arg_13_0)
	local var_13_0 = SurvivalMapModel.instance:getSceneMo()
	local var_13_1 = var_13_0.gameTime - var_13_0.addTime
	local var_13_2 = (var_13_0.currMaxGameTime - var_13_0.addTime) / (#arg_13_0._configs - 1)
	local var_13_3 = math.ceil(var_13_1 / var_13_2)
	local var_13_4 = Mathf.Clamp(var_13_3, 1, #arg_13_0._configs - 1)
	local var_13_5 = var_13_4 + 1
	local var_13_6 = (var_13_1 - (var_13_4 - 1) * var_13_2) / var_13_2
	local var_13_7 = arg_13_0._configs[var_13_4]
	local var_13_8 = arg_13_0._configs[var_13_5]

	arg_13_0._toData = arg_13_0:lerpVal(var_13_6, var_13_7, var_13_8, arg_13_0._toData)
end

function var_0_0.lerpVal(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if type(arg_14_2) == "table" then
		arg_14_4 = arg_14_4 or {}

		for iter_14_0 in pairs(arg_14_2) do
			arg_14_4[iter_14_0] = arg_14_0:lerpVal(arg_14_1, arg_14_2[iter_14_0], arg_14_3[iter_14_0], arg_14_4[iter_14_0])
		end

		return arg_14_4
	elseif type(arg_14_2) == "number" then
		return Mathf.Lerp(arg_14_2, arg_14_3, arg_14_1)
	end
end

function var_0_0.simpleCopy(arg_15_0, arg_15_1, arg_15_2)
	if type(arg_15_1) == "table" then
		arg_15_2 = arg_15_2 or {}

		for iter_15_0, iter_15_1 in pairs(arg_15_1) do
			arg_15_2[iter_15_0] = arg_15_0:simpleCopy(iter_15_1, arg_15_2[iter_15_0])
		end

		return arg_15_2
	else
		return arg_15_1
	end
end

function var_0_0.applyShaher(arg_16_0)
	if not arg_16_0._data then
		return
	end

	var_0_1.SetGlobalFloat(var_0_2.AMBIENTSIZE, arg_16_0._data.ambientsize)
	var_0_1.SetGlobalFloat(var_0_2.HFLAMBERT, arg_16_0._data.hflambert)
	var_0_1.SetGlobalColor(var_0_2.AMBIENTCOL, arg_16_0:TrColor(arg_16_0._data.ambientcol))
	var_0_1.SetGlobalVector(var_0_2.SHADOW_PARAMS, arg_16_0:V4(arg_16_0._data.outsideShadow, arg_16_0._data.insideShadow))
	var_0_1.SetGlobalVector(var_0_2.SHADOW_PARAMS_OPT, arg_16_0:V4(arg_16_0._data.insideShadow - arg_16_0._data.outsideShadow, arg_16_0._data.outsideShadow))
	var_0_1.SetGlobalColor(var_0_2._ShadowColor, arg_16_0:TrColor(arg_16_0._data.shadowColor))
	var_0_1.SetGlobalColor(var_0_2.FOGCOLOR, arg_16_0:TrColor(arg_16_0._data.fogColor))
	var_0_1.SetGlobalColor(var_0_2.FOGCOLOR2, arg_16_0:TrColor(arg_16_0._data.fogColor2))
	var_0_1.SetGlobalVector(var_0_2.FOGPARAMS, arg_16_0:TrV4(arg_16_0._data.fogParams))
	var_0_1.SetGlobalFloat(var_0_2.FOGHEIGHT, arg_16_0._data.fogHeight)
	var_0_1.SetGlobalFloat(var_0_2.HEIGHTFOGEDGE, arg_16_0._data.heightfogedge)
	var_0_1.SetGlobalFloat(var_0_2.DISFOGSTART, arg_16_0._data.disfogstart)
	var_0_1.SetGlobalFloat(var_0_2.DISFOGEDGE, arg_16_0._data.disfogedge)
	var_0_1.SetGlobalFloat(var_0_2.ADD_RANGE, arg_16_0._data.addRange)

	local var_16_0 = 1 / arg_16_0._data.disfogedge
	local var_16_1 = -arg_16_0._data.disfogstart / arg_16_0._data.disfogedge
	local var_16_2 = arg_16_0:TrV4(arg_16_0._data.fogParams)
	local var_16_3 = var_16_2.x
	local var_16_4 = var_16_2.y - var_16_3
	local var_16_5 = var_16_4 ~= 0 and 1 / var_16_4 or var_16_3
	local var_16_6 = -var_16_3 * var_16_5

	var_0_1.SetGlobalVector(var_0_2._DisFogDataAndFogParmasOpt, arg_16_0:V4(var_16_0, var_16_1, var_16_5, var_16_6))
end

function var_0_0.applyAmbient(arg_17_0)
	if not arg_17_0._sceneAmbient or not arg_17_0._data or not arg_17_0._sceneAmbientData then
		return
	end

	arg_17_0._sceneAmbientData.rimcol = arg_17_0:TrColor(arg_17_0._data.rimcol)
	arg_17_0._sceneAmbientData.lightRangeNear = arg_17_0._data.lightRangeNear
	arg_17_0._sceneAmbientData.lightRangeFar = arg_17_0._data.lightRangeFar
	arg_17_0._sceneAmbientData.lightOffsetNear = arg_17_0._data.lightOffsetNear
	arg_17_0._sceneAmbientData.lightOffsetFar = arg_17_0._data.lightOffsetFar
	arg_17_0._sceneAmbientData.cameraDistanceValue = arg_17_0._data.cameraDistanceValue
	arg_17_0._sceneAmbientData.lightmin = arg_17_0._data.lightmin
	arg_17_0._sceneAmbientData.lightmax = arg_17_0._data.lightmax
	arg_17_0._sceneAmbientData.lightParams = arg_17_0:TrV2(arg_17_0._data.lightParams)
	arg_17_0._sceneAmbient.data = arg_17_0._sceneAmbientData
end

function var_0_0.applyLight(arg_18_0)
	if not arg_18_0._light or not arg_18_0._data then
		return
	end

	arg_18_0._light.color = arg_18_0:TrColor(arg_18_0._data.dirLightColor)
	arg_18_0._light.intensity = arg_18_0._data.dirLightIntensity

	local var_18_0 = arg_18_0:TrV4(arg_18_0._data.lightDir)

	transformhelper.setLocalRotation(arg_18_0._lightTrans, var_18_0.x, var_18_0.y, var_18_0.z)
end

function var_0_0.applyFog(arg_19_0)
	if not arg_19_0._data then
		return
	end

	if arg_19_0._matFogParticle then
		arg_19_0._matFogParticle:SetColor(var_0_2.FOGMAINCOL, arg_19_0:TrColor(arg_19_0._data.fogMainCol))
		arg_19_0._matFogParticle:SetColor(var_0_2.FOGOUTSIDECOL, arg_19_0:TrColor(arg_19_0._data.fogOutSideCol))
	end

	if arg_19_0._matFogPlane then
		arg_19_0._matFogPlane:SetColor(var_0_2.FOGPLANEMAINCOLOR, arg_19_0:TrColor(arg_19_0._data.fogPlaneMainCol))
		arg_19_0._matFogPlane:SetColor(var_0_2.FOGPLANEOUTSIDECOLOR, arg_19_0:TrColor(arg_19_0._data.fogPlaneOutSideCol))
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

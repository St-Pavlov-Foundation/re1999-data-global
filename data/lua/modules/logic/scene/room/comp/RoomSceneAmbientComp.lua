module("modules.logic.scene.room.comp.RoomSceneAmbientComp", package.seeall)

local var_0_0 = class("RoomSceneAmbientComp", BaseSceneComp)
local var_0_1 = UnityEngine.Shader
local var_0_2 = {
	LIGHTRANGE = var_0_1.PropertyToID("_LightRange"),
	LIGHTOFFSET = var_0_1.PropertyToID("_LightOffset"),
	LIGHTPOSITION = var_0_1.PropertyToID("_LightPosition"),
	LIGHTMAX = var_0_1.PropertyToID("_LightMax"),
	LIGHTMIN = var_0_1.PropertyToID("_LightMin"),
	LIGHTCOLA = var_0_1.PropertyToID("_LightColA"),
	_LightParamOptimize = var_0_1.PropertyToID("_LightParamOptimize"),
	LIGHTPARAMS = var_0_1.PropertyToID("_LightParams"),
	BENDING_AMOUNT = var_0_1.PropertyToID("_Curvature"),
	BENDING_AMOUNT_SCALED = var_0_1.PropertyToID("_CurvatureScaled"),
	AMBIENTSIZE = var_0_1.PropertyToID("_AmbientSize"),
	HFLAMBERT = var_0_1.PropertyToID("_Hflambert"),
	AMBIENTCOL = var_0_1.PropertyToID("_AmbientCol"),
	_ShadowColor = var_0_1.PropertyToID("_ShadowColor"),
	SHADOW_PARAMS = var_0_1.PropertyToID("_ShadowParams"),
	SHADOW_PARAMS_OPT = var_0_1.PropertyToID("_ShadowParamsOpt"),
	FOGCOLOR = var_0_1.PropertyToID("_FogColor"),
	FOGCOLOR2 = var_0_1.PropertyToID("_FogColor2"),
	FOGPARAMS = var_0_1.PropertyToID("_FogParams"),
	FOGHEIGHT = var_0_1.PropertyToID("_FogHeight"),
	HEIGHTFOGEDGE = var_0_1.PropertyToID("_HeightFogEdge"),
	DISFOGSTART = var_0_1.PropertyToID("_DisFogStart"),
	_DisFogDataAndFogParmasOpt = var_0_1.PropertyToID("_DisFogDataAndFogParmasOpt"),
	DISFOGEDGE = var_0_1.PropertyToID("_DisFogEdge"),
	FOGDENSITYMIN = var_0_1.PropertyToID("_FogDensityMin"),
	FOGDENSITYMAX = var_0_1.PropertyToID("_FogDensityMax"),
	FOGMAINCOL = var_0_1.PropertyToID("_MainCol"),
	FOGOUTSIDECOL = var_0_1.PropertyToID("_OutSideCol"),
	FOGPLANEOUTSIDECOLOR = var_0_1.PropertyToID("_OutSideColor"),
	FOGPLANEMAINCOLOR = var_0_1.PropertyToID("_MainColor"),
	FogDensityData = var_0_1.PropertyToID("_FogDensityData"),
	ADD_RANGE = var_0_1.PropertyToID("_AddRange")
}

var_0_0.ShaderIDMap = var_0_2

local var_0_3 = {
	vector3 = 3,
	vector4 = 4,
	color = 5,
	vector2 = 2,
	number = 1
}
local var_0_4 = {
	ambientsize = var_0_3.number,
	hflambert = var_0_3.number,
	ambientcol = var_0_3.color,
	outsideShadow = var_0_3.number,
	insideShadow = var_0_3.number,
	shadowColor = var_0_3.color,
	fogColor = var_0_3.color,
	fogColor2 = var_0_3.color,
	fogParams = var_0_3.vector2,
	fogHeight = var_0_3.number,
	heightfogedge = var_0_3.number,
	disfogstart = var_0_3.number,
	disfogedge = var_0_3.number,
	fogdensitymin = var_0_3.number,
	fogdensitymax = var_0_3.number,
	addRange = var_0_3.number,
	dirLightColor = var_0_3.color,
	dirLightIntensity = var_0_3.number,
	lightDir = var_0_3.vector3,
	fogPlaneMainCol = var_0_3.color,
	fogPlaneOutSideCol = var_0_3.color,
	fogMainCol = var_0_3.color,
	fogOutSideCol = var_0_3.color,
	rimcol = var_0_3.color,
	lightRangeNear = var_0_3.number,
	lightRangeFar = var_0_3.number,
	lightOffsetNear = var_0_3.number,
	lightOffsetFar = var_0_3.number,
	cameraDistanceValue = var_0_3.number,
	lightmin = var_0_3.number,
	lightmax = var_0_3.number,
	lightParams = var_0_3.vector2
}
local var_0_5 = "night_1"
local var_0_6 = {
	"day_1",
	"day_2",
	"afternoon",
	"night_1"
}

var_0_0.Update_Rate_Time = 10
var_0_0.Switch_Tween_Time = 5

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0._matFogPlane = arg_2_0._scene.go.sceneAmbient.matFogPlane
	arg_2_0._matFogParticle = arg_2_0._scene.go.sceneAmbient.matFogParticle
	arg_2_0._updateRateTime = var_0_0.Update_Rate_Time
	arg_2_0._swithchTweenTime = var_0_0.Switch_Tween_Time

	local var_2_0 = CommonConfig.instance:getConstStr(ConstEnum.RoomWeatherUpdateTime)

	if not string.nilorempty(var_2_0) then
		local var_2_1 = string.splitToNumber(var_2_0, "#")

		arg_2_0._updateRateTime = var_2_1[1] or var_0_0.Update_Rate_Time
		arg_2_0._swithchTweenTime = var_2_1[2] or 0
	end

	local var_2_2 = arg_2_0:_isCanUpdate()

	if arg_2_0._lastAutoUpdateReport ~= var_2_2 then
		arg_2_0._lastAutoUpdateReport = var_2_2

		arg_2_0:reset()
	end
end

function var_0_0.reset(arg_3_0)
	arg_3_0._ambientId = nil
	arg_3_0._curDataParams = nil
	arg_3_0._data = nil

	local var_3_0 = arg_3_0._curRoomMode

	arg_3_0._curRoomMode = RoomModel.instance:getGameMode()
	arg_3_0._ambientIds = {}

	for iter_3_0, iter_3_1 in ipairs(var_0_6) do
		if RoomConfig.instance:getSceneAmbientConfig(iter_3_1) then
			table.insert(arg_3_0._ambientIds, iter_3_1)
		end
	end

	TaskDispatcher.cancelTask(arg_3_0.updateReport, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._initReport, arg_3_0)

	if arg_3_0:_isCanUpdate() then
		TaskDispatcher.runRepeat(arg_3_0.updateReport, arg_3_0, arg_3_0._updateRateTime)
	end

	TaskDispatcher.runDelay(arg_3_0._initReport, arg_3_0, 0.1)
end

function var_0_0._initReport(arg_4_0)
	local var_4_0 = 1

	if arg_4_0:_isCanUpdate() then
		local var_4_1, var_4_2 = WeatherModel.instance:getReport()

		if var_4_1 then
			var_4_0 = var_4_1.roomMode
		end
	end

	arg_4_0:tweenToAmbientId(arg_4_0._ambientIds[var_4_0] or arg_4_0._ambientIds[1])
end

function var_0_0._isCanUpdate(arg_5_0)
	if RoomController.instance:isObMode() or RoomController.instance:isVisitMode() then
		return true
	end

	return false
end

function var_0_0.updateReport(arg_6_0)
	if not arg_6_0._ambientIds then
		return
	end

	arg_6_0._ambientIds = arg_6_0._ambientIds

	local var_6_0 = (tabletool.indexOf(arg_6_0._ambientIds, arg_6_0._ambientId) or 0) + 1

	if var_6_0 > #arg_6_0._ambientIds then
		var_6_0 = 1
	end

	arg_6_0:tweenToAmbientId(arg_6_0._ambientIds[var_6_0])
end

function var_0_0._getKeyTypeFuncMap(arg_7_0)
	if not arg_7_0._keyTypeFuncMap then
		arg_7_0._keyTypeFuncMap = {
			[var_0_3.number] = arg_7_0._paramToNumber,
			[var_0_3.vector2] = arg_7_0._paramToVector2,
			[var_0_3.vector3] = arg_7_0._paramToVector3,
			[var_0_3.vector4] = arg_7_0._paramToVector4,
			[var_0_3.color] = arg_7_0._paramToColor
		}
	end

	return arg_7_0._keyTypeFuncMap
end

function var_0_0.tweenToAmbientId(arg_8_0, arg_8_1)
	local var_8_0 = RoomConfig.instance:getSceneAmbientConfig(arg_8_1)

	if not var_8_0 then
		logError(string.format("room_scene_ambient --> can not find ambientId:[%s]", arg_8_1))

		return
	end

	arg_8_0:_killTween()

	arg_8_0._ambientId = arg_8_1

	if not arg_8_0._curDataParams then
		arg_8_0:_updateData(1, var_8_0, var_8_0)
		arg_8_0:_nightLight()

		return
	end

	local var_8_1 = {
		fromAmbientCfg = arg_8_0:_copyAmbientParam(arg_8_0._curDataParams or var_8_0),
		toAmbientCfg = var_8_0
	}
	local var_8_2 = arg_8_0._swithchTweenTime or var_0_0.Switch_Tween_Time

	arg_8_0._tweenId = arg_8_0._scene.tween:tweenFloat(0, 1, var_8_2, arg_8_0._frameCallback, arg_8_0._finishCallback, arg_8_0, var_8_1)

	arg_8_0:_nightLight()
end

function var_0_0._killTween(arg_9_0)
	if arg_9_0._tweenId then
		arg_9_0._scene.tween:killById(arg_9_0._tweenId)

		arg_9_0._tweenId = nil
	end
end

function var_0_0._frameCallback(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:_updateData(arg_10_1, arg_10_2.fromAmbientCfg, arg_10_2.toAmbientCfg)
end

function var_0_0._finishCallback(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._tweenId = nil
end

function var_0_0._copyAmbientParam(arg_12_0, arg_12_1)
	local var_12_0 = {}

	arg_12_0:_getZoomAmbientParam(1, var_12_0, arg_12_1, arg_12_1)

	return var_12_0
end

function var_0_0._getZoomAmbientParam(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = var_0_4

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if arg_13_3[iter_13_0] ~= nil and arg_13_4[iter_13_0] ~= nil then
			if iter_13_1 == var_0_3.number then
				arg_13_0:_zoomToKeyNumber(arg_13_2, iter_13_0, arg_13_1, arg_13_3[iter_13_0], arg_13_4[iter_13_0])
			else
				arg_13_0:_zoomToKeyTable(arg_13_2, iter_13_0, arg_13_1, arg_13_3[iter_13_0], arg_13_4[iter_13_0])
			end
		end
	end
end

function var_0_0._updateData(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2 == nil and arg_14_3 == nil then
		return
	end

	local var_14_0 = arg_14_2 or arg_14_3
	local var_14_1 = arg_14_3 or arg_14_2

	arg_14_0._data = arg_14_0._data or {}
	arg_14_0._curDataParams = arg_14_0._curDataParams or {}

	arg_14_0:_getZoomAmbientParam(arg_14_1, arg_14_0._curDataParams, var_14_0, var_14_1)

	local var_14_2 = var_0_4
	local var_14_3 = arg_14_0:_getKeyTypeFuncMap()

	for iter_14_0, iter_14_1 in pairs(var_14_2) do
		if arg_14_0._curDataParams[iter_14_0] ~= nil then
			local var_14_4 = var_14_3[iter_14_1]

			if var_14_4 then
				arg_14_0._data[iter_14_0] = var_14_4(arg_14_0, arg_14_0._curDataParams[iter_14_0])
			else
				logError(string.format("can not find keyTypeFuncMap[%s]", iter_14_1))
			end
		else
			logError(string.format("can not find key[%s]", iter_14_0))
		end
	end

	arg_14_0:applyInspectorParam()
end

function var_0_0._zoomToKeyNumber(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	arg_15_1[arg_15_2] = arg_15_0:_zoomToNumber(arg_15_3, arg_15_4, arg_15_5)
end

function var_0_0._zoomToKeyTable(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	if not arg_16_1[arg_16_2] then
		arg_16_1[arg_16_2] = {}
	end

	local var_16_0 = arg_16_1[arg_16_2]

	for iter_16_0 = 1, #arg_16_4 do
		var_16_0[iter_16_0] = arg_16_0:_zoomToNumber(arg_16_3, arg_16_4[iter_16_0], arg_16_5[iter_16_0])
	end
end

function var_0_0._zoomToNumber(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_1 >= 1 then
		return arg_17_3
	elseif arg_17_1 <= 0 then
		return arg_17_2
	end

	return arg_17_2 + (arg_17_3 - arg_17_2) * arg_17_1
end

function var_0_0._paramToNumber(arg_18_0, arg_18_1)
	return arg_18_1
end

function var_0_0._paramToVector2(arg_19_0, arg_19_1)
	return Vector4(arg_19_1[1], arg_19_1[2], 0, 0)
end

function var_0_0._paramToVector3(arg_20_0, arg_20_1)
	return Vector4(arg_20_1[1], arg_20_1[2], arg_20_1[3], 0)
end

function var_0_0._paramTooVector4(arg_21_0, arg_21_1)
	return Vector4(arg_21_1[1], arg_21_1[2], arg_21_1[3], arg_21_1[4])
end

function var_0_0._paramToColor(arg_22_0, arg_22_1)
	return Color(arg_22_1[1], arg_22_1[2], arg_22_1[3], arg_22_1[4])
end

function var_0_0.applyInspectorParam(arg_23_0)
	arg_23_0:_applyShaher()
	arg_23_0:_applyAmbientData()
	arg_23_0:_applyLightComp()
	arg_23_0:_applyFog()
end

function var_0_0._applyShaher(arg_24_0)
	if not arg_24_0._data then
		return
	end

	local var_24_0 = arg_24_0._data

	var_0_1.SetGlobalFloat(var_0_2.AMBIENTSIZE, var_24_0.ambientsize)
	var_0_1.SetGlobalFloat(var_0_2.HFLAMBERT, var_24_0.hflambert)
	var_0_1.SetGlobalColor(var_0_2.AMBIENTCOL, var_24_0.ambientcol)
	var_0_1.SetGlobalVector(var_0_2.SHADOW_PARAMS, Vector4(var_24_0.outsideShadow, var_24_0.insideShadow))
	var_0_1.SetGlobalVector(var_0_2.SHADOW_PARAMS_OPT, Vector4(var_24_0.insideShadow - var_24_0.outsideShadow, var_24_0.outsideShadow))
	var_0_1.SetGlobalColor(var_0_2._ShadowColor, var_24_0.shadowColor)
	var_0_1.SetGlobalColor(var_0_2.FOGCOLOR, var_24_0.fogColor)
	var_0_1.SetGlobalColor(var_0_2.FOGCOLOR2, var_24_0.fogColor2)
	var_0_1.SetGlobalVector(var_0_2.FOGPARAMS, var_24_0.fogParams)
	var_0_1.SetGlobalFloat(var_0_2.FOGHEIGHT, var_24_0.fogHeight)
	var_0_1.SetGlobalFloat(var_0_2.HEIGHTFOGEDGE, var_24_0.heightfogedge)
	var_0_1.SetGlobalFloat(var_0_2.DISFOGSTART, var_24_0.disfogstart)
	var_0_1.SetGlobalFloat(var_0_2.DISFOGEDGE, var_24_0.disfogedge)
	var_0_1.SetGlobalFloat(var_0_2.ADD_RANGE, var_24_0.addRange)

	local var_24_1 = 1 / var_24_0.disfogedge
	local var_24_2 = -var_24_0.disfogstart / var_24_0.disfogedge
	local var_24_3 = var_24_0.fogParams.x
	local var_24_4 = var_24_0.fogParams.y - var_24_3
	local var_24_5 = var_24_4 ~= 0 and 1 / var_24_4 or var_24_3
	local var_24_6 = -var_24_3 * var_24_5

	var_0_1.SetGlobalVector(var_0_2._DisFogDataAndFogParmasOpt, Vector4(var_24_1, var_24_2, var_24_5, var_24_6))
end

function var_0_0._applyAmbientData(arg_25_0)
	local var_25_0 = arg_25_0._scene.go.sceneAmbientData
	local var_25_1 = arg_25_0._scene.go.sceneAmbient
	local var_25_2 = arg_25_0._data

	if var_25_2 and var_25_1 and var_25_0 then
		var_25_0.rimcol = var_25_2.rimcol
		var_25_0.lightRangeNear = var_25_2.lightRangeNear
		var_25_0.lightRangeFar = var_25_2.lightRangeFar
		var_25_0.lightOffsetNear = var_25_2.lightOffsetNear
		var_25_0.lightOffsetFar = var_25_2.lightOffsetFar
		var_25_0.cameraDistanceValue = var_25_2.cameraDistanceValue
		var_25_0.lightmin = var_25_2.lightmin
		var_25_0.lightmax = var_25_2.lightmax
		var_25_0.lightParams = var_25_2.lightParams
		var_25_1.data = var_25_0
	end
end

function var_0_0._applyLightComp(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._scene.light
	local var_26_1 = arg_26_0._data

	if var_26_0 and var_26_1 then
		var_26_0:setLightColor(var_26_1.dirLightColor)
		var_26_0:setLightIntensity(var_26_1.dirLightIntensity)
		var_26_0:setLocalRotation(var_26_1.lightDir.x, var_26_1.lightDir.y, var_26_1.lightDir.z)
	end
end

function var_0_0._applyFog(arg_27_0)
	local var_27_0 = arg_27_0._data

	if var_27_0 then
		if arg_27_0._matFogParticle then
			arg_27_0._matFogParticle:SetColor(var_0_2.FOGMAINCOL, var_27_0.fogMainCol)
			arg_27_0._matFogParticle:SetColor(var_0_2.FOGOUTSIDECOL, var_27_0.fogOutSideCol)
		end

		if arg_27_0._matFogPlane then
			arg_27_0._matFogPlane:SetColor(var_0_2.FOGPLANEMAINCOLOR, var_27_0.fogPlaneMainCol)
			arg_27_0._matFogPlane:SetColor(var_0_2.FOGPLANEOUTSIDECOLOR, var_27_0.fogPlaneOutSideCol)
		end
	end
end

function var_0_0._nightLight(arg_28_0)
	local var_28_0 = arg_28_0._ambientId == var_0_5

	if RoomWeatherModel.instance:getIsNight() ~= var_28_0 then
		RoomWeatherModel.instance:setIsNight(var_28_0)
		RoomMapController.instance:dispatchEvent(RoomEvent.MapEntityNightLight, var_28_0)
	end
end

function var_0_0.onSceneClose(arg_29_0)
	arg_29_0._matFogParticle = nil
	arg_29_0._matFogPlane = nil
	arg_29_0._curRoomMode = nil
	arg_29_0._lastAutoUpdateReport = nil

	TaskDispatcher.cancelTask(arg_29_0.updateReport, arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._initReport, arg_29_0)
	arg_29_0:_killTween()
end

return var_0_0

module("modules.logic.scene.room.comp.RoomSceneAmbientComp", package.seeall)

slot0 = class("RoomSceneAmbientComp", BaseSceneComp)
slot1 = UnityEngine.Shader
slot2 = {
	LIGHTRANGE = slot1.PropertyToID("_LightRange"),
	LIGHTOFFSET = slot1.PropertyToID("_LightOffset"),
	LIGHTPOSITION = slot1.PropertyToID("_LightPosition"),
	LIGHTMAX = slot1.PropertyToID("_LightMax"),
	LIGHTMIN = slot1.PropertyToID("_LightMin"),
	LIGHTCOLA = slot1.PropertyToID("_LightColA"),
	_LightParamOptimize = slot1.PropertyToID("_LightParamOptimize"),
	LIGHTPARAMS = slot1.PropertyToID("_LightParams"),
	BENDING_AMOUNT = slot1.PropertyToID("_Curvature"),
	BENDING_AMOUNT_SCALED = slot1.PropertyToID("_CurvatureScaled"),
	AMBIENTSIZE = slot1.PropertyToID("_AmbientSize"),
	HFLAMBERT = slot1.PropertyToID("_Hflambert"),
	AMBIENTCOL = slot1.PropertyToID("_AmbientCol"),
	_ShadowColor = slot1.PropertyToID("_ShadowColor"),
	SHADOW_PARAMS = slot1.PropertyToID("_ShadowParams"),
	SHADOW_PARAMS_OPT = slot1.PropertyToID("_ShadowParamsOpt"),
	FOGCOLOR = slot1.PropertyToID("_FogColor"),
	FOGCOLOR2 = slot1.PropertyToID("_FogColor2"),
	FOGPARAMS = slot1.PropertyToID("_FogParams"),
	FOGHEIGHT = slot1.PropertyToID("_FogHeight"),
	HEIGHTFOGEDGE = slot1.PropertyToID("_HeightFogEdge"),
	DISFOGSTART = slot1.PropertyToID("_DisFogStart"),
	_DisFogDataAndFogParmasOpt = slot1.PropertyToID("_DisFogDataAndFogParmasOpt"),
	DISFOGEDGE = slot1.PropertyToID("_DisFogEdge"),
	FOGDENSITYMIN = slot1.PropertyToID("_FogDensityMin"),
	FOGDENSITYMAX = slot1.PropertyToID("_FogDensityMax"),
	FOGMAINCOL = slot1.PropertyToID("_MainCol"),
	FOGOUTSIDECOL = slot1.PropertyToID("_OutSideCol"),
	FOGPLANEOUTSIDECOLOR = slot1.PropertyToID("_OutSideColor"),
	FOGPLANEMAINCOLOR = slot1.PropertyToID("_MainColor"),
	FogDensityData = slot1.PropertyToID("_FogDensityData"),
	ADD_RANGE = slot1.PropertyToID("_AddRange")
}
slot3 = {
	vector3 = 3,
	vector4 = 4,
	color = 5,
	vector2 = 2,
	number = 1
}
slot4 = {
	ambientsize = slot3.number,
	hflambert = slot3.number,
	ambientcol = slot3.color,
	outsideShadow = slot3.number,
	insideShadow = slot3.number,
	shadowColor = slot3.color,
	fogColor = slot3.color,
	fogColor2 = slot3.color,
	fogParams = slot3.vector2,
	fogHeight = slot3.number,
	heightfogedge = slot3.number,
	disfogstart = slot3.number,
	disfogedge = slot3.number,
	fogdensitymin = slot3.number,
	fogdensitymax = slot3.number,
	addRange = slot3.number,
	dirLightColor = slot3.color,
	dirLightIntensity = slot3.number,
	lightDir = slot3.vector3,
	fogPlaneMainCol = slot3.color,
	fogPlaneOutSideCol = slot3.color,
	fogMainCol = slot3.color,
	fogOutSideCol = slot3.color,
	rimcol = slot3.color,
	lightRangeNear = slot3.number,
	lightRangeFar = slot3.number,
	lightOffsetNear = slot3.number,
	lightOffsetFar = slot3.number,
	cameraDistanceValue = slot3.number,
	lightmin = slot3.number,
	lightmax = slot3.number,
	lightParams = slot3.vector2
}
slot5 = "night_1"
slot6 = {
	"day_1",
	"day_2",
	"afternoon",
	"night_1"
}
slot0.Update_Rate_Time = 10
slot0.Switch_Tween_Time = 5

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._matFogPlane = slot0._scene.go.sceneAmbient.matFogPlane
	slot0._matFogParticle = slot0._scene.go.sceneAmbient.matFogParticle
	slot0._updateRateTime = uv0.Update_Rate_Time
	slot0._swithchTweenTime = uv0.Switch_Tween_Time

	if not string.nilorempty(CommonConfig.instance:getConstStr(ConstEnum.RoomWeatherUpdateTime)) then
		slot0._updateRateTime = string.splitToNumber(slot3, "#")[1] or uv0.Update_Rate_Time
		slot0._swithchTweenTime = slot4[2] or 0
	end

	if slot0._lastAutoUpdateReport ~= slot0:_isCanUpdate() then
		slot0._lastAutoUpdateReport = slot4

		slot0:reset()
	end
end

function slot0.reset(slot0)
	slot0._ambientId = nil
	slot0._curDataParams = nil
	slot0._data = nil
	slot1 = slot0._curRoomMode
	slot0._curRoomMode = RoomModel.instance:getGameMode()
	slot0._ambientIds = {}

	for slot5, slot6 in ipairs(uv0) do
		if RoomConfig.instance:getSceneAmbientConfig(slot6) then
			table.insert(slot0._ambientIds, slot6)
		end
	end

	TaskDispatcher.cancelTask(slot0.updateReport, slot0)
	TaskDispatcher.cancelTask(slot0._initReport, slot0)

	if slot0:_isCanUpdate() then
		TaskDispatcher.runRepeat(slot0.updateReport, slot0, slot0._updateRateTime)
	end

	TaskDispatcher.runDelay(slot0._initReport, slot0, 0.1)
end

function slot0._initReport(slot0)
	slot1 = 1

	if slot0:_isCanUpdate() then
		slot2, slot3 = WeatherModel.instance:getReport()

		if slot2 then
			slot1 = slot2.roomMode
		end
	end

	slot0:tweenToAmbientId(slot0._ambientIds[slot1] or slot0._ambientIds[1])
end

function slot0._isCanUpdate(slot0)
	if RoomController.instance:isObMode() or RoomController.instance:isVisitMode() then
		return true
	end

	return false
end

function slot0.updateReport(slot0)
	if not slot0._ambientIds then
		return
	end

	slot0._ambientIds = slot0._ambientIds

	if (tabletool.indexOf(slot0._ambientIds, slot0._ambientId) or 0) + 1 > #slot0._ambientIds then
		slot1 = 1
	end

	slot0:tweenToAmbientId(slot0._ambientIds[slot1])
end

function slot0._getKeyTypeFuncMap(slot0)
	if not slot0._keyTypeFuncMap then
		slot0._keyTypeFuncMap = {
			[uv0.number] = slot0._paramToNumber,
			[uv0.vector2] = slot0._paramToVector2,
			[uv0.vector3] = slot0._paramToVector3,
			[uv0.vector4] = slot0._paramToVector4,
			[uv0.color] = slot0._paramToColor
		}
	end

	return slot0._keyTypeFuncMap
end

function slot0.tweenToAmbientId(slot0, slot1)
	if not RoomConfig.instance:getSceneAmbientConfig(slot1) then
		logError(string.format("room_scene_ambient --> can not find ambientId:[%s]", slot1))

		return
	end

	slot0:_killTween()

	slot0._ambientId = slot1

	if not slot0._curDataParams then
		slot0:_updateData(1, slot2, slot2)
		slot0:_nightLight()

		return
	end

	slot0._tweenId = slot0._scene.tween:tweenFloat(0, 1, slot0._swithchTweenTime or uv0.Switch_Tween_Time, slot0._frameCallback, slot0._finishCallback, slot0, {
		fromAmbientCfg = slot0:_copyAmbientParam(slot0._curDataParams or slot2),
		toAmbientCfg = slot2
	})

	slot0:_nightLight()
end

function slot0._killTween(slot0)
	if slot0._tweenId then
		slot0._scene.tween:killById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0._frameCallback(slot0, slot1, slot2)
	slot0:_updateData(slot1, slot2.fromAmbientCfg, slot2.toAmbientCfg)
end

function slot0._finishCallback(slot0, slot1, slot2)
	slot0._tweenId = nil
end

function slot0._copyAmbientParam(slot0, slot1)
	slot2 = {}

	slot0:_getZoomAmbientParam(1, slot2, slot1, slot1)

	return slot2
end

function slot0._getZoomAmbientParam(slot0, slot1, slot2, slot3, slot4)
	for slot9, slot10 in pairs(uv0) do
		if slot3[slot9] ~= nil and slot4[slot9] ~= nil then
			if slot10 == uv1.number then
				slot0:_zoomToKeyNumber(slot2, slot9, slot1, slot3[slot9], slot4[slot9])
			else
				slot0:_zoomToKeyTable(slot2, slot9, slot1, slot3[slot9], slot4[slot9])
			end
		end
	end
end

function slot0._updateData(slot0, slot1, slot2, slot3)
	if slot2 == nil and slot3 == nil then
		return
	end

	slot0._data = slot0._data or {}
	slot0._curDataParams = slot0._curDataParams or {}

	slot0:_getZoomAmbientParam(slot1, slot0._curDataParams, slot2 or slot3, slot3 or slot2)

	for slot11, slot12 in pairs(uv0) do
		if slot0._curDataParams[slot11] ~= nil then
			if slot0:_getKeyTypeFuncMap()[slot12] then
				slot0._data[slot11] = slot13(slot0, slot0._curDataParams[slot11])
			else
				logError(string.format("can not find keyTypeFuncMap[%s]", slot12))
			end
		else
			logError(string.format("can not find key[%s]", slot11))
		end
	end

	slot0:applyInspectorParam()
end

function slot0._zoomToKeyNumber(slot0, slot1, slot2, slot3, slot4, slot5)
	slot1[slot2] = slot0:_zoomToNumber(slot3, slot4, slot5)
end

function slot0._zoomToKeyTable(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot1[slot2] then
		slot1[slot2] = {}
	end

	for slot10 = 1, #slot4 do
		slot1[slot2][slot10] = slot0:_zoomToNumber(slot3, slot4[slot10], slot5[slot10])
	end
end

function slot0._zoomToNumber(slot0, slot1, slot2, slot3)
	if slot1 >= 1 then
		return slot3
	elseif slot1 <= 0 then
		return slot2
	end

	return slot2 + (slot3 - slot2) * slot1
end

function slot0._paramToNumber(slot0, slot1)
	return slot1
end

function slot0._paramToVector2(slot0, slot1)
	return Vector4(slot1[1], slot1[2], 0, 0)
end

function slot0._paramToVector3(slot0, slot1)
	return Vector4(slot1[1], slot1[2], slot1[3], 0)
end

function slot0._paramTooVector4(slot0, slot1)
	return Vector4(slot1[1], slot1[2], slot1[3], slot1[4])
end

function slot0._paramToColor(slot0, slot1)
	return Color(slot1[1], slot1[2], slot1[3], slot1[4])
end

function slot0.applyInspectorParam(slot0)
	slot0:_applyShaher()
	slot0:_applyAmbientData()
	slot0:_applyLightComp()
	slot0:_applyFog()
end

function slot0._applyShaher(slot0)
	if not slot0._data then
		return
	end

	slot1 = slot0._data

	uv0.SetGlobalFloat(uv1.AMBIENTSIZE, slot1.ambientsize)
	uv0.SetGlobalFloat(uv1.HFLAMBERT, slot1.hflambert)
	uv0.SetGlobalColor(uv1.AMBIENTCOL, slot1.ambientcol)
	uv0.SetGlobalVector(uv1.SHADOW_PARAMS, Vector4(slot1.outsideShadow, slot1.insideShadow))
	uv0.SetGlobalVector(uv1.SHADOW_PARAMS_OPT, Vector4(slot1.insideShadow - slot1.outsideShadow, slot1.outsideShadow))
	uv0.SetGlobalColor(uv1._ShadowColor, slot1.shadowColor)
	uv0.SetGlobalColor(uv1.FOGCOLOR, slot1.fogColor)
	uv0.SetGlobalColor(uv1.FOGCOLOR2, slot1.fogColor2)
	uv0.SetGlobalVector(uv1.FOGPARAMS, slot1.fogParams)
	uv0.SetGlobalFloat(uv1.FOGHEIGHT, slot1.fogHeight)
	uv0.SetGlobalFloat(uv1.HEIGHTFOGEDGE, slot1.heightfogedge)
	uv0.SetGlobalFloat(uv1.DISFOGSTART, slot1.disfogstart)
	uv0.SetGlobalFloat(uv1.DISFOGEDGE, slot1.disfogedge)
	uv0.SetGlobalFloat(uv1.ADD_RANGE, slot1.addRange)

	slot6 = slot1.fogParams.y - slot1.fogParams.x ~= 0 and 1 / slot5 or slot4

	uv0.SetGlobalVector(uv1._DisFogDataAndFogParmasOpt, Vector4(1 / slot1.disfogedge, -slot1.disfogstart / slot1.disfogedge, slot6, -slot4 * slot6))
end

function slot0._applyAmbientData(slot0)
	slot1 = slot0._scene.go.sceneAmbientData
	slot2 = slot0._scene.go.sceneAmbient

	if slot0._data and slot2 and slot1 then
		slot1.rimcol = slot3.rimcol
		slot1.lightRangeNear = slot3.lightRangeNear
		slot1.lightRangeFar = slot3.lightRangeFar
		slot1.lightOffsetNear = slot3.lightOffsetNear
		slot1.lightOffsetFar = slot3.lightOffsetFar
		slot1.cameraDistanceValue = slot3.cameraDistanceValue
		slot1.lightmin = slot3.lightmin
		slot1.lightmax = slot3.lightmax
		slot1.lightParams = slot3.lightParams
		slot2.data = slot1
	end
end

function slot0._applyLightComp(slot0, slot1)
	slot3 = slot0._data

	if slot0._scene.light and slot3 then
		slot2:setLightColor(slot3.dirLightColor)
		slot2:setLightIntensity(slot3.dirLightIntensity)
		slot2:setLocalRotation(slot3.lightDir.x, slot3.lightDir.y, slot3.lightDir.z)
	end
end

function slot0._applyFog(slot0)
	if slot0._data then
		if slot0._matFogParticle then
			slot0._matFogParticle:SetColor(uv0.FOGMAINCOL, slot1.fogMainCol)
			slot0._matFogParticle:SetColor(uv0.FOGOUTSIDECOL, slot1.fogOutSideCol)
		end

		if slot0._matFogPlane then
			slot0._matFogPlane:SetColor(uv0.FOGPLANEMAINCOLOR, slot1.fogPlaneMainCol)
			slot0._matFogPlane:SetColor(uv0.FOGPLANEOUTSIDECOLOR, slot1.fogPlaneOutSideCol)
		end
	end
end

function slot0._nightLight(slot0)
	if RoomWeatherModel.instance:getIsNight() ~= (slot0._ambientId == uv0) then
		RoomWeatherModel.instance:setIsNight(slot1)
		RoomMapController.instance:dispatchEvent(RoomEvent.MapEntityNightLight, slot1)
	end
end

function slot0.onSceneClose(slot0)
	slot0._matFogParticle = nil
	slot0._matFogPlane = nil
	slot0._curRoomMode = nil

	TaskDispatcher.cancelTask(slot0.updateReport, slot0)
	TaskDispatcher.cancelTask(slot0._initReport, slot0)
	slot0:_killTween()
end

return slot0

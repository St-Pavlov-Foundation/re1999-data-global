module("modules.logic.weather.controller.WeatherYearAnimationComp", package.seeall)

slot0 = class("WeatherYearAnimationComp", BaseSceneComp)
slot0.CurveAssetPath = "scenes/dynamic/m_s01_zjm_a/anim/year_curve.asset"
slot0.ConstVarId = {
	RotateDurationId = 602,
	IntervalId = 600,
	CirculationIntervalId = 603,
	RotateCircleId = 601,
	StartYearId = 604
}

function slot0.onInit(slot0)
	slot0.animationEndTime = 0
	slot0.materials = {}
	slot0.yearTable = {}
	slot0.node = nil
	slot0.node1 = nil
	slot0.aniCurveConfig = nil
	slot0.circulationNums = {}
	slot0.circulationIndex = 0
	slot0.interval = CommonConfig.instance:getConstNum(uv0.ConstVarId.IntervalId)
	slot0.rotateCircle = CommonConfig.instance:getConstNum(uv0.ConstVarId.RotateCircleId)
	slot0.rotateDuration = CommonConfig.instance:getConstNum(uv0.ConstVarId.RotateDurationId)
	slot0.circulationInterval = CommonConfig.instance:getConstNum(uv0.ConstVarId.CirculationIntervalId)
	slot0.startYear = CommonConfig.instance:getConstNum(uv0.ConstVarId.StartYearId)
	slot0.setNumYearTable = slot0:_numberConvertToTable(slot0.startYear)
end

function slot0.initSceneGo(slot0, slot1)
	slot0._sceneGo = slot1

	slot0:initSceneNodeStatus()
	slot0:initAnimationCurve(slot0._onCloseViewFinish, slot0)
end

function slot0.initSceneNodeStatus(slot0)
	slot0.node = slot0:getSceneNode("s01_obj_a/Anim/Obj/s01_C_Obj_a/year")
	slot0.node1 = slot0:getSceneNode("s01_obj_a/Anim/Obj/s01_C_Obj_a/year (1)")

	if not slot0.node then
		logError("initSceneNodeStatus no node")

		return
	end

	slot0.materials = {}

	table.insert(slot0.materials, slot0.node:GetComponent(typeof(UnityEngine.Renderer)).material)

	if slot0.node1 then
		table.insert(slot0.materials, slot0.node1:GetComponent(typeof(UnityEngine.Renderer)).material)
	end

	slot0:setMaterialsParam()
end

function slot0.initAnimationCurve(slot0, slot1, slot2)
	slot0.loadAnimationCurveCallback = slot1
	slot0.loadAnimationCurveCallbackObj = slot2

	loadAbAsset(uv0.CurveAssetPath, false, slot0.loadCallback, slot0)
end

function slot0.loadCallback(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot0.assetItem = slot1

		slot0.assetItem:Retain()

		slot0.aniCurveConfig = slot0.assetItem:GetResource(uv0.CurveAssetPath)
	else
		slot0.aniCurveConfig = nil

		logError("%s scene load '%s' failed", GameSceneMgr.instance:getCurScene()._gameObj.name, uv0.CurveAssetPath)
	end

	slot0.loadAnimationCurveCallback(slot0.loadAnimationCurveCallbackObj)
end

function slot0._onCloseViewFinish(slot0)
	if not slot0.node then
		logNormal("node not found, direct return, not play animation")

		return
	end

	slot1 = (DungeonModel.instance:getLastEpisodeConfigAndInfo().preEpisode ~= 0 or DungeonConfig.instance:getEpisodeCO(10003)) and DungeonConfig.instance:getEpisodeCO(slot1.preEpisode)

	if not slot0.lastEpisodeCo or slot1.id ~= slot0.lastEpisodeCo.id then
		slot0.lastEpisodeCo = slot1

		slot0:reCirculateCirculationNums()
	end

	slot0:cancelRepeatTask()

	if slot0.circulationNums and #slot0.circulationNums ~= 0 then
		slot0.circulationIndex = 0

		slot0:addRepeatTask()
		slot0:_playNodeAnimation()
	end
end

function slot0.reCirculateCirculationNums(slot0)
	slot0.circulationNums = {}

	if slot0.lastEpisodeCo.year == 0 then
		logNormal(string.format("[WeatherYearAnimationComp] episode config not have year, id : %s, name : %s, year : %s", slot0.lastEpisodeCo.id, slot0.lastEpisodeCo.name, slot0.lastEpisodeCo.year))
		slot0:hideNode()

		return
	end

	table.insert(slot0.circulationNums, slot0.lastEpisodeCo.year)

	if not string.nilorempty(slot0.lastEpisodeCo.time) then
		slot2, slot3, slot4, slot5, slot6, slot7 = string.find(slot1, "(%d+)/(%d+)%s+(%d+):(%d+)")

		if not string.nilorempty(slot4) and not string.nilorempty(slot5) then
			table.insert(slot0.circulationNums, string.format("%02d%02d", slot4, slot5))
		end

		if not string.nilorempty(slot6) and not string.nilorempty(slot7) then
			table.insert(slot0.circulationNums, string.format("%02d%02d", slot6, slot7))
		end
	end
end

function slot0.getSceneNode(slot0, slot1)
	if slot0._sceneGo then
		return gohelper.findChild(slot2, slot1)
	end
end

function slot0._playNodeAnimation(slot0)
	slot0:showNode()

	slot0.circulationIndex = slot0.circulationIndex + 1

	if slot0.circulationIndex > #slot0.circulationNums then
		slot0.circulationIndex = 1
	end

	for slot4 = 1, #slot0.setNumYearTable do
		slot0.setNumYearTable[slot4] = math.floor(slot0.setNumYearTable[slot4] % 10)
	end

	slot0.yearTable = {}

	for slot5 = 1, #slot0:_numberConvertToTable(slot0.circulationNums[slot0.circulationIndex]) do
		slot7 = slot0:_getTotalIncrement(slot0.setNumYearTable[slot5], slot1[slot5])

		table.insert(slot0.yearTable, {
			totalIncrement = slot7,
			everySecondIncrement = slot7 / slot0.rotateDuration,
			startNum = slot0.setNumYearTable[slot5],
			targetNum = slot0.setNumYearTable[slot5] + slot7
		})
	end

	if #slot0.yearTable ~= 4 then
		logError(string.format("episode config error, id : %s, name : %s, year : %s, time : %s ", slot0.lastEpisodeCo.id, slot0.lastEpisodeCo.name, slot0.lastEpisodeCo.year, slot0.lastEpisodeCo.time))

		return
	end

	for slot6 = 1, 4 do
		slot0.yearTable[slot6].startTime = Time.time + (slot6 - 1) * slot0.interval
	end

	slot0.animationEndTime = slot0.yearTable[4].startTime + slot0.rotateDuration

	TaskDispatcher.runRepeat(slot0._onFrame, slot0, 0.001)
end

function slot0._onFrame(slot0)
	slot1 = Time.time

	if slot0:canStopAnimation() then
		slot0:cancelAnimationTask()

		return
	end

	for slot5 = 1, 4 do
		if slot0.yearTable[slot5].startTime <= slot1 then
			if slot0.rotateDuration <= slot1 - slot0.yearTable[slot5].startTime then
				slot0.setNumYearTable[slot5] = slot0.yearTable[slot5].targetNum
			else
				slot0.setNumYearTable[slot5] = slot0.yearTable[slot5].startNum + slot0.yearTable[slot5].totalIncrement * slot0.aniCurveConfig:GetY(slot6 / slot0.rotateDuration)
			end
		end
	end

	slot0:setMaterialsParam()
end

function slot0.hideNode(slot0)
	gohelper.setActive(slot0.node, false)
	gohelper.setActive(slot0.node1, false)
end

function slot0.showNode(slot0)
	gohelper.setActive(slot0.node, true)
	gohelper.setActive(slot0.node1, true)
end

function slot0.canStopAnimation(slot0)
	if slot0.animationEndTime < Time.time then
		for slot4 = 1, 4 do
			if slot0.setNumYearTable[slot4] < slot0.yearTable[slot4].targetNum then
				return false
			end
		end

		return true
	end

	return false
end

function slot0.setMaterialsParam(slot0)
	for slot4, slot5 in ipairs(slot0.materials) do
		slot5:SetVector("_Year", Vector4.New(slot0.setNumYearTable[1], slot0.setNumYearTable[2], slot0.setNumYearTable[3], slot0.setNumYearTable[4]))
	end
end

function slot0._getTotalIncrement(slot0, slot1, slot2)
	slot3 = 10 * slot0.rotateCircle

	if slot2 - slot1 < 0 then
		slot4 = slot4 + 10
	end

	return slot3 + slot4
end

function slot0._numberConvertToTable(slot0, slot1)
	slot3 = {}

	for slot7 in string.gmatch(tostring(slot1), ".") do
		table.insert(slot3, tonumber(slot7))
	end

	return slot3
end

function slot0.addRepeatTask(slot0)
	TaskDispatcher.runRepeat(slot0._playNodeAnimation, slot0, slot0.rotateDuration + slot0.circulationInterval)
end

function slot0.cancelRepeatTask(slot0)
	TaskDispatcher.cancelTask(slot0._playNodeAnimation, slot0)
	slot0:cancelAnimationTask()
end

function slot0.cancelAnimationTask(slot0)
	TaskDispatcher.cancelTask(slot0._onFrame, slot0)

	slot0.yearTable = {}
end

function slot0.onSceneClose(slot0)
	slot0:cancelRepeatTask()

	slot0.materials = {}
	slot0.setNumYearTable = {}
	slot0.yearTable = {}
	slot0.circulationNums = {}
	slot0.node = nil
	slot0.node1 = nil
	slot0.circulationIndex = 0
	slot0.lastEpisodeCo = nil

	if slot0.assetItem then
		slot0.assetItem:Release()

		slot0.aniCurveConfig = nil
	else
		removeAssetLoadCb(uv0.CurveAssetPath, slot0.loadCallback, slot0)
	end
end

return slot0

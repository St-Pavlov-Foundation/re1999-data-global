module("modules.logic.weather.controller.WeatherYearAnimationComp", package.seeall)

local var_0_0 = class("WeatherYearAnimationComp", BaseSceneComp)

var_0_0.CurveAssetPath = "scenes/dynamic/m_s01_zjm_a/anim/year_curve.asset"
var_0_0.ConstVarId = {
	RotateDurationId = 602,
	IntervalId = 600,
	CirculationIntervalId = 603,
	RotateCircleId = 601,
	StartYearId = 604
}

function var_0_0.onInit(arg_1_0)
	arg_1_0.animationEndTime = 0
	arg_1_0.materials = {}
	arg_1_0.yearTable = {}
	arg_1_0.node = nil
	arg_1_0.node1 = nil
	arg_1_0.aniCurveConfig = nil
	arg_1_0.circulationNums = {}
	arg_1_0.circulationIndex = 0
	arg_1_0.interval = CommonConfig.instance:getConstNum(var_0_0.ConstVarId.IntervalId)
	arg_1_0.rotateCircle = CommonConfig.instance:getConstNum(var_0_0.ConstVarId.RotateCircleId)
	arg_1_0.rotateDuration = CommonConfig.instance:getConstNum(var_0_0.ConstVarId.RotateDurationId)
	arg_1_0.circulationInterval = CommonConfig.instance:getConstNum(var_0_0.ConstVarId.CirculationIntervalId)
	arg_1_0.startYear = CommonConfig.instance:getConstNum(var_0_0.ConstVarId.StartYearId)
	arg_1_0.setNumYearTable = arg_1_0:_numberConvertToTable(arg_1_0.startYear)
end

function var_0_0.initSceneGo(arg_2_0, arg_2_1)
	arg_2_0._sceneGo = arg_2_1

	arg_2_0:initSceneNodeStatus()
	arg_2_0:initAnimationCurve(arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.initSceneNodeStatus(arg_3_0)
	arg_3_0.node = arg_3_0:getSceneNode("s01_obj_a/Anim/Obj/s01_C_Obj_a/year")
	arg_3_0.node1 = arg_3_0:getSceneNode("s01_obj_a/Anim/Obj/s01_C_Obj_a/year (1)")

	if not arg_3_0.node then
		logError("initSceneNodeStatus no node")

		return
	end

	arg_3_0.materials = {}

	local var_3_0 = arg_3_0.node:GetComponent(typeof(UnityEngine.Renderer)).material

	table.insert(arg_3_0.materials, var_3_0)

	if arg_3_0.node1 then
		local var_3_1 = arg_3_0.node1:GetComponent(typeof(UnityEngine.Renderer)).material

		table.insert(arg_3_0.materials, var_3_1)
	end

	arg_3_0:setMaterialsParam()
end

function var_0_0.initAnimationCurve(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.loadAnimationCurveCallback = arg_4_1
	arg_4_0.loadAnimationCurveCallbackObj = arg_4_2

	loadAbAsset(var_0_0.CurveAssetPath, false, arg_4_0.loadCallback, arg_4_0)
end

function var_0_0.loadCallback(arg_5_0, arg_5_1)
	if arg_5_1.IsLoadSuccess then
		local var_5_0 = arg_5_0.assetItem

		arg_5_0.assetItem = arg_5_1

		arg_5_0.assetItem:Retain()

		if var_5_0 then
			var_5_0:Release()
		end

		arg_5_0.aniCurveConfig = arg_5_0.assetItem:GetResource(var_0_0.CurveAssetPath)
	else
		arg_5_0.aniCurveConfig = nil

		logError("%s scene load '%s' failed", GameSceneMgr.instance:getCurScene()._gameObj.name, var_0_0.CurveAssetPath)
	end

	arg_5_0.loadAnimationCurveCallback(arg_5_0.loadAnimationCurveCallbackObj)
end

function var_0_0._onCloseViewFinish(arg_6_0)
	if not arg_6_0.node then
		logNormal("node not found, direct return, not play animation")

		return
	end

	local var_6_0 = DungeonModel.instance:getLastEpisodeConfigAndInfo()

	if var_6_0.preEpisode == 0 then
		var_6_0 = DungeonConfig.instance:getEpisodeCO(10003)
	else
		var_6_0 = DungeonConfig.instance:getEpisodeCO(var_6_0.preEpisode)
	end

	if not arg_6_0.lastEpisodeCo or var_6_0.id ~= arg_6_0.lastEpisodeCo.id then
		arg_6_0.lastEpisodeCo = var_6_0

		arg_6_0:reCirculateCirculationNums()
	end

	arg_6_0:cancelRepeatTask()

	if arg_6_0.circulationNums and #arg_6_0.circulationNums ~= 0 then
		arg_6_0.circulationIndex = 0

		arg_6_0:addRepeatTask()
		arg_6_0:_playNodeAnimation()
	end
end

function var_0_0.reCirculateCirculationNums(arg_7_0)
	arg_7_0.circulationNums = {}

	if arg_7_0.lastEpisodeCo.year == 0 then
		logNormal(string.format("[WeatherYearAnimationComp] episode config not have year, id : %s, name : %s, year : %s", arg_7_0.lastEpisodeCo.id, arg_7_0.lastEpisodeCo.name, arg_7_0.lastEpisodeCo.year))
		arg_7_0:hideNode()

		return
	end

	table.insert(arg_7_0.circulationNums, arg_7_0.lastEpisodeCo.year)

	local var_7_0 = arg_7_0.lastEpisodeCo.time

	if not string.nilorempty(var_7_0) then
		local var_7_1, var_7_2, var_7_3, var_7_4, var_7_5, var_7_6 = string.find(var_7_0, "(%d+)/(%d+)%s+(%d+):(%d+)")

		if not string.nilorempty(var_7_3) and not string.nilorempty(var_7_4) then
			table.insert(arg_7_0.circulationNums, string.format("%02d%02d", var_7_3, var_7_4))
		end

		if not string.nilorempty(var_7_5) and not string.nilorempty(var_7_6) then
			table.insert(arg_7_0.circulationNums, string.format("%02d%02d", var_7_5, var_7_6))
		end
	end
end

function var_0_0.getSceneNode(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._sceneGo

	if var_8_0 then
		return gohelper.findChild(var_8_0, arg_8_1)
	end
end

function var_0_0._playNodeAnimation(arg_9_0)
	arg_9_0:showNode()

	arg_9_0.circulationIndex = arg_9_0.circulationIndex + 1

	if arg_9_0.circulationIndex > #arg_9_0.circulationNums then
		arg_9_0.circulationIndex = 1
	end

	for iter_9_0 = 1, #arg_9_0.setNumYearTable do
		arg_9_0.setNumYearTable[iter_9_0] = math.floor(arg_9_0.setNumYearTable[iter_9_0] % 10)
	end

	arg_9_0.yearTable = {}

	local var_9_0 = arg_9_0:_numberConvertToTable(arg_9_0.circulationNums[arg_9_0.circulationIndex])

	for iter_9_1 = 1, #var_9_0 do
		local var_9_1 = {}
		local var_9_2 = arg_9_0:_getTotalIncrement(arg_9_0.setNumYearTable[iter_9_1], var_9_0[iter_9_1])

		var_9_1.totalIncrement = var_9_2
		var_9_1.everySecondIncrement = var_9_2 / arg_9_0.rotateDuration
		var_9_1.startNum = arg_9_0.setNumYearTable[iter_9_1]
		var_9_1.targetNum = arg_9_0.setNumYearTable[iter_9_1] + var_9_2

		table.insert(arg_9_0.yearTable, var_9_1)
	end

	if #arg_9_0.yearTable ~= 4 then
		logError(string.format("episode config error, id : %s, name : %s, year : %s, time : %s ", arg_9_0.lastEpisodeCo.id, arg_9_0.lastEpisodeCo.name, arg_9_0.lastEpisodeCo.year, arg_9_0.lastEpisodeCo.time))

		return
	end

	local var_9_3 = Time.time

	for iter_9_2 = 1, 4 do
		arg_9_0.yearTable[iter_9_2].startTime = var_9_3 + (iter_9_2 - 1) * arg_9_0.interval
	end

	arg_9_0.animationEndTime = arg_9_0.yearTable[4].startTime + arg_9_0.rotateDuration

	TaskDispatcher.runRepeat(arg_9_0._onFrame, arg_9_0, 0.001)
end

function var_0_0._onFrame(arg_10_0)
	local var_10_0 = Time.time

	if arg_10_0:canStopAnimation() then
		arg_10_0:cancelAnimationTask()

		return
	end

	for iter_10_0 = 1, 4 do
		if var_10_0 >= arg_10_0.yearTable[iter_10_0].startTime then
			local var_10_1 = var_10_0 - arg_10_0.yearTable[iter_10_0].startTime

			if var_10_1 >= arg_10_0.rotateDuration then
				arg_10_0.setNumYearTable[iter_10_0] = arg_10_0.yearTable[iter_10_0].targetNum
			else
				local var_10_2 = var_10_1 / arg_10_0.rotateDuration
				local var_10_3 = arg_10_0.aniCurveConfig:GetY(var_10_2)

				arg_10_0.setNumYearTable[iter_10_0] = arg_10_0.yearTable[iter_10_0].startNum + arg_10_0.yearTable[iter_10_0].totalIncrement * var_10_3
			end
		end
	end

	arg_10_0:setMaterialsParam()
end

function var_0_0.hideNode(arg_11_0)
	gohelper.setActive(arg_11_0.node, false)
	gohelper.setActive(arg_11_0.node1, false)
end

function var_0_0.showNode(arg_12_0)
	gohelper.setActive(arg_12_0.node, true)
	gohelper.setActive(arg_12_0.node1, true)
end

function var_0_0.canStopAnimation(arg_13_0)
	if arg_13_0.animationEndTime < Time.time then
		for iter_13_0 = 1, 4 do
			if arg_13_0.setNumYearTable[iter_13_0] < arg_13_0.yearTable[iter_13_0].targetNum then
				return false
			end
		end

		return true
	end

	return false
end

function var_0_0.setMaterialsParam(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.materials) do
		iter_14_1:SetVector("_Year", Vector4.New(arg_14_0.setNumYearTable[1], arg_14_0.setNumYearTable[2], arg_14_0.setNumYearTable[3], arg_14_0.setNumYearTable[4]))
	end
end

function var_0_0._getTotalIncrement(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = 10 * arg_15_0.rotateCircle
	local var_15_1 = arg_15_2 - arg_15_1

	if var_15_1 < 0 then
		var_15_1 = var_15_1 + 10
	end

	return var_15_0 + var_15_1
end

function var_0_0._numberConvertToTable(arg_16_0, arg_16_1)
	local var_16_0 = tostring(arg_16_1)
	local var_16_1 = {}

	for iter_16_0 in string.gmatch(var_16_0, ".") do
		table.insert(var_16_1, tonumber(iter_16_0))
	end

	return var_16_1
end

function var_0_0.addRepeatTask(arg_17_0)
	TaskDispatcher.runRepeat(arg_17_0._playNodeAnimation, arg_17_0, arg_17_0.rotateDuration + arg_17_0.circulationInterval)
end

function var_0_0.cancelRepeatTask(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._playNodeAnimation, arg_18_0)
	arg_18_0:cancelAnimationTask()
end

function var_0_0.cancelAnimationTask(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._onFrame, arg_19_0)

	arg_19_0.yearTable = {}
end

function var_0_0.onSceneClose(arg_20_0)
	arg_20_0:cancelRepeatTask()

	arg_20_0.materials = {}
	arg_20_0.setNumYearTable = {}
	arg_20_0.yearTable = {}
	arg_20_0.circulationNums = {}
	arg_20_0.node = nil
	arg_20_0.node1 = nil
	arg_20_0.circulationIndex = 0
	arg_20_0.lastEpisodeCo = nil

	if arg_20_0.assetItem then
		arg_20_0.assetItem:Release()

		arg_20_0.aniCurveConfig = nil
		arg_20_0.assetItem = nil
	else
		removeAssetLoadCb(var_0_0.CurveAssetPath, arg_20_0.loadCallback, arg_20_0)
	end
end

return var_0_0

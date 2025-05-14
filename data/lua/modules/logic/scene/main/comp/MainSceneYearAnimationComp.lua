module("modules.logic.scene.main.comp.MainSceneYearAnimationComp", package.seeall)

local var_0_0 = class("MainSceneYearAnimationComp", BaseSceneComp)

var_0_0.CurveAssetPath = "scenes/dynamic/m_s01_zjm_a/anim/year_curve.asset"
var_0_0.ConstVarId = {
	RotateDurationId = 602,
	IntervalId = 600,
	CirculationIntervalId = 603,
	RotateCircleId = 601,
	StartYearId = 604
}

function var_0_0.onInit(arg_1_0)
	arg_1_0.interval = 0.3
	arg_1_0.rotateCircle = 1
	arg_1_0.rotateDuration = 3
	arg_1_0.circulationInterval = 2
	arg_1_0.startYear = 1999
	arg_1_0.animationEndTime = 0
	arg_1_0.materials = {}
	arg_1_0.yearTable = {}
	arg_1_0.setNumYearTable = {}
	arg_1_0.node = nil
	arg_1_0.node1 = nil
	arg_1_0.aniCurveConfig = nil
	arg_1_0.forcePlayAnimation = false
	arg_1_0.circulationNums = {}
	arg_1_0.circulationIndex = 0
end

function var_0_0.onSceneStart(arg_2_0)
	arg_2_0.interval = CommonConfig.instance:getConstNum(var_0_0.ConstVarId.IntervalId)
	arg_2_0.rotateCircle = CommonConfig.instance:getConstNum(var_0_0.ConstVarId.RotateCircleId)
	arg_2_0.rotateDuration = CommonConfig.instance:getConstNum(var_0_0.ConstVarId.RotateDurationId)
	arg_2_0.circulationInterval = CommonConfig.instance:getConstNum(var_0_0.ConstVarId.CirculationIntervalId)
	arg_2_0.startYear = CommonConfig.instance:getConstNum(var_0_0.ConstVarId.StartYearId)
	arg_2_0.setNumYearTable = arg_2_0:_numberConvertToTable(arg_2_0.startYear)
end

function var_0_0.onScenePrepared(arg_3_0, arg_3_1, arg_3_2)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	arg_3_0:initSceneNodeStatus()

	if arg_3_0.forcePlayAnimation then
		arg_3_0:_onCloseViewFinish()
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
	MainSceneSwitchController.instance:registerCallback(MainSceneSwitchEvent.SwitchSceneFinish, arg_3_0._onSwitchSceneFinish, arg_3_0)
end

function var_0_0._onSwitchSceneFinish(arg_4_0)
	arg_4_0:initSceneNodeStatus()

	arg_4_0.lastEpisodeCo = nil
	arg_4_0.forcePlayAnimation = true

	arg_4_0:_onCloseViewFinish()

	arg_4_0.forcePlayAnimation = false
end

function var_0_0.initSceneNodeStatus(arg_5_0)
	arg_5_0.node = arg_5_0:getSceneNode("s01_obj_a/Anim/Obj/s01_C_Obj_a/year")
	arg_5_0.node1 = arg_5_0:getSceneNode("s01_obj_a/Anim/Obj/s01_C_Obj_a/year (1)")

	if not arg_5_0.node then
		logError("initSceneNodeStatus no node")

		return
	end

	arg_5_0.materials = {}

	local var_5_0 = arg_5_0.node:GetComponent(typeof(UnityEngine.Renderer)).material

	table.insert(arg_5_0.materials, var_5_0)

	if arg_5_0.node1 then
		local var_5_1 = arg_5_0.node1:GetComponent(typeof(UnityEngine.Renderer)).material

		table.insert(arg_5_0.materials, var_5_1)
	end

	arg_5_0:setMaterialsParam()
end

function var_0_0.initAnimationCurve(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.loadAnimationCurveCallback = arg_6_1
	arg_6_0.loadAnimationCurveCallbackObj = arg_6_2

	loadAbAsset(var_0_0.CurveAssetPath, false, arg_6_0.loadCallback, arg_6_0)
end

function var_0_0.loadCallback(arg_7_0, arg_7_1)
	if arg_7_1.IsLoadSuccess then
		arg_7_0.assetItem = arg_7_1

		arg_7_0.assetItem:Retain()

		arg_7_0.aniCurveConfig = arg_7_0.assetItem:GetResource(var_0_0.CurveAssetPath)
	else
		arg_7_0.aniCurveConfig = nil

		logError("%s scene load '%s' failed", GameSceneMgr.instance:getCurScene()._gameObj.name, var_0_0.CurveAssetPath)
	end

	arg_7_0.loadAnimationCurveCallback(arg_7_0.loadAnimationCurveCallbackObj)
end

function var_0_0._onCloseViewFinish(arg_8_0)
	if not arg_8_0.node then
		logNormal("node not found, direct return, not play animation")

		return
	end

	if not arg_8_0.forcePlayAnimation then
		if not ViewMgr.instance:isOpen(ViewName.MainView) then
			return
		end

		if not ViewHelper.instance:checkViewOnTheTop(ViewName.MainView) then
			return
		end
	end

	local var_8_0 = DungeonModel.instance:getLastEpisodeConfigAndInfo()

	if var_8_0.preEpisode == 0 then
		var_8_0 = DungeonConfig.instance:getEpisodeCO(10003)
	else
		var_8_0 = DungeonConfig.instance:getEpisodeCO(var_8_0.preEpisode)
	end

	if not arg_8_0.lastEpisodeCo or var_8_0.id ~= arg_8_0.lastEpisodeCo.id then
		arg_8_0.lastEpisodeCo = var_8_0

		arg_8_0:reCirculateCirculationNums()
	end

	arg_8_0:cancelRepeatTask()

	if arg_8_0.circulationNums and #arg_8_0.circulationNums ~= 0 then
		arg_8_0.circulationIndex = 0

		arg_8_0:addRepeatTask()
		arg_8_0:_playNodeAnimation()
	end
end

function var_0_0.reCirculateCirculationNums(arg_9_0)
	arg_9_0.circulationNums = {}

	if arg_9_0.lastEpisodeCo.year == 0 then
		logNormal(string.format("[MainSceneYearAnimationComp] episode config not have year, id : %s, name : %s, year : %s", arg_9_0.lastEpisodeCo.id, arg_9_0.lastEpisodeCo.name, arg_9_0.lastEpisodeCo.year))
		arg_9_0:hideNode()

		return
	end

	table.insert(arg_9_0.circulationNums, arg_9_0.lastEpisodeCo.year)

	local var_9_0 = arg_9_0.lastEpisodeCo.time

	if not string.nilorempty(var_9_0) then
		local var_9_1, var_9_2, var_9_3, var_9_4, var_9_5, var_9_6 = string.find(var_9_0, "(%d+)/(%d+)%s+(%d+):(%d+)")

		if not string.nilorempty(var_9_3) and not string.nilorempty(var_9_4) then
			table.insert(arg_9_0.circulationNums, string.format("%02d%02d", var_9_3, var_9_4))
		end

		if not string.nilorempty(var_9_5) and not string.nilorempty(var_9_6) then
			table.insert(arg_9_0.circulationNums, string.format("%02d%02d", var_9_5, var_9_6))
		end
	end
end

function var_0_0.forcePlayAni(arg_10_0)
	arg_10_0.forcePlayAnimation = true

	arg_10_0:_onCloseViewFinish()

	arg_10_0.forcePlayAnimation = false
end

function var_0_0.getSceneNode(arg_11_0, arg_11_1)
	local var_11_0 = GameSceneMgr.instance:getCurScene().level:getSceneGo()

	if var_11_0 then
		return gohelper.findChild(var_11_0, arg_11_1)
	end
end

function var_0_0._playNodeAnimation(arg_12_0)
	arg_12_0:showNode()

	arg_12_0.circulationIndex = arg_12_0.circulationIndex + 1

	if arg_12_0.circulationIndex > #arg_12_0.circulationNums then
		arg_12_0.circulationIndex = 1
	end

	for iter_12_0 = 1, #arg_12_0.setNumYearTable do
		arg_12_0.setNumYearTable[iter_12_0] = math.floor(arg_12_0.setNumYearTable[iter_12_0] % 10)
	end

	arg_12_0.yearTable = {}

	local var_12_0 = arg_12_0:_numberConvertToTable(arg_12_0.circulationNums[arg_12_0.circulationIndex])

	for iter_12_1 = 1, #var_12_0 do
		local var_12_1 = {}
		local var_12_2 = arg_12_0:_getTotalIncrement(arg_12_0.setNumYearTable[iter_12_1], var_12_0[iter_12_1])

		var_12_1.totalIncrement = var_12_2
		var_12_1.everySecondIncrement = var_12_2 / arg_12_0.rotateDuration
		var_12_1.startNum = arg_12_0.setNumYearTable[iter_12_1]
		var_12_1.targetNum = arg_12_0.setNumYearTable[iter_12_1] + var_12_2

		table.insert(arg_12_0.yearTable, var_12_1)
	end

	if #arg_12_0.yearTable ~= 4 then
		logError(string.format("episode config error, id : %s, name : %s, year : %s, time : %s ", arg_12_0.lastEpisodeCo.id, arg_12_0.lastEpisodeCo.name, arg_12_0.lastEpisodeCo.year, arg_12_0.lastEpisodeCo.time))

		return
	end

	local var_12_3 = Time.time

	for iter_12_2 = 1, 4 do
		arg_12_0.yearTable[iter_12_2].startTime = var_12_3 + (iter_12_2 - 1) * arg_12_0.interval
	end

	arg_12_0.animationEndTime = arg_12_0.yearTable[4].startTime + arg_12_0.rotateDuration

	TaskDispatcher.runRepeat(arg_12_0._onFrame, arg_12_0, 0.001)
end

function var_0_0._onFrame(arg_13_0)
	local var_13_0 = Time.time

	if arg_13_0:canStopAnimation() then
		arg_13_0:cancelAnimationTask()

		return
	end

	if MainSceneSwitchController.instance:isSwitching() then
		return
	end

	for iter_13_0 = 1, 4 do
		if var_13_0 >= arg_13_0.yearTable[iter_13_0].startTime then
			local var_13_1 = var_13_0 - arg_13_0.yearTable[iter_13_0].startTime

			if var_13_1 >= arg_13_0.rotateDuration then
				arg_13_0.setNumYearTable[iter_13_0] = arg_13_0.yearTable[iter_13_0].targetNum
			else
				local var_13_2 = var_13_1 / arg_13_0.rotateDuration
				local var_13_3 = arg_13_0.aniCurveConfig:GetY(var_13_2)

				arg_13_0.setNumYearTable[iter_13_0] = arg_13_0.yearTable[iter_13_0].startNum + arg_13_0.yearTable[iter_13_0].totalIncrement * var_13_3
			end
		end
	end

	arg_13_0:setMaterialsParam()
end

function var_0_0.hideNode(arg_14_0)
	gohelper.setActive(arg_14_0.node, false)
	gohelper.setActive(arg_14_0.node1, false)
end

function var_0_0.showNode(arg_15_0)
	gohelper.setActive(arg_15_0.node, true)
	gohelper.setActive(arg_15_0.node1, true)
end

function var_0_0.canStopAnimation(arg_16_0)
	if arg_16_0.animationEndTime < Time.time then
		for iter_16_0 = 1, 4 do
			if arg_16_0.setNumYearTable[iter_16_0] < arg_16_0.yearTable[iter_16_0].targetNum then
				return false
			end
		end

		return true
	end

	return false
end

function var_0_0.setMaterialsParam(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.materials) do
		iter_17_1:SetVector("_Year", Vector4.New(arg_17_0.setNumYearTable[1], arg_17_0.setNumYearTable[2], arg_17_0.setNumYearTable[3], arg_17_0.setNumYearTable[4]))
	end
end

function var_0_0._getTotalIncrement(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = 10 * arg_18_0.rotateCircle
	local var_18_1 = arg_18_2 - arg_18_1

	if var_18_1 < 0 then
		var_18_1 = var_18_1 + 10
	end

	return var_18_0 + var_18_1
end

function var_0_0._numberConvertToTable(arg_19_0, arg_19_1)
	local var_19_0 = tostring(arg_19_1)
	local var_19_1 = {}

	for iter_19_0 in string.gmatch(var_19_0, ".") do
		table.insert(var_19_1, tonumber(iter_19_0))
	end

	return var_19_1
end

function var_0_0.addRepeatTask(arg_20_0)
	TaskDispatcher.runRepeat(arg_20_0._playNodeAnimation, arg_20_0, arg_20_0.rotateDuration + arg_20_0.circulationInterval)
end

function var_0_0.cancelRepeatTask(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._playNodeAnimation, arg_21_0)
	arg_21_0:cancelAnimationTask()
end

function var_0_0.cancelAnimationTask(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._onFrame, arg_22_0)

	arg_22_0.yearTable = {}
end

function var_0_0.onSceneClose(arg_23_0)
	arg_23_0:cancelRepeatTask()

	arg_23_0.materials = {}
	arg_23_0.setNumYearTable = {}
	arg_23_0.yearTable = {}
	arg_23_0.circulationNums = {}
	arg_23_0.node = nil
	arg_23_0.node1 = nil
	arg_23_0.circulationIndex = 0
	arg_23_0.lastEpisodeCo = nil

	if arg_23_0.assetItem then
		arg_23_0.assetItem:Release()

		arg_23_0.aniCurveConfig = nil
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_23_0._onCloseViewFinish, arg_23_0)
	MainSceneSwitchController.instance:unregisterCallback(MainSceneSwitchEvent.SwitchSceneFinish, arg_23_0._onSwitchSceneFinish, arg_23_0)
end

return var_0_0

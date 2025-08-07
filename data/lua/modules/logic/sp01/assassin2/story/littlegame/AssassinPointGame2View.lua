module("modules.logic.sp01.assassin2.story.littlegame.AssassinPointGame2View", package.seeall)

local var_0_0 = class("AssassinPointGame2View", BaseView)
local var_0_1 = {
	Disconnected = 1,
	Connected = 2
}
local var_0_2 = "AssassinPointGame2View"
local var_0_3 = 0.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gogame1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_game1")
	arg_1_0._golines = gohelper.findChild(arg_1_0.viewGO, "root/#go_game1/#go_lines2")
	arg_1_0._gopoints1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_game1/#go_points")
	arg_1_0._gopoints2 = gohelper.findChild(arg_1_0.viewGO, "root/#go_game1/#go_points2")
	arg_1_0._goeyelight = gohelper.findChild(arg_1_0.viewGO, "root/top/#go_points/#go_point1/#eyelight")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnGameAfterStoryDone, arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._pointView = arg_4_0.viewContainer._views[1]

	arg_4_0:initLines()
	arg_4_0:initPoints()
end

function var_0_0.initLines(arg_5_0)
	arg_5_0._linesTran = arg_5_0._golines.transform
	arg_5_0._lineCount = arg_5_0._linesTran.childCount
	arg_5_0._lineName2GoDict = {}
	arg_5_0._lineStatusDict = {}

	for iter_5_0 = 1, arg_5_0._lineCount do
		local var_5_0 = arg_5_0._linesTran:GetChild(iter_5_0 - 1).gameObject

		if gohelper.isNil(var_5_0) then
			break
		end

		local var_5_1 = var_5_0.name

		arg_5_0._lineName2GoDict[var_5_1] = var_5_0
		arg_5_0._lineStatusDict[var_5_1] = var_0_1.Disconnected
	end
end

function var_0_0.initPoints(arg_6_0)
	arg_6_0._pointGoTab = arg_6_0:getUserDataTb_()
	arg_6_0._pointName2GoTab = arg_6_0:getUserDataTb_()
	arg_6_0._lineName2ConnectPointDict = {}
	arg_6_0._point2ConnectLineNameDict = {}
	arg_6_0._pointsTran = arg_6_0._gopoints2.transform
	arg_6_0._pointCount = 1
	arg_6_0._collectPointCount = 0

	for iter_6_0 = 1, arg_6_0._pointCount do
		local var_6_0 = arg_6_0._pointsTran:GetChild(iter_6_0 - 1).gameObject

		if gohelper.isNil(var_6_0) then
			break
		end

		arg_6_0._pointName2GoTab[var_6_0.name] = var_6_0
		arg_6_0._pointGoTab[iter_6_0] = var_6_0

		local var_6_1 = string.split(var_6_0.name, "#")

		for iter_6_1, iter_6_2 in ipairs(var_6_1) do
			arg_6_0._lineName2ConnectPointDict[iter_6_2] = iter_6_0
		end

		arg_6_0._point2ConnectLineNameDict[iter_6_0] = var_6_1
	end
end

function var_0_0.onClickLineConnectPoint(arg_7_0, arg_7_1)
	if arg_7_0._lastClickPointIndex then
		local var_7_0 = arg_7_0:getTwoPointConnectLine(arg_7_0._lastClickPointIndex, arg_7_1)

		if var_7_0 then
			gohelper.setActive(var_7_0, true)

			arg_7_0._lineStatusDict[var_7_0.name] = var_0_1.Connected

			arg_7_0:checkNewLineConnectOtherLine(var_7_0)
			AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_connectPoint)
		end

		arg_7_0._pointView:onClickPointError(arg_7_1)
		arg_7_0._pointView:onClickPointError(arg_7_0._lastClickPointIndex)

		arg_7_0._lastClickPointIndex = nil

		return
	end

	arg_7_0._lastClickPointIndex = arg_7_1
end

function var_0_0.getTwoPointConnectLine(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = string.format("%s_%s", arg_8_1, arg_8_2)
	local var_8_1 = string.format("%s_%s", arg_8_2, arg_8_1)

	return arg_8_0._lineName2GoDict[var_8_0] or arg_8_0._lineName2GoDict[var_8_1]
end

function var_0_0.checkNewLineConnectOtherLine(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.name
	local var_9_1 = arg_9_0._lineName2ConnectPointDict[var_9_0]
	local var_9_2 = var_9_1 and arg_9_0._point2ConnectLineNameDict[var_9_1]

	if not var_9_2 or #var_9_2 <= 0 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		if arg_9_0._lineStatusDict[iter_9_1] == var_0_1.Disconnected then
			return
		end
	end

	arg_9_0:destroyFlow()

	arg_9_0._flow = FlowSequence.New()

	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0.lockScreen, arg_9_0, true))
	arg_9_0._flow:addWork(DelayDoFuncWork.New(arg_9_0.onNewLineConnectOtherLine, arg_9_0, var_0_3, var_9_1))
	arg_9_0._flow:addWork(FunctionWork.New(arg_9_0.lockScreen, arg_9_0, false))
	arg_9_0._flow:start()
end

function var_0_0.destroyFlow(arg_10_0)
	if arg_10_0._flow then
		arg_10_0._flow:destroy()

		arg_10_0._flow = nil
	end
end

function var_0_0.lockScreen(arg_11_0, arg_11_1)
	AssassinHelper.lockScreen(var_0_2, arg_11_1)
end

function var_0_0.onNewLineConnectOtherLine(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._pointGoTab[arg_12_1]

	if not var_12_0 then
		return
	end

	gohelper.setActive(var_12_0, true)
	gohelper.setActive(arg_12_0._gopoints2, true)
	gohelper.setActive(arg_12_0._goeyelight, true)
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_findEyeSucc)

	arg_12_0._collectPointCount = arg_12_0._collectPointCount + 1

	arg_12_0:checkIsGameDone()
end

function var_0_0.checkIsGameDone(arg_13_0)
	if arg_13_0._collectPointCount >= arg_13_0._pointCount then
		gohelper.setActive(arg_13_0._gopoints1, false)
		gohelper.setActive(arg_13_0._golines, false)

		local var_13_0 = VersionActivity2_9DungeonHelper.getLittleGameDialogIds(AssassinEnum.ConstId.DialogId_PointGame)
		local var_13_1 = var_13_0 and #var_13_0 or 0

		arg_13_0._pointView:playDialog(var_13_1, arg_13_0.onGameDone, arg_13_0)
	end
end

function var_0_0.onGameDone(arg_14_0)
	arg_14_0.viewContainer:stat(StatEnum.Result.Success)
	AssassinController.instance:dispatchEvent(AssassinEvent.OnGameEpisodeFinished, arg_14_0._episodeId)
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0._episodeId = arg_15_0.viewParam and arg_15_0.viewParam.episodeId
end

function var_0_0.onClose(arg_16_0)
	arg_16_0:destroyFlow()
	arg_16_0:lockScreen(false)
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0

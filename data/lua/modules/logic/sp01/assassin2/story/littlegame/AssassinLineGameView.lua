module("modules.logic.sp01.assassin2.story.littlegame.AssassinLineGameView", package.seeall)

local var_0_0 = class("AssassinLineGameView", BaseView)
local var_0_1 = {
	Disconnected = 1,
	Connecting = 3,
	Connected = 2
}
local var_0_2 = "AssassinLineGameView"
local var_0_3 = 30
local var_0_4 = 0.3
local var_0_5 = 2

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gogame1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_game1")
	arg_1_0._golines = gohelper.findChild(arg_1_0.viewGO, "root/#go_game1/#go_lines")
	arg_1_0._gopoints = gohelper.findChild(arg_1_0.viewGO, "root/#go_game1/#go_points")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "root/top/#txt_title")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._goprogresspoints = gohelper.findChild(arg_1_0.viewGO, "root/top/#go_points")
	arg_1_0._goprogressitem = gohelper.findChild(arg_1_0.viewGO, "root/top/#go_points/#go_point")

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
	arg_4_0:initLines()
	arg_4_0:initPoints()
	arg_4_0:initDialogs()
	arg_4_0:refreshProgress()
end

function var_0_0.initLines(arg_5_0)
	arg_5_0._linesTran = arg_5_0._golines.transform
	arg_5_0._lineCount = arg_5_0._linesTran.childCount
	arg_5_0._lineRootGoTab = arg_5_0:getUserDataTb_()
	arg_5_0._guideLineGoTab = arg_5_0:getUserDataTb_()
	arg_5_0._lineStatusMap = {}

	for iter_5_0 = 1, arg_5_0._lineCount do
		local var_5_0 = arg_5_0._linesTran:GetChild(iter_5_0 - 1).gameObject

		if gohelper.isNil(var_5_0) then
			break
		end

		SLFramework.UGUI.UIDragListener.Get(var_5_0):AddDragBeginListener(arg_5_0._onDragBegin, arg_5_0, iter_5_0)
		SLFramework.UGUI.UIDragListener.Get(var_5_0):AddDragListener(arg_5_0._onDrag, arg_5_0, iter_5_0)
		SLFramework.UGUI.UIDragListener.Get(var_5_0):AddDragEndListener(arg_5_0._onDragEnd, arg_5_0, iter_5_0)
		gohelper.setActive(var_5_0, false)
		table.insert(arg_5_0._lineRootGoTab, var_5_0)

		local var_5_1 = gohelper.findChild(arg_5_0.viewGO, "root/#go_game1/#go_guid/#line" .. iter_5_0)

		gohelper.setActive(var_5_1, false)

		arg_5_0._guideLineGoTab[iter_5_0] = var_5_1
		arg_5_0._lineStatusMap[iter_5_0] = var_0_1.Disconnected
	end
end

function var_0_0.initPoints(arg_6_0)
	arg_6_0._lineIndex2PointDict = {}
	arg_6_0._pointGoTab = arg_6_0:getUserDataTb_()
	arg_6_0._pointsTran = arg_6_0._gopoints.transform
	arg_6_0._pointCount = arg_6_0._pointsTran.childCount
	arg_6_0._collectPointCount = 0

	for iter_6_0 = 1, arg_6_0._pointCount do
		local var_6_0 = arg_6_0._pointsTran:GetChild(iter_6_0 - 1).gameObject

		if gohelper.isNil(var_6_0) then
			break
		end

		local var_6_1 = string.splitToNumber(var_6_0.name, "_")
		local var_6_2 = var_6_1[1]
		local var_6_3 = var_6_1[2]

		arg_6_0._lineIndex2PointDict[var_6_2] = iter_6_0
		arg_6_0._lineIndex2PointDict[var_6_3] = iter_6_0
		arg_6_0._pointGoTab[iter_6_0] = var_6_0

		gohelper.setActive(var_6_0, false)
	end
end

function var_0_0.activeGuideLine(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 or not arg_7_2 then
		return
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		local var_7_0 = tabletool.indexOf(arg_7_2, iter_7_0) ~= nil

		gohelper.setActive(iter_7_1, var_7_0)
	end
end

function var_0_0.getLineConnectKey(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 < arg_8_1 then
		arg_8_2, arg_8_1 = arg_8_1, arg_8_2
	end

	return string.format("%s_%s", arg_8_1, arg_8_2)
end

function var_0_0._onDragBegin(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:_processDragEvent(arg_9_1, arg_9_2)
end

function var_0_0._onDrag(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:_processDragEvent(arg_10_1, arg_10_2)
end

function var_0_0._onDragEnd(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:_processDragEvent(arg_11_1, arg_11_2)

	arg_11_0._startDragPosition = nil
end

function var_0_0._processDragEvent(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0._startDragPosition then
		arg_12_0._startDragPosition = arg_12_2.position
	end

	local var_12_0 = tonumber(arg_12_1)
	local var_12_1 = arg_12_0._lineStatusMap[var_12_0]
	local var_12_2 = arg_12_0._lineRootGoTab[var_12_0]

	if not var_12_1 or var_12_1 == var_0_1.Connected or var_12_1 == var_0_1.Connecting or Vector2.Distance(arg_12_2.position, arg_12_0._startDragPosition) < var_0_3 then
		return
	end

	arg_12_0._lineStatusMap[var_12_0] = var_0_1.Connecting

	gohelper.setActive(arg_12_0._guideLineGoTab[var_12_0], false)
	SLFramework.AnimatorPlayer.Get(var_12_2):Play("open", arg_12_0._onLinePlayOpenAnimDone, {
		self = arg_12_0,
		lineIndex = var_12_0
	})
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_dragLine)
end

function var_0_0._onLinePlayOpenAnimDone(arg_13_0)
	local var_13_0 = arg_13_0 and arg_13_0.self
	local var_13_1 = arg_13_0 and arg_13_0.lineIndex

	if var_13_1 % 2 ~= 0 then
		var_13_0:activeLineAndGuide(var_13_1 + 1, true)
	end

	var_13_0._lineStatusMap[var_13_1] = var_0_1.Connected

	var_13_0:_checkIsLineConnect2OtherLine(var_13_1)
end

function var_0_0._checkIsLineConnect2OtherLine(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._lineIndex2PointDict[arg_14_1]

	if not var_14_0 then
		return
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_0._lineIndex2PointDict) do
		if iter_14_0 ~= arg_14_1 and iter_14_1 == var_14_0 then
			local var_14_1 = iter_14_0

			if arg_14_0._lineStatusMap[var_14_1] ~= var_0_1.Connected then
				return
			end
		end
	end

	arg_14_0:destroyConnectPointFlow()

	arg_14_0._connectLineFlow = FlowSequence.New()

	arg_14_0._connectLineFlow:addWork(FunctionWork.New(arg_14_0.lockScreen, arg_14_0, true))
	arg_14_0._connectLineFlow:addWork(DelayDoFuncWork.New(arg_14_0.onConnect2Point, arg_14_0, var_0_4, var_14_0))
	arg_14_0._connectLineFlow:addWork(DelayDoFuncWork.New(arg_14_0.switch2NextGame, arg_14_0, var_0_5))
	arg_14_0._connectLineFlow:addWork(FunctionWork.New(arg_14_0.lockScreen, arg_14_0, false))
	arg_14_0._connectLineFlow:start()
end

function var_0_0.onConnect2Point(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._pointGoTab[arg_15_1]

	if not var_15_0 then
		return
	end

	arg_15_0._collectPointCount = arg_15_0._collectPointCount + 1

	gohelper.setActive(var_15_0, true)
	arg_15_0:playLineCloseAnim(arg_15_1)
	arg_15_0:refreshProgress()
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_findEyeSucc)
end

function var_0_0.playLineCloseAnim(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in pairs(arg_16_0._lineIndex2PointDict) do
		if iter_16_1 == arg_16_1 then
			SLFramework.AnimatorPlayer.Get(arg_16_0._lineRootGoTab[iter_16_0]):Play("close", arg_16_0._onPlayLineCloseAnimDone, arg_16_0)
		end
	end
end

function var_0_0._onPlayLineCloseAnimDone(arg_17_0)
	return
end

function var_0_0.switch2NextGame(arg_18_0)
	if arg_18_0._collectPointCount >= arg_18_0._pointCount then
		arg_18_0:onGameDone()
	else
		VersionActivity2_9DungeonController.instance:openAssassinStoryDialogView(arg_18_0._dialogIdList[2], arg_18_0.reallySwitch2NextGroup, arg_18_0)
	end
end

function var_0_0.reallySwitch2NextGroup(arg_19_0)
	arg_19_0:activeLineAndGuide(3, true)
end

function var_0_0.refreshProgress(arg_20_0)
	gohelper.CreateObjList(arg_20_0, arg_20_0._refreshSingleProgressPoint, arg_20_0._pointGoTab, arg_20_0._goprogresspoints, arg_20_0._goprogressitem)
end

function var_0_0._refreshSingleProgressPoint(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = gohelper.findChild(arg_21_1, "#eyelight")

	gohelper.setActive(var_21_0, arg_21_3 <= arg_21_0._collectPointCount)
end

function var_0_0.initDialogs(arg_22_0)
	arg_22_0._dialogIdList = VersionActivity2_9DungeonHelper.getLittleGameDialogIds(AssassinEnum.ConstId.DialogId_LineGame)

	VersionActivity2_9DungeonController.instance:openAssassinStoryDialogView(arg_22_0._dialogIdList[1], arg_22_0.reallyStartGame, arg_22_0)
end

function var_0_0.reallyStartGame(arg_23_0)
	arg_23_0:activeLineAndGuide(1, true)
end

function var_0_0.activeLineAndGuide(arg_24_0, arg_24_1, arg_24_2)
	gohelper.setActive(arg_24_0._lineRootGoTab[arg_24_1], arg_24_2)
	gohelper.setActive(arg_24_0._guideLineGoTab[arg_24_1], arg_24_2)
end

function var_0_0.onGameDone(arg_25_0)
	arg_25_0.viewContainer:stat(StatEnum.Result.Success)
	AssassinController.instance:dispatchEvent(AssassinEvent.OnGameEpisodeFinished, arg_25_0._episodeId)
end

function var_0_0.destroyConnectPointFlow(arg_26_0)
	if arg_26_0._connectLineFlow then
		arg_26_0._connectLineFlow:destroy()

		arg_26_0._connectLineFlow = nil
	end
end

function var_0_0.releaseAllListener(arg_27_0)
	if arg_27_0._lineRootGoTab then
		for iter_27_0, iter_27_1 in pairs(arg_27_0._lineRootGoTab) do
			SLFramework.UGUI.UIDragListener.Get(iter_27_1):RemoveDragBeginListener()
			SLFramework.UGUI.UIDragListener.Get(iter_27_1):RemoveDragListener()
			SLFramework.UGUI.UIDragListener.Get(iter_27_1):RemoveDragEndListener()
		end
	end
end

function var_0_0.lockScreen(arg_28_0, arg_28_1)
	AssassinHelper.lockScreen(var_0_2, arg_28_1)
end

function var_0_0.onOpen(arg_29_0)
	arg_29_0._episodeId = arg_29_0.viewParam and arg_29_0.viewParam.episodeId
end

function var_0_0.onClose(arg_30_0)
	arg_30_0:lockScreen(false)
	arg_30_0:releaseAllListener()
	arg_30_0:destroyConnectPointFlow()
end

function var_0_0.onDestroyView(arg_31_0)
	return
end

return var_0_0

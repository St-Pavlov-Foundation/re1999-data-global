module("modules.logic.sp01.assassin2.story.littlegame.AssassinEyeGameView", package.seeall)

local var_0_0 = class("AssassinEyeGameView", BaseView)
local var_0_1 = 2
local var_0_2 = "AssassinController;AssassinEvent;OnEyeGameFinished"
local var_0_3 = {
	Intense = 2,
	Slight = 1,
	None = 0
}
local var_0_4 = {
	[var_0_3.None] = 0,
	[var_0_3.Slight] = 10,
	[var_0_3.Intense] = 0
}
local var_0_5 = {
	[var_0_3.None] = 0,
	[var_0_3.Slight] = 0.1,
	[var_0_3.Intense] = 0.05
}
local var_0_6 = {
	Intersect = 2,
	Include = 3,
	Away = 1
}
local var_0_7 = 0.06
local var_0_8 = {
	[var_0_6.Away] = var_0_3.None,
	[var_0_6.Intersect] = var_0_3.Slight,
	[var_0_6.Include] = var_0_3.Intense
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gogame1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_game1")
	arg_1_0._gogame2 = gohelper.findChild(arg_1_0.viewGO, "root/#go_game2")
	arg_1_0._goframe = gohelper.findChild(arg_1_0.viewGO, "root/#go_frame")
	arg_1_0._imageframe = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_frame/#image_frame")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "root/top/#txt_title")
	arg_1_0._gopoints = gohelper.findChild(arg_1_0.viewGO, "root/top/#go_points")
	arg_1_0._gopoint = gohelper.findChild(arg_1_0.viewGO, "root/top/#go_points/#go_point")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "root/#go_topright")
	arg_1_0._btnfind = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_topright/#btn_find")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "root/#go_frame/#image_frame/#go_mask")
	arg_1_0._golightbg = gohelper.findChild(arg_1_0.viewGO, "root/simage_light")
	arg_1_0._golighteye = gohelper.findChild(arg_1_0.viewGO, "root/#go_topright/#btn_find/image_light")
	arg_1_0._gogreyeye = gohelper.findChild(arg_1_0.viewGO, "root/#go_topright/#btn_find/image_grey")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfind:AddClickListener(arg_2_0._btnfindOnClick, arg_2_0)
	SLFramework.UGUI.UIDragListener.Get(arg_2_0._goframe):AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	SLFramework.UGUI.UIDragListener.Get(arg_2_0._goframe):AddDragListener(arg_2_0._onDrag, arg_2_0)
	SLFramework.UGUI.UIDragListener.Get(arg_2_0._goframe):AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnGameAfterStoryDone, arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfind:RemoveClickListener()
	SLFramework.UGUI.UIDragListener.Get(arg_3_0._goframe):RemoveDragBeginListener()
	SLFramework.UGUI.UIDragListener.Get(arg_3_0._goframe):RemoveDragListener()
	SLFramework.UGUI.UIDragListener.Get(arg_3_0._goframe):RemoveDragEndListener()
end

function var_0_0._btnfindOnClick(arg_4_0)
	if arg_4_0._isUseEye then
		return
	end

	arg_4_0._isUseEye = true

	arg_4_0:refreshMaskPoint()
	gohelper.setActive(arg_4_0._goframe, true)
	gohelper.setActive(arg_4_0._golightbg, true)
	gohelper.setActive(arg_4_0._golighteye, arg_4_0._isUseEye)
	gohelper.setActive(arg_4_0._gogreyeye, not arg_4_0._isUseEye)
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_clickeye)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._isUseEye = false

	gohelper.setActive(arg_5_0._goframe, false)
	gohelper.setActive(arg_5_0._gogame1, false)
	gohelper.setActive(arg_5_0._gogame2, false)
	gohelper.setActive(arg_5_0._golightbg, false)
	gohelper.setActive(arg_5_0._golighteye, arg_5_0._isUseEye)
	gohelper.setActive(arg_5_0._gogreyeye, not arg_5_0._isUseEye)

	arg_5_0._frameTran = arg_5_0._goframe.transform
	arg_5_0._framePosTab = arg_5_0:calcPosRangeInRect(0, 0, arg_5_0._frameTran)
	arg_5_0._frameImgTran = arg_5_0._imageframe.transform
	arg_5_0.viewTran = arg_5_0.viewGO.transform
	arg_5_0._maskTran = arg_5_0._gomask.transform
	arg_5_0._animator = gohelper.onceAddComponent(arg_5_0.viewGO, gohelper.Type_Animator)
	arg_5_0._gointersecteffect = gohelper.findChild(arg_5_0._goframe, "#image_frame/#faguang")
	arg_5_0._goincludeeffect = gohelper.findChild(arg_5_0._goframe, "#image_frame/#jiexi")
	arg_5_0._dialogIdList = VersionActivity2_9DungeonHelper.getLittleGameDialogIds(AssassinEnum.ConstId.DialogId_EyeGame)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._episodeId = arg_6_0.viewParam and arg_6_0.viewParam.episodeId
	arg_6_0._flow = FlowSequence.New()

	arg_6_0._flow:addWork(arg_6_0:buildGameFlow(1))
	arg_6_0._flow:addWork(FunctionWork.New(arg_6_0.beforeSwitchNextGame, arg_6_0))
	arg_6_0._flow:addWork(arg_6_0:buildGameFlow(2))
	arg_6_0._flow:registerDoneListener(arg_6_0.onGameDone, arg_6_0)
	arg_6_0._flow:start()
	arg_6_0:playDialog(1, arg_6_0.triggerGuideEvent, arg_6_0)
end

function var_0_0.triggerGuideEvent(arg_7_0)
	AssassinController.instance:dispatchEvent(AssassinEvent.TriggerEyeGameGuide)
end

function var_0_0.buildGameFlow(arg_8_0, arg_8_1)
	local var_8_0 = FlowSequence.New()

	var_8_0:addWork(FunctionWork.New(arg_8_0.init, arg_8_0, arg_8_1))
	var_8_0:addWork(WaitEventWork.New(var_0_2 .. ";" .. arg_8_1))
	var_8_0:addWork(AssassinDialogWork.New(arg_8_0._dialogIdList[arg_8_1 + 1]))

	return var_8_0
end

function var_0_0.beforeSwitchNextGame(arg_9_0)
	arg_9_0._animator:Play("switch", 0, 0)
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_switchNext)
end

function var_0_0.playDialog(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0._dialogIdList and arg_10_0._dialogIdList[arg_10_1]

	if not var_10_0 then
		return
	end

	VersionActivity2_9DungeonController.instance:openAssassinStoryDialogView(var_10_0, arg_10_2, arg_10_3)
end

function var_0_0.onGameDone(arg_11_0)
	arg_11_0.viewContainer:stat(StatEnum.Result.Success)
	AssassinController.instance:dispatchEvent(AssassinEvent.OnGameEpisodeFinished, arg_11_0._episodeId)
end

function var_0_0.init(arg_12_0, arg_12_1)
	arg_12_0._curGameIndex = arg_12_1
	arg_12_0._rootGO, arg_12_0._maskRootGO = arg_12_0:_activeTargetGame(arg_12_1)
	arg_12_0._rootTran = arg_12_0._rootGO.transform
	arg_12_0._maskRootTran = arg_12_0._maskRootGO.transform
	arg_12_0._gofindarea = gohelper.findChild(arg_12_0._rootGO, "go_findarea")
	arg_12_0._findAreaTran = arg_12_0._gofindarea.transform
	arg_12_0._findAreaWidth = recthelper.getWidth(arg_12_0._findAreaTran)
	arg_12_0._findAreaHeight = recthelper.getHeight(arg_12_0._findAreaTran)
	arg_12_0._frameTran.parent = arg_12_0._findAreaTran

	gohelper.setActive(arg_12_0._goframe, arg_12_0._isUseEye)

	arg_12_0._maskPointsGO = gohelper.findChild(arg_12_0._maskRootGO, "go_points")
	arg_12_0._maskPointsTran = arg_12_0._maskPointsGO.transform
	arg_12_0._minFindAreaPosX = -arg_12_0._findAreaWidth / 2 + arg_12_0._framePosTab.width / 2
	arg_12_0._maxFindAreaPosX = arg_12_0._findAreaWidth / 2 - arg_12_0._framePosTab.width / 2
	arg_12_0._minFindAreaPosY = -arg_12_0._findAreaHeight / 2 + arg_12_0._framePosTab.height / 2
	arg_12_0._maxFindAreaPosY = arg_12_0._findAreaHeight / 2 - arg_12_0._framePosTab.height / 2
	arg_12_0._findAreaIndex = 0
	arg_12_0._rectPositionType = var_0_6.Away
	arg_12_0._findAreaIndexDict = {}
	arg_12_0._pointRectPosList = {}
	arg_12_0._pointTranList = arg_12_0:getUserDataTb_()
	arg_12_0._pointIconTranList = arg_12_0:getUserDataTb_()

	arg_12_0:refreshMaskPoint()

	for iter_12_0 = 1, math.huge do
		local var_12_0 = gohelper.findChild(arg_12_0._maskPointsGO, "go_area" .. iter_12_0)

		if gohelper.isNil(var_12_0) then
			break
		end

		local var_12_1 = gohelper.findChildImage(var_12_0, "icon")
		local var_12_2 = var_12_0.transform
		local var_12_3, var_12_4 = recthelper.rectToRelativeAnchorPos2(var_12_2.position, arg_12_0._findAreaTran)
		local var_12_5 = arg_12_0:calcPosRangeInRect(var_12_3, var_12_4, var_12_2)

		table.insert(arg_12_0._pointRectPosList, var_12_5)
		table.insert(arg_12_0._pointTranList, var_12_0.transform)
		table.insert(arg_12_0._pointIconTranList, var_12_1.transform)
	end

	arg_12_0._allPointNum = #arg_12_0._pointRectPosList

	gohelper.setActive(arg_12_0._findAreaTran, true)
	gohelper.setActive(arg_12_0._goincludeeffect, false)
	gohelper.setActive(arg_12_0._gointersecteffect, false)
	arg_12_0:refreshFindProgress()
end

function var_0_0._activeTargetGame(arg_13_0, arg_13_1)
	local var_13_0
	local var_13_1

	for iter_13_0 = 1, math.huge do
		local var_13_2 = gohelper.findChild(arg_13_0.viewGO, "root/#go_game" .. iter_13_0)
		local var_13_3 = gohelper.findChild(arg_13_0._gomask, "#go_gamemask" .. iter_13_0)

		if gohelper.isNil(var_13_2) or gohelper.isNil(var_13_3) then
			break
		end

		local var_13_4 = iter_13_0 == arg_13_1

		gohelper.setActive(var_13_2, var_13_4)
		gohelper.setActive(var_13_3, var_13_4)

		if var_13_4 then
			var_13_0 = var_13_2
			var_13_1 = var_13_3
		end
	end

	return var_13_0, var_13_1
end

function var_0_0._onDragBegin(arg_14_0)
	arg_14_0:_processDragEvent()
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_beginDragFrame)
end

function var_0_0._onDrag(arg_15_0)
	arg_15_0:_processDragEvent()
end

function var_0_0._onDragEnd(arg_16_0)
	arg_16_0:_processDragEvent()
end

function var_0_0._processDragEvent(arg_17_0)
	local var_17_0 = GamepadController.instance:getMousePosition()
	local var_17_1, var_17_2 = recthelper.screenPosToAnchorPos2(var_17_0, arg_17_0._findAreaTran)
	local var_17_3 = Mathf.Clamp(var_17_1, arg_17_0._minFindAreaPosX, arg_17_0._maxFindAreaPosX)
	local var_17_4 = Mathf.Clamp(var_17_2, arg_17_0._minFindAreaPosY, arg_17_0._maxFindAreaPosY)

	recthelper.setAnchor(arg_17_0._frameTran, var_17_3, var_17_4)

	local var_17_5, var_17_6 = arg_17_0:checkIsFindArea(var_17_3, var_17_4)

	if var_17_6 ~= arg_17_0._findAreaIndex or var_17_5 ~= arg_17_0._rectPositionType then
		arg_17_0._rectPositionType = var_17_5
		arg_17_0._findAreaIndex = var_17_6

		TaskDispatcher.cancelTask(arg_17_0._wait2FindAreaSuccee, arg_17_0)

		if var_17_6 and var_17_5 == var_0_6.Include then
			TaskDispatcher.cancelTask(arg_17_0._wait2FindAreaSuccee, arg_17_0)
			TaskDispatcher.runDelay(arg_17_0._wait2FindAreaSuccee, arg_17_0, var_0_1)
			AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_findEye)
		end

		local var_17_7 = var_0_8[var_17_5]

		arg_17_0:tickShake(var_17_7)
	end

	gohelper.setActive(arg_17_0._gointersecteffect, var_17_5 == var_0_6.Intersect)
	gohelper.setActive(arg_17_0._goincludeeffect, var_17_5 == var_0_6.Include)
	arg_17_0:refreshMaskPoint()
end

function var_0_0.checkIsFindArea(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:calcPosRangeInRect(arg_18_1, arg_18_2, arg_18_0._frameTran, arg_18_0._framePosTab)

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._pointRectPosList) do
		if not arg_18_0._findAreaIndexDict[iter_18_0] then
			local var_18_0 = arg_18_0:calcTwoRectPositionType(arg_18_0._framePosTab, iter_18_1)

			if var_18_0 ~= var_0_6.Away then
				return var_18_0, iter_18_0
			end
		end
	end

	return var_0_6.Away
end

function var_0_0.calcTwoRectPositionType(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1.minPosX
	local var_19_1 = arg_19_1.maxPosX
	local var_19_2 = arg_19_1.minPosY
	local var_19_3 = arg_19_1.maxPosY
	local var_19_4 = arg_19_2.minPosX
	local var_19_5 = arg_19_2.maxPosX
	local var_19_6 = arg_19_2.minPosY
	local var_19_7 = arg_19_2.maxPosY

	if var_19_0 <= var_19_4 and var_19_5 <= var_19_1 and var_19_2 <= var_19_6 and var_19_7 <= var_19_3 then
		return var_0_6.Include
	else
		local var_19_8 = math.max(var_19_0, var_19_4)
		local var_19_9 = math.min(var_19_1, var_19_5)
		local var_19_10 = math.max(var_19_2, var_19_6)
		local var_19_11 = math.min(var_19_3, var_19_7)

		if var_19_8 < var_19_9 and var_19_10 < var_19_11 then
			return var_0_6.Intersect
		end
	end

	return var_0_6.Away
end

function var_0_0.calcPosRangeInRect(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	arg_20_4 = arg_20_4 or {
		width = recthelper.getWidth(arg_20_3),
		height = recthelper.getHeight(arg_20_3)
	}

	local var_20_0 = arg_20_4.width
	local var_20_1 = arg_20_4.height

	arg_20_4.minPosX = arg_20_1 - var_20_0 / 2
	arg_20_4.maxPosX = arg_20_1 + var_20_0 / 2
	arg_20_4.minPosY = arg_20_2 - var_20_1 / 2
	arg_20_4.maxPosY = arg_20_2 + var_20_1 / 2
	arg_20_4.posX = arg_20_1
	arg_20_4.posY = arg_20_2
	arg_20_4.screenPos = recthelper.uiPosToScreenPos(arg_20_3)

	return arg_20_4
end

function var_0_0._wait2FindAreaSuccee(arg_21_0)
	if arg_21_0._findAreaIndex then
		arg_21_0._findAreaIndexDict[arg_21_0._findAreaIndex] = true

		gohelper.setActive(arg_21_0._pointTranList[arg_21_0._findAreaIndex], true)
		AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_findEyeSucc)
		gohelper.onceAddComponent(arg_21_0._pointTranList[arg_21_0._findAreaIndex], gohelper.Type_Animator):Play("finish", 0, 0)
		arg_21_0:refreshFindProgress()
		arg_21_0:tickShake(var_0_3.None)
		TaskDispatcher.cancelTask(arg_21_0._shake, arg_21_0)

		arg_21_0._findAreaIndex = nil
	end
end

function var_0_0.refreshFindProgress(arg_22_0)
	arg_22_0._hasFindNum = tabletool.len(arg_22_0._findAreaIndexDict)
	arg_22_0._txttitle.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("assassineyegameview_title"), arg_22_0._hasFindNum, arg_22_0._allPointNum)

	gohelper.CreateObjList(arg_22_0, arg_22_0.refreshSingleProgress, arg_22_0._pointRectPosList, arg_22_0._gopoints, arg_22_0._gopoint)

	if arg_22_0._hasFindNum >= arg_22_0._allPointNum then
		AssassinController.instance:dispatchEvent(AssassinEvent.OnEyeGameFinished, arg_22_0._curGameIndex)
	end
end

function var_0_0.refreshSingleProgress(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_3 <= arg_23_0._hasFindNum
	local var_23_1 = arg_23_1:GetComponent(gohelper.Type_Image)
	local var_23_2 = gohelper.findChild(arg_23_1, "#eyelight")

	gohelper.setActive(var_23_2, var_23_0)
	UISpriteSetMgr.instance:setSp01AssassinSprite(var_23_1, var_23_0 and "assassin2_threegames_eyes_3_1" or "assassin2_threegames_eyes_3_2")
end

function var_0_0.tickShake(arg_24_0, arg_24_1)
	if arg_24_0._curShakeType == arg_24_1 then
		return
	end

	arg_24_0._curShakeType = arg_24_1

	arg_24_0:_shake()
	TaskDispatcher.cancelTask(arg_24_0._shake, arg_24_0)

	if arg_24_1 ~= var_0_3.None then
		local var_24_0 = var_0_5[arg_24_1]

		TaskDispatcher.runRepeat(arg_24_0._shake, arg_24_0, var_24_0)
	end
end

function var_0_0._shake(arg_25_0)
	local var_25_0 = var_0_4[arg_25_0._curShakeType]

	if not var_25_0 then
		logError(string.format("未配置震动移动范围(ShakeType2ShakeRange) shakeType = %s", arg_25_0._curShakeType))

		return
	end

	arg_25_0:_killTweenId("_frameTweenId")
	arg_25_0:_killTweenId("_iconTweenId")

	local var_25_1, var_25_2 = GameUtil.getRandomPosInCircle(0, 0, var_25_0)

	arg_25_0._frameTweenId = ZProj.TweenHelper.DOAnchorPos(arg_25_0._frameImgTran, var_25_1, var_25_2, var_0_7)

	if arg_25_0._findAreaIndex and arg_25_0._pointIconTranList[arg_25_0._findAreaIndex] then
		local var_25_3, var_25_4 = GameUtil.getRandomPosInCircle(0, 0, var_25_0)

		arg_25_0._iconTweenId = ZProj.TweenHelper.DOAnchorPos(arg_25_0._pointIconTranList[arg_25_0._findAreaIndex], var_25_3, var_25_4, var_0_7)
	end

	arg_25_0:refreshMaskPoint()
end

function var_0_0._killTweenId(arg_26_0, arg_26_1)
	if arg_26_1 and arg_26_0[arg_26_1] then
		ZProj.TweenHelper.KillById(arg_26_0[arg_26_1])

		arg_26_0[arg_26_1] = nil
	end
end

function var_0_0.refreshMaskPoint(arg_27_0)
	local var_27_0, var_27_1 = recthelper.rectToRelativeAnchorPos2(arg_27_0._rootTran.position, arg_27_0._maskTran)

	recthelper.setAnchor(arg_27_0._maskRootTran, var_27_0, var_27_1)
end

function var_0_0.onClose(arg_28_0)
	if arg_28_0._flow then
		arg_28_0._flow:destroy()

		arg_28_0._flow = nil
	end

	arg_28_0:_killTweenId("_frameTweenId")
	arg_28_0:_killTweenId("_iconTweenId")
	TaskDispatcher.cancelTask(arg_28_0._wait2FindAreaSuccee, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._shake, arg_28_0)
end

function var_0_0.onDestroyView(arg_29_0)
	return
end

return var_0_0

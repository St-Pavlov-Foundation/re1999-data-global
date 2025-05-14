module("modules.logic.versionactivity2_5.liangyue.view.LiangYueGameView", package.seeall)

local var_0_0 = class("LiangYueGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_PanelBG")
	arg_1_0._simagePanelPaper = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_PanelPaper")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Left/Top/#txt_Descr")
	arg_1_0._txtTarget = gohelper.findChildText(arg_1_0.viewGO, "Left/Game/Target/#txt_Target")
	arg_1_0._goTick = gohelper.findChild(arg_1_0.viewGO, "Left/Game/Target/#go_Tick")
	arg_1_0._goGridBg = gohelper.findChild(arg_1_0.viewGO, "Left/Game/Grid/image_Grid")
	arg_1_0._gomeshContainer = gohelper.findChild(arg_1_0.viewGO, "Left/Game/Grid/#go_Grid/#go_meshContainer")
	arg_1_0._txtattribute = gohelper.findChildText(arg_1_0.viewGO, "Left/Game/Grid/#go_Grid/#go_meshContainer/image/#txt_attribute")
	arg_1_0._goillustrationContainer = gohelper.findChild(arg_1_0.viewGO, "Left/Game/Grid/#go_Grid/#go_illustrationContainer")
	arg_1_0._godragItem = gohelper.findChild(arg_1_0.viewGO, "Left/Game/Grid/#go_Grid/#go_illustrationContainer/#go_dragItem")
	arg_1_0._goPiecesList = gohelper.findChild(arg_1_0.viewGO, "Right/#go_PiecesList")
	arg_1_0._scrollPieces = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#go_PiecesList/#scroll_Pieces")
	arg_1_0._goillstrationItem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_PiecesList/#scroll_Pieces/Viewport/Content/#go_illstrationItem")
	arg_1_0._imagePiece = gohelper.findChildImage(arg_1_0.viewGO, "Right/#go_PiecesList/#scroll_Pieces/Viewport/Content/#go_illstrationItem/#image_Piece")
	arg_1_0._goLine = gohelper.findChild(arg_1_0.viewGO, "Right/#go_PiecesList/#scroll_Pieces/Viewport/Content/#go_illstrationItem/#go_Line")
	arg_1_0._scrollText = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#scroll_Text")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "Right/#scroll_Text/Viewport/Content/#go_Item")
	arg_1_0._goCompleted = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Completed")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._btnfinished = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Finished")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Reset")
	arg_1_0._txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_Title")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "Right/#go_PiecesList/#scroll_Pieces/Viewport/Content")
	arg_1_0._goScrollIllustration = gohelper.findChild(arg_1_0.viewGO, "Right/#go_PiecesList/#scroll_Pieces")
	arg_1_0._goScrollText = gohelper.findChild(arg_1_0.viewGO, "Right/#scroll_Text")
	arg_1_0._goImageBg = gohelper.findChild(arg_1_0.viewGO, "Left/Game/Grid/image_Grid")
	arg_1_0._clickMeshContainer = gohelper.findChildClick(arg_1_0.viewGO, "Left/Game/Grid/#go_Grid/#go_meshContainer")
	arg_1_0._txtYear = gohelper.findChildText(arg_1_0.viewGO, "Left/Top/txt_1999")
	arg_1_0._txtMonth = gohelper.findChildText(arg_1_0.viewGO, "Left/Top/txt_Month")
	arg_1_0._txtDay = gohelper.findChildText(arg_1_0.viewGO, "Left/Top/txt_Day")
	arg_1_0._txtStory = gohelper.findChildTextMesh(arg_1_0._goItem, "")
	arg_1_0._goVxEnable = gohelper.findChild(arg_1_0.viewGO, "Left/Game/vx_enough")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._clickMeshContainer:AddClickListener(arg_2_0._onMeshContainerClick, arg_2_0)
	arg_2_0._btnfinished:AddClickListener(arg_2_0.onClickFinished, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0.onBtnResetClick, arg_2_0)
	arg_2_0:addEventCb(LiangYueController.instance, LiangYueEvent.OnFinishEpisode, arg_2_0.onEpisodeFinish, arg_2_0)
	arg_2_0:addEventCb(LiangYueController.instance, LiangYueEvent.OnReceiveEpisodeInfo, arg_2_0._refreshView, arg_2_0)
	arg_2_0._illustrationDragListener:AddDragBeginListener(arg_2_0._onItemBeginDrag, arg_2_0)
	arg_2_0._illustrationDragListener:AddDragListener(arg_2_0._onItemDrag, arg_2_0)
	arg_2_0._illustrationDragListener:AddDragEndListener(arg_2_0._onItemEndDrag, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._clickMeshContainer:RemoveClickListener()
	arg_3_0._btnfinished:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0:removeEventCb(LiangYueController.instance, LiangYueEvent.OnFinishEpisode, arg_3_0.onEpisodeFinish, arg_3_0)
	arg_3_0:removeEventCb(LiangYueController.instance, LiangYueEvent.OnReceiveEpisodeInfo, arg_3_0._refreshView, arg_3_0)
	arg_3_0._illustrationDragListener:RemoveDragBeginListener()
	arg_3_0._illustrationDragListener:RemoveDragListener()
	arg_3_0._illustrationDragListener:RemoveDragEndListener()
end

function var_0_0.onClickFinished(arg_4_0)
	if arg_4_0._isDrag then
		return
	end

	local var_4_0 = arg_4_0._meshSize[1]
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0._illustrationIndexDic) do
		if not arg_4_0:_isStaticIllustration(iter_4_0) then
			local var_4_2 = (iter_4_0 - 1) % var_4_0 + 1
			local var_4_3 = math.floor((iter_4_0 - 1) / var_4_0) + 1
			local var_4_4 = string.format("%s#%s#%s", var_4_2, var_4_3, iter_4_1)

			table.insert(var_4_1, var_4_4)
		end
	end

	local var_4_5 = table.concat(var_4_1, "|")

	logNormal("Result: " .. var_4_5)
	LiangYueController.instance:finishEpisode(arg_4_0._actId, arg_4_0._episodeId, var_4_5)
end

function var_0_0.onEpisodeFinish(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._actId ~= arg_5_1 or arg_5_0._episodeId ~= arg_5_2 then
		return
	end

	local var_5_0 = LiangYueModel.instance:isEpisodeFinish(arg_5_1, arg_5_2)

	if var_5_0 then
		arg_5_0:statData(LiangYueEnum.StatGameState.Finish)
	end

	arg_5_0._animator:Play("finish", 0, 0)

	arg_5_0._isFinish = var_5_0

	arg_5_0:_lockScreen(true)
	AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wulu_aizila_forward_paper)
	TaskDispatcher.runDelay(arg_5_0.delayFinishAnim, arg_5_0, LiangYueEnum.FinishAnimDelayTime)
	TaskDispatcher.runDelay(arg_5_0.delayFinishAnimEnd, arg_5_0, LiangYueEnum.FinishAnimDelayTimeEnd)
end

function var_0_0.delayFinishAnim(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.delayFinishAnim, arg_6_0)

	for iter_6_0, iter_6_1 in pairs(arg_6_0._usedDragItemDic) do
		iter_6_1:setAttributeState(false)
	end

	arg_6_0:_refreshCompleteState()
end

function var_0_0.delayFinishAnimEnd(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.delayFinishAnimEnd, arg_7_0)
	arg_7_0:_lockScreen(false)
	arg_7_0:_refreshFinishBtnState()
	AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_pen2)
end

function var_0_0.onBtnResetClick(arg_8_0)
	if arg_8_0._isDrag then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.LiangYueResetTip, MsgBoxEnum.BoxType.Yes_No, arg_8_0.resetGame, nil, nil, arg_8_0)
end

function var_0_0.resetGame(arg_9_0)
	if next(arg_9_0._illustrationUseDic) == nil then
		return
	end

	arg_9_0:_beforeAttributeChanged()
	arg_9_0:statData(LiangYueEnum.StatGameState.Restart)

	arg_9_0._resetTime = ServerTime.now()
	arg_9_0._enterTime = ServerTime.now()

	local var_9_0 = arg_9_0._meshSize[1]

	for iter_9_0, iter_9_1 in pairs(arg_9_0._illustrationIndexDic) do
		if not arg_9_0:_isStaticIllustration(iter_9_0) then
			local var_9_1 = (iter_9_0 - 1) % var_9_0 + 1
			local var_9_2 = math.floor((iter_9_0 - 1) / var_9_0) + 1

			arg_9_0:_ClearMesh(var_9_1, var_9_2, iter_9_1)
		end
	end

	arg_9_0:_afterAttributeChanged()
end

function var_0_0._beforeAttributeChanged(arg_10_0)
	arg_10_0._tempParam = tabletool.copy(arg_10_0._paramDic)

	TaskDispatcher.cancelTask(arg_10_0._resetAttributeState, arg_10_0)
end

function var_0_0._afterAttributeChanged(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._attributeAnimList) do
		local var_11_0 = arg_11_0._tempParam[iter_11_0] or 0
		local var_11_1 = arg_11_0._paramDic[iter_11_0] or 0
		local var_11_2

		if var_11_0 < var_11_1 then
			var_11_2 = LiangYueEnum.AttributeAnim.Up
		elseif var_11_1 < var_11_0 then
			var_11_2 = LiangYueEnum.AttributeAnim.Down

			local var_11_3 = arg_11_0._targetDescItemList[iter_11_0]

			if var_11_3 == nil then
				logError("动画组件和实际lua脚本组件数量不对应")
			else
				var_11_3:setTxtColor(LiangYueEnum.AttributeDownColor)
			end
		else
			var_11_2 = LiangYueEnum.AttributeAnim.Empty
		end

		iter_11_1.enabled = true

		iter_11_1:Play(var_11_2, 0, 0)
	end

	TaskDispatcher.runDelay(arg_11_0._resetAttributeState, arg_11_0, LiangYueEnum.AttributeAnimRevertTime)

	arg_11_0._tempParam = nil
end

function var_0_0._resetAttributeState(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._resetAttributeState, arg_12_0)

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._attributeAnimList) do
		if iter_12_1.gameObject.activeSelf == true then
			local var_12_0 = arg_12_0._paramDic[iter_12_0] or 0
			local var_12_1 = arg_12_0._targetParamDic[iter_12_0] or 0
			local var_12_2 = arg_12_0._targetDescItemList[iter_12_0]
			local var_12_3 = var_12_1 <= var_12_0 and LiangYueEnum.AttributeColor[iter_12_0] or LiangYueEnum.AttributeNotEnoughColor

			iter_12_1:Play(LiangYueEnum.AttributeAnim.Empty, 0, 0)
			var_12_2:setTxtColor(var_12_3)
		end
	end
end

function var_0_0._onMeshContainerClick(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_0._isFinish or arg_13_0._isDrag then
		return nil, nil, nil
	end

	local var_13_0 = recthelper.screenPosToAnchorPos(arg_13_2, arg_13_0._gomeshContainer.transform)
	local var_13_1, var_13_2 = arg_13_0:_getMeshPosByIndex(var_13_0.x, var_13_0.y)

	if not arg_13_0._meshData[var_13_2] or not arg_13_0._meshData[var_13_2][var_13_1] then
		return nil, nil, nil
	end

	local var_13_3 = arg_13_0._meshData[var_13_2][var_13_1]

	if arg_13_0:_isStaticIllustration(var_13_3) then
		ToastController.instance:showToast(ToastEnum.Act184PuzzleCanNotMove)

		return nil, nil, nil
	end

	if not arg_13_4 then
		AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_delete)
	end

	local var_13_4 = arg_13_0._illustrationPosDic[var_13_3]
	local var_13_5 = arg_13_0._illustrationIndexDic[var_13_3]

	arg_13_0:_beforeAttributeChanged()
	arg_13_0:_ClearMesh(var_13_4[1], var_13_4[2], var_13_5)
	arg_13_0:_afterAttributeChanged()

	return var_13_5, var_13_4[1], var_13_4[2]
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._illustrationDragListener = SLFramework.UGUI.UIDragListener.Get(arg_14_0._gomeshContainer)

	gohelper.setActive(arg_14_0._godragItem, false)
	gohelper.setActive(arg_14_0._goillstrationItem, false)
	arg_14_0:_initAttributeComp()
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0._initAttributeComp(arg_16_0)
	arg_16_0._targetDescItemList = {}

	local var_16_0 = gohelper.findChild(arg_16_0.viewGO, "Left/Game/TargetIcon")

	arg_16_0._goTarget = var_16_0
	arg_16_0._attributeAnimList = {}

	local var_16_1 = arg_16_0._goTarget.transform.childCount

	for iter_16_0 = 1, var_16_1 do
		local var_16_2 = var_16_0.transform:GetChild(iter_16_0 - 1)
		local var_16_3 = LiangYueAttributeDescItem.New()

		var_16_3:init(var_16_2.gameObject)
		table.insert(arg_16_0._targetDescItemList, var_16_3)

		local var_16_4 = gohelper.findChildAnim(var_16_2.gameObject, "")

		table.insert(arg_16_0._attributeAnimList, var_16_4)
	end

	arg_16_0._animator = gohelper.findChildAnim(arg_16_0.viewGO, "")
end

function var_0_0._initGameData(arg_17_0)
	arg_17_0._actId = arg_17_0.viewParam.actId
	arg_17_0._episodeId = arg_17_0.viewParam.episodeId
	arg_17_0._episodeGameId = arg_17_0.viewParam.episodeGameId
	arg_17_0._enterTime = ServerTime.now()
	arg_17_0._resetTime = ServerTime.now()
	arg_17_0._meshItemList = {}
	arg_17_0._dyeingMeshItemList = {}
	arg_17_0._dyeingMeshItemCount = 0
	arg_17_0._meshData = {}
	arg_17_0._illustrationIndexDic = {}
	arg_17_0._illustrationIndexList = {}
	arg_17_0._illustrationCountDic = {}
	arg_17_0._illustrationUseDic = {}
	arg_17_0._illustrationScrollItemList = {}
	arg_17_0._unusedDragItemList = {}
	arg_17_0._usedDragItemDic = {}
	arg_17_0._illustrationPosDic = {}
	arg_17_0._staticIllustrationDic = {}
	arg_17_0._paramDic = {}
	arg_17_0._targetParamDic = {}
end

function var_0_0.onOpen(arg_18_0)
	arg_18_0._animator:Play("open", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wulu_aizila_forward_paper)
	arg_18_0:_initGameData()
	arg_18_0:_refreshView()
end

function var_0_0._refreshView(arg_19_0)
	local var_19_0 = LiangYueConfig.instance:getEpisodePuzzleConfigByActAndId(arg_19_0._actId, arg_19_0._episodeGameId)

	if var_19_0 == nil then
		return
	end

	arg_19_0._episodeConfig = var_19_0

	local var_19_1 = LiangYueModel.instance:isEpisodeFinish(arg_19_0._actId, arg_19_0._episodeId)

	arg_19_0._isEnable = var_19_1
	arg_19_0._isFinish = var_19_1

	if not var_19_1 then
		arg_19_0:_refreshIllustration(var_19_0)
	end

	arg_19_0:_refreshTargetParam(var_19_0)
	arg_19_0:_resetMeshContent(var_19_0)
	arg_19_0:_refreshTitle(var_19_0)
	arg_19_0:_refreshFinishBtnState()
	arg_19_0:_refreshCompleteState()
end

function var_0_0._resetMeshContent(arg_20_0, arg_20_1)
	arg_20_0._meshSize = string.splitToNumber(arg_20_1.size, "#")

	arg_20_0:_rebuildMesh()
	arg_20_0:_refreshMeshData()
end

function var_0_0._refreshTitle(arg_21_0, arg_21_1)
	arg_21_0._txtDescr.text = arg_21_1.titleTxt

	local var_21_0 = TimeUtil.stringToTimestamp(arg_21_1.date)
	local var_21_1 = TimeUtil.timestampToTable(var_21_0)

	arg_21_0._txtYear.text = var_21_1.year
	arg_21_0._txtMonth.text = string.upper(LiangYueEnum.MonthEn[var_21_1.month])
	arg_21_0._txtDay.text = var_21_1.day
	arg_21_0._txtStory.text = arg_21_1.txt
end

function var_0_0._refreshTargetParam(arg_22_0, arg_22_1)
	tabletool.clear(arg_22_0._targetParamDic)

	local var_22_0 = arg_22_1.target
	local var_22_1 = string.split(var_22_0, "|")

	if #var_22_1 <= 0 then
		logError("no target param")

		return
	end

	for iter_22_0, iter_22_1 in ipairs(var_22_1) do
		local var_22_2 = string.splitToNumber(iter_22_1, "#")

		if not arg_22_0._targetParamDic[var_22_2[1]] then
			arg_22_0._targetParamDic[var_22_2[1]] = var_22_2[2]
		end
	end

	for iter_22_2, iter_22_3 in ipairs(arg_22_0._targetDescItemList) do
		iter_22_3:setActive(arg_22_0._targetParamDic[iter_22_2] ~= nil)
	end

	arg_22_0:_updateAttributeInfo()
end

function var_0_0._refreshIllustration(arg_23_0, arg_23_1)
	arg_23_0:_refreshIllustrationData(arg_23_1)
	arg_23_0:_refreshIllustrationContent()
end

function var_0_0._refreshIllustrationData(arg_24_0, arg_24_1)
	tabletool.clear(arg_24_0._illustrationCountDic)
	tabletool.clear(arg_24_0._illustrationUseDic)

	local var_24_0 = arg_24_1.illustrationCount

	if string.nilorempty(var_24_0) then
		logError("episode puzzle count data is nil")

		return
	end

	local var_24_1 = string.split(var_24_0, "|")

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		local var_24_2 = string.splitToNumber(iter_24_1, "#")

		arg_24_0._illustrationCountDic[var_24_2[1]] = var_24_2[2]
	end
end

function var_0_0._refreshIllustrationContent(arg_25_0)
	local var_25_0 = 0
	local var_25_1 = #arg_25_0._illustrationScrollItemList

	for iter_25_0, iter_25_1 in pairs(arg_25_0._illustrationCountDic) do
		var_25_0 = var_25_0 + 1

		local var_25_2

		if var_25_1 < var_25_0 then
			var_25_2 = arg_25_0:_createIllustrationItem(iter_25_0, var_25_0)
		else
			var_25_2 = arg_25_0._illustrationScrollItemList[var_25_0]
		end

		local var_25_3 = LiangYueConfig.instance:getIllustrationConfigById(arg_25_0._actId, iter_25_0)
		local var_25_4 = LiangYueConfig.instance:getIllustrationShape(arg_25_0._actId, iter_25_0)
		local var_25_5 = #var_25_4 / #var_25_4[1]

		if var_25_2 == nil then
			logError("have no item index :" .. var_25_0)
		else
			var_25_2:setActive(true)
			var_25_2:setInfo(iter_25_0, var_25_0, iter_25_1, var_25_3.imageId, var_25_5, arg_25_0._actId)
		end
	end

	if var_25_0 < var_25_1 then
		for iter_25_2 = var_25_0 + 1, var_25_1 do
			arg_25_0._illustrationScrollItemList[iter_25_2]:setActive(false)
		end
	end
end

function var_0_0._refreshMeshData(arg_26_0)
	arg_26_0._meshData = {}

	local var_26_0 = LiangYueConfig.instance:getEpisodeStaticIllustrationDic(arg_26_0._actId, arg_26_0._episodeGameId)

	if var_26_0 ~= nil then
		for iter_26_0, iter_26_1 in pairs(var_26_0) do
			for iter_26_2, iter_26_3 in pairs(iter_26_1) do
				if arg_26_0._meshData[iter_26_0] and arg_26_0._meshData[iter_26_0][iter_26_2] then
					logError("固定格子位置重复 位置: x:" .. iter_26_0 .. "y:" .. iter_26_2)
				else
					arg_26_0:_fillMesh(iter_26_0, iter_26_2, iter_26_3, true)
				end
			end
		end
	end

	local var_26_1 = LiangYueModel.instance:getEpisodeInfoMo(arg_26_0._actId, arg_26_0._episodeId)

	if string.nilorempty(var_26_1.puzzle) then
		return
	end

	local var_26_2 = string.split(var_26_1.puzzle, "|")

	for iter_26_4, iter_26_5 in ipairs(var_26_2) do
		local var_26_3 = string.splitToNumber(iter_26_5, "#")

		if var_26_3 ~= nil then
			arg_26_0:_fillMesh(var_26_3[1], var_26_3[2], var_26_3[3])
		else
			logError("玩家插画数据错误： 数据格式：" .. var_26_1.puzzle)
		end
	end
end

function var_0_0._refreshCompleteState(arg_27_0)
	local var_27_0 = LiangYueConfig.instance:getEpisodePuzzleConfigByActAndId(arg_27_0._actId, arg_27_0._episodeGameId)
	local var_27_1 = arg_27_0._isFinish

	gohelper.setActive(arg_27_0._goPiecesList, not var_27_1)
	gohelper.setActive(arg_27_0._goScrollText, var_27_1)
	gohelper.setActive(arg_27_0._goCompleted, var_27_1)
	gohelper.setActive(arg_27_0._btnreset, not var_27_1)
	gohelper.setActive(arg_27_0._goGridBg.gameObject, not var_27_1)

	local var_27_2 = arg_27_0._isFinish and luaLang("act184_target_complete") or luaLang("act184_target_not_complete")

	arg_27_0._txtTarget.text = var_27_2

	local var_27_3 = arg_27_0._isFinish and var_27_0.titile or luaLang("act184_puzzle_title")

	arg_27_0._txtTitle.text = var_27_3
end

function var_0_0._refreshFinishBtnState(arg_28_0)
	local var_28_0 = arg_28_0._isEnable and not arg_28_0._isFinish

	gohelper.setActive(arg_28_0._btnfinished, var_28_0)
	gohelper.setActive(arg_28_0._goVxEnable, var_28_0)
	gohelper.setActive(arg_28_0._goTick, arg_28_0._isFinish)

	if var_28_0 then
		AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_pen1)
	end
end

function var_0_0._fillMesh(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	local var_29_0 = arg_29_0._meshData
	local var_29_1 = 0
	local var_29_2 = 0
	local var_29_3 = false
	local var_29_4 = LiangYueConfig.instance:getIllustrationShape(arg_29_0._actId, arg_29_3)
	local var_29_5 = #var_29_4
	local var_29_6 = #var_29_4[1]
	local var_29_7 = (arg_29_2 - 1) * arg_29_0._meshSize[1] + arg_29_1

	for iter_29_0 = 1, var_29_5 do
		local var_29_8 = var_29_4[iter_29_0]

		for iter_29_1 = 1, var_29_6 do
			local var_29_9 = var_29_8[iter_29_1] == 1

			if not var_29_3 and var_29_9 then
				var_29_1 = iter_29_1 - 1
				var_29_2 = iter_29_0 - 1
				var_29_3 = true
			end

			if var_29_3 and var_29_9 then
				local var_29_10 = arg_29_2 - var_29_2 + iter_29_0 - 1
				local var_29_11 = arg_29_1 - var_29_1 + iter_29_1 - 1

				if not var_29_0[var_29_10] then
					var_29_0[var_29_10] = {}
				end

				if var_29_0[var_29_10][var_29_11] then
					logError("meshFill failed posX: " .. var_29_11 .. " Y " .. var_29_10)
				else
					var_29_0[var_29_10][var_29_11] = var_29_7
				end
			end
		end
	end

	local var_29_12 = arg_29_1 - var_29_1
	local var_29_13 = ((var_29_12 - 1) * arg_29_0._meshWidth + (var_29_12 - 1 + var_29_6) * arg_29_0._meshWidth) * 0.5 - arg_29_0._meshMaxX
	local var_29_14 = arg_29_2 - var_29_2
	local var_29_15 = arg_29_0._meshSize[2] - var_29_14 + 1
	local var_29_16 = (var_29_15 * arg_29_0._meshHeight + (var_29_15 - var_29_5) * arg_29_0._meshHeight) * 0.5 - arg_29_0._meshMaxY

	arg_29_5 = arg_29_5 or arg_29_0:_getDragItem(arg_29_3, arg_29_4, arg_29_0._isFinish)
	arg_29_0._illustrationIndexDic[var_29_7] = arg_29_3

	table.insert(arg_29_0._illustrationIndexList, var_29_7)

	arg_29_0._illustrationPosDic[var_29_7] = {
		arg_29_1,
		arg_29_2
	}
	arg_29_0._usedDragItemDic[var_29_7] = arg_29_5

	if arg_29_4 then
		arg_29_0._staticIllustrationDic[var_29_7] = arg_29_3
	elseif not arg_29_0._illustrationUseDic[arg_29_3] then
		arg_29_0._illustrationUseDic[arg_29_3] = 1
	else
		arg_29_0._illustrationUseDic[arg_29_3] = arg_29_0._illustrationUseDic[arg_29_3] + 1
	end

	arg_29_0:_refreshIllustrationIndex()
	arg_29_0:_refreshIllustrationCount()

	if arg_29_4 or arg_29_0._isFinish == true then
		recthelper.setAnchor(arg_29_5.go.transform, var_29_13, var_29_16)
	else
		arg_29_0._tweenItem = arg_29_5

		arg_29_5:setAttributeInfo(arg_29_0._actId, arg_29_5.id)

		arg_29_0._tweenPos = ZProj.TweenHelper.DOAnchorPos(arg_29_5.go.transform, var_29_13, var_29_16, LiangYueEnum.TweenDuration, arg_29_0._onTweenEnd, arg_29_0)
	end

	logNormal(string.format("fill illustration: pos x:%s y:%s index : x: %s y: %s", var_29_13, var_29_16, arg_29_1, arg_29_2))
end

function var_0_0._onTweenEnd(arg_30_0)
	local var_30_0 = arg_30_0._tweenItem

	if var_30_0 ~= nil then
		var_30_0:setItemPosY()
	end

	arg_30_0._tweenItem = nil
	arg_30_0._tweenPos = nil
end

function var_0_0._ClearMesh(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_0._meshData
	local var_31_1 = 0
	local var_31_2 = 0
	local var_31_3 = false
	local var_31_4 = LiangYueConfig.instance:getIllustrationShape(arg_31_0._actId, arg_31_3)
	local var_31_5 = #var_31_4
	local var_31_6 = #var_31_4[1]

	for iter_31_0 = 1, var_31_5 do
		local var_31_7 = var_31_4[iter_31_0]

		for iter_31_1 = 1, var_31_6 do
			local var_31_8 = var_31_7[iter_31_1] == 1

			if not var_31_3 and var_31_8 then
				var_31_1 = iter_31_1 - 1
				var_31_2 = iter_31_0 - 1
				var_31_3 = true
			end

			if var_31_3 and var_31_8 then
				local var_31_9 = arg_31_2 - var_31_2 + iter_31_0 - 1
				local var_31_10 = arg_31_1 - var_31_1 + iter_31_1 - 1

				if not var_31_0[var_31_9] or not var_31_0[var_31_9][var_31_10] then
					logError("clear mesh failed posX: " .. var_31_10 .. " Y " .. var_31_9)
				else
					var_31_0[var_31_9][var_31_10] = nil

					local var_31_11 = (var_31_9 - 1) * arg_31_0._meshSize[1] + var_31_10
				end
			end
		end
	end

	local var_31_12 = (arg_31_2 - 1) * arg_31_0._meshSize[1] + arg_31_1

	arg_31_0._illustrationIndexDic[var_31_12] = nil

	tabletool.removeValue(arg_31_0._illustrationIndexList, var_31_12)

	local var_31_13 = arg_31_0._usedDragItemDic[var_31_12]

	arg_31_0._usedDragItemDic[var_31_12] = nil
	arg_31_0._illustrationPosDic[var_31_12] = nil

	if not arg_31_0._illustrationUseDic[arg_31_3] then
		logError("not such illustration use")
	else
		local var_31_14 = arg_31_0._illustrationUseDic[arg_31_3] - 1

		if var_31_14 <= 0 then
			arg_31_0._illustrationUseDic[arg_31_3] = nil
		else
			arg_31_0._illustrationUseDic[arg_31_3] = var_31_14
		end
	end

	arg_31_0:_recycleDragItem(var_31_13)
	arg_31_0:_refreshIllustrationIndex()
	arg_31_0:_refreshIllustrationCount()
end

function var_0_0._refreshIllustrationCount(arg_32_0)
	for iter_32_0, iter_32_1 in pairs(arg_32_0._illustrationScrollItemList) do
		if arg_32_0._illustrationCountDic[iter_32_1.id] and arg_32_0._illustrationCountDic[iter_32_1.id] ~= 0 then
			local var_32_0 = arg_32_0._illustrationUseDic[iter_32_1.id] or 0
			local var_32_1 = arg_32_0._illustrationCountDic[iter_32_1.id] - var_32_0

			iter_32_1:setCount(var_32_1)
			iter_32_1:setEnoughState(var_32_1 > 0)
		end
	end
end

function var_0_0._getMeshPosByIndex(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = 1
	local var_33_1 = arg_33_0._meshSize[1]
	local var_33_2 = arg_33_0._meshSize[2]
	local var_33_3 = Mathf.Clamp(math.floor((arg_33_1 + arg_33_0._meshMaxX) / arg_33_0._meshWidth) + 1, var_33_0, var_33_1)
	local var_33_4 = Mathf.Clamp(var_33_2 - math.floor((arg_33_2 + arg_33_0._meshMaxY) / arg_33_0._meshHeight), var_33_0, var_33_2)

	logNormal("button click mesh x:" .. var_33_3 .. "mesh y:" .. var_33_4)

	return var_33_3, var_33_4
end

function var_0_0._refreshIllustrationIndex(arg_34_0)
	table.sort(arg_34_0._illustrationIndexList)
	tabletool.clear(arg_34_0._paramDic)

	local var_34_0 = 0

	for iter_34_0, iter_34_1 in ipairs(arg_34_0._illustrationIndexList) do
		local var_34_1 = arg_34_0._usedDragItemDic[iter_34_1]

		if var_34_1 == nil then
			logError("item is null index:" .. iter_34_1)
		else
			var_34_1:setIndex(iter_34_0)

			local var_34_2 = arg_34_0._illustrationIndexDic[iter_34_1]
			local var_34_3 = LiangYueConfig.instance:getIllustrationConfigById(arg_34_0._actId, var_34_2).attribute

			arg_34_0:_calculateAttribute(var_34_3, arg_34_0._paramDic)

			if not arg_34_0._staticIllustrationDic[iter_34_0] then
				var_34_0 = var_34_0 + 1
			end
		end
	end

	if not arg_34_0._isFinish then
		LiangYueController.instance:dispatchEvent(LiangYueEvent.OnDragIllustration, var_34_0)
		logNormal("OnDragIllustration Count: " .. tostring(var_34_0))
	end

	arg_34_0:_updateAttributeInfo()
end

function var_0_0._updateAttributeInfo(arg_35_0)
	local var_35_0 = arg_35_0._paramDic
	local var_35_1 = 0

	for iter_35_0, iter_35_1 in pairs(arg_35_0._targetParamDic) do
		local var_35_2 = var_35_0[iter_35_0] or 0
		local var_35_3 = iter_35_1 <= var_35_2

		if not var_35_3 then
			var_35_1 = var_35_1 + 1
		end

		local var_35_4 = arg_35_0._targetDescItemList[iter_35_0]
		local var_35_5 = var_35_3 and LiangYueEnum.AttributeColor[iter_35_0] or LiangYueEnum.AttributeNotEnoughColor

		var_35_4:setTargetInfo(var_35_2, iter_35_1, var_35_5)
	end

	arg_35_0._isEnable = var_35_1 <= 0

	if not arg_35_0._isFinish and arg_35_0._isEnable then
		LiangYueController.instance:dispatchEvent(LiangYueEvent.OnAttributeMeetConditions, arg_35_0._episodeId)
		logNormal("OnAttributeMeetConditions  episodeId:" .. tostring(arg_35_0._episodeId))
	end

	arg_35_0:_refreshFinishBtnState()
end

function var_0_0._calculateAttribute(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = string.split(arg_36_1, "|")

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		local var_36_1 = string.splitToNumber(iter_36_1, "#")
		local var_36_2 = var_36_1[1]
		local var_36_3 = var_36_1[2]
		local var_36_4 = var_36_1[3]

		if arg_36_2[var_36_2] == nil then
			arg_36_2[var_36_2] = 0
		end

		local var_36_5 = arg_36_2[var_36_2]

		if var_36_3 == LiangYueEnum.CalculateType.Add then
			var_36_5 = var_36_5 + var_36_4
		elseif var_36_3 == LiangYueEnum.CalculateType.Minus then
			var_36_5 = var_36_5 - var_36_4
		elseif var_36_3 == LiangYueEnum.CalculateType.Multiply then
			var_36_5 = var_36_5 * var_36_4
		elseif var_36_3 == LiangYueEnum.CalculateType.Divide then
			var_36_5 = var_36_5 / var_36_4
		end

		arg_36_2[var_36_2] = math.floor(var_36_5)
	end
end

function var_0_0._onItemBeginDrag(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if arg_37_0._isFinish then
		return
	end

	local var_37_0
	local var_37_1 = recthelper.screenPosToAnchorPos(arg_37_2.position, arg_37_0._goillustrationContainer.transform)
	local var_37_2
	local var_37_3
	local var_37_4 = arg_37_3 == nil

	if var_37_4 then
		local var_37_5, var_37_6

		arg_37_3, var_37_5, var_37_6 = arg_37_0:_onMeshContainerClick(arg_37_1, arg_37_2.position, nil, true)

		if arg_37_3 == nil then
			return
		end

		arg_37_0._previousPosX = var_37_5
		arg_37_0._previousPosY = var_37_6
	end

	if arg_37_0:_CheckDragItemCount(arg_37_3) then
		GameFacade.showToast(ToastEnum.Act184PuzzleNotEnough)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_anzhu)

	local var_37_7 = var_37_4 and LiangYueEnum.NormalAlpha or LiangYueEnum.DragAlpha

	arg_37_0:_setScrollItemAlpha(arg_37_3, var_37_7)

	local var_37_8 = arg_37_0:_getDragItem(arg_37_3)

	logNormal("Start Drag")
	gohelper.setAsLastSibling(var_37_8.go)

	arg_37_0._currentDragItem = var_37_8
	arg_37_0._isDrag = true
	arg_37_0._dragShapeId = arg_37_3

	recthelper.setAnchor(var_37_8.rectTran, var_37_1.x, var_37_1.y)

	arg_37_0._previousDragPos = var_37_1

	arg_37_0:_onSelectShape(arg_37_3)
	arg_37_0:_resetMeshItemEnableState()
end

function var_0_0._onSelectShape(arg_38_0, arg_38_1)
	local var_38_0 = LiangYueConfig.instance:getIllustrationShape(arg_38_0._actId, arg_38_1)
	local var_38_1 = #var_38_0
	local var_38_2 = #var_38_0[1]
	local var_38_3 = var_38_1 * arg_38_0._meshHeight
	local var_38_4 = var_38_2 * arg_38_0._meshWidth

	arg_38_0._dragItemMaxX = var_38_4 * 0.5
	arg_38_0._dragItemMinX = -arg_38_0._dragItemMaxX
	arg_38_0._dragItemMaxY = var_38_3 * 0.5
	arg_38_0._dragItemMinY = -arg_38_0._dragItemMaxY
	arg_38_0._dragItemHeight = var_38_3
	arg_38_0._dragItemWidth = var_38_4
	arg_38_0._currentDragCheckList = var_38_0
	arg_38_0._dragItemSize = {
		var_38_2,
		var_38_1
	}
	arg_38_0._needCheckMeshCount = LiangYueConfig.instance:getIllustrationShapeCount(arg_38_0._actId, arg_38_1)
end

function var_0_0._setScrollItemAlpha(arg_39_0, arg_39_1, arg_39_2)
	for iter_39_0, iter_39_1 in ipairs(arg_39_0._illustrationScrollItemList) do
		if iter_39_1.id == arg_39_1 then
			iter_39_1:setAlpha(arg_39_2)

			return
		end
	end
end

function var_0_0._CheckDragItemCount(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0._illustrationCountDic[arg_40_1]

	if not var_40_0 or var_40_0 == 0 then
		return false
	end

	return var_40_0 <= (arg_40_0._illustrationUseDic[arg_40_1] or 0)
end

function var_0_0._updateItemPos(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0._currentDragItem.rectTran
	local var_41_1 = recthelper.screenPosToAnchorPos(arg_41_1.position, arg_41_0._gomeshContainer.transform)
	local var_41_2 = var_41_1.x - arg_41_0._previousDragPos.x
	local var_41_3 = var_41_1.y - arg_41_0._previousDragPos.y
	local var_41_4, var_41_5 = recthelper.getAnchor(var_41_0)
	local var_41_6 = var_41_4 + var_41_2
	local var_41_7 = var_41_5 + var_41_3

	recthelper.setAnchor(var_41_0, var_41_6, var_41_7)

	arg_41_0._previousDragPos = var_41_1

	return var_41_6, var_41_7
end

function var_0_0._onItemDrag(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_0._currentDragItem == nil then
		return
	end

	arg_42_0:_resetMeshItemEnableState()
	arg_42_0:_onItemMove(arg_42_2)
end

function var_0_0._onItemMove(arg_43_0, arg_43_1)
	local var_43_0, var_43_1 = arg_43_0:_updateItemPos(arg_43_1)
	local var_43_2 = arg_43_0._dragItemMinX + var_43_0
	local var_43_3 = arg_43_0._dragItemMaxX + var_43_0
	local var_43_4 = arg_43_0._dragItemMinY + var_43_1
	local var_43_5 = arg_43_0._dragItemMaxY + var_43_1
	local var_43_6 = arg_43_0._meshWidth * 0.5
	local var_43_7 = arg_43_0._meshHeight * 0.5
	local var_43_8 = arg_43_0._meshMaxX
	local var_43_9 = arg_43_0._meshMaxY

	if var_43_3 < -var_43_8 + var_43_6 or var_43_2 > var_43_8 - var_43_6 or var_43_5 < -var_43_9 + var_43_7 or var_43_4 > var_43_9 - var_43_7 then
		return false, nil, nil
	end

	local var_43_10 = math.max(var_43_2, -var_43_8) - var_43_0 + arg_43_0._dragItemMaxX
	local var_43_11 = math.min(var_43_3, var_43_8) - var_43_0 + arg_43_0._dragItemMaxX
	local var_43_12 = math.max(var_43_4, -var_43_9) - var_43_1 + arg_43_0._dragItemMaxY
	local var_43_13 = math.min(var_43_5, var_43_9) - var_43_1 + arg_43_0._dragItemMaxY
	local var_43_14 = 1
	local var_43_15 = arg_43_0._dragItemSize[1]
	local var_43_16 = arg_43_0._dragItemSize[2]
	local var_43_17, var_43_18, var_43_19, var_43_20 = arg_43_0:_calculateOverlapMeshBoundary(var_43_10, var_43_11, var_43_12, var_43_13, arg_43_0._meshWidth, arg_43_0._meshHeight, var_43_15, var_43_16)
	local var_43_21 = arg_43_0._meshSize[1]
	local var_43_22 = arg_43_0._meshSize[2]
	local var_43_23 = 0
	local var_43_24 = 0
	local var_43_25
	local var_43_26
	local var_43_27 = false

	for iter_43_0 = var_43_19, var_43_20 do
		for iter_43_1 = var_43_17, var_43_18 do
			if arg_43_0._currentDragCheckList[iter_43_0] and arg_43_0._currentDragCheckList[iter_43_0][iter_43_1] == 1 then
				local var_43_28 = (iter_43_1 - 1) * arg_43_0._meshWidth + arg_43_0._dragItemMinX + var_43_6 + var_43_0 + arg_43_0._meshMaxX
				local var_43_29 = (var_43_16 - iter_43_0 + 1) * arg_43_0._meshHeight + arg_43_0._dragItemMinY + var_43_1 + arg_43_0._meshMaxY
				local var_43_30 = math.floor(var_43_28 / arg_43_0._meshWidth) + 1
				local var_43_31 = Mathf.Clamp(var_43_30, var_43_14, var_43_21)
				local var_43_32 = math.floor(var_43_29 / arg_43_0._meshWidth + 0.5)
				local var_43_33 = var_43_22 - Mathf.Clamp(var_43_32, var_43_14, var_43_22) + 1
				local var_43_34 = var_43_21 * (var_43_33 - 1) + var_43_31
				local var_43_35 = arg_43_0._meshItemList[var_43_34]

				if var_43_35 then
					if not var_43_27 then
						var_43_25 = var_43_31
						var_43_26 = var_43_33
						var_43_27 = true
					end

					local var_43_36 = arg_43_0._meshData[var_43_33] and arg_43_0._meshData[var_43_33][var_43_31] ~= nil

					table.insert(arg_43_0._dyeingMeshItemList, var_43_35)

					var_43_23 = var_43_23 + 1

					if not var_43_36 then
						var_43_24 = var_43_24 + 1
					end
				end
			end
		end
	end

	local var_43_37 = var_43_24 >= arg_43_0._needCheckMeshCount
	local var_43_38 = var_43_37 and LiangYueEnum.MeshItemColor.Enable or LiangYueEnum.MeshItemColor.Disable

	if var_43_23 > 0 then
		for iter_43_2, iter_43_3 in ipairs(arg_43_0._dyeingMeshItemList) do
			iter_43_3:setActive(true)
			iter_43_3:setBgColor(var_43_38)
		end
	end

	arg_43_0._dyeingMeshItemCount = var_43_23

	if not var_43_37 then
		return true, nil, nil
	end

	return true, var_43_25, var_43_26
end

function var_0_0._calculateOverlapMeshBoundary(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5, arg_44_6, arg_44_7, arg_44_8)
	local var_44_0 = 1
	local var_44_1 = arg_44_1 / arg_44_5
	local var_44_2 = arg_44_2 / arg_44_5
	local var_44_3 = arg_44_3 / arg_44_6
	local var_44_4 = arg_44_4 / arg_44_6
	local var_44_5 = Mathf.Clamp(math.floor(var_44_1 + 0.5) + 1, var_44_0, arg_44_7)
	local var_44_6 = Mathf.Clamp(math.floor(var_44_2 + 0.5), var_44_0, arg_44_7)
	local var_44_7 = arg_44_8 - Mathf.Clamp(math.floor(var_44_4 + 0.5), var_44_0, arg_44_8) + 1
	local var_44_8 = arg_44_8 - Mathf.Clamp(math.floor(var_44_3 + 0.5) + 1, var_44_0, arg_44_8) + 1

	return var_44_5, var_44_6, var_44_7, var_44_8
end

function var_0_0._resetMeshItemEnableState(arg_45_0)
	if arg_45_0._dyeingMeshItemCount > 0 then
		for iter_45_0, iter_45_1 in ipairs(arg_45_0._dyeingMeshItemList) do
			iter_45_1:setActive(false)
		end

		tabletool.clear(arg_45_0._dyeingMeshItemList)

		arg_45_0._dyeingMeshItemCount = 0
	end
end

function var_0_0._onItemEndDrag(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_0._currentDragItem == nil then
		return
	end

	logNormal("End Drag")

	arg_46_0._isDrag = false

	local var_46_0, var_46_1, var_46_2 = arg_46_0:_onItemMove(arg_46_2)

	var_46_1 = var_46_1 or arg_46_0._previousPosX
	var_46_2 = var_46_2 or arg_46_0._previousPosY

	arg_46_0:_setScrollItemAlpha(arg_46_0._dragShapeId, LiangYueEnum.NormalAlpha)
	arg_46_0:_beforeAttributeChanged()

	if var_46_0 and var_46_1 and var_46_2 then
		logNormal("放置插画")
		arg_46_0:_fillMesh(var_46_1, var_46_2, arg_46_0._dragShapeId, false, arg_46_0._currentDragItem)
		AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_fangru)
	else
		logNormal("回收插画")
		arg_46_0:_recycleDragItem(arg_46_0._currentDragItem)
	end

	arg_46_0:_afterAttributeChanged()

	arg_46_0._dragShapeId = nil
	arg_46_0._previousPosX = nil
	arg_46_0._previousPosX = nil
	arg_46_0._currentDragItem = nil

	arg_46_0:_resetMeshItemEnableState()
end

function var_0_0._rebuildMesh(arg_47_0)
	local var_47_0 = recthelper.getWidth(arg_47_0._goImageBg.transform)
	local var_47_1 = recthelper.getHeight(arg_47_0._goImageBg.transform)
	local var_47_2 = arg_47_0._meshSize[1]
	local var_47_3 = arg_47_0._meshSize[2]

	arg_47_0._meshWidth = var_47_0 / var_47_2
	arg_47_0._meshHeight = var_47_1 / var_47_3

	local var_47_4 = arg_47_0._meshWidth * var_47_2
	local var_47_5 = arg_47_0._meshHeight * var_47_3
	local var_47_6 = (var_47_4 + arg_47_0._meshWidth) * 0.5
	local var_47_7 = (var_47_5 + arg_47_0._meshHeight) * 0.5

	recthelper.setSize(arg_47_0._gomeshContainer.transform, var_47_4, var_47_5)
	recthelper.setSize(arg_47_0._goillustrationContainer.transform, var_47_4, var_47_5)
	recthelper.setAnchor(arg_47_0._gomeshContainer.transform, 0, 0)
	recthelper.setAnchor(arg_47_0._goillustrationContainer.transform, 0, 0)

	arg_47_0._meshMaxX = var_47_4 * 0.5
	arg_47_0._meshMinX = -arg_47_0._meshMaxX
	arg_47_0._meshMaxY = var_47_5 * 0.5
	arg_47_0._meshMinY = -arg_47_0._meshMaxY

	local var_47_8 = var_47_2 * var_47_3
	local var_47_9 = #arg_47_0._meshItemList

	for iter_47_0 = 1, var_47_3 do
		for iter_47_1 = 1, var_47_2 do
			local var_47_10 = (iter_47_0 - 1) * var_47_2 + iter_47_1
			local var_47_11

			if var_47_9 < var_47_10 then
				var_47_11 = arg_47_0:_createMeshItem(var_47_10)
			else
				var_47_11 = arg_47_0._meshItemList[var_47_10]
			end

			local var_47_12 = iter_47_1 * arg_47_0._meshWidth - var_47_6
			local var_47_13 = var_47_5 - (iter_47_0 - 1) * arg_47_0._meshHeight - var_47_7

			var_47_11:setPos(var_47_12, var_47_13)
			var_47_11:setActive(false)
		end
	end

	if var_47_8 < var_47_9 then
		for iter_47_2 = var_47_8 + 1, var_47_9 do
			arg_47_0._meshItemList[iter_47_2]:setActive(false)
		end
	end
end

function var_0_0._createIllustrationItem(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = string.format("item_%s_%s", arg_48_1, arg_48_2)
	local var_48_1 = gohelper.clone(arg_48_0._goillstrationItem, arg_48_0._goContent, var_48_0)
	local var_48_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_48_1, LiangYueScrollItem)

	var_48_2:setParentView(arg_48_0)
	table.insert(arg_48_0._illustrationScrollItemList, var_48_2)

	return var_48_2
end

function var_0_0._createMeshItem(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0:getResInst(arg_49_0.viewContainer._viewSetting.otherRes[1], arg_49_0._gomeshContainer, "meshItem" .. arg_49_1)

	recthelper.setSize(var_49_0.transform, arg_49_0._meshHeight, arg_49_0._meshHeight)

	local var_49_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_49_0, LiangYueMeshItem)

	table.insert(arg_49_0._meshItemList, var_49_1)

	return var_49_1
end

function var_0_0._getDragItem(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	local var_50_0
	local var_50_1 = #arg_50_0._unusedDragItemList

	if var_50_1 <= 0 then
		local var_50_2 = gohelper.clone(arg_50_0._godragItem, arg_50_0._goillustrationContainer)

		var_50_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_50_2, LiangYueDragItem)
	else
		var_50_0 = arg_50_0._unusedDragItemList[var_50_1]
		arg_50_0._unusedDragItemList[var_50_1] = nil
	end

	local var_50_3 = LiangYueConfig.instance:getIllustrationConfigById(arg_50_0._actId, arg_50_1)

	var_50_0:setActive(true)
	var_50_0:setInfo(arg_50_1, var_50_3, arg_50_2, arg_50_3)

	return var_50_0
end

function var_0_0._recycleDragItem(arg_51_0, arg_51_1)
	if arg_51_1 ~= nil then
		arg_51_1:setActive(false)
		table.insert(arg_51_0._unusedDragItemList, arg_51_1)
	end
end

function var_0_0._isStaticIllustration(arg_52_0, arg_52_1)
	if arg_52_0._staticIllustrationDic[arg_52_1] then
		return true
	end

	return false
end

function var_0_0.statData(arg_53_0, arg_53_1)
	local var_53_0 = {}

	for iter_53_0, iter_53_1 in pairs(arg_53_0._illustrationIndexList) do
		local var_53_1 = arg_53_0._illustrationIndexDic[iter_53_1]

		if not arg_53_0:_isStaticIllustration(iter_53_1) then
			table.insert(var_53_0, var_53_1)
		end
	end

	local var_53_2

	if arg_53_1 == LiangYueEnum.StatGameState.Restart then
		var_53_2 = arg_53_0._resetTime
	else
		var_53_2 = arg_53_0._enterTime
	end

	LiangYueController.instance:statExitData(var_53_2, arg_53_0._episodeGameId, arg_53_1, var_53_0)
end

function var_0_0._lockScreen(arg_54_0, arg_54_1)
	if arg_54_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("LiangYueGameLock")
	else
		UIBlockMgr.instance:endBlock("LiangYueGameLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.onClose(arg_55_0)
	LiangYueModel.instance:setCurActId(nil)
	LiangYueModel.instance:setCurEpisodeId(nil)
	TaskDispatcher.cancelTask(arg_55_0.delayFinishAnim, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0.delayFinishAnimEnd, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._resetAttributeState, arg_55_0)

	if arg_55_0._tweenPos then
		ZProj.TweenHelper.KillById(arg_55_0._tweenPos)

		arg_55_0._tweenPos = nil
	end
end

function var_0_0.onDestroyView(arg_56_0)
	return
end

return var_0_0

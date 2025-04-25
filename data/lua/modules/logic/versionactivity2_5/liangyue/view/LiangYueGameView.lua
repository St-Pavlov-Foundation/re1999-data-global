module("modules.logic.versionactivity2_5.liangyue.view.LiangYueGameView", package.seeall)

slot0 = class("LiangYueGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_PanelBG")
	slot0._simagePanelPaper = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_PanelPaper")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Left/Top/#txt_Descr")
	slot0._txtTarget = gohelper.findChildText(slot0.viewGO, "Left/Game/Target/#txt_Target")
	slot0._goTick = gohelper.findChild(slot0.viewGO, "Left/Game/Target/#go_Tick")
	slot0._goGridBg = gohelper.findChild(slot0.viewGO, "Left/Game/Grid/image_Grid")
	slot0._gomeshContainer = gohelper.findChild(slot0.viewGO, "Left/Game/Grid/#go_Grid/#go_meshContainer")
	slot0._txtattribute = gohelper.findChildText(slot0.viewGO, "Left/Game/Grid/#go_Grid/#go_meshContainer/image/#txt_attribute")
	slot0._goillustrationContainer = gohelper.findChild(slot0.viewGO, "Left/Game/Grid/#go_Grid/#go_illustrationContainer")
	slot0._godragItem = gohelper.findChild(slot0.viewGO, "Left/Game/Grid/#go_Grid/#go_illustrationContainer/#go_dragItem")
	slot0._goPiecesList = gohelper.findChild(slot0.viewGO, "Right/#go_PiecesList")
	slot0._scrollPieces = gohelper.findChildScrollRect(slot0.viewGO, "Right/#go_PiecesList/#scroll_Pieces")
	slot0._goillstrationItem = gohelper.findChild(slot0.viewGO, "Right/#go_PiecesList/#scroll_Pieces/Viewport/Content/#go_illstrationItem")
	slot0._imagePiece = gohelper.findChildImage(slot0.viewGO, "Right/#go_PiecesList/#scroll_Pieces/Viewport/Content/#go_illstrationItem/#image_Piece")
	slot0._goLine = gohelper.findChild(slot0.viewGO, "Right/#go_PiecesList/#scroll_Pieces/Viewport/Content/#go_illstrationItem/#go_Line")
	slot0._scrollText = gohelper.findChildScrollRect(slot0.viewGO, "Right/#scroll_Text")
	slot0._goItem = gohelper.findChild(slot0.viewGO, "Right/#scroll_Text/Viewport/Content/#go_Item")
	slot0._goCompleted = gohelper.findChild(slot0.viewGO, "Right/#go_Completed")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")
	slot0._btnfinished = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Finished")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Reset")
	slot0._txtTitle = gohelper.findChildTextMesh(slot0.viewGO, "Right/#txt_Title")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "Right/#go_PiecesList/#scroll_Pieces/Viewport/Content")
	slot0._goScrollIllustration = gohelper.findChild(slot0.viewGO, "Right/#go_PiecesList/#scroll_Pieces")
	slot0._goScrollText = gohelper.findChild(slot0.viewGO, "Right/#scroll_Text")
	slot0._goImageBg = gohelper.findChild(slot0.viewGO, "Left/Game/Grid/image_Grid")
	slot0._clickMeshContainer = gohelper.findChildClick(slot0.viewGO, "Left/Game/Grid/#go_Grid/#go_meshContainer")
	slot0._txtYear = gohelper.findChildText(slot0.viewGO, "Left/Top/txt_1999")
	slot0._txtMonth = gohelper.findChildText(slot0.viewGO, "Left/Top/txt_Month")
	slot0._txtDay = gohelper.findChildText(slot0.viewGO, "Left/Top/txt_Day")
	slot0._txtStory = gohelper.findChildTextMesh(slot0._goItem, "")
	slot0._goVxEnable = gohelper.findChild(slot0.viewGO, "Left/Game/vx_enough")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._clickMeshContainer:AddClickListener(slot0._onMeshContainerClick, slot0)
	slot0._btnfinished:AddClickListener(slot0.onClickFinished, slot0)
	slot0._btnreset:AddClickListener(slot0.onBtnResetClick, slot0)
	slot0:addEventCb(LiangYueController.instance, LiangYueEvent.OnFinishEpisode, slot0.onEpisodeFinish, slot0)
	slot0:addEventCb(LiangYueController.instance, LiangYueEvent.OnReceiveEpisodeInfo, slot0._refreshView, slot0)
	slot0._illustrationDragListener:AddDragBeginListener(slot0._onItemBeginDrag, slot0)
	slot0._illustrationDragListener:AddDragListener(slot0._onItemDrag, slot0)
	slot0._illustrationDragListener:AddDragEndListener(slot0._onItemEndDrag, slot0)
end

function slot0.removeEvents(slot0)
	slot0._clickMeshContainer:RemoveClickListener()
	slot0._btnfinished:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0:removeEventCb(LiangYueController.instance, LiangYueEvent.OnFinishEpisode, slot0.onEpisodeFinish, slot0)
	slot0:removeEventCb(LiangYueController.instance, LiangYueEvent.OnReceiveEpisodeInfo, slot0._refreshView, slot0)
	slot0._illustrationDragListener:RemoveDragBeginListener()
	slot0._illustrationDragListener:RemoveDragListener()
	slot0._illustrationDragListener:RemoveDragEndListener()
end

function slot0.onClickFinished(slot0)
	if slot0._isDrag then
		return
	end

	slot1 = slot0._meshSize[1]
	slot2 = {}

	for slot6, slot7 in pairs(slot0._illustrationIndexDic) do
		if not slot0:_isStaticIllustration(slot6) then
			table.insert(slot2, string.format("%s#%s#%s", (slot6 - 1) % slot1 + 1, math.floor((slot6 - 1) / slot1) + 1, slot7))
		end
	end

	slot3 = table.concat(slot2, "|")

	logNormal("Result: " .. slot3)
	LiangYueController.instance:finishEpisode(slot0._actId, slot0._episodeId, slot3)
end

function slot0.onEpisodeFinish(slot0, slot1, slot2)
	if slot0._actId ~= slot1 or slot0._episodeId ~= slot2 then
		return
	end

	if LiangYueModel.instance:isEpisodeFinish(slot1, slot2) then
		slot0:statData(LiangYueEnum.StatGameState.Finish)
	end

	slot0._animator:Play("finish", 0, 0)

	slot0._isFinish = slot3

	slot0:_lockScreen(true)
	AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wulu_aizila_forward_paper)
	TaskDispatcher.runDelay(slot0.delayFinishAnim, slot0, LiangYueEnum.FinishAnimDelayTime)
	TaskDispatcher.runDelay(slot0.delayFinishAnimEnd, slot0, LiangYueEnum.FinishAnimDelayTimeEnd)
end

function slot0.delayFinishAnim(slot0)
	TaskDispatcher.cancelTask(slot0.delayFinishAnim, slot0)

	for slot4, slot5 in pairs(slot0._usedDragItemDic) do
		slot5:setAttributeState(false)
	end

	slot0:_refreshCompleteState()
end

function slot0.delayFinishAnimEnd(slot0)
	TaskDispatcher.cancelTask(slot0.delayFinishAnimEnd, slot0)
	slot0:_lockScreen(false)
	slot0:_refreshFinishBtnState()
	AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_pen2)
end

function slot0.onBtnResetClick(slot0)
	if slot0._isDrag then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.LiangYueResetTip, MsgBoxEnum.BoxType.Yes_No, slot0.resetGame, nil, , slot0)
end

function slot0.resetGame(slot0)
	if next(slot0._illustrationUseDic) == nil then
		return
	end

	slot0:_beforeAttributeChanged()
	slot0:statData(LiangYueEnum.StatGameState.Restart)

	slot0._resetTime = ServerTime.now()
	slot0._enterTime = ServerTime.now()
	slot1 = slot0._meshSize[1]

	for slot5, slot6 in pairs(slot0._illustrationIndexDic) do
		if not slot0:_isStaticIllustration(slot5) then
			slot0:_ClearMesh((slot5 - 1) % slot1 + 1, math.floor((slot5 - 1) / slot1) + 1, slot6)
		end
	end

	slot0:_afterAttributeChanged()
end

function slot0._beforeAttributeChanged(slot0)
	slot0._tempParam = tabletool.copy(slot0._paramDic)

	TaskDispatcher.cancelTask(slot0._resetAttributeState, slot0)
end

function slot0._afterAttributeChanged(slot0)
	for slot4, slot5 in ipairs(slot0._attributeAnimList) do
		slot8 = nil

		if (slot0._tempParam[slot4] or 0) < (slot0._paramDic[slot4] or 0) then
			slot8 = LiangYueEnum.AttributeAnim.Up
		elseif slot7 < slot6 then
			slot8 = LiangYueEnum.AttributeAnim.Down

			if slot0._targetDescItemList[slot4] == nil then
				logError("动画组件和实际lua脚本组件数量不对应")
			else
				slot9:setTxtColor(LiangYueEnum.AttributeDownColor)
			end
		else
			slot8 = LiangYueEnum.AttributeAnim.Empty
		end

		slot5.enabled = true

		slot5:Play(slot8, 0, 0)
	end

	TaskDispatcher.runDelay(slot0._resetAttributeState, slot0, LiangYueEnum.AttributeAnimRevertTime)

	slot0._tempParam = nil
end

function slot0._resetAttributeState(slot0)
	TaskDispatcher.cancelTask(slot0._resetAttributeState, slot0)

	for slot4, slot5 in ipairs(slot0._attributeAnimList) do
		if slot5.gameObject.activeSelf == true then
			slot5:Play(LiangYueEnum.AttributeAnim.Empty, 0, 0)
			slot0._targetDescItemList[slot4]:setTxtColor((slot0._targetParamDic[slot4] or 0) <= (slot0._paramDic[slot4] or 0) and LiangYueEnum.AttributeColor[slot4] or LiangYueEnum.AttributeNotEnoughColor)
		end
	end
end

function slot0._onMeshContainerClick(slot0, slot1, slot2, slot3, slot4)
	if slot0._isFinish or slot0._isDrag then
		return nil, , 
	end

	slot5 = recthelper.screenPosToAnchorPos(slot2, slot0._gomeshContainer.transform)
	slot6, slot7 = slot0:_getMeshPosByIndex(slot5.x, slot5.y)

	if not slot0._meshData[slot7] or not slot0._meshData[slot7][slot6] then
		return nil, , 
	end

	if slot0:_isStaticIllustration(slot0._meshData[slot7][slot6]) then
		ToastController.instance:showToast(ToastEnum.Act184PuzzleCanNotMove)

		return nil, , 
	end

	if not slot4 then
		AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_delete)
	end

	slot9 = slot0._illustrationPosDic[slot8]
	slot10 = slot0._illustrationIndexDic[slot8]

	slot0:_beforeAttributeChanged()
	slot0:_ClearMesh(slot9[1], slot9[2], slot10)
	slot0:_afterAttributeChanged()

	return slot10, slot9[1], slot9[2]
end

function slot0._editableInitView(slot0)
	slot0._illustrationDragListener = SLFramework.UGUI.UIDragListener.Get(slot0._gomeshContainer)

	gohelper.setActive(slot0._godragItem, false)
	gohelper.setActive(slot0._goillstrationItem, false)
	slot0:_initAttributeComp()
end

function slot0.onUpdateParam(slot0)
end

function slot0._initAttributeComp(slot0)
	slot0._targetDescItemList = {}
	slot0._goTarget = gohelper.findChild(slot0.viewGO, "Left/Game/TargetIcon")
	slot0._attributeAnimList = {}

	for slot6 = 1, slot0._goTarget.transform.childCount do
		slot7 = slot1.transform:GetChild(slot6 - 1)
		slot8 = LiangYueAttributeDescItem.New()

		slot8:init(slot7.gameObject)
		table.insert(slot0._targetDescItemList, slot8)
		table.insert(slot0._attributeAnimList, gohelper.findChildAnim(slot7.gameObject, ""))
	end

	slot0._animator = gohelper.findChildAnim(slot0.viewGO, "")
end

function slot0._initGameData(slot0)
	slot0._actId = slot0.viewParam.actId
	slot0._episodeId = slot0.viewParam.episodeId
	slot0._episodeGameId = slot0.viewParam.episodeGameId
	slot0._enterTime = ServerTime.now()
	slot0._resetTime = ServerTime.now()
	slot0._meshItemList = {}
	slot0._dyeingMeshItemList = {}
	slot0._dyeingMeshItemCount = 0
	slot0._meshData = {}
	slot0._illustrationIndexDic = {}
	slot0._illustrationIndexList = {}
	slot0._illustrationCountDic = {}
	slot0._illustrationUseDic = {}
	slot0._illustrationScrollItemList = {}
	slot0._unusedDragItemList = {}
	slot0._usedDragItemDic = {}
	slot0._illustrationPosDic = {}
	slot0._staticIllustrationDic = {}
	slot0._paramDic = {}
	slot0._targetParamDic = {}
end

function slot0.onOpen(slot0)
	slot0._animator:Play("open", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wulu_aizila_forward_paper)
	slot0:_initGameData()
	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	if LiangYueConfig.instance:getEpisodePuzzleConfigByActAndId(slot0._actId, slot0._episodeGameId) == nil then
		return
	end

	slot0._episodeConfig = slot1
	slot2 = LiangYueModel.instance:isEpisodeFinish(slot0._actId, slot0._episodeId)
	slot0._isEnable = slot2
	slot0._isFinish = slot2

	if not slot2 then
		slot0:_refreshIllustration(slot1)
	end

	slot0:_refreshTargetParam(slot1)
	slot0:_resetMeshContent(slot1)
	slot0:_refreshTitle(slot1)
	slot0:_refreshFinishBtnState()
	slot0:_refreshCompleteState()
end

function slot0._resetMeshContent(slot0, slot1)
	slot0._meshSize = string.splitToNumber(slot1.size, "#")

	slot0:_rebuildMesh()
	slot0:_refreshMeshData()
end

function slot0._refreshTitle(slot0, slot1)
	slot0._txtDescr.text = slot1.titleTxt
	slot3 = TimeUtil.timestampToTable(TimeUtil.stringToTimestamp(slot1.date))
	slot0._txtYear.text = slot3.year
	slot0._txtMonth.text = string.upper(LiangYueEnum.MonthEn[slot3.month])
	slot0._txtDay.text = slot3.day
	slot0._txtStory.text = slot1.txt
end

function slot0._refreshTargetParam(slot0, slot1)
	tabletool.clear(slot0._targetParamDic)

	if #string.split(slot1.target, "|") <= 0 then
		logError("no target param")

		return
	end

	for slot7, slot8 in ipairs(slot3) do
		if not slot0._targetParamDic[string.splitToNumber(slot8, "#")[1]] then
			slot0._targetParamDic[slot9[1]] = slot9[2]
		end
	end

	for slot7, slot8 in ipairs(slot0._targetDescItemList) do
		slot8:setActive(slot0._targetParamDic[slot7] ~= nil)
	end

	slot0:_updateAttributeInfo()
end

function slot0._refreshIllustration(slot0, slot1)
	slot0:_refreshIllustrationData(slot1)
	slot0:_refreshIllustrationContent()
end

function slot0._refreshIllustrationData(slot0, slot1)
	tabletool.clear(slot0._illustrationCountDic)
	tabletool.clear(slot0._illustrationUseDic)

	if string.nilorempty(slot1.illustrationCount) then
		logError("episode puzzle count data is nil")

		return
	end

	for slot7, slot8 in ipairs(string.split(slot2, "|")) do
		slot9 = string.splitToNumber(slot8, "#")
		slot0._illustrationCountDic[slot9[1]] = slot9[2]
	end
end

function slot0._refreshIllustrationContent(slot0)
	slot1 = 0
	slot2 = #slot0._illustrationScrollItemList

	for slot6, slot7 in pairs(slot0._illustrationCountDic) do
		slot8 = nil
		slot9 = LiangYueConfig.instance:getIllustrationConfigById(slot0._actId, slot6)
		slot10 = LiangYueConfig.instance:getIllustrationShape(slot0._actId, slot6)
		slot11 = #slot10 / #slot10[1]

		if ((slot2 >= slot1 + 1 or slot0:_createIllustrationItem(slot6, slot1)) and slot0._illustrationScrollItemList[slot1]) == nil then
			logError("have no item index :" .. slot1)
		else
			slot8:setActive(true)
			slot8:setInfo(slot6, slot1, slot7, slot9.imageId, slot11, slot0._actId)
		end
	end

	if slot1 < slot2 then
		for slot6 = slot1 + 1, slot2 do
			slot0._illustrationScrollItemList[slot6]:setActive(false)
		end
	end
end

function slot0._refreshMeshData(slot0)
	slot0._meshData = {}

	if LiangYueConfig.instance:getEpisodeStaticIllustrationDic(slot0._actId, slot0._episodeGameId) ~= nil then
		for slot5, slot6 in pairs(slot1) do
			for slot10, slot11 in pairs(slot6) do
				if slot0._meshData[slot5] and slot0._meshData[slot5][slot10] then
					logError("固定格子位置重复 位置: x:" .. slot5 .. "y:" .. slot10)
				else
					slot0:_fillMesh(slot5, slot10, slot11, true)
				end
			end
		end
	end

	if string.nilorempty(LiangYueModel.instance:getEpisodeInfoMo(slot0._actId, slot0._episodeId).puzzle) then
		return
	end

	for slot7, slot8 in ipairs(string.split(slot2.puzzle, "|")) do
		if string.splitToNumber(slot8, "#") ~= nil then
			slot0:_fillMesh(slot9[1], slot9[2], slot9[3])
		else
			logError("玩家插画数据错误： 数据格式：" .. slot2.puzzle)
		end
	end
end

function slot0._refreshCompleteState(slot0)
	slot2 = slot0._isFinish

	gohelper.setActive(slot0._goPiecesList, not slot2)
	gohelper.setActive(slot0._goScrollText, slot2)
	gohelper.setActive(slot0._goCompleted, slot2)
	gohelper.setActive(slot0._btnreset, not slot2)
	gohelper.setActive(slot0._goGridBg.gameObject, not slot2)

	slot0._txtTarget.text = slot0._isFinish and luaLang("act184_target_complete") or luaLang("act184_target_not_complete")
	slot0._txtTitle.text = slot0._isFinish and LiangYueConfig.instance:getEpisodePuzzleConfigByActAndId(slot0._actId, slot0._episodeGameId).titile or luaLang("act184_puzzle_title")
end

function slot0._refreshFinishBtnState(slot0)
	slot1 = slot0._isEnable and not slot0._isFinish

	gohelper.setActive(slot0._btnfinished, slot1)
	gohelper.setActive(slot0._goVxEnable, slot1)
	gohelper.setActive(slot0._goTick, slot0._isFinish)

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_pen1)
	end
end

function slot0._fillMesh(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot0._meshData
	slot7 = 0
	slot8 = 0
	slot9 = false
	slot10 = LiangYueConfig.instance:getIllustrationShape(slot0._actId, slot3)
	slot12 = #slot10[1]
	slot13 = (slot2 - 1) * slot0._meshSize[1] + slot1

	for slot17 = 1, #slot10 do
		for slot22 = 1, slot12 do
			slot23 = slot10[slot17][slot22] == 1

			if not slot9 and slot23 then
				slot7 = slot22 - 1
				slot8 = slot17 - 1
				slot9 = true
			end

			if slot9 and slot23 then
				slot25 = slot1 - slot7 + slot22 - 1

				if not slot6[slot2 - slot8 + slot17 - 1] then
					slot6[slot24] = {}
				end

				if slot6[slot24][slot25] then
					logError("meshFill failed posX: " .. slot25 .. " Y " .. slot24)
				else
					slot6[slot24][slot25] = slot13
				end
			end
		end
	end

	slot14 = slot1 - slot7
	slot17 = ((slot14 - 1) * slot0._meshWidth + (slot14 - 1 + slot12) * slot0._meshWidth) * 0.5 - slot0._meshMaxX
	slot19 = slot0._meshSize[2] - (slot2 - slot8) + 1
	slot23 = (slot19 * slot0._meshHeight + (slot19 - slot11) * slot0._meshHeight) * 0.5 - slot0._meshMaxY
	slot0._illustrationIndexDic[slot13] = slot3

	table.insert(slot0._illustrationIndexList, slot13)

	slot0._illustrationPosDic[slot13] = {
		slot1,
		slot2
	}
	slot0._usedDragItemDic[slot13] = slot5 or slot0:_getDragItem(slot3, slot4, slot0._isFinish)

	if slot4 then
		slot0._staticIllustrationDic[slot13] = slot3
	elseif not slot0._illustrationUseDic[slot3] then
		slot0._illustrationUseDic[slot3] = 1
	else
		slot0._illustrationUseDic[slot3] = slot0._illustrationUseDic[slot3] + 1
	end

	slot0:_refreshIllustrationIndex()
	slot0:_refreshIllustrationCount()

	if slot4 or slot0._isFinish == true then
		recthelper.setAnchor(slot5.go.transform, slot17, slot23)
	else
		slot0._tweenItem = slot5

		slot5:setAttributeInfo(slot0._actId, slot5.id)

		slot0._tweenPos = ZProj.TweenHelper.DOAnchorPos(slot5.go.transform, slot17, slot23, LiangYueEnum.TweenDuration, slot0._onTweenEnd, slot0)
	end

	logNormal(string.format("fill illustration: pos x:%s y:%s index : x: %s y: %s", slot17, slot23, slot1, slot2))
end

function slot0._onTweenEnd(slot0)
	if slot0._tweenItem ~= nil then
		slot1:setItemPosY()
	end

	slot0._tweenItem = nil
	slot0._tweenPos = nil
end

function slot0._ClearMesh(slot0, slot1, slot2, slot3)
	slot4 = slot0._meshData
	slot5 = 0
	slot6 = 0
	slot7 = false
	slot8 = LiangYueConfig.instance:getIllustrationShape(slot0._actId, slot3)
	slot10 = #slot8[1]

	for slot14 = 1, #slot8 do
		for slot19 = 1, slot10 do
			slot20 = slot8[slot14][slot19] == 1

			if not slot7 and slot20 then
				slot5 = slot19 - 1
				slot6 = slot14 - 1
				slot7 = true
			end

			if slot7 and slot20 then
				slot22 = slot1 - slot5 + slot19 - 1

				if not slot4[slot2 - slot6 + slot14 - 1] or not slot4[slot21][slot22] then
					logError("clear mesh failed posX: " .. slot22 .. " Y " .. slot21)
				else
					slot4[slot21][slot22] = nil
					slot23 = (slot21 - 1) * slot0._meshSize[1] + slot22
				end
			end
		end
	end

	slot11 = (slot2 - 1) * slot0._meshSize[1] + slot1
	slot0._illustrationIndexDic[slot11] = nil

	tabletool.removeValue(slot0._illustrationIndexList, slot11)

	slot12 = slot0._usedDragItemDic[slot11]
	slot0._usedDragItemDic[slot11] = nil
	slot0._illustrationPosDic[slot11] = nil

	if not slot0._illustrationUseDic[slot3] then
		logError("not such illustration use")
	elseif slot0._illustrationUseDic[slot3] - 1 <= 0 then
		slot0._illustrationUseDic[slot3] = nil
	else
		slot0._illustrationUseDic[slot3] = slot13
	end

	slot0:_recycleDragItem(slot12)
	slot0:_refreshIllustrationIndex()
	slot0:_refreshIllustrationCount()
end

function slot0._refreshIllustrationCount(slot0)
	for slot4, slot5 in pairs(slot0._illustrationScrollItemList) do
		if slot0._illustrationCountDic[slot5.id] and slot0._illustrationCountDic[slot5.id] ~= 0 then
			slot7 = slot0._illustrationCountDic[slot5.id] - (slot0._illustrationUseDic[slot5.id] or 0)

			slot5:setCount(slot7)
			slot5:setEnoughState(slot7 > 0)
		end
	end
end

function slot0._getMeshPosByIndex(slot0, slot1, slot2)
	slot3 = 1
	slot5 = slot0._meshSize[2]
	slot6 = Mathf.Clamp(math.floor((slot1 + slot0._meshMaxX) / slot0._meshWidth) + 1, slot3, slot0._meshSize[1])
	slot7 = Mathf.Clamp(slot5 - math.floor((slot2 + slot0._meshMaxY) / slot0._meshHeight), slot3, slot5)

	logNormal("button click mesh x:" .. slot6 .. "mesh y:" .. slot7)

	return slot6, slot7
end

function slot0._refreshIllustrationIndex(slot0)
	table.sort(slot0._illustrationIndexList)
	tabletool.clear(slot0._paramDic)

	slot1 = 0

	for slot5, slot6 in ipairs(slot0._illustrationIndexList) do
		if slot0._usedDragItemDic[slot6] == nil then
			logError("item is null index:" .. slot6)
		else
			slot7:setIndex(slot5)
			slot0:_calculateAttribute(LiangYueConfig.instance:getIllustrationConfigById(slot0._actId, slot0._illustrationIndexDic[slot6]).attribute, slot0._paramDic)

			if not slot0._staticIllustrationDic[slot5] then
				slot1 = slot1 + 1
			end
		end
	end

	if not slot0._isFinish then
		LiangYueController.instance:dispatchEvent(LiangYueEvent.OnDragIllustration, slot1)
		logNormal("OnDragIllustration Count: " .. tostring(slot1))
	end

	slot0:_updateAttributeInfo()
end

function slot0._updateAttributeInfo(slot0)
	for slot6, slot7 in pairs(slot0._targetParamDic) do
		if not (slot7 <= (slot0._paramDic[slot6] or 0)) then
			slot2 = 0 + 1
		end

		slot0._targetDescItemList[slot6]:setTargetInfo(slot8, slot7, slot9 and LiangYueEnum.AttributeColor[slot6] or LiangYueEnum.AttributeNotEnoughColor)
	end

	slot0._isEnable = slot2 <= 0

	if not slot0._isFinish and slot0._isEnable then
		LiangYueController.instance:dispatchEvent(LiangYueEvent.OnAttributeMeetConditions, slot0._episodeId)
		logNormal("OnAttributeMeetConditions  episodeId:" .. tostring(slot0._episodeId))
	end

	slot0:_refreshFinishBtnState()
end

function slot0._calculateAttribute(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(string.split(slot1, "|")) do
		slot9 = string.splitToNumber(slot8, "#")
		slot11 = slot9[2]
		slot12 = slot9[3]

		if slot2[slot9[1]] == nil then
			slot2[slot10] = 0
		end

		if slot11 == LiangYueEnum.CalculateType.Add then
			slot13 = slot2[slot10] + slot12
		elseif slot11 == LiangYueEnum.CalculateType.Minus then
			slot13 = slot13 - slot12
		elseif slot11 == LiangYueEnum.CalculateType.Multiply then
			slot13 = slot13 * slot12
		elseif slot11 == LiangYueEnum.CalculateType.Divide then
			slot13 = slot13 / slot12
		end

		slot2[slot10] = math.floor(slot13)
	end
end

function slot0._onItemBeginDrag(slot0, slot1, slot2, slot3)
	if slot0._isFinish then
		return
	end

	slot4 = nil
	slot5 = recthelper.screenPosToAnchorPos(slot2.position, slot0._goillustrationContainer.transform)
	slot6, slot7 = nil

	if slot3 == nil then
		slot9, slot6, slot7 = slot0:_onMeshContainerClick(slot1, slot2.position, nil, true)

		if slot9 == nil then
			return
		end

		slot0._previousPosX = slot6
		slot0._previousPosY = slot7
	end

	if slot0:_CheckDragItemCount(slot3) then
		GameFacade.showToast(ToastEnum.Act184PuzzleNotEnough)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_anzhu)
	slot0:_setScrollItemAlpha(slot3, slot8 and LiangYueEnum.NormalAlpha or LiangYueEnum.DragAlpha)

	slot4 = slot0:_getDragItem(slot3)

	logNormal("Start Drag")
	gohelper.setAsLastSibling(slot4.go)

	slot0._currentDragItem = slot4
	slot0._isDrag = true
	slot0._dragShapeId = slot3

	recthelper.setAnchor(slot4.rectTran, slot5.x, slot5.y)

	slot0._previousDragPos = slot5

	slot0:_onSelectShape(slot3)
	slot0:_resetMeshItemEnableState()
end

function slot0._onSelectShape(slot0, slot1)
	slot2 = LiangYueConfig.instance:getIllustrationShape(slot0._actId, slot1)
	slot3 = #slot2
	slot4 = #slot2[1]
	slot5 = slot3 * slot0._meshHeight
	slot6 = slot4 * slot0._meshWidth
	slot0._dragItemMaxX = slot6 * 0.5
	slot0._dragItemMinX = -slot0._dragItemMaxX
	slot0._dragItemMaxY = slot5 * 0.5
	slot0._dragItemMinY = -slot0._dragItemMaxY
	slot0._dragItemHeight = slot5
	slot0._dragItemWidth = slot6
	slot0._currentDragCheckList = slot2
	slot0._dragItemSize = {
		slot4,
		slot3
	}
	slot0._needCheckMeshCount = LiangYueConfig.instance:getIllustrationShapeCount(slot0._actId, slot1)
end

function slot0._setScrollItemAlpha(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0._illustrationScrollItemList) do
		if slot7.id == slot1 then
			slot7:setAlpha(slot2)

			return
		end
	end
end

function slot0._CheckDragItemCount(slot0, slot1)
	if not slot0._illustrationCountDic[slot1] or slot2 == 0 then
		return false
	end

	return slot2 <= (slot0._illustrationUseDic[slot1] or 0)
end

function slot0._updateItemPos(slot0, slot1)
	slot2 = slot0._currentDragItem.rectTran
	slot3 = recthelper.screenPosToAnchorPos(slot1.position, slot0._gomeshContainer.transform)
	slot6, slot7 = recthelper.getAnchor(slot2)
	slot8 = slot6 + slot3.x - slot0._previousDragPos.x
	slot9 = slot7 + slot3.y - slot0._previousDragPos.y

	recthelper.setAnchor(slot2, slot8, slot9)

	slot0._previousDragPos = slot3

	return slot8, slot9
end

function slot0._onItemDrag(slot0, slot1, slot2)
	if slot0._currentDragItem == nil then
		return
	end

	slot0:_resetMeshItemEnableState()
	slot0:_onItemMove(slot2)
end

function slot0._onItemMove(slot0, slot1)
	slot2, slot3 = slot0:_updateItemPos(slot1)
	slot4 = slot0._dragItemMinX + slot2
	slot6 = slot0._dragItemMinY + slot3
	slot7 = slot0._dragItemMaxY + slot3
	slot9 = slot0._meshHeight * 0.5
	slot11 = slot0._meshMaxY

	if slot0._dragItemMaxX + slot2 < -slot0._meshMaxX + slot0._meshWidth * 0.5 or slot4 > slot10 - slot8 or slot7 < -slot11 + slot9 or slot6 > slot11 - slot9 then
		return false, nil, 
	end

	slot16 = 1
	slot19, slot20, slot21, slot22 = slot0:_calculateOverlapMeshBoundary(math.max(slot4, -slot10) - slot2 + slot0._dragItemMaxX, math.min(slot5, slot10) - slot2 + slot0._dragItemMaxX, math.max(slot6, -slot11) - slot3 + slot0._dragItemMaxY, math.min(slot7, slot11) - slot3 + slot0._dragItemMaxY, slot0._meshWidth, slot0._meshHeight, slot0._dragItemSize[1], slot0._dragItemSize[2])
	slot23 = slot0._meshSize[1]
	slot24 = slot0._meshSize[2]
	slot25 = 0
	slot26 = 0
	slot27, slot28 = nil
	slot29 = false

	for slot33 = slot21, slot22 do
		for slot37 = slot19, slot20 do
			if slot0._currentDragCheckList[slot33] and slot0._currentDragCheckList[slot33][slot37] == 1 and slot0._meshItemList[slot23 * (slot24 - Mathf.Clamp(math.floor(((slot18 - slot33 + 1) * slot0._meshHeight + slot0._dragItemMinY + slot3 + slot0._meshMaxY) / slot0._meshWidth + 0.5), slot16, slot24) + 1 - 1) + Mathf.Clamp(math.floor(((slot37 - 1) * slot0._meshWidth + slot0._dragItemMinX + slot8 + slot2 + slot0._meshMaxX) / slot0._meshWidth) + 1, slot16, slot23)] then
				if not slot29 then
					slot27 = slot40
					slot28 = slot41
					slot29 = true
				end

				table.insert(slot0._dyeingMeshItemList, slot43)

				slot25 = slot25 + 1

				if not (slot0._meshData[slot41] and slot0._meshData[slot41][slot40] ~= nil) then
					slot26 = slot26 + 1
				end
			end
		end
	end

	slot31 = slot0._needCheckMeshCount <= slot26 and LiangYueEnum.MeshItemColor.Enable or LiangYueEnum.MeshItemColor.Disable

	if slot25 > 0 then
		for slot35, slot36 in ipairs(slot0._dyeingMeshItemList) do
			slot36:setActive(true)
			slot36:setBgColor(slot31)
		end
	end

	slot0._dyeingMeshItemCount = slot25

	if not slot30 then
		return true, nil, 
	end

	return true, slot27, slot28
end

function slot0._calculateOverlapMeshBoundary(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot9 = 1

	return Mathf.Clamp(math.floor(slot1 / slot5 + 0.5) + 1, slot9, slot7), Mathf.Clamp(math.floor(slot2 / slot5 + 0.5), slot9, slot7), slot8 - Mathf.Clamp(math.floor(slot4 / slot6 + 0.5), slot9, slot8) + 1, slot8 - Mathf.Clamp(math.floor(slot3 / slot6 + 0.5) + 1, slot9, slot8) + 1
end

function slot0._resetMeshItemEnableState(slot0)
	if slot0._dyeingMeshItemCount > 0 then
		for slot4, slot5 in ipairs(slot0._dyeingMeshItemList) do
			slot5:setActive(false)
		end

		tabletool.clear(slot0._dyeingMeshItemList)

		slot0._dyeingMeshItemCount = 0
	end
end

function slot0._onItemEndDrag(slot0, slot1, slot2)
	if slot0._currentDragItem == nil then
		return
	end

	logNormal("End Drag")

	slot0._isDrag = false
	slot3, slot4, slot5 = slot0:_onItemMove(slot2)
	slot4 = slot4 or slot0._previousPosX
	slot5 = slot5 or slot0._previousPosY

	slot0:_setScrollItemAlpha(slot0._dragShapeId, LiangYueEnum.NormalAlpha)
	slot0:_beforeAttributeChanged()

	if slot3 and slot4 and slot5 then
		logNormal("放置插画")
		slot0:_fillMesh(slot4, slot5, slot0._dragShapeId, false, slot0._currentDragItem)
		AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_tangren_fangru)
	else
		logNormal("回收插画")
		slot0:_recycleDragItem(slot0._currentDragItem)
	end

	slot0:_afterAttributeChanged()

	slot0._dragShapeId = nil
	slot0._previousPosX = nil
	slot0._previousPosX = nil
	slot0._currentDragItem = nil

	slot0:_resetMeshItemEnableState()
end

function slot0._rebuildMesh(slot0)
	slot3 = slot0._meshSize[1]
	slot4 = slot0._meshSize[2]
	slot0._meshWidth = recthelper.getWidth(slot0._goImageBg.transform) / slot3
	slot0._meshHeight = recthelper.getHeight(slot0._goImageBg.transform) / slot4
	slot5 = slot0._meshWidth * slot3
	slot6 = slot0._meshHeight * slot4
	slot7 = (slot5 + slot0._meshWidth) * 0.5
	slot8 = (slot6 + slot0._meshHeight) * 0.5

	recthelper.setSize(slot0._gomeshContainer.transform, slot5, slot6)
	recthelper.setSize(slot0._goillustrationContainer.transform, slot5, slot6)
	recthelper.setAnchor(slot0._gomeshContainer.transform, 0, 0)
	recthelper.setAnchor(slot0._goillustrationContainer.transform, 0, 0)

	slot0._meshMaxX = slot5 * 0.5
	slot0._meshMinX = -slot0._meshMaxX
	slot0._meshMaxY = slot6 * 0.5
	slot0._meshMinY = -slot0._meshMaxY
	slot9 = slot3 * slot4
	slot10 = #slot0._meshItemList

	for slot14 = 1, slot4 do
		for slot18 = 1, slot3 do
			slot20 = nil
			slot20 = (slot10 >= (slot14 - 1) * slot3 + slot18 or slot0:_createMeshItem(slot19)) and slot0._meshItemList[slot19]

			slot20:setPos(slot18 * slot0._meshWidth - slot7, slot6 - (slot14 - 1) * slot0._meshHeight - slot8)
			slot20:setActive(false)
		end
	end

	if slot9 < slot10 then
		for slot14 = slot9 + 1, slot10 do
			slot0._meshItemList[slot14]:setActive(false)
		end
	end
end

function slot0._createIllustrationItem(slot0, slot1, slot2)
	slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._goillstrationItem, slot0._goContent, string.format("item_%s_%s", slot1, slot2)), LiangYueScrollItem)

	slot5:setParentView(slot0)
	table.insert(slot0._illustrationScrollItemList, slot5)

	return slot5
end

function slot0._createMeshItem(slot0, slot1)
	slot2 = slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[1], slot0._gomeshContainer, "meshItem" .. slot1)

	recthelper.setSize(slot2.transform, slot0._meshHeight, slot0._meshHeight)

	slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(slot2, LiangYueMeshItem)

	table.insert(slot0._meshItemList, slot3)

	return slot3
end

function slot0._getDragItem(slot0, slot1, slot2, slot3)
	slot4 = nil

	if #slot0._unusedDragItemList <= 0 then
		slot4 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._godragItem, slot0._goillustrationContainer), LiangYueDragItem)
	else
		slot4 = slot0._unusedDragItemList[slot5]
		slot0._unusedDragItemList[slot5] = nil
	end

	slot4:setActive(true)
	slot4:setInfo(slot1, LiangYueConfig.instance:getIllustrationConfigById(slot0._actId, slot1), slot2, slot3)

	return slot4
end

function slot0._recycleDragItem(slot0, slot1)
	if slot1 ~= nil then
		slot1:setActive(false)
		table.insert(slot0._unusedDragItemList, slot1)
	end
end

function slot0._isStaticIllustration(slot0, slot1)
	if slot0._staticIllustrationDic[slot1] then
		return true
	end

	return false
end

function slot0.statData(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0._illustrationIndexList) do
		if not slot0:_isStaticIllustration(slot7) then
			table.insert(slot2, slot0._illustrationIndexDic[slot7])
		end
	end

	slot3 = nil

	LiangYueController.instance:statExitData((slot1 ~= LiangYueEnum.StatGameState.Restart or slot0._resetTime) and slot0._enterTime, slot0._episodeGameId, slot1, slot2)
end

function slot0._lockScreen(slot0, slot1)
	if slot1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("LiangYueGameLock")
	else
		UIBlockMgr.instance:endBlock("LiangYueGameLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function slot0.onClose(slot0)
	LiangYueModel.instance:setCurActId(nil)
	LiangYueModel.instance:setCurEpisodeId(nil)
	TaskDispatcher.cancelTask(slot0.delayFinishAnim, slot0)
	TaskDispatcher.cancelTask(slot0.delayFinishAnimEnd, slot0)
	TaskDispatcher.cancelTask(slot0._resetAttributeState, slot0)

	if slot0._tweenPos then
		ZProj.TweenHelper.KillById(slot0._tweenPos)

		slot0._tweenPos = nil
	end
end

function slot0.onDestroyView(slot0)
end

return slot0

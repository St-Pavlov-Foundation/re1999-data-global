module("modules.logic.versionactivity.view.VersionActivityPuzzleView", package.seeall)

slot0 = class("VersionActivityPuzzleView", BaseView)

function slot0.onInitView(slot0)
	slot0._goclose = gohelper.findChild(slot0.viewGO, "#go_close")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#simage_bg/#txt_title")
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "#simage_bg/Scroll View/Viewport/Content/#txt_info")
	slot0._gooptions = gohelper.findChild(slot0.viewGO, "#simage_bg/#go_options")
	slot0._gooptionitem = gohelper.findChild(slot0.viewGO, "#simage_bg/#go_options/#go_optionitem")
	slot0._goemptyoptionitem = gohelper.findChild(slot0.viewGO, "#simage_bg/#go_options/#go_empty")
	slot0._godragoptionitem = gohelper.findChild(slot0.viewGO, "#simage_bg/#go_dragoptionitem")
	slot0._goadsorbrect = gohelper.findChild(slot0.viewGO, "#simage_bg/#go_adsorbrect")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_finish")
	slot0._txtgamename = gohelper.findChildText(slot0.viewGO, "#simage_bg/#txt_gamename")
	slot0._txttemp = gohelper.findChildText(slot0.viewGO, "#txt_temp")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.GuideBorder = 10
slot0.FingerAnswerOffsetX = 77
slot0.FingerAnswerOffsetY = -160
slot0.FingerOptionOffsetX = 150
slot0.FingerOptionOffsetY = -250
slot0.AbsorbOffsetX = 20
slot0.AbsorbOffsetY = 10

function slot0.closeViewOnClick(slot0)
	slot0:closeThis()
end

function slot0.initCharacterWidth(slot0)
	slot0._txttemp.text = luaLang("lei_mi_te_bei_placeholder")
	slot0.oneCharacterWidth = slot0._txttemp.preferredWidth
	slot0._txttemp.text = string.rep(luaLang("lei_mi_te_bei_placeholder"), 2)
	slot0.intervalX = slot0._txttemp.preferredWidth - 2 * slot0.oneCharacterWidth
end

function slot0._editableInitView(slot0)
	slot0.defaultAnchorPos = Vector2(0, 0)

	slot0:initCharacterWidth()

	slot0._goGuide = gohelper.findChild(slot0.viewGO, "guide_activitypuzzle")

	gohelper.setActive(slot0._godragoptionitem, false)
	gohelper.setActive(slot0._goadsorbrect, false)

	slot0.goAdsorbSuccess = gohelper.findChild(slot0.viewGO, "#simage_bg/#go_adsorbrect/success")
	slot0.goAdsorbFail = gohelper.findChild(slot0.viewGO, "#simage_bg/#go_adsorbrect/fail")

	slot0:resetAdsorbEffect()

	slot0.goGuideAnimationContainer = gohelper.findChild(slot0.viewGO, "guide_activitypuzzle/guide1")
	slot0.goGuideAnimator = slot0.goGuideAnimationContainer:GetComponent(typeof(UnityEngine.Animator))
	slot0.goAnswerRect = gohelper.findChild(slot0.viewGO, "guide_activitypuzzle/guide1/kuang1")
	slot0.goOptionRect = gohelper.findChild(slot0.viewGO, "guide_activitypuzzle/guide1/kuang2")
	slot0.goFinger = gohelper.findChild(slot0.viewGO, "guide_activitypuzzle/guide1/shouzhi")
	slot0.rectTransformAnswer = slot0.goAnswerRect.transform
	slot0.rectTransformOption = slot0.goOptionRect.transform
	slot0.rectTransformFinger = slot0.goFinger.transform

	slot0:initDragOptionItem()
	slot0:initTextScrollViewScenePosRect()
	gohelper.setActive(slot0._gofinish, false)

	slot0.bgHalfWidth = recthelper.getWidth(slot0._simagebg.transform) / 2
	slot0.bgHalfHeight = recthelper.getHeight(slot0._simagebg.transform) / 2
	slot0.closeViewClick = gohelper.getClick(slot0._goclose)

	slot0.closeViewClick:AddClickListener(slot0.closeViewOnClick, slot0)

	slot0.optionItemList = {}
	slot0.answerExistOptionItemDict = {}
	slot0.needAnswerList = {}
	slot0.answerMatched = false
end

function slot0.initDragOptionItem(slot0)
	slot0.dragOptionItem = slot0:getUserDataTb_()
	slot0.dragOptionItem.go = slot0._godragoptionitem
	slot0.dragOptionItem.txtInfo = gohelper.findChildText(slot0.dragOptionItem.go, "info")
	slot0.dragOptionItem.transform = slot0.dragOptionItem.go.transform
end

function slot0.initTextScrollViewScenePosRect(slot0)
	slot0.goScroll = gohelper.findChild(slot0.viewGO, "#simage_bg/Scroll View")
	slot1 = slot0.goScroll.transform:GetWorldCorners()
	slot0.textScrollScenePosRect = {
		slot1[0],
		slot1[1],
		slot1[2],
		slot1[3]
	}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.isFinish = slot0.viewParam.isFinish
	slot0.elementCo = slot0.viewParam.elementCo
	slot0.puzzleId = tonumber(slot0.elementCo.param)
	slot0.puzzleConfig = lua_version_activity_puzzle_question.configDict[slot0.puzzleId]
	slot0._txtgamename.text = slot0.puzzleConfig.tittle

	if slot0.puzzleConfig == nil then
		logError(string.format("not found puzzleId : %s, elementId : %s", slot0.puzzleId, slot0.elementCo.id))
		slot0:closeThis()

		return
	end

	slot0.options, slot0.maxAnswerLenList = slot0:buildOptions(slot0.puzzleConfig.answer)
	slot0.halfAnsWerHeight = recthelper.getHeight(slot0._goadsorbrect.transform) * 0.5

	if slot0.isFinish then
		slot0:refreshFinishStatus()
	else
		slot0:refreshNormalStatus()
	end
end

function slot0.refreshFinishStatus(slot0)
	if slot0._gofinish:GetComponent(typeof(UnityEngine.Animator)) then
		slot1.enabled = false
	end

	gohelper.setActive(slot0._gofinish, true)

	slot0.showText = slot0:buildFinishText(slot0.puzzleConfig.text)

	slot0:onTextInfoChange()
	slot0:refreshOptions()
end

function slot0.refreshNormalStatus(slot0)
	slot0.showText = slot0:buildText(slot0.puzzleConfig.text)

	slot0:onTextInfoChange()
	slot0:refreshOptions()
	gohelper.setActive(slot0._goGuide, false)

	if PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.LeiMiTeBeiEnteredPuzzleViewKey), 0) == 0 then
		UIBlockMgr.instance:startBlock(slot0.viewName .. "PlayGuideAnimation")
		TaskDispatcher.runDelay(slot0.showGuide, slot0, 0.7)
	end
end

function slot0.showGuide(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName .. "PlayGuideAnimation")
	gohelper.setActive(slot0._goGuide, true)
	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.LeiMiTeBeiEnteredPuzzleViewKey), 1)

	slot0.guideBlock = gohelper.findChild(slot0.viewGO, "guide_activitypuzzle/guide_block")
	slot0.guideClick = gohelper.getClick(slot0.guideBlock)

	slot0.guideClick:AddClickListener(slot0.onClickGuideGo, slot0)

	slot0.guideAnswerAnchor = slot0:getFirstAnswerAnchorPos()

	recthelper.setWidth(slot0.rectTransformAnswer, slot0:getAnswerWidth(1))
	recthelper.setAnchor(slot0.rectTransformAnswer, slot0.guideAnswerAnchor.x, slot0.guideAnswerAnchor.y)

	slot0.optionAnchor = recthelper.screenPosToAnchorPos(slot0.optionItemList[slot0.firstAnswerIndex]:getScreenPos(), slot0.rectTransformOption.parent)

	recthelper.setAnchor(slot0.rectTransformOption, slot0.optionAnchor.x, slot0.optionAnchor.y)
	slot0.goGuideAnimator:Play(UIAnimationName.Open, 0, 0)
	TaskDispatcher.runDelay(slot0.playGuideAnimation, slot0, 1)
end

function slot0.playGuideAnimation(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)
	end

	recthelper.setAnchor(slot0.rectTransformFinger, slot0.optionAnchor.x + uv0.FingerOptionOffsetX, slot0.optionAnchor.y + uv0.FingerOptionOffsetY)

	slot0.tweenId = ZProj.TweenHelper.DOAnchorPos(slot0.rectTransformFinger, slot0.guideAnswerAnchor.x + uv0.FingerAnswerOffsetX, slot0.guideAnswerAnchor.y + uv0.FingerAnswerOffsetY, 1.667, slot0.playGuideAnimation, slot0)

	slot0.goGuideAnimator:Play(UIAnimationName.Loop, 0, 0)
end

function slot0.stopGuideAnimation(slot0)
	TaskDispatcher.cancelTask(slot0.playGuideAnimation, slot0)

	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)
	end

	slot0.goGuideAnimator.enabled = false
end

function slot0.onTextInfoChange(slot0)
	slot0._txtinfo.text = slot0.showText
end

function slot0.buildOptions(slot0, slot1)
	slot3 = nil
	slot4 = {}
	slot5 = {}
	slot9 = "|"

	for slot9, slot10 in ipairs(string.split(string.trim(slot1), slot9)) do
		slot2 = Mathf.Max(0, GameUtil.utf8len(string.split(slot10, "#")[2]))

		if slot9 % 4 == 0 then
			if slot2 % 2 ~= 0 then
				slot2 = slot2 + 1
			end

			table.insert(slot5, slot2 + 1)

			slot2 = 0
		end

		table.insert(slot4, slot3)
	end

	return slot4, slot5
end

function slot0.buildText(slot0, slot1)
	slot0.placeholderDict = {}

	for slot6 in string.gmatch(slot1, "{(%d+)}") do
		slot7 = tonumber(slot6)

		table.insert(slot0.needAnswerList, slot7)
		slot0:buildPlaceholder(slot7, 0 + 1)

		slot1 = string.gsub(slot1, "{(%d+)}", slot0:addUnderlineTag(string.format("<link=%s>%s</link>", "%1", slot0.placeholderDict[slot7])), 1)
	end

	slot0.firstAnswerIndex = slot0.needAnswerList[1]

	return slot1
end

function slot0.buildFinishText(slot0, slot1)
	for slot5 in string.gmatch(slot1, "{(%d+)}") do
		slot1 = string.gsub(slot1, "{(%d+)}", slot0:addUnderlineTag(string.format("<color=%s>%s</color>", VersionActivityEnum.PuzzleColorEnum.MatchCorrectColor, slot0.options[tonumber(slot5)])), 1)
	end

	return slot1
end

function slot0.addUnderlineTag(slot0, slot1)
	return string.format("<u>%s</u>", slot1)
end

function slot0.buildPlaceholder(slot0, slot1, slot2)
	if slot0.placeholderDict[slot1] then
		return
	end

	slot5 = string.rep(luaLang("lei_mi_te_bei_placeholder"), math.floor((slot0.maxAnswerLenList[slot2] - 1) / 2))
	slot0.placeholderDict[slot1] = slot5 .. string.format("<sprite name=\"num%s\">", slot2) .. slot5
end

function slot0.refreshOptions(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(slot0.options) do
		if not slot0.optionItemList[slot5] then
			table.insert(slot0.optionItemList, slot0:createOptionItem())
		end

		slot1:updateInfo(slot6, slot5)
	end

	for slot5 = #slot0.options + 1, #slot0.optionItemList do
		slot0.optionItemList[slot5]:hide()
	end

	slot0:refreshEmptyOptionItem()
end

function slot0.createOptionItem(slot0)
	slot1 = VersionActivityPuzzleOptionItem.New()

	slot1:onInitView(gohelper.cloneInPlace(slot0._gooptionitem), slot0)

	return slot1
end

function slot0.refreshEmptyOptionItem(slot0)
	if not slot0._emptyOption then
		slot0._emptyOption = slot0:getUserDataTb_()
	end

	slot2 = {
		6,
		7,
		12,
		13,
		18,
		19
	}

	for slot6 = 1, 6 do
		if #slot0._emptyOption < slot6 then
			table.insert(slot0._emptyOption, gohelper.cloneInPlace(slot0._goemptyoptionitem))
		end

		gohelper.setActive(slot0._emptyOption[slot6], true)

		slot0._emptyOption[slot6].name = "emptyitem_" .. slot6 .. "  " .. slot2[slot6]

		gohelper.setSibling(slot0._emptyOption[slot6], slot2[slot6])
	end
end

function slot0.onDragItemDragBegin(slot0, slot1, slot2, slot3)
	if slot0.complete or slot0.isFinish then
		return
	end

	gohelper.setActive(slot0.dragOptionItem.go, true)

	slot0.dragOptionItem.txtInfo.text = slot2
	slot0.draggingAnswerIndex = slot3

	slot0:changeDragItemAnchor(slot1)
	slot0:calculateLinksRectAnchor()
	slot0:resetAdsorbEffect()
end

function slot0.onDragItemDragging(slot0, slot1)
	if slot0.complete or slot0.isFinish then
		return
	end

	slot0:changeDragItemAnchor(slot1)
end

function slot0.onDragItemDragEnd(slot0, slot1)
	if slot0.complete or slot0.isFinish then
		return
	end

	TaskDispatcher.cancelTask(slot0.showEndEffect, slot0)
	slot0:changeDragItemAnchor(slot1)

	if slot0:getShowAdsorbRectAnswerIndex() > 0 then
		slot0.hoverAnswerIndex = slot2

		if not slot0.answerExistOptionItemDict[slot2] or slot3.answerIndex ~= slot0.draggingAnswerIndex then
			if slot3 then
				slot3:unUse()
			end

			slot0:resetGroupAnswerOption(slot0:getAnswerGroupIndex(slot0.draggingAnswerIndex))

			slot0.answerExistOptionItemDict[slot2] = slot0.optionItemList[slot0.draggingAnswerIndex]
			slot5 = slot0.options[slot0.draggingAnswerIndex]
			slot6 = nil

			if slot2 == slot0.draggingAnswerIndex then
				slot4:matchCorrect()

				slot6 = VersionActivityEnum.PuzzleColorEnum.MatchCorrectColor
			else
				slot4:matchError()

				slot6 = VersionActivityEnum.PuzzleColorEnum.MatchErrorColor
			end

			slot0.showText = string.gsub(slot0.showText, string.format("<link=%s>.-</link>", slot2), string.format("<link=%s>%s</link>", slot2, string.format("<color=%s>%s</color>", slot6, slot0:getAnswerText(slot5, slot2))))

			slot0:onTextInfoChange()
			slot0:checkComplete()
			TaskDispatcher.runDelay(slot0.showEndEffect, slot0, 0.1)
		end
	end

	gohelper.setActive(slot0.dragOptionItem.go, false)
end

function slot0.showEndEffect(slot0)
	if not slot0.hoverAnswerIndex or slot0.hoverAnswerIndex <= 0 then
		return
	end

	if slot0.hoverAnswerIndex == slot0.draggingAnswerIndex then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_decrypt_correct)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_decrypt_incorrect)
	end

	slot0:calculateLinksRectAnchor()

	slot2 = slot0.answerToAnchorPosDict[slot0.hoverAnswerIndex][1]

	recthelper.setAnchor(slot0._goadsorbrect.transform, slot2.x, slot2.y)
	gohelper.setActive(slot0._goadsorbrect, true)
	gohelper.setActive(slot0.goAdsorbSuccess, slot1)
	gohelper.setActive(slot0.goAdsorbFail, not slot1)
	TaskDispatcher.runDelay(slot0.hideAdsorb, slot0, 1)
end

function slot0.hideAdsorb(slot0)
	gohelper.setActive(slot0._goadsorbrect, false)
	slot0:resetAdsorbEffect()
end

function slot0.resetGroupAnswerOption(slot0, slot1)
	slot2 = (slot1 - 1) * 4 + 1
	slot3, slot4 = nil

	for slot8 = slot2, slot2 + 3 do
		if slot0:getBeUsedAnswerByOptionItem(slot0.optionItemList[slot8]) > 0 then
			slot3:unUse()

			slot0.showText = string.gsub(slot0.showText, string.format("<link=%s>.-</link>", slot4), string.format("<link=%s>%s</link>", slot4, slot0.placeholderDict[slot4]))
			slot0.answerExistOptionItemDict[slot4] = nil
		end
	end
end

function slot0.getBeUsedAnswerByOptionItem(slot0, slot1)
	for slot5, slot6 in pairs(slot0.answerExistOptionItemDict) do
		if slot6.answerIndex == slot1.answerIndex then
			return slot5
		end
	end

	return -1
end

function slot0.getAnswerText(slot0, slot1, slot2)
	if slot0.maxAnswerLenList[slot0:getAnswerGroupIndex(slot2)] - GameUtil.utf8len(slot1) <= 0 then
		return slot1
	end

	return string.format("%s%s%s", string.rep("<nbsp>", slot5), slot1, string.rep("<nbsp>", slot5))
end

function slot0.changeDragItemAnchor(slot0, slot1)
	slot2 = recthelper.screenPosToAnchorPos(slot1.position, slot0._simagebg.transform)
	slot4 = slot2.y
	slot3 = (slot2.x <= 0 or Mathf.Min(slot0.bgHalfWidth + 800, slot3)) and Mathf.Max(-slot0.bgHalfWidth, slot3)
	slot4 = (slot4 <= 0 or Mathf.Min(slot0.bgHalfHeight, slot4)) and Mathf.Max(-slot0.bgHalfHeight, slot4)
	slot0.dragOptionAnchor = Vector2.New(slot3, slot4)

	recthelper.setAnchor(slot0.dragOptionItem.transform, slot3, slot4)
end

function slot0.getDraggingOptionItemBeUsedAnswer(slot0)
	for slot4, slot5 in pairs(slot0.answerExistOptionItemDict) do
		if slot0.draggingAnswerIndex == slot5.answerIndex then
			return slot4
		end
	end

	return -1
end

function slot0.checkComplete(slot0)
	if slot0:isComplete() then
		slot0:onComplete()
	end
end

function slot0.isComplete(slot0)
	slot1 = nil

	for slot5, slot6 in pairs(slot0.needAnswerList) do
		if not slot0.answerExistOptionItemDict[slot6] or slot6 ~= slot1.answerIndex then
			return false
		end
	end

	return true
end

function slot0.onComplete(slot0)
	slot0.complete = true

	DungeonRpc.instance:sendPuzzleFinishRequest(slot0.elementCo.id)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(slot0._gofinish, true)
	GameFacade.showToast(ToastEnum.DungeonPuzzle2)
end

function slot0.onClickGuideGo(slot0)
	slot0:stopGuideAnimation()
	gohelper.setActive(slot0._goGuide, false)
	slot0.guideClick:RemoveClickListener()

	slot0.guideClick = nil
end

function slot0.calculateLinksRectAnchor(slot0)
	slot0.answerToAnchorPosDict = {}
	slot1 = slot0._txtinfo.transform
	slot2 = slot0._txtinfo:GetComponent(typeof(TMPro.TMP_Text))
	slot4 = slot2.textInfo.characterInfo
	slot5, slot6 = nil
	slot7 = slot2.textInfo.linkInfo:GetEnumerator()

	while slot7:MoveNext() do
		slot8 = slot7.Current
		slot10 = slot4[slot8.linkTextfirstCharacterIndex]

		if slot8.linkTextLength == 1 then
			slot0:addCenterPos(tonumber(slot8:GetLinkID()), slot1:TransformPoint(Vector3.New(slot10.bottomLeft.x, slot10.descender, 0)), slot1:TransformPoint(Vector3.New(slot10.topRight.x, slot10.ascender, 0)))
		elseif slot10.lineNumber == slot4[slot8.linkTextfirstCharacterIndex + slot8.linkTextLength - 1].lineNumber then
			slot0:addCenterPos(slot9, slot5, slot1:TransformPoint(Vector3.New(slot11.topRight.x, slot11.ascender, 0)))
		else
			slot16 = slot10.ascender
			slot6 = slot1:TransformPoint(Vector3.New(slot10.topRight.x, slot16, 0))

			for slot16 = 1, slot8.linkTextLength - 1 do
				if slot4[slot8.linkTextfirstCharacterIndex + slot16].lineNumber == slot10.lineNumber then
					slot6 = slot1:TransformPoint(Vector3.New(slot18.topRight.x, slot18.ascender, 0))
				else
					slot0:addCenterPos(slot9, slot5, slot6)

					slot12 = slot19
					slot5 = slot1:TransformPoint(Vector3.New(slot18.bottomLeft.x, slot18.descender, 0))
					slot6 = slot1:TransformPoint(Vector3.New(slot18.topRight.x, slot18.ascender, 0))
				end
			end

			slot0:addCenterPos(slot9, slot5, slot6)
		end
	end
end

function slot0.addCenterPos(slot0, slot1, slot2, slot3)
	if slot0:checkScenePosIsValid((slot2 + slot3) * 0.5) then
		if not slot0.answerToAnchorPosDict[slot1] then
			slot0.answerToAnchorPosDict[slot1] = {}
		end

		table.insert(slot0.answerToAnchorPosDict[slot1], recthelper.worldPosToAnchorPos(slot4, slot0._goadsorbrect.transform.parent, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUICamera()))
	end
end

function slot0.getFirstAnswerAnchorPos(slot0)
	slot1 = slot0._txtinfo.transform
	slot2 = slot0._txtinfo:GetComponent(typeof(TMPro.TMP_Text))
	slot4 = slot2.textInfo.characterInfo
	slot5, slot6, slot7 = nil
	slot8 = slot2.textInfo.linkInfo:GetEnumerator()

	while slot8:MoveNext() do
		slot9 = slot8.Current
		slot10 = slot4[slot9.linkTextfirstCharacterIndex]

		if slot9.linkTextLength == 1 then
			slot7 = slot0:getAnchorPos(slot1:TransformPoint(Vector3.New(slot10.bottomLeft.x, slot10.descender, 0)), slot1:TransformPoint(Vector3.New(slot10.topRight.x, slot10.ascender, 0)), slot0.goGuideAnimationContainer.transform)
		elseif slot10.lineNumber == slot4[slot9.linkTextfirstCharacterIndex + slot9.linkTextLength - 1].lineNumber then
			slot7 = slot0:getAnchorPos(slot5, slot1:TransformPoint(Vector3.New(slot11.topRight.x, slot11.ascender, 0)), slot0.goGuideAnimationContainer.transform)
		else
			slot16 = slot10.ascender
			slot6 = slot1:TransformPoint(Vector3.New(slot10.topRight.x, slot16, 0))

			for slot16 = 1, slot9.linkTextLength - 1 do
				if slot4[slot9.linkTextfirstCharacterIndex + slot16].lineNumber == slot10.lineNumber then
					slot6 = slot1:TransformPoint(Vector3.New(slot18.topRight.x, slot18.ascender, 0))
				else
					slot7 = slot0:getAnchorPos(slot5, slot6, slot0.goGuideAnimationContainer.transform)

					break
				end
			end
		end

		return slot7
	end

	return slot0.defaultAnchorPos
end

function slot0.getAnchorPos(slot0, slot1, slot2, slot3)
	if slot0:checkScenePosIsValid((slot1 + slot2) * 0.5) then
		return recthelper.worldPosToAnchorPos(slot4, slot3, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUICamera())
	end

	return slot0.defaultAnchorPos
end

function slot0.getShowAdsorbRectAnswerIndex(slot0)
	slot1 = 0
	slot2 = 99999

	for slot6, slot7 in pairs(slot0.answerToAnchorPosDict) do
		slot12 = slot6
		slot8 = slot0:getAnswerWidth(slot0:getAnswerGroupIndex(slot12)) / 2

		for slot12, slot13 in ipairs(slot7) do
			if slot0.dragOptionAnchor.x >= slot13.x - (slot8 + uv0.AbsorbOffsetX) and slot0.dragOptionAnchor.x <= slot13.x + slot8 + uv0.AbsorbOffsetX and slot0.dragOptionAnchor.y >= slot13.y - (slot0.halfAnsWerHeight + uv0.AbsorbOffsetY) and slot0.dragOptionAnchor.y <= slot13.y + slot0.halfAnsWerHeight + uv0.AbsorbOffsetY and Vector2.Distance(slot13, slot0.dragOptionAnchor) < slot2 then
				slot2 = slot14
				slot1 = slot6
			end
		end
	end

	return slot1
end

function slot0.checkScenePosIsValid(slot0, slot1)
	return GameUtil.checkPointInRectangle(slot1, slot0.textScrollScenePosRect[1], slot0.textScrollScenePosRect[2], slot0.textScrollScenePosRect[3], slot0.textScrollScenePosRect[4])
end

function slot0.getAnswerGroupIndex(slot0, slot1)
	return math.ceil(slot1 / 4)
end

function slot0.resetAdsorbEffect(slot0)
	gohelper.setActive(slot0.goAdsorbSuccess, false)
	gohelper.setActive(slot0.goAdsorbFail, false)
end

function slot0.getAnswerWidth(slot0, slot1)
	slot2 = slot0.maxAnswerLenList[slot1]

	return slot2 * slot0.oneCharacterWidth + slot0.intervalX * (slot2 - 1) + uv0.GuideBorder * 2
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	TaskDispatcher.cancelTask(slot0.showGuide, slot0)
	TaskDispatcher.cancelTask(slot0.hideAdsorb, slot0)
	TaskDispatcher.cancelTask(slot0.showEndEffect, slot0)
	slot0:stopGuideAnimation()

	if DungeonMapModel.instance:hasMapPuzzleStatus(slot0.elementCo.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, slot0.elementCo.id)
	end
end

function slot0.onDestroyView(slot0)
	slot0.closeViewClick:RemoveClickListener()

	if slot0.guideClick then
		slot0.guideClick:RemoveClickListener()
	end

	for slot4, slot5 in ipairs(slot0.optionItemList) do
		slot5:onDestroy()
	end
end

return slot0

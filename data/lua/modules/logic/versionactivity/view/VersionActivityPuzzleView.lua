module("modules.logic.versionactivity.view.VersionActivityPuzzleView", package.seeall)

local var_0_0 = class("VersionActivityPuzzleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goclose = gohelper.findChild(arg_1_0.viewGO, "#go_close")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#simage_bg/#txt_title")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "#simage_bg/Scroll View/Viewport/Content/#txt_info")
	arg_1_0._gooptions = gohelper.findChild(arg_1_0.viewGO, "#simage_bg/#go_options")
	arg_1_0._gooptionitem = gohelper.findChild(arg_1_0.viewGO, "#simage_bg/#go_options/#go_optionitem")
	arg_1_0._goemptyoptionitem = gohelper.findChild(arg_1_0.viewGO, "#simage_bg/#go_options/#go_empty")
	arg_1_0._godragoptionitem = gohelper.findChild(arg_1_0.viewGO, "#simage_bg/#go_dragoptionitem")
	arg_1_0._goadsorbrect = gohelper.findChild(arg_1_0.viewGO, "#simage_bg/#go_adsorbrect")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._txtgamename = gohelper.findChildText(arg_1_0.viewGO, "#simage_bg/#txt_gamename")
	arg_1_0._txttemp = gohelper.findChildText(arg_1_0.viewGO, "#txt_temp")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.GuideBorder = 10
var_0_0.FingerAnswerOffsetX = 77
var_0_0.FingerAnswerOffsetY = -160
var_0_0.FingerOptionOffsetX = 150
var_0_0.FingerOptionOffsetY = -250
var_0_0.AbsorbOffsetX = 20
var_0_0.AbsorbOffsetY = 10

function var_0_0.closeViewOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.initCharacterWidth(arg_5_0)
	arg_5_0._txttemp.text = luaLang("lei_mi_te_bei_placeholder")
	arg_5_0.oneCharacterWidth = arg_5_0._txttemp.preferredWidth
	arg_5_0._txttemp.text = string.rep(luaLang("lei_mi_te_bei_placeholder"), 2)
	arg_5_0.intervalX = arg_5_0._txttemp.preferredWidth - 2 * arg_5_0.oneCharacterWidth
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.defaultAnchorPos = Vector2(0, 0)

	arg_6_0:initCharacterWidth()

	arg_6_0._goGuide = gohelper.findChild(arg_6_0.viewGO, "guide_activitypuzzle")

	gohelper.setActive(arg_6_0._godragoptionitem, false)
	gohelper.setActive(arg_6_0._goadsorbrect, false)

	arg_6_0.goAdsorbSuccess = gohelper.findChild(arg_6_0.viewGO, "#simage_bg/#go_adsorbrect/success")
	arg_6_0.goAdsorbFail = gohelper.findChild(arg_6_0.viewGO, "#simage_bg/#go_adsorbrect/fail")

	arg_6_0:resetAdsorbEffect()

	arg_6_0.goGuideAnimationContainer = gohelper.findChild(arg_6_0.viewGO, "guide_activitypuzzle/guide1")
	arg_6_0.goGuideAnimator = arg_6_0.goGuideAnimationContainer:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0.goAnswerRect = gohelper.findChild(arg_6_0.viewGO, "guide_activitypuzzle/guide1/kuang1")
	arg_6_0.goOptionRect = gohelper.findChild(arg_6_0.viewGO, "guide_activitypuzzle/guide1/kuang2")
	arg_6_0.goFinger = gohelper.findChild(arg_6_0.viewGO, "guide_activitypuzzle/guide1/shouzhi")
	arg_6_0.rectTransformAnswer = arg_6_0.goAnswerRect.transform
	arg_6_0.rectTransformOption = arg_6_0.goOptionRect.transform
	arg_6_0.rectTransformFinger = arg_6_0.goFinger.transform

	arg_6_0:initDragOptionItem()
	arg_6_0:initTextScrollViewScenePosRect()
	gohelper.setActive(arg_6_0._gofinish, false)

	arg_6_0.bgHalfWidth = recthelper.getWidth(arg_6_0._simagebg.transform) / 2
	arg_6_0.bgHalfHeight = recthelper.getHeight(arg_6_0._simagebg.transform) / 2
	arg_6_0.closeViewClick = gohelper.getClick(arg_6_0._goclose)

	arg_6_0.closeViewClick:AddClickListener(arg_6_0.closeViewOnClick, arg_6_0)

	arg_6_0.optionItemList = {}
	arg_6_0.answerExistOptionItemDict = {}
	arg_6_0.needAnswerList = {}
	arg_6_0.answerMatched = false
end

function var_0_0.initDragOptionItem(arg_7_0)
	arg_7_0.dragOptionItem = arg_7_0:getUserDataTb_()
	arg_7_0.dragOptionItem.go = arg_7_0._godragoptionitem
	arg_7_0.dragOptionItem.txtInfo = gohelper.findChildText(arg_7_0.dragOptionItem.go, "info")
	arg_7_0.dragOptionItem.transform = arg_7_0.dragOptionItem.go.transform
end

function var_0_0.initTextScrollViewScenePosRect(arg_8_0)
	arg_8_0.goScroll = gohelper.findChild(arg_8_0.viewGO, "#simage_bg/Scroll View")

	local var_8_0 = arg_8_0.goScroll.transform:GetWorldCorners()
	local var_8_1 = var_8_0[0]
	local var_8_2 = var_8_0[1]
	local var_8_3 = var_8_0[2]
	local var_8_4 = var_8_0[3]

	arg_8_0.textScrollScenePosRect = {
		var_8_1,
		var_8_2,
		var_8_3,
		var_8_4
	}
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.isFinish = arg_10_0.viewParam.isFinish
	arg_10_0.elementCo = arg_10_0.viewParam.elementCo
	arg_10_0.puzzleId = tonumber(arg_10_0.elementCo.param)
	arg_10_0.puzzleConfig = lua_version_activity_puzzle_question.configDict[arg_10_0.puzzleId]
	arg_10_0._txtgamename.text = arg_10_0.puzzleConfig.tittle

	if arg_10_0.puzzleConfig == nil then
		logError(string.format("not found puzzleId : %s, elementId : %s", arg_10_0.puzzleId, arg_10_0.elementCo.id))
		arg_10_0:closeThis()

		return
	end

	arg_10_0.options, arg_10_0.maxAnswerLenList = arg_10_0:buildOptions(arg_10_0.puzzleConfig.answer)
	arg_10_0.halfAnsWerHeight = recthelper.getHeight(arg_10_0._goadsorbrect.transform) * 0.5

	if arg_10_0.isFinish then
		arg_10_0:refreshFinishStatus()
	else
		arg_10_0:refreshNormalStatus()
	end
end

function var_0_0.refreshFinishStatus(arg_11_0)
	local var_11_0 = arg_11_0._gofinish:GetComponent(typeof(UnityEngine.Animator))

	if var_11_0 then
		var_11_0.enabled = false
	end

	gohelper.setActive(arg_11_0._gofinish, true)

	arg_11_0.showText = arg_11_0:buildFinishText(arg_11_0.puzzleConfig.text)

	arg_11_0:onTextInfoChange()
	arg_11_0:refreshOptions()
end

function var_0_0.refreshNormalStatus(arg_12_0)
	arg_12_0.showText = arg_12_0:buildText(arg_12_0.puzzleConfig.text)

	arg_12_0:onTextInfoChange()
	arg_12_0:refreshOptions()

	local var_12_0 = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.LeiMiTeBeiEnteredPuzzleViewKey), 0) == 0

	gohelper.setActive(arg_12_0._goGuide, false)

	if var_12_0 then
		UIBlockMgr.instance:startBlock(arg_12_0.viewName .. "PlayGuideAnimation")
		TaskDispatcher.runDelay(arg_12_0.showGuide, arg_12_0, 0.7)
	end
end

function var_0_0.showGuide(arg_13_0)
	UIBlockMgr.instance:endBlock(arg_13_0.viewName .. "PlayGuideAnimation")
	gohelper.setActive(arg_13_0._goGuide, true)
	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.LeiMiTeBeiEnteredPuzzleViewKey), 1)

	arg_13_0.guideBlock = gohelper.findChild(arg_13_0.viewGO, "guide_activitypuzzle/guide_block")
	arg_13_0.guideClick = gohelper.getClick(arg_13_0.guideBlock)

	arg_13_0.guideClick:AddClickListener(arg_13_0.onClickGuideGo, arg_13_0)

	arg_13_0.guideAnswerAnchor = arg_13_0:getFirstAnswerAnchorPos()

	recthelper.setWidth(arg_13_0.rectTransformAnswer, arg_13_0:getAnswerWidth(1))
	recthelper.setAnchor(arg_13_0.rectTransformAnswer, arg_13_0.guideAnswerAnchor.x, arg_13_0.guideAnswerAnchor.y)

	local var_13_0 = arg_13_0.optionItemList[arg_13_0.firstAnswerIndex]:getScreenPos()

	arg_13_0.optionAnchor = recthelper.screenPosToAnchorPos(var_13_0, arg_13_0.rectTransformOption.parent)

	recthelper.setAnchor(arg_13_0.rectTransformOption, arg_13_0.optionAnchor.x, arg_13_0.optionAnchor.y)
	arg_13_0.goGuideAnimator:Play(UIAnimationName.Open, 0, 0)
	TaskDispatcher.runDelay(arg_13_0.playGuideAnimation, arg_13_0, 1)
end

function var_0_0.playGuideAnimation(arg_14_0)
	if arg_14_0.tweenId then
		ZProj.TweenHelper.KillById(arg_14_0.tweenId)
	end

	recthelper.setAnchor(arg_14_0.rectTransformFinger, arg_14_0.optionAnchor.x + var_0_0.FingerOptionOffsetX, arg_14_0.optionAnchor.y + var_0_0.FingerOptionOffsetY)

	arg_14_0.tweenId = ZProj.TweenHelper.DOAnchorPos(arg_14_0.rectTransformFinger, arg_14_0.guideAnswerAnchor.x + var_0_0.FingerAnswerOffsetX, arg_14_0.guideAnswerAnchor.y + var_0_0.FingerAnswerOffsetY, 1.667, arg_14_0.playGuideAnimation, arg_14_0)

	arg_14_0.goGuideAnimator:Play(UIAnimationName.Loop, 0, 0)
end

function var_0_0.stopGuideAnimation(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0.playGuideAnimation, arg_15_0)

	if arg_15_0.tweenId then
		ZProj.TweenHelper.KillById(arg_15_0.tweenId)
	end

	arg_15_0.goGuideAnimator.enabled = false
end

function var_0_0.onTextInfoChange(arg_16_0)
	arg_16_0._txtinfo.text = arg_16_0.showText
end

function var_0_0.buildOptions(arg_17_0, arg_17_1)
	arg_17_1 = string.trim(arg_17_1)

	local var_17_0 = 0
	local var_17_1
	local var_17_2 = {}
	local var_17_3 = {}

	for iter_17_0, iter_17_1 in ipairs(string.split(arg_17_1, "|")) do
		local var_17_4 = string.split(iter_17_1, "#")[2]

		var_17_0 = Mathf.Max(var_17_0, GameUtil.utf8len(var_17_4))

		if iter_17_0 % 4 == 0 then
			if var_17_0 % 2 ~= 0 then
				var_17_0 = var_17_0 + 1
			end

			var_17_0 = var_17_0 + 1

			table.insert(var_17_3, var_17_0)

			var_17_0 = 0
		end

		table.insert(var_17_2, var_17_4)
	end

	return var_17_2, var_17_3
end

function var_0_0.buildText(arg_18_0, arg_18_1)
	arg_18_0.placeholderDict = {}

	local var_18_0 = 0

	for iter_18_0 in string.gmatch(arg_18_1, "{(%d+)}") do
		local var_18_1 = tonumber(iter_18_0)

		table.insert(arg_18_0.needAnswerList, var_18_1)

		var_18_0 = var_18_0 + 1

		arg_18_0:buildPlaceholder(var_18_1, var_18_0)

		arg_18_1 = string.gsub(arg_18_1, "{(%d+)}", arg_18_0:addUnderlineTag(string.format("<link=%s>%s</link>", "%1", arg_18_0.placeholderDict[var_18_1])), 1)
	end

	arg_18_0.firstAnswerIndex = arg_18_0.needAnswerList[1]

	return arg_18_1
end

function var_0_0.buildFinishText(arg_19_0, arg_19_1)
	for iter_19_0 in string.gmatch(arg_19_1, "{(%d+)}") do
		iter_19_0 = tonumber(iter_19_0)
		arg_19_1 = string.gsub(arg_19_1, "{(%d+)}", arg_19_0:addUnderlineTag(string.format("<color=%s>%s</color>", VersionActivityEnum.PuzzleColorEnum.MatchCorrectColor, arg_19_0.options[iter_19_0])), 1)
	end

	return arg_19_1
end

function var_0_0.addUnderlineTag(arg_20_0, arg_20_1)
	return string.format("<u>%s</u>", arg_20_1)
end

function var_0_0.buildPlaceholder(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0.placeholderDict[arg_21_1] then
		return
	end

	local var_21_0 = arg_21_0.maxAnswerLenList[arg_21_2]
	local var_21_1 = math.floor((var_21_0 - 1) / 2)
	local var_21_2 = string.rep(luaLang("lei_mi_te_bei_placeholder"), var_21_1)
	local var_21_3 = var_21_2

	arg_21_0.placeholderDict[arg_21_1] = var_21_2 .. string.format("<sprite name=\"num%s\">", arg_21_2) .. var_21_3
end

function var_0_0.refreshOptions(arg_22_0)
	local var_22_0

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.options) do
		local var_22_1 = arg_22_0.optionItemList[iter_22_0]

		if not var_22_1 then
			var_22_1 = arg_22_0:createOptionItem()

			table.insert(arg_22_0.optionItemList, var_22_1)
		end

		var_22_1:updateInfo(iter_22_1, iter_22_0)
	end

	for iter_22_2 = #arg_22_0.options + 1, #arg_22_0.optionItemList do
		arg_22_0.optionItemList[iter_22_2]:hide()
	end

	arg_22_0:refreshEmptyOptionItem()
end

function var_0_0.createOptionItem(arg_23_0)
	local var_23_0 = VersionActivityPuzzleOptionItem.New()

	var_23_0:onInitView(gohelper.cloneInPlace(arg_23_0._gooptionitem), arg_23_0)

	return var_23_0
end

function var_0_0.refreshEmptyOptionItem(arg_24_0)
	if not arg_24_0._emptyOption then
		arg_24_0._emptyOption = arg_24_0:getUserDataTb_()
	end

	local var_24_0 = #arg_24_0._emptyOption
	local var_24_1 = {
		6,
		7,
		12,
		13,
		18,
		19
	}

	for iter_24_0 = 1, 6 do
		if var_24_0 < iter_24_0 then
			local var_24_2 = gohelper.cloneInPlace(arg_24_0._goemptyoptionitem)

			table.insert(arg_24_0._emptyOption, var_24_2)
		end

		gohelper.setActive(arg_24_0._emptyOption[iter_24_0], true)

		arg_24_0._emptyOption[iter_24_0].name = "emptyitem_" .. iter_24_0 .. "  " .. var_24_1[iter_24_0]

		gohelper.setSibling(arg_24_0._emptyOption[iter_24_0], var_24_1[iter_24_0])
	end
end

function var_0_0.onDragItemDragBegin(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_0.complete or arg_25_0.isFinish then
		return
	end

	gohelper.setActive(arg_25_0.dragOptionItem.go, true)

	arg_25_0.dragOptionItem.txtInfo.text = arg_25_2
	arg_25_0.draggingAnswerIndex = arg_25_3

	arg_25_0:changeDragItemAnchor(arg_25_1)
	arg_25_0:calculateLinksRectAnchor()
	arg_25_0:resetAdsorbEffect()
end

function var_0_0.onDragItemDragging(arg_26_0, arg_26_1)
	if arg_26_0.complete or arg_26_0.isFinish then
		return
	end

	arg_26_0:changeDragItemAnchor(arg_26_1)
end

function var_0_0.onDragItemDragEnd(arg_27_0, arg_27_1)
	if arg_27_0.complete or arg_27_0.isFinish then
		return
	end

	TaskDispatcher.cancelTask(arg_27_0.showEndEffect, arg_27_0)
	arg_27_0:changeDragItemAnchor(arg_27_1)

	local var_27_0 = arg_27_0:getShowAdsorbRectAnswerIndex()

	if var_27_0 > 0 then
		local var_27_1 = arg_27_0.answerExistOptionItemDict[var_27_0]

		arg_27_0.hoverAnswerIndex = var_27_0

		if not var_27_1 or var_27_1.answerIndex ~= arg_27_0.draggingAnswerIndex then
			if var_27_1 then
				var_27_1:unUse()
			end

			arg_27_0:resetGroupAnswerOption(arg_27_0:getAnswerGroupIndex(arg_27_0.draggingAnswerIndex))

			local var_27_2 = arg_27_0.optionItemList[arg_27_0.draggingAnswerIndex]

			arg_27_0.answerExistOptionItemDict[var_27_0] = var_27_2

			local var_27_3 = arg_27_0.options[arg_27_0.draggingAnswerIndex]
			local var_27_4

			if var_27_0 == arg_27_0.draggingAnswerIndex then
				var_27_2:matchCorrect()

				var_27_4 = VersionActivityEnum.PuzzleColorEnum.MatchCorrectColor
			else
				var_27_2:matchError()

				var_27_4 = VersionActivityEnum.PuzzleColorEnum.MatchErrorColor
			end

			local var_27_5 = string.format("<color=%s>%s</color>", var_27_4, arg_27_0:getAnswerText(var_27_3, var_27_0))

			arg_27_0.showText = string.gsub(arg_27_0.showText, string.format("<link=%s>.-</link>", var_27_0), string.format("<link=%s>%s</link>", var_27_0, var_27_5))

			arg_27_0:onTextInfoChange()
			arg_27_0:checkComplete()
			TaskDispatcher.runDelay(arg_27_0.showEndEffect, arg_27_0, 0.1)
		end
	end

	gohelper.setActive(arg_27_0.dragOptionItem.go, false)
end

function var_0_0.showEndEffect(arg_28_0)
	if not arg_28_0.hoverAnswerIndex or arg_28_0.hoverAnswerIndex <= 0 then
		return
	end

	local var_28_0 = arg_28_0.hoverAnswerIndex == arg_28_0.draggingAnswerIndex

	if var_28_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_decrypt_correct)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_decrypt_incorrect)
	end

	arg_28_0:calculateLinksRectAnchor()

	local var_28_1 = arg_28_0.answerToAnchorPosDict[arg_28_0.hoverAnswerIndex][1]

	recthelper.setAnchor(arg_28_0._goadsorbrect.transform, var_28_1.x, var_28_1.y)
	gohelper.setActive(arg_28_0._goadsorbrect, true)
	gohelper.setActive(arg_28_0.goAdsorbSuccess, var_28_0)
	gohelper.setActive(arg_28_0.goAdsorbFail, not var_28_0)
	TaskDispatcher.runDelay(arg_28_0.hideAdsorb, arg_28_0, 1)
end

function var_0_0.hideAdsorb(arg_29_0)
	gohelper.setActive(arg_29_0._goadsorbrect, false)
	arg_29_0:resetAdsorbEffect()
end

function var_0_0.resetGroupAnswerOption(arg_30_0, arg_30_1)
	local var_30_0 = (arg_30_1 - 1) * 4 + 1
	local var_30_1
	local var_30_2

	for iter_30_0 = var_30_0, var_30_0 + 3 do
		local var_30_3 = arg_30_0.optionItemList[iter_30_0]
		local var_30_4 = arg_30_0:getBeUsedAnswerByOptionItem(var_30_3)

		if var_30_4 > 0 then
			var_30_3:unUse()

			arg_30_0.showText = string.gsub(arg_30_0.showText, string.format("<link=%s>.-</link>", var_30_4), string.format("<link=%s>%s</link>", var_30_4, arg_30_0.placeholderDict[var_30_4]))
			arg_30_0.answerExistOptionItemDict[var_30_4] = nil
		end
	end
end

function var_0_0.getBeUsedAnswerByOptionItem(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.answerExistOptionItemDict) do
		if iter_31_1.answerIndex == arg_31_1.answerIndex then
			return iter_31_0
		end
	end

	return -1
end

function var_0_0.getAnswerText(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = GameUtil.utf8len(arg_32_1)
	local var_32_1 = arg_32_0.maxAnswerLenList[arg_32_0:getAnswerGroupIndex(arg_32_2)] - var_32_0

	if var_32_1 <= 0 then
		return arg_32_1
	end

	return string.format("%s%s%s", string.rep("<nbsp>", var_32_1), arg_32_1, string.rep("<nbsp>", var_32_1))
end

function var_0_0.changeDragItemAnchor(arg_33_0, arg_33_1)
	local var_33_0 = recthelper.screenPosToAnchorPos(arg_33_1.position, arg_33_0._simagebg.transform)
	local var_33_1 = var_33_0.x
	local var_33_2 = var_33_0.y

	if var_33_1 > 0 then
		var_33_1 = Mathf.Min(arg_33_0.bgHalfWidth + 800, var_33_1)
	else
		var_33_1 = Mathf.Max(-arg_33_0.bgHalfWidth, var_33_1)
	end

	if var_33_2 > 0 then
		var_33_2 = Mathf.Min(arg_33_0.bgHalfHeight, var_33_2)
	else
		var_33_2 = Mathf.Max(-arg_33_0.bgHalfHeight, var_33_2)
	end

	arg_33_0.dragOptionAnchor = Vector2.New(var_33_1, var_33_2)

	recthelper.setAnchor(arg_33_0.dragOptionItem.transform, var_33_1, var_33_2)
end

function var_0_0.getDraggingOptionItemBeUsedAnswer(arg_34_0)
	for iter_34_0, iter_34_1 in pairs(arg_34_0.answerExistOptionItemDict) do
		if arg_34_0.draggingAnswerIndex == iter_34_1.answerIndex then
			return iter_34_0
		end
	end

	return -1
end

function var_0_0.checkComplete(arg_35_0)
	if arg_35_0:isComplete() then
		arg_35_0:onComplete()
	end
end

function var_0_0.isComplete(arg_36_0)
	local var_36_0

	for iter_36_0, iter_36_1 in pairs(arg_36_0.needAnswerList) do
		local var_36_1 = arg_36_0.answerExistOptionItemDict[iter_36_1]

		if not var_36_1 or iter_36_1 ~= var_36_1.answerIndex then
			return false
		end
	end

	return true
end

function var_0_0.onComplete(arg_37_0)
	arg_37_0.complete = true

	DungeonRpc.instance:sendPuzzleFinishRequest(arg_37_0.elementCo.id)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(arg_37_0._gofinish, true)
	GameFacade.showToast(ToastEnum.DungeonPuzzle2)
end

function var_0_0.onClickGuideGo(arg_38_0)
	arg_38_0:stopGuideAnimation()
	gohelper.setActive(arg_38_0._goGuide, false)
	arg_38_0.guideClick:RemoveClickListener()

	arg_38_0.guideClick = nil
end

function var_0_0.calculateLinksRectAnchor(arg_39_0)
	arg_39_0.answerToAnchorPosDict = {}

	local var_39_0 = arg_39_0._txtinfo.transform
	local var_39_1 = arg_39_0._txtinfo:GetComponent(typeof(TMPro.TMP_Text))
	local var_39_2 = var_39_1.textInfo.linkInfo
	local var_39_3 = var_39_1.textInfo.characterInfo
	local var_39_4
	local var_39_5
	local var_39_6 = var_39_2:GetEnumerator()

	while var_39_6:MoveNext() do
		local var_39_7 = var_39_6.Current
		local var_39_8 = tonumber(var_39_7:GetLinkID())
		local var_39_9 = var_39_3[var_39_7.linkTextfirstCharacterIndex]
		local var_39_10 = var_39_0:TransformPoint(Vector3.New(var_39_9.bottomLeft.x, var_39_9.descender, 0))

		if var_39_7.linkTextLength == 1 then
			local var_39_11 = var_39_0:TransformPoint(Vector3.New(var_39_9.topRight.x, var_39_9.ascender, 0))

			arg_39_0:addCenterPos(var_39_8, var_39_10, var_39_11)
		else
			local var_39_12 = var_39_3[var_39_7.linkTextfirstCharacterIndex + var_39_7.linkTextLength - 1]

			if var_39_9.lineNumber == var_39_12.lineNumber then
				local var_39_13 = var_39_0:TransformPoint(Vector3.New(var_39_12.topRight.x, var_39_12.ascender, 0))

				arg_39_0:addCenterPos(var_39_8, var_39_10, var_39_13)
			else
				local var_39_14 = var_39_0:TransformPoint(Vector3.New(var_39_9.topRight.x, var_39_9.ascender, 0))
				local var_39_15 = var_39_9.lineNumber

				for iter_39_0 = 1, var_39_7.linkTextLength - 1 do
					local var_39_16 = var_39_3[var_39_7.linkTextfirstCharacterIndex + iter_39_0]
					local var_39_17 = var_39_16.lineNumber

					if var_39_17 == var_39_15 then
						var_39_14 = var_39_0:TransformPoint(Vector3.New(var_39_16.topRight.x, var_39_16.ascender, 0))
					else
						arg_39_0:addCenterPos(var_39_8, var_39_10, var_39_14)

						var_39_15 = var_39_17
						var_39_10 = var_39_0:TransformPoint(Vector3.New(var_39_16.bottomLeft.x, var_39_16.descender, 0))
						var_39_14 = var_39_0:TransformPoint(Vector3.New(var_39_16.topRight.x, var_39_16.ascender, 0))
					end
				end

				arg_39_0:addCenterPos(var_39_8, var_39_10, var_39_14)
			end
		end
	end
end

function var_0_0.addCenterPos(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = (arg_40_2 + arg_40_3) * 0.5

	if arg_40_0:checkScenePosIsValid(var_40_0) then
		if not arg_40_0.answerToAnchorPosDict[arg_40_1] then
			arg_40_0.answerToAnchorPosDict[arg_40_1] = {}
		end

		table.insert(arg_40_0.answerToAnchorPosDict[arg_40_1], recthelper.worldPosToAnchorPos(var_40_0, arg_40_0._goadsorbrect.transform.parent, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUICamera()))
	end
end

function var_0_0.getFirstAnswerAnchorPos(arg_41_0)
	local var_41_0 = arg_41_0._txtinfo.transform
	local var_41_1 = arg_41_0._txtinfo:GetComponent(typeof(TMPro.TMP_Text))
	local var_41_2 = var_41_1.textInfo.linkInfo
	local var_41_3 = var_41_1.textInfo.characterInfo
	local var_41_4
	local var_41_5
	local var_41_6
	local var_41_7 = var_41_2:GetEnumerator()

	while var_41_7:MoveNext() do
		local var_41_8 = var_41_7.Current
		local var_41_9 = var_41_3[var_41_8.linkTextfirstCharacterIndex]
		local var_41_10 = var_41_0:TransformPoint(Vector3.New(var_41_9.bottomLeft.x, var_41_9.descender, 0))

		if var_41_8.linkTextLength == 1 then
			local var_41_11 = var_41_0:TransformPoint(Vector3.New(var_41_9.topRight.x, var_41_9.ascender, 0))

			var_41_6 = arg_41_0:getAnchorPos(var_41_10, var_41_11, arg_41_0.goGuideAnimationContainer.transform)
		else
			local var_41_12 = var_41_3[var_41_8.linkTextfirstCharacterIndex + var_41_8.linkTextLength - 1]

			if var_41_9.lineNumber == var_41_12.lineNumber then
				local var_41_13 = var_41_0:TransformPoint(Vector3.New(var_41_12.topRight.x, var_41_12.ascender, 0))

				var_41_6 = arg_41_0:getAnchorPos(var_41_10, var_41_13, arg_41_0.goGuideAnimationContainer.transform)
			else
				local var_41_14 = var_41_0:TransformPoint(Vector3.New(var_41_9.topRight.x, var_41_9.ascender, 0))
				local var_41_15 = var_41_9.lineNumber

				for iter_41_0 = 1, var_41_8.linkTextLength - 1 do
					local var_41_16 = var_41_3[var_41_8.linkTextfirstCharacterIndex + iter_41_0]

					if var_41_16.lineNumber == var_41_15 then
						var_41_14 = var_41_0:TransformPoint(Vector3.New(var_41_16.topRight.x, var_41_16.ascender, 0))
					else
						var_41_6 = arg_41_0:getAnchorPos(var_41_10, var_41_14, arg_41_0.goGuideAnimationContainer.transform)

						break
					end
				end
			end
		end

		return var_41_6
	end

	return arg_41_0.defaultAnchorPos
end

function var_0_0.getAnchorPos(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = (arg_42_1 + arg_42_2) * 0.5

	if arg_42_0:checkScenePosIsValid(var_42_0) then
		return recthelper.worldPosToAnchorPos(var_42_0, arg_42_3, CameraMgr.instance:getUICamera(), CameraMgr.instance:getUICamera())
	end

	return arg_42_0.defaultAnchorPos
end

function var_0_0.getShowAdsorbRectAnswerIndex(arg_43_0)
	local var_43_0 = 0
	local var_43_1 = 99999

	for iter_43_0, iter_43_1 in pairs(arg_43_0.answerToAnchorPosDict) do
		local var_43_2 = arg_43_0:getAnswerWidth(arg_43_0:getAnswerGroupIndex(iter_43_0)) / 2

		for iter_43_2, iter_43_3 in ipairs(iter_43_1) do
			if arg_43_0.dragOptionAnchor.x >= iter_43_3.x - (var_43_2 + var_0_0.AbsorbOffsetX) and arg_43_0.dragOptionAnchor.x <= iter_43_3.x + (var_43_2 + var_0_0.AbsorbOffsetX) and arg_43_0.dragOptionAnchor.y >= iter_43_3.y - (arg_43_0.halfAnsWerHeight + var_0_0.AbsorbOffsetY) and arg_43_0.dragOptionAnchor.y <= iter_43_3.y + (arg_43_0.halfAnsWerHeight + var_0_0.AbsorbOffsetY) then
				local var_43_3 = Vector2.Distance(iter_43_3, arg_43_0.dragOptionAnchor)

				if var_43_3 < var_43_1 then
					var_43_1 = var_43_3
					var_43_0 = iter_43_0
				end
			end
		end
	end

	return var_43_0
end

function var_0_0.checkScenePosIsValid(arg_44_0, arg_44_1)
	return GameUtil.checkPointInRectangle(arg_44_1, arg_44_0.textScrollScenePosRect[1], arg_44_0.textScrollScenePosRect[2], arg_44_0.textScrollScenePosRect[3], arg_44_0.textScrollScenePosRect[4])
end

function var_0_0.getAnswerGroupIndex(arg_45_0, arg_45_1)
	return math.ceil(arg_45_1 / 4)
end

function var_0_0.resetAdsorbEffect(arg_46_0)
	gohelper.setActive(arg_46_0.goAdsorbSuccess, false)
	gohelper.setActive(arg_46_0.goAdsorbFail, false)
end

function var_0_0.getAnswerWidth(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0.maxAnswerLenList[arg_47_1]

	return var_47_0 * arg_47_0.oneCharacterWidth + arg_47_0.intervalX * (var_47_0 - 1) + var_0_0.GuideBorder * 2
end

function var_0_0.onClose(arg_48_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	TaskDispatcher.cancelTask(arg_48_0.showGuide, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0.hideAdsorb, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0.showEndEffect, arg_48_0)
	arg_48_0:stopGuideAnimation()

	if DungeonMapModel.instance:hasMapPuzzleStatus(arg_48_0.elementCo.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, arg_48_0.elementCo.id)
	end
end

function var_0_0.onDestroyView(arg_49_0)
	arg_49_0.closeViewClick:RemoveClickListener()

	if arg_49_0.guideClick then
		arg_49_0.guideClick:RemoveClickListener()
	end

	for iter_49_0, iter_49_1 in ipairs(arg_49_0.optionItemList) do
		iter_49_1:onDestroy()
	end
end

return var_0_0

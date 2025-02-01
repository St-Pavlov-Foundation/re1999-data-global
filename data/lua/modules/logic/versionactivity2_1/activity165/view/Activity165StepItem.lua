module("modules.logic.versionactivity2_1.activity165.view.Activity165StepItem", package.seeall)

slot0 = class("Activity165StepItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_left")
	slot0._txtstory = gohelper.findChildText(slot0.viewGO, "#go_left/scroll_story/Viewport/#txt_story")
	slot0._goright = gohelper.findChild(slot0.viewGO, "#go_right")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_right/icon/bg/#go_select")
	slot0._goadd = gohelper.findChild(slot0.viewGO, "#go_right/icon/#go_add")
	slot0._gocorrect = gohelper.findChild(slot0.viewGO, "#go_right/icon/#go_correct")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_right/icon/#image_icon")
	slot0._gopoint = gohelper.findChild(slot0.viewGO, "#go_right/icon/#go_point")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_right/icon/#btn_click")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "#go_right/indexbg/#txt_index")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
end

function slot0._btnclickOnClick(slot0)
	if slot0.isFixed then
		return
	end

	if (slot0._storyMo and slot0._storyMo:getState()) == Activity165Enum.StoryStage.Ending then
		return
	end

	Activity165Controller.instance:dispatchEvent(Activity165Event.onClickStepBtn, slot0._index)
end

function slot0._editableInitView(slot0)
	slot0._goindex = gohelper.findChild(slot0.viewGO, "#go_right/indexbg")
	slot0._goDecorate = gohelper.findChild(slot0.viewGO, "#go_left/img_tex")
	slot0._goTxt = gohelper.findChild(slot0.viewGO, "#go_left/scroll_story")
	slot0._scrollStory = gohelper.findChildScrollRect(slot0.viewGO, "#go_left/scroll_story")
	slot0._gobg = gohelper.findChild(slot0.viewGO, "#go_right/icon/bg")
	slot0._tex1 = gohelper.findChild(slot0.viewGO, "#go_left/img_tex/img_en1")
	slot0._tex2 = gohelper.findChild(slot0.viewGO, "#go_left/img_tex/img_en2")
	slot0._goeglocked = gohelper.findChild(slot0.viewGO, "#go_eglocked")
	slot0._goline = gohelper.findChild(slot0.viewGO, "line")
	slot0._anieglocked = SLFramework.AnimatorPlayer.Get(slot0._goeglocked.gameObject)
	slot0._aniTex = SLFramework.AnimatorPlayer.Get(slot0._goDecorate.gameObject)
	slot0._aniView = SLFramework.AnimatorPlayer.Get(slot0.viewGO.gameObject)
	slot0._keywordPointList = slot0:getUserDataTb_()
	slot0._typeMarkItemList = slot0:getUserDataTb_()
	slot0._markItemList = slot0:getUserDataTb_()
	slot0._goMarkPrefabs = slot0:getUserDataTb_()

	for slot5 = 1, 4 do
		slot0._goMarkPrefabs[slot5] = gohelper.findChild(gohelper.findChild(slot0.viewGO, "#go_left/scroll_story/Viewport/#txt_story/go_mark"), "mark_" .. slot5)

		gohelper.setActive(slot0._goMarkPrefabs[slot5], false)

		slot0._typeMarkItemList[slot5] = slot0:getUserDataTb_()
	end

	for slot5 = 1, slot0._gopoint.transform.childCount do
		slot6 = gohelper.findChild(slot0._gopoint, slot5)

		for slot10 = 1, slot5 do
			slot11 = gohelper.findChildImage(slot6, slot10)

			if not slot0._keywordPointList[slot5] then
				slot0._keywordPointList[slot5] = slot0:getUserDataTb_()
				slot0._keywordPointList[slot5].go = slot6
				slot0._keywordPointList[slot5].ponit = slot0:getUserDataTb_()
			end

			slot12 = slot0:getUserDataTb_()
			slot12.go = slot11.gameObject
			slot12.icon = slot11
			slot12.canvasgroup = slot11.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))

			table.insert(slot0._keywordPointList[slot5].ponit, slot12)
		end
	end

	slot0._txtstory.text = ""
	slot0._keywordMaxCount = tabletool.len(slot0._keywordPointList)
	slot0._keywordItem = slot0:getUserDataTb_()
	slot0._keywordIdList = {}
	slot0._bogusId = nil
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
end

function slot0.onInitItem(slot0, slot1, slot2)
	slot0._index = slot2
	slot0._storyMo = slot1
	slot0._actId = slot1._actId

	if slot0._index == 3 then
		transformhelper.setLocalPosXY(slot0._goeglocked.transform, 763, 850)
	end

	slot0:activeStep(false)
end

function slot0.onRefreshMo(slot0, slot1)
	slot0._stepMo = slot1 and slot0._storyMo:getStepMo(slot1)
	slot0._keywordIdList = slot0._storyMo:getKwIdsByStepIndex(slot0._index) or {}
	slot0._isUnlock = slot0._index - slot0._storyMo:getUnlockStepIdRemoveEndingCount() <= 0

	if slot0._storyMo:getState() == Activity165Enum.StoryStage.Filling then
		slot0._isCurStep = slot5 == 1
	else
		slot0._isCurStep = false
	end

	slot0.isFixed = slot0._isUnlock and not LuaUtil.tableNotEmpty(slot0._keywordIdList)

	if slot0._stepMo and slot0._isUnlock and slot0.isFixed and not string.nilorempty(slot0._stepMo.stepCo.pic) then
		UISpriteSetMgr.instance:setV2a1Act165Sprite(slot0._imageicon, slot6, true)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0:killTween()

	slot0._stepId = slot1

	slot0:onRefreshMo(slot1)
	slot0:refreshIndex(slot0._index)
	gohelper.setActive(slot0._gocorrect.gameObject, slot0._isUnlock)

	if slot0._isCurStep then
		slot0:showEgLock()
	else
		slot0:_hideEglocked()
	end

	if not slot0._isUnlock and not slot0._isCurStep then
		slot0:activeStep(false)

		return
	end

	slot0:activeStep(true)

	if slot0._isUnlock then
		slot0:showStoryTxt()
	end

	slot0:refreshState()
	gohelper.setActive(slot0._goTxt.gameObject, slot0._isUnlock)
	slot0:showDecorateTexture()
	slot0:setKeywordItem()
end

function slot0.showEgLock(slot0, slot1)
	gohelper.setActive(slot0._goeglocked.gameObject, true)
	slot0._anieglocked:Play(Activity165Enum.EditViewAnim.Idle, slot1, slot0)
end

function slot0.unlockEgLock(slot0)
	if not slot0.isFixed and LuaUtil.tableNotEmpty(slot0._keywordIdList) then
		gohelper.setActive(slot0._goeglocked.gameObject, true)
		slot0._anieglocked:Play(Activity165Enum.EditViewAnim.Unlock, slot0._hideEglocked, slot0)
	else
		slot0:_hideEglocked()
	end
end

function slot0._hideEglocked(slot0)
	gohelper.setActive(slot0._goeglocked.gameObject, false)
end

function slot0.showDecorateTexture(slot0, slot1)
	slot2 = not slot0._isUnlock and slot0:getFillKwCount() >= 1

	gohelper.setActive(slot0._goDecorate.gameObject, slot2)

	if slot2 then
		slot0._aniTex:Play(Activity165Enum.EditViewAnim.Idle, slot1, slot0)
	end
end

function slot0.unlockDecorateTexture(slot0, slot1)
	gohelper.setActive(slot0._goDecorate.gameObject, true)
	slot0._aniTex:Play(Activity165Enum.EditViewAnim.Unlock, slot1, slot0)
end

function slot0.playDecorateTexture(slot0, slot1)
	gohelper.setActive(slot0._goDecorate.gameObject, true)
	slot0._aniTex:Play(Activity165Enum.EditViewAnim.Unlock, slot1, slot0)
end

function slot0.hideyDecorateTexture(slot0)
	gohelper.setActive(slot0._goDecorate.gameObject, false)
end

function slot0.onFinishStep(slot0, slot1)
	slot0._isUnlock = true

	slot0:beginShowTxt(slot1)
	slot0:unlockEgLock()
	gohelper.setActive(slot0._gocorrect.gameObject, true)
end

function slot0.activeStep(slot0, slot1)
	gohelper.setActive(slot0._goleft.gameObject, slot1)
	gohelper.setActive(slot0._goright.gameObject, slot1)
	gohelper.setActive(slot0._goline.gameObject, slot1)

	if not slot0._goleft.gameObject.activeSelf and slot1 then
		slot0._aniView:Play(Activity165Enum.EditViewAnim.EgOpen, nil, slot0)
	end
end

function slot0.refreshIndex(slot0, slot1)
	slot0._txtindex.text = slot1 > 10 and slot1 or "0" .. slot1
	slot2 = Activity165Enum.StepOffsetObj[slot1 % 2 + 1]

	recthelper.setWidth(slot0._goTxt.transform, slot0.isFixed and 480 or 530)

	slot0._scrollTxtHeight = slot0._goTxt.transform.rect.height

	transformhelper.setLocalPosXY(slot0._goleft.transform, slot2.goleft.PosX, slot2.goleft.PosY)
	transformhelper.setLocalPosXY(slot0._goright.transform, slot2.goright.PosX, slot2.goright.PosY)
	transformhelper.setLocalPosXY(slot0._goindex.transform, slot2.goindex.PosX, slot2.goindex.PosY)
	transformhelper.setLocalPosXY(slot0._goTxt.transform, slot0.isFixed and slot2.gotxt.PosX + (slot1 % 2 == 0 and -15 or 15) or slot2.gotxt.PosX, slot2.gotxt.PosY)
	gohelper.setActive(slot0._tex1, slot1 % 2 == 0)
	gohelper.setActive(slot0._tex2, slot1 % 2 == 1)
end

function slot0.onDestroy(slot0)
	slot0:killTween()
end

function slot0.refreshState(slot0)
	if not slot0.isFixed then
		gohelper.setActive(slot0._goadd.gameObject, not slot0._isUnlock and slot0:isNullKeyword() and not slot0._bogusId)
		slot0:refreshFillStepState()
	end

	gohelper.setActive(slot0._gobg, not slot0.isFixed)
	gohelper.setActive(slot0._imageicon.gameObject, slot0.isFixed)
end

function slot0.setBogusKeyword(slot0, slot1)
	if slot0._bogusId or not slot0:tryFillKeyword() then
		return
	end

	slot0._bogusId = slot1

	slot0:setKeywordItem()
end

function slot0.cancelBogusKeyword(slot0)
	slot0._bogusId = nil
end

function slot0.refreshBogusKeyword(slot0)
	if slot0._bogusId then
		slot0._bogusId = nil

		slot0:setKeywordItem()
	end
end

function slot0.refreshFillStepState(slot0)
	slot1 = slot0._storyMo and slot0._storyMo:getSelectStepIndex()

	gohelper.setActive(slot0._goselect.gameObject, slot1 and slot1 == slot0._index or false)
end

function slot0.tryFillKeyword(slot0, slot1)
	if slot0:isFullKeyword() then
		return false
	end

	if LuaUtil.tableContains(slot0._keywordIdList, slot1) then
		return false
	end

	return true
end

function slot0.getFillKwCount(slot0)
	return tabletool.len(slot0._keywordIdList)
end

function slot0.fillKeyword(slot0, slot1)
	slot0:addKeywordItem(slot1)

	if slot0:getFillKwCount() == 1 then
		slot0:unlockDecorateTexture()
	end
end

function slot0.failFillKeyword(slot0, slot1)
	slot0:removeKeywordItem(slot1)
end

function slot0.addKeywordItem(slot0, slot1)
	if not LuaUtil.tableContains(slot0._keywordIdList, slot1) then
		table.insert(slot0._keywordIdList, slot1)
	end

	slot0:setKeywordItem()
end

function slot0.removeKeywordItem(slot0, slot1)
	if LuaUtil.tableContains(slot0._keywordIdList, slot1) then
		tabletool.removeValue(slot0._keywordIdList, slot1)
		slot0:showDecorateTexture()
	end

	slot0:setKeywordItem()
end

function slot0.clearStep(slot0)
	slot0._keywordIdList = {}

	for slot4, slot5 in pairs(slot0._keywordPointList) do
		gohelper.setActive(slot5.go, false)
	end

	slot0.isFixed = false

	slot0:_hideAllMark()
	slot0:onUpdateMO()
	gohelper.setActive(slot0._goTxt.gameObject, false)
	slot0:showDecorateTexture()
end

function slot0.setKeywordItem(slot0)
	if slot0._bogusId then
		slot1 = slot0:getFillKwCount() + 1
	end

	if slot1 > 0 and slot1 <= slot0._keywordMaxCount then
		slot2 = 1

		if LuaUtil.tableNotEmpty(slot0._keywordIdList) then
			for slot6, slot7 in pairs(slot0._keywordIdList) do
				slot8 = slot0._keywordPointList[slot1].ponit[slot2]

				if not string.nilorempty(Activity165Config.instance:getKeywordCo(slot0._actId, slot7).pic) then
					UISpriteSetMgr.instance:setV2a1Act165Sprite(slot8.icon, slot10)
				end

				if slot8.canvasgroup then
					slot8.canvasgroup.alpha = 1
				end

				slot2 = slot2 + 1
			end
		end

		if slot0._bogusId then
			slot3 = slot0._keywordPointList[slot1].ponit[slot2]

			if not string.nilorempty(Activity165Config.instance:getKeywordCo(slot0._actId, slot0._bogusId).pic) then
				UISpriteSetMgr.instance:setV2a1Act165Sprite(slot3.icon, slot5)
			end

			if slot3.canvasgroup then
				slot3.canvasgroup.alpha = 0.5
			end
		end
	end

	for slot5, slot6 in pairs(slot0._keywordPointList) do
		gohelper.setActive(slot6.go, slot1 == slot5)
	end

	slot0:refreshState()
end

function slot0.getKeywordItem(slot0, slot1)
	if not slot0._keywordItem[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._gokeyword, "kw_" .. slot1)
		slot0._keywordItem[slot1] = {
			go = slot3,
			icon = gohelper.findChildImage(slot3, "#image_keyword"),
			anim = SLFramework.AnimatorPlayer.Get(slot3.gameObject)
		}
	end

	return slot2
end

function slot0.getKeywordList(slot0)
	return slot0._keywordIdList
end

function slot0.isKeyword(slot0, slot1)
	return LuaUtil.tableContains(slot0._keywordIdList, slot1)
end

function slot0.isNullKeyword(slot0)
	return not LuaUtil.tableNotEmpty(slot0._keywordIdList)
end

function slot0.isFullKeyword(slot0)
	if slot0._keywordMaxCount <= slot0:getFillKwCount() then
		GameFacade.showToast(ToastEnum.Act165StepMaxCount, slot0._keywordMaxCount)
		AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_fill_fail)
	end

	return slot1
end

function slot0.beginShowTxt(slot0, slot1)
	if not LuaUtil.tableNotEmpty(slot0._stepMo) then
		slot0._stepMo = slot0._storyMo:getStepMo(slot1)
	end

	slot0:_setStepText()

	slot0._markItemPos = {}

	slot0:_setMarkItemPos()

	slot0._txtstory.text = ""
	slot0._finsihShowTxt = nil
	slot0._scrollHeight = recthelper.getHeight(slot0._scrollStory.transform)
	slot0._tweenTime = 0
	slot0._separateChars = Activity165Model.instance:setSeparateChars(slot0._reallyTxt)

	gohelper.setActive(slot0._goTxt.gameObject, false)
	slot0:playDecorateTexture(slot0.beginShowTxtCallback)
end

function slot0.beginShowTxtCallback(slot0)
	slot1 = #slot0._separateChars
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, slot1, slot1 * 0.033, slot0._onTweenFrameCallback, slot0._onTweenFinishCallback, slot0, nil, EaseType.Linear)

	gohelper.setActive(slot0._goTxt.gameObject, true)
	slot0:hideyDecorateTexture()
end

function slot0._onTweenFrameCallback(slot0, slot1)
	if slot0._finsihShowTxt or slot1 - slot0._tweenTime < 1 then
		return
	end

	if slot1 <= #slot0._separateChars then
		slot0._txtstory.text = slot0._separateChars[math.floor(slot1)]

		if slot0._scrollStory.verticalNormalizedPosition ~= 0 then
			slot0._scrollStory.verticalNormalizedPosition = 0
		end
	else
		slot0._txtstory.text = slot0._reallyTxt
	end

	slot0._tweenTime = slot1
end

function slot0._onTweenFinishCallback(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	recthelper.setHeight(slot0._txtstory.transform, slot0._txtstory:GetPreferredValues().y)
	slot0:_showStoryTxt()
	slot0:_markNote()
	slot0:_playMarkItemAnim()
end

function slot0.isPlayingTxt(slot0)
	return slot0._tweenId ~= nil
end

function slot0._setStepText(slot0)
	if not slot0._stepMo then
		return
	end

	slot0:_setReallyStepText(slot0._stepMo.stepCo.text, "<%d-:.->", "<%d-:(.-)>")
end

function slot0._setReallyStepText(slot0, slot1, slot2, slot3)
	slot0._reallyTxt, slot5 = slot0:_matchData(slot1, slot2, slot3)

	if not slot5 then
		return
	end

	slot0:_getReallyStepText(slot4, slot2, slot3)
end

function slot0._showStoryTxt(slot0)
	if string.nilorempty(slot0._reallyTxt) then
		slot0:_setStepText()
	end

	slot0._txtstory.text = slot0._reallyTxt

	recthelper.setHeight(slot0._txtstory.transform, slot0._txtstory:GetPreferredValues().y)
end

function slot0.finishStoryAnim(slot0)
	slot0:showStoryTxt()
	slot0:_hideEglocked()
	Activity165Controller.instance:dispatchEvent(Activity165Event.finishStepAnim, slot0._index)
end

function slot0.showStoryTxt(slot0)
	slot0:killTween()
	slot0:_showStoryTxt()
	slot0:_markNote()

	slot0._finsihShowTxt = true

	for slot4, slot5 in pairs(slot0._markItemList) do
		gohelper.setActive(slot5.go, true)
	end
end

function slot0._markNote(slot0)
	if not slot0._stepMo then
		return
	end

	slot0._markItemPos = {}

	slot0:_matchData(slot0._stepMo.stepCo.text, "<%d-:.->", "<%d-:(.-)>", nil, slot0._markData)
	slot0:_setMarkItemPos()

	slot0._curShowMarkIndex = 1
end

function slot0._matchData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7 = string.find(slot1, slot2)

	if not slot6 then
		return slot1, slot6, slot4
	end

	if not tonumber(string.match(slot1, "<(%d-):.->")) then
		return
	end

	slot1 = string.gsub(slot1, slot3, function (slot0)
		uv0 = slot0

		return slot0
	end, 1)

	if slot5 then
		slot5(slot0, slot1, slot6, slot8, "")
	end

	return slot0:_matchData(slot1, slot2, slot3, slot8, slot5)
end

function slot0._markData(slot0, slot1, slot2, slot3, slot4)
	slot6 = slot0._txtstory:GetTextInfo(slot1)
	slot7 = GameUtil.utf8len(string.sub(slot1, 1, slot2 - 1))
	slot14 = slot0._txtstory.transform.rect.width
	slot15 = slot0:parseMark(slot3, 4)

	if math.floor(math.abs(slot6.characterInfo[GameUtil.utf8len(slot4) + slot7 - 1].bottomRight.y - slot6.characterInfo[slot7].bottomLeft.y) / slot0._txtstory.fontSize) > 0 then
		for slot20 = 1, slot16 + 1 do
			if slot20 == 1 then
				table.insert(slot0._markItemPos, {
					types = slot15,
					posX = slot11.x,
					posY = slot11.y,
					width = slot14 - slot11.x,
					fillContent = slot4
				})
			elseif slot20 == slot16 + 1 then
				table.insert(slot0._markItemPos, {
					types = slot15,
					posX = 0,
					posY = slot12.y,
					width = slot12.x,
					fillContent = slot4
				})
			else
				table.insert(slot0._markItemPos, {
					types = slot15,
					posX = 0,
					posY = slot11.y - slot13 * slot20,
					width = slot14,
					fillContent = slot4
				})
			end
		end
	else
		table.insert(slot0._markItemPos, {
			types = slot15,
			posX = slot11.x,
			posY = slot11.y,
			width = slot12.x - slot11.x,
			fillContent = slot4
		})
	end
end

function slot0.getMarkItemByType(slot0, slot1, slot2)
	if not slot0._typeMarkItemList[slot1][slot2] then
		slot4 = gohelper.cloneInPlace(slot0._goMarkPrefabs[slot1])
		slot3 = slot0:getUserDataTb_()
		slot3.go = slot4
		slot3.icon = gohelper.findChildImage(slot4, "mark")
		slot3.anim = SLFramework.AnimatorPlayer.Get(slot4.gameObject)
		slot0._typeMarkItemList[slot1][slot2] = slot3

		gohelper.setActive(slot3.go, false)
	end

	return slot3
end

function slot0._setMarkItemPos(slot0)
	slot0._markItemList = {}
	slot2 = slot0._txtstory:GetPreferredValues().y

	for slot6, slot7 in pairs(slot0._markItemPos) do
		for slot11, slot12 in pairs(slot7.types) do
			slot13 = slot0:getMarkItemByType(slot12, slot6)
			slot13.go.name = slot7.fillContent .. "_" .. slot12 .. "_" .. slot11 .. "_" .. slot6

			table.insert(slot0._markItemList, slot13)

			slot14 = slot7.posY

			if slot2 < slot0._scrollTxtHeight then
				slot14 = slot7.posY - (slot0._scrollTxtHeight - slot2) * 0.5
			end

			recthelper.setAnchor(slot13.go.transform, slot7.posX, slot14)
			recthelper.setWidth(slot13.icon.transform, math.max(slot7.width, slot0._goMarkPrefabs[slot12] and slot0._goMarkPrefabs[slot12].transform.rect.width or 100))
		end
	end
end

function slot0._playMarkItemAnim(slot0)
	if slot0._curShowMarkIndex > #slot0._markItemList then
		return slot0:finishStoryAnim()
	end

	if not slot0._markItemList[slot0._curShowMarkIndex] or not slot1.go then
		return slot0:finishStoryAnim()
	end

	gohelper.setActive(slot1.go, true)

	slot0._curShowMarkIndex = slot0._curShowMarkIndex + 1

	slot1.anim:Play(Activity165Enum.EditViewAnim.Open, slot0._playMarkItemAnim, slot0)
end

function slot0.parseMark(slot0, slot1, slot2)
	slot3 = {}
	slot4 = slot1

	for slot8 = slot2, 1, -1 do
		if slot4 >= 2^slot8 then
			table.insert(slot3, slot8)

			if slot4 - slot9 == 0 then
				break
			end
		end
	end

	return slot3
end

function slot0._hideAllMark(slot0)
	for slot4, slot5 in pairs(slot0._markItemList) do
		gohelper.setActive(slot5.go, false)
	end

	slot0._markItemList = {}
end

function slot0.killTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot0._markTweenId then
		ZProj.TweenHelper.KillById(slot0._markTweenId)

		slot0._markTweenId = nil
	end

	TaskDispatcher.cancelTask(slot0._playMarkItemAnim, slot0)
end

return slot0

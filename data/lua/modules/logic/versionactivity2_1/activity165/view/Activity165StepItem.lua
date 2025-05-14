module("modules.logic.versionactivity2_1.activity165.view.Activity165StepItem", package.seeall)

local var_0_0 = class("Activity165StepItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_left")
	arg_1_0._txtstory = gohelper.findChildText(arg_1_0.viewGO, "#go_left/scroll_story/Viewport/#txt_story")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "#go_right")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_right/icon/bg/#go_select")
	arg_1_0._goadd = gohelper.findChild(arg_1_0.viewGO, "#go_right/icon/#go_add")
	arg_1_0._gocorrect = gohelper.findChild(arg_1_0.viewGO, "#go_right/icon/#go_correct")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_right/icon/#image_icon")
	arg_1_0._gopoint = gohelper.findChild(arg_1_0.viewGO, "#go_right/icon/#go_point")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_right/icon/#btn_click")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "#go_right/indexbg/#txt_index")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addEvents()
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0:removeEvents()
end

function var_0_0._btnclickOnClick(arg_6_0)
	if arg_6_0.isFixed then
		return
	end

	if (arg_6_0._storyMo and arg_6_0._storyMo:getState()) == Activity165Enum.StoryStage.Ending then
		return
	end

	Activity165Controller.instance:dispatchEvent(Activity165Event.onClickStepBtn, arg_6_0._index)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._goindex = gohelper.findChild(arg_7_0.viewGO, "#go_right/indexbg")
	arg_7_0._goDecorate = gohelper.findChild(arg_7_0.viewGO, "#go_left/img_tex")
	arg_7_0._goTxt = gohelper.findChild(arg_7_0.viewGO, "#go_left/scroll_story")
	arg_7_0._scrollStory = gohelper.findChildScrollRect(arg_7_0.viewGO, "#go_left/scroll_story")
	arg_7_0._gobg = gohelper.findChild(arg_7_0.viewGO, "#go_right/icon/bg")
	arg_7_0._tex1 = gohelper.findChild(arg_7_0.viewGO, "#go_left/img_tex/img_en1")
	arg_7_0._tex2 = gohelper.findChild(arg_7_0.viewGO, "#go_left/img_tex/img_en2")
	arg_7_0._goeglocked = gohelper.findChild(arg_7_0.viewGO, "#go_eglocked")
	arg_7_0._goline = gohelper.findChild(arg_7_0.viewGO, "line")
	arg_7_0._anieglocked = SLFramework.AnimatorPlayer.Get(arg_7_0._goeglocked.gameObject)
	arg_7_0._aniTex = SLFramework.AnimatorPlayer.Get(arg_7_0._goDecorate.gameObject)
	arg_7_0._aniView = SLFramework.AnimatorPlayer.Get(arg_7_0.viewGO.gameObject)
	arg_7_0._keywordPointList = arg_7_0:getUserDataTb_()
	arg_7_0._typeMarkItemList = arg_7_0:getUserDataTb_()
	arg_7_0._markItemList = arg_7_0:getUserDataTb_()

	local var_7_0 = gohelper.findChild(arg_7_0.viewGO, "#go_left/scroll_story/Viewport/#txt_story/go_mark")

	arg_7_0._goMarkPrefabs = arg_7_0:getUserDataTb_()

	for iter_7_0 = 1, 4 do
		arg_7_0._goMarkPrefabs[iter_7_0] = gohelper.findChild(var_7_0, "mark_" .. iter_7_0)

		gohelper.setActive(arg_7_0._goMarkPrefabs[iter_7_0], false)

		arg_7_0._typeMarkItemList[iter_7_0] = arg_7_0:getUserDataTb_()
	end

	for iter_7_1 = 1, arg_7_0._gopoint.transform.childCount do
		local var_7_1 = gohelper.findChild(arg_7_0._gopoint, iter_7_1)

		for iter_7_2 = 1, iter_7_1 do
			local var_7_2 = gohelper.findChildImage(var_7_1, iter_7_2)

			if not arg_7_0._keywordPointList[iter_7_1] then
				arg_7_0._keywordPointList[iter_7_1] = arg_7_0:getUserDataTb_()
				arg_7_0._keywordPointList[iter_7_1].go = var_7_1
				arg_7_0._keywordPointList[iter_7_1].ponit = arg_7_0:getUserDataTb_()
			end

			local var_7_3 = arg_7_0:getUserDataTb_()

			var_7_3.go = var_7_2.gameObject
			var_7_3.icon = var_7_2
			var_7_3.canvasgroup = var_7_2.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))

			table.insert(arg_7_0._keywordPointList[iter_7_1].ponit, var_7_3)
		end
	end

	arg_7_0._txtstory.text = ""
	arg_7_0._keywordMaxCount = tabletool.len(arg_7_0._keywordPointList)
	arg_7_0._keywordItem = arg_7_0:getUserDataTb_()
	arg_7_0._keywordIdList = {}
	arg_7_0._bogusId = nil
end

function var_0_0.init(arg_8_0, arg_8_1)
	arg_8_0.viewGO = arg_8_1

	arg_8_0:onInitView()
end

function var_0_0.onInitItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._index = arg_9_2
	arg_9_0._storyMo = arg_9_1
	arg_9_0._actId = arg_9_1._actId

	if arg_9_0._index == 3 then
		transformhelper.setLocalPosXY(arg_9_0._goeglocked.transform, 763, 850)
	end

	arg_9_0:activeStep(false)
end

function var_0_0.onRefreshMo(arg_10_0, arg_10_1)
	arg_10_0._stepMo = arg_10_1 and arg_10_0._storyMo:getStepMo(arg_10_1)
	arg_10_0._keywordIdList = arg_10_0._storyMo:getKwIdsByStepIndex(arg_10_0._index) or {}

	local var_10_0 = arg_10_0._storyMo:getState() == Activity165Enum.StoryStage.Filling
	local var_10_1 = arg_10_0._storyMo:getUnlockStepIdRemoveEndingCount()
	local var_10_2 = arg_10_0._index - var_10_1

	arg_10_0._isUnlock = var_10_2 <= 0

	if var_10_0 then
		arg_10_0._isCurStep = var_10_2 == 1
	else
		arg_10_0._isCurStep = false
	end

	arg_10_0.isFixed = arg_10_0._isUnlock and not LuaUtil.tableNotEmpty(arg_10_0._keywordIdList)

	if arg_10_0._stepMo and arg_10_0._isUnlock and arg_10_0.isFixed then
		local var_10_3 = arg_10_0._stepMo.stepCo.pic

		if not string.nilorempty(var_10_3) then
			UISpriteSetMgr.instance:setV2a1Act165Sprite(arg_10_0._imageicon, var_10_3, true)
		end
	end
end

function var_0_0.onUpdateMO(arg_11_0, arg_11_1)
	arg_11_0:killTween()

	arg_11_0._stepId = arg_11_1

	arg_11_0:onRefreshMo(arg_11_1)
	arg_11_0:refreshIndex(arg_11_0._index)
	gohelper.setActive(arg_11_0._gocorrect.gameObject, arg_11_0._isUnlock)

	if arg_11_0._isCurStep then
		arg_11_0:showEgLock()
	else
		arg_11_0:_hideEglocked()
	end

	if not arg_11_0._isUnlock and not arg_11_0._isCurStep then
		arg_11_0:activeStep(false)

		return
	end

	arg_11_0:activeStep(true)

	if arg_11_0._isUnlock then
		arg_11_0:showStoryTxt()
	end

	arg_11_0:refreshState()
	gohelper.setActive(arg_11_0._goTxt.gameObject, arg_11_0._isUnlock)
	arg_11_0:showDecorateTexture()
	arg_11_0:setKeywordItem()
end

function var_0_0.showEgLock(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._goeglocked.gameObject, true)
	arg_12_0._anieglocked:Play(Activity165Enum.EditViewAnim.Idle, arg_12_1, arg_12_0)
end

function var_0_0.unlockEgLock(arg_13_0)
	if not arg_13_0.isFixed and LuaUtil.tableNotEmpty(arg_13_0._keywordIdList) then
		gohelper.setActive(arg_13_0._goeglocked.gameObject, true)
		arg_13_0._anieglocked:Play(Activity165Enum.EditViewAnim.Unlock, arg_13_0._hideEglocked, arg_13_0)
	else
		arg_13_0:_hideEglocked()
	end
end

function var_0_0._hideEglocked(arg_14_0)
	gohelper.setActive(arg_14_0._goeglocked.gameObject, false)
end

function var_0_0.showDecorateTexture(arg_15_0, arg_15_1)
	local var_15_0 = not arg_15_0._isUnlock and arg_15_0:getFillKwCount() >= 1

	gohelper.setActive(arg_15_0._goDecorate.gameObject, var_15_0)

	if var_15_0 then
		arg_15_0._aniTex:Play(Activity165Enum.EditViewAnim.Idle, arg_15_1, arg_15_0)
	end
end

function var_0_0.unlockDecorateTexture(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._goDecorate.gameObject, true)
	arg_16_0._aniTex:Play(Activity165Enum.EditViewAnim.Unlock, arg_16_1, arg_16_0)
end

function var_0_0.playDecorateTexture(arg_17_0, arg_17_1)
	gohelper.setActive(arg_17_0._goDecorate.gameObject, true)
	arg_17_0._aniTex:Play(Activity165Enum.EditViewAnim.Unlock, arg_17_1, arg_17_0)
end

function var_0_0.hideyDecorateTexture(arg_18_0)
	gohelper.setActive(arg_18_0._goDecorate.gameObject, false)
end

function var_0_0.onFinishStep(arg_19_0, arg_19_1)
	arg_19_0._isUnlock = true

	arg_19_0:beginShowTxt(arg_19_1)
	arg_19_0:unlockEgLock()
	gohelper.setActive(arg_19_0._gocorrect.gameObject, true)
end

function var_0_0.activeStep(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._goleft.gameObject.activeSelf

	gohelper.setActive(arg_20_0._goleft.gameObject, arg_20_1)
	gohelper.setActive(arg_20_0._goright.gameObject, arg_20_1)
	gohelper.setActive(arg_20_0._goline.gameObject, arg_20_1)

	if not var_20_0 and arg_20_1 then
		arg_20_0._aniView:Play(Activity165Enum.EditViewAnim.EgOpen, nil, arg_20_0)
	end
end

function var_0_0.refreshIndex(arg_21_0, arg_21_1)
	arg_21_0._txtindex.text = arg_21_1 > 10 and arg_21_1 or "0" .. arg_21_1

	local var_21_0 = Activity165Enum.StepOffsetObj[arg_21_1 % 2 + 1]
	local var_21_1 = arg_21_0.isFixed and 480 or 530
	local var_21_2 = arg_21_1 % 2 == 0 and -15 or 15
	local var_21_3 = arg_21_0.isFixed and var_21_0.gotxt.PosX + var_21_2 or var_21_0.gotxt.PosX

	recthelper.setWidth(arg_21_0._goTxt.transform, var_21_1)

	arg_21_0._scrollTxtHeight = arg_21_0._goTxt.transform.rect.height

	transformhelper.setLocalPosXY(arg_21_0._goleft.transform, var_21_0.goleft.PosX, var_21_0.goleft.PosY)
	transformhelper.setLocalPosXY(arg_21_0._goright.transform, var_21_0.goright.PosX, var_21_0.goright.PosY)
	transformhelper.setLocalPosXY(arg_21_0._goindex.transform, var_21_0.goindex.PosX, var_21_0.goindex.PosY)
	transformhelper.setLocalPosXY(arg_21_0._goTxt.transform, var_21_3, var_21_0.gotxt.PosY)
	gohelper.setActive(arg_21_0._tex1, arg_21_1 % 2 == 0)
	gohelper.setActive(arg_21_0._tex2, arg_21_1 % 2 == 1)
end

function var_0_0.onDestroy(arg_22_0)
	arg_22_0:killTween()
end

function var_0_0.refreshState(arg_23_0)
	if not arg_23_0.isFixed then
		local var_23_0 = arg_23_0:isNullKeyword()

		gohelper.setActive(arg_23_0._goadd.gameObject, not arg_23_0._isUnlock and var_23_0 and not arg_23_0._bogusId)
		arg_23_0:refreshFillStepState()
	end

	gohelper.setActive(arg_23_0._gobg, not arg_23_0.isFixed)
	gohelper.setActive(arg_23_0._imageicon.gameObject, arg_23_0.isFixed)
end

function var_0_0.setBogusKeyword(arg_24_0, arg_24_1)
	if arg_24_0._bogusId or not arg_24_0:tryFillKeyword() then
		return
	end

	arg_24_0._bogusId = arg_24_1

	arg_24_0:setKeywordItem()
end

function var_0_0.cancelBogusKeyword(arg_25_0)
	arg_25_0._bogusId = nil
end

function var_0_0.refreshBogusKeyword(arg_26_0)
	if arg_26_0._bogusId then
		arg_26_0._bogusId = nil

		arg_26_0:setKeywordItem()
	end
end

function var_0_0.refreshFillStepState(arg_27_0)
	local var_27_0 = arg_27_0._storyMo and arg_27_0._storyMo:getSelectStepIndex()
	local var_27_1 = var_27_0 and var_27_0 == arg_27_0._index or false

	gohelper.setActive(arg_27_0._goselect.gameObject, var_27_1)
end

function var_0_0.tryFillKeyword(arg_28_0, arg_28_1)
	if arg_28_0:isFullKeyword() then
		return false
	end

	if LuaUtil.tableContains(arg_28_0._keywordIdList, arg_28_1) then
		return false
	end

	return true
end

function var_0_0.getFillKwCount(arg_29_0)
	return tabletool.len(arg_29_0._keywordIdList)
end

function var_0_0.fillKeyword(arg_30_0, arg_30_1)
	arg_30_0:addKeywordItem(arg_30_1)

	if arg_30_0:getFillKwCount() == 1 then
		arg_30_0:unlockDecorateTexture()
	end
end

function var_0_0.failFillKeyword(arg_31_0, arg_31_1)
	arg_31_0:removeKeywordItem(arg_31_1)
end

function var_0_0.addKeywordItem(arg_32_0, arg_32_1)
	if not LuaUtil.tableContains(arg_32_0._keywordIdList, arg_32_1) then
		table.insert(arg_32_0._keywordIdList, arg_32_1)
	end

	arg_32_0:setKeywordItem()
end

function var_0_0.removeKeywordItem(arg_33_0, arg_33_1)
	if LuaUtil.tableContains(arg_33_0._keywordIdList, arg_33_1) then
		tabletool.removeValue(arg_33_0._keywordIdList, arg_33_1)
		arg_33_0:showDecorateTexture()
	end

	arg_33_0:setKeywordItem()
end

function var_0_0.clearStep(arg_34_0)
	arg_34_0._keywordIdList = {}

	for iter_34_0, iter_34_1 in pairs(arg_34_0._keywordPointList) do
		gohelper.setActive(iter_34_1.go, false)
	end

	arg_34_0.isFixed = false

	arg_34_0:_hideAllMark()
	arg_34_0:onUpdateMO()
	gohelper.setActive(arg_34_0._goTxt.gameObject, false)
	arg_34_0:showDecorateTexture()
end

function var_0_0.setKeywordItem(arg_35_0)
	local var_35_0 = arg_35_0:getFillKwCount()

	if arg_35_0._bogusId then
		var_35_0 = var_35_0 + 1
	end

	if var_35_0 > 0 and var_35_0 <= arg_35_0._keywordMaxCount then
		local var_35_1 = 1

		if LuaUtil.tableNotEmpty(arg_35_0._keywordIdList) then
			for iter_35_0, iter_35_1 in pairs(arg_35_0._keywordIdList) do
				local var_35_2 = arg_35_0._keywordPointList[var_35_0].ponit[var_35_1]
				local var_35_3 = Activity165Config.instance:getKeywordCo(arg_35_0._actId, iter_35_1).pic

				if not string.nilorempty(var_35_3) then
					UISpriteSetMgr.instance:setV2a1Act165Sprite(var_35_2.icon, var_35_3)
				end

				if var_35_2.canvasgroup then
					var_35_2.canvasgroup.alpha = 1
				end

				var_35_1 = var_35_1 + 1
			end
		end

		if arg_35_0._bogusId then
			local var_35_4 = arg_35_0._keywordPointList[var_35_0].ponit[var_35_1]
			local var_35_5 = Activity165Config.instance:getKeywordCo(arg_35_0._actId, arg_35_0._bogusId).pic

			if not string.nilorempty(var_35_5) then
				UISpriteSetMgr.instance:setV2a1Act165Sprite(var_35_4.icon, var_35_5)
			end

			if var_35_4.canvasgroup then
				var_35_4.canvasgroup.alpha = 0.5
			end
		end
	end

	for iter_35_2, iter_35_3 in pairs(arg_35_0._keywordPointList) do
		gohelper.setActive(iter_35_3.go, var_35_0 == iter_35_2)
	end

	arg_35_0:refreshState()
end

function var_0_0.getKeywordItem(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._keywordItem[arg_36_1]

	if not var_36_0 then
		local var_36_1 = gohelper.cloneInPlace(arg_36_0._gokeyword, "kw_" .. arg_36_1)

		var_36_0 = {
			go = var_36_1,
			icon = gohelper.findChildImage(var_36_1, "#image_keyword"),
			anim = SLFramework.AnimatorPlayer.Get(var_36_1.gameObject)
		}
		arg_36_0._keywordItem[arg_36_1] = var_36_0
	end

	return var_36_0
end

function var_0_0.getKeywordList(arg_37_0)
	return arg_37_0._keywordIdList
end

function var_0_0.isKeyword(arg_38_0, arg_38_1)
	return LuaUtil.tableContains(arg_38_0._keywordIdList, arg_38_1)
end

function var_0_0.isNullKeyword(arg_39_0)
	return not LuaUtil.tableNotEmpty(arg_39_0._keywordIdList)
end

function var_0_0.isFullKeyword(arg_40_0)
	local var_40_0 = arg_40_0._keywordMaxCount <= arg_40_0:getFillKwCount()

	if var_40_0 then
		GameFacade.showToast(ToastEnum.Act165StepMaxCount, arg_40_0._keywordMaxCount)
		AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_fill_fail)
	end

	return var_40_0
end

function var_0_0.beginShowTxt(arg_41_0, arg_41_1)
	if not LuaUtil.tableNotEmpty(arg_41_0._stepMo) then
		arg_41_0._stepMo = arg_41_0._storyMo:getStepMo(arg_41_1)
	end

	arg_41_0:_setStepText()

	arg_41_0._markItemPos = {}

	arg_41_0:_setMarkItemPos()

	arg_41_0._txtstory.text = ""
	arg_41_0._finsihShowTxt = nil
	arg_41_0._scrollHeight = recthelper.getHeight(arg_41_0._scrollStory.transform)
	arg_41_0._tweenTime = 0
	arg_41_0._separateChars = Activity165Model.instance:setSeparateChars(arg_41_0._reallyTxt)

	gohelper.setActive(arg_41_0._goTxt.gameObject, false)
	arg_41_0:playDecorateTexture(arg_41_0.beginShowTxtCallback)
end

function var_0_0.beginShowTxtCallback(arg_42_0)
	local var_42_0 = #arg_42_0._separateChars
	local var_42_1 = var_42_0 * 0.033

	arg_42_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, var_42_0, var_42_1, arg_42_0._onTweenFrameCallback, arg_42_0._onTweenFinishCallback, arg_42_0, nil, EaseType.Linear)

	gohelper.setActive(arg_42_0._goTxt.gameObject, true)
	arg_42_0:hideyDecorateTexture()
end

function var_0_0._onTweenFrameCallback(arg_43_0, arg_43_1)
	if arg_43_0._finsihShowTxt or arg_43_1 - arg_43_0._tweenTime < 1 then
		return
	end

	if arg_43_1 <= #arg_43_0._separateChars then
		local var_43_0 = math.floor(arg_43_1)

		arg_43_0._txtstory.text = arg_43_0._separateChars[var_43_0]

		if arg_43_0._scrollStory.verticalNormalizedPosition ~= 0 then
			arg_43_0._scrollStory.verticalNormalizedPosition = 0
		end
	else
		arg_43_0._txtstory.text = arg_43_0._reallyTxt
	end

	arg_43_0._tweenTime = arg_43_1
end

function var_0_0._onTweenFinishCallback(arg_44_0)
	if arg_44_0._tweenId then
		ZProj.TweenHelper.KillById(arg_44_0._tweenId)

		arg_44_0._tweenId = nil
	end

	local var_44_0 = arg_44_0._txtstory:GetPreferredValues()

	recthelper.setHeight(arg_44_0._txtstory.transform, var_44_0.y)
	arg_44_0:_showStoryTxt()
	arg_44_0:_markNote()
	arg_44_0:_playMarkItemAnim()
end

function var_0_0.isPlayingTxt(arg_45_0)
	return arg_45_0._tweenId ~= nil
end

function var_0_0._setStepText(arg_46_0)
	if not arg_46_0._stepMo then
		return
	end

	local var_46_0 = arg_46_0._stepMo.stepCo.text
	local var_46_1 = "<%d-:.->"
	local var_46_2 = "<%d-:(.-)>"

	arg_46_0:_setReallyStepText(var_46_0, var_46_1, var_46_2)
end

function var_0_0._setReallyStepText(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0, var_47_1 = arg_47_0:_matchData(arg_47_1, arg_47_2, arg_47_3)

	if not var_47_1 then
		arg_47_0._reallyTxt = var_47_0

		return
	end

	arg_47_0:_getReallyStepText(var_47_0, arg_47_2, arg_47_3)
end

function var_0_0._showStoryTxt(arg_48_0)
	if string.nilorempty(arg_48_0._reallyTxt) then
		arg_48_0:_setStepText()
	end

	arg_48_0._txtstory.text = arg_48_0._reallyTxt

	local var_48_0 = arg_48_0._txtstory:GetPreferredValues()

	recthelper.setHeight(arg_48_0._txtstory.transform, var_48_0.y)
end

function var_0_0.finishStoryAnim(arg_49_0)
	arg_49_0:showStoryTxt()
	arg_49_0:_hideEglocked()
	Activity165Controller.instance:dispatchEvent(Activity165Event.finishStepAnim, arg_49_0._index)
end

function var_0_0.showStoryTxt(arg_50_0)
	arg_50_0:killTween()
	arg_50_0:_showStoryTxt()
	arg_50_0:_markNote()

	arg_50_0._finsihShowTxt = true

	for iter_50_0, iter_50_1 in pairs(arg_50_0._markItemList) do
		gohelper.setActive(iter_50_1.go, true)
	end
end

function var_0_0._markNote(arg_51_0)
	if not arg_51_0._stepMo then
		return
	end

	local var_51_0 = arg_51_0._stepMo.stepCo.text
	local var_51_1 = "<%d-:.->"
	local var_51_2 = "<%d-:(.-)>"

	arg_51_0._markItemPos = {}

	arg_51_0:_matchData(var_51_0, var_51_1, var_51_2, nil, arg_51_0._markData)
	arg_51_0:_setMarkItemPos()

	arg_51_0._curShowMarkIndex = 1
end

function var_0_0._matchData(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4, arg_52_5)
	local var_52_0, var_52_1 = string.find(arg_52_1, arg_52_2)

	if not var_52_0 then
		return arg_52_1, var_52_0, arg_52_4
	end

	local var_52_2 = string.match(arg_52_1, "<(%d-):.->")
	local var_52_3 = tonumber(var_52_2)

	if not var_52_3 then
		return
	end

	local var_52_4 = ""

	arg_52_1 = string.gsub(arg_52_1, arg_52_3, function(arg_53_0)
		var_52_4 = arg_53_0

		return arg_53_0
	end, 1)

	if arg_52_5 then
		arg_52_5(arg_52_0, arg_52_1, var_52_0, var_52_3, var_52_4)
	end

	return arg_52_0:_matchData(arg_52_1, arg_52_2, arg_52_3, var_52_3, arg_52_5)
end

function var_0_0._markData(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4)
	local var_54_0 = string.sub(arg_54_1, 1, arg_54_2 - 1)
	local var_54_1 = arg_54_0._txtstory:GetTextInfo(arg_54_1)
	local var_54_2 = GameUtil.utf8len(var_54_0)
	local var_54_3 = GameUtil.utf8len(arg_54_4) + var_54_2 - 1
	local var_54_4 = var_54_1.characterInfo[var_54_2]
	local var_54_5 = var_54_1.characterInfo[var_54_3]
	local var_54_6 = var_54_4.bottomLeft
	local var_54_7 = var_54_5.bottomRight
	local var_54_8 = arg_54_0._txtstory.fontSize
	local var_54_9 = arg_54_0._txtstory.transform.rect.width
	local var_54_10 = arg_54_0:parseMark(arg_54_3, 4)
	local var_54_11 = math.floor(math.abs(var_54_7.y - var_54_6.y) / var_54_8)

	if var_54_11 > 0 then
		for iter_54_0 = 1, var_54_11 + 1 do
			if iter_54_0 == 1 then
				local var_54_12 = {
					types = var_54_10,
					posX = var_54_6.x,
					posY = var_54_6.y,
					width = var_54_9 - var_54_6.x,
					fillContent = arg_54_4
				}

				table.insert(arg_54_0._markItemPos, var_54_12)
			elseif iter_54_0 == var_54_11 + 1 then
				local var_54_13 = {
					types = var_54_10
				}

				var_54_13.posX = 0
				var_54_13.posY = var_54_7.y
				var_54_13.width = var_54_7.x
				var_54_13.fillContent = arg_54_4

				table.insert(arg_54_0._markItemPos, var_54_13)
			else
				local var_54_14 = {
					types = var_54_10
				}

				var_54_14.posX = 0
				var_54_14.posY = var_54_6.y - var_54_8 * iter_54_0
				var_54_14.width = var_54_9
				var_54_14.fillContent = arg_54_4

				table.insert(arg_54_0._markItemPos, var_54_14)
			end
		end
	else
		local var_54_15 = {
			types = var_54_10,
			posX = var_54_6.x,
			posY = var_54_6.y,
			width = var_54_7.x - var_54_6.x,
			fillContent = arg_54_4
		}

		table.insert(arg_54_0._markItemPos, var_54_15)
	end
end

function var_0_0.getMarkItemByType(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = arg_55_0._typeMarkItemList[arg_55_1][arg_55_2]

	if not var_55_0 then
		local var_55_1 = gohelper.cloneInPlace(arg_55_0._goMarkPrefabs[arg_55_1])

		var_55_0 = arg_55_0:getUserDataTb_()
		var_55_0.go = var_55_1
		var_55_0.icon = gohelper.findChildImage(var_55_1, "mark")
		var_55_0.anim = SLFramework.AnimatorPlayer.Get(var_55_1.gameObject)
		arg_55_0._typeMarkItemList[arg_55_1][arg_55_2] = var_55_0

		gohelper.setActive(var_55_0.go, false)
	end

	return var_55_0
end

function var_0_0._setMarkItemPos(arg_56_0)
	arg_56_0._markItemList = {}

	local var_56_0 = arg_56_0._txtstory:GetPreferredValues().y

	for iter_56_0, iter_56_1 in pairs(arg_56_0._markItemPos) do
		for iter_56_2, iter_56_3 in pairs(iter_56_1.types) do
			local var_56_1 = arg_56_0:getMarkItemByType(iter_56_3, iter_56_0)

			var_56_1.go.name = iter_56_1.fillContent .. "_" .. iter_56_3 .. "_" .. iter_56_2 .. "_" .. iter_56_0

			table.insert(arg_56_0._markItemList, var_56_1)

			local var_56_2 = iter_56_1.posY

			if var_56_0 < arg_56_0._scrollTxtHeight then
				local var_56_3 = (arg_56_0._scrollTxtHeight - var_56_0) * 0.5

				var_56_2 = iter_56_1.posY - var_56_3
			end

			recthelper.setAnchor(var_56_1.go.transform, iter_56_1.posX, var_56_2)

			local var_56_4 = arg_56_0._goMarkPrefabs[iter_56_3] and arg_56_0._goMarkPrefabs[iter_56_3].transform.rect.width or 100
			local var_56_5 = math.max(iter_56_1.width, var_56_4)

			recthelper.setWidth(var_56_1.icon.transform, var_56_5)
		end
	end
end

function var_0_0._playMarkItemAnim(arg_57_0)
	if arg_57_0._curShowMarkIndex > #arg_57_0._markItemList then
		return arg_57_0:finishStoryAnim()
	end

	local var_57_0 = arg_57_0._markItemList[arg_57_0._curShowMarkIndex]

	if not var_57_0 or not var_57_0.go then
		return arg_57_0:finishStoryAnim()
	end

	gohelper.setActive(var_57_0.go, true)

	arg_57_0._curShowMarkIndex = arg_57_0._curShowMarkIndex + 1

	var_57_0.anim:Play(Activity165Enum.EditViewAnim.Open, arg_57_0._playMarkItemAnim, arg_57_0)
end

function var_0_0.parseMark(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = {}
	local var_58_1 = arg_58_1

	for iter_58_0 = arg_58_2, 1, -1 do
		local var_58_2 = 2^iter_58_0

		if var_58_2 <= var_58_1 then
			table.insert(var_58_0, iter_58_0)

			var_58_1 = var_58_1 - var_58_2

			if var_58_1 == 0 then
				break
			end
		end
	end

	return var_58_0
end

function var_0_0._hideAllMark(arg_59_0)
	for iter_59_0, iter_59_1 in pairs(arg_59_0._markItemList) do
		gohelper.setActive(iter_59_1.go, false)
	end

	arg_59_0._markItemList = {}
end

function var_0_0.killTween(arg_60_0)
	if arg_60_0._tweenId then
		ZProj.TweenHelper.KillById(arg_60_0._tweenId)

		arg_60_0._tweenId = nil
	end

	if arg_60_0._markTweenId then
		ZProj.TweenHelper.KillById(arg_60_0._markTweenId)

		arg_60_0._markTweenId = nil
	end

	TaskDispatcher.cancelTask(arg_60_0._playMarkItemAnim, arg_60_0)
end

return var_0_0

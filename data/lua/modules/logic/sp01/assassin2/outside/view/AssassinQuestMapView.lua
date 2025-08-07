module("modules.logic.sp01.assassin2.outside.view.AssassinQuestMapView", package.seeall)

local var_0_0 = class("AssassinQuestMapView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._godrag = gohelper.findChild(arg_1_0.viewGO, "root/#go_drag")
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "root/#go_drag/simage_fullbg")
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "root/#go_drag/simage_fullbg/#go_bg")
	arg_1_0._goquestItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_drag/simage_fullbg/#go_container/#go_questItem")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "root/left/info/#txt_title")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "root/left/info/#txt_progress")
	arg_1_0._sliderprogress = gohelper.findChildSlider(arg_1_0.viewGO, "root/left/info/#slider_progress")
	arg_1_0._goquestInfo = gohelper.findChild(arg_1_0.viewGO, "root/left/info/#go_questInfo")
	arg_1_0._goquestInfoItem = gohelper.findChild(arg_1_0.viewGO, "root/left/info/#go_questInfo/#go_questInfoItem")
	arg_1_0._btnmanor = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/#btn_manor", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._gomanorreddot = gohelper.findChild(arg_1_0.viewGO, "root/left/#btn_manor/go_manorreddot")
	arg_1_0._btndevelop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#btn_develop", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#btn_task", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "root/right/#btn_task/#go_taskreddot")
	arg_1_0._btnlibrary = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#btn_library", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._golibraryreddot = gohelper.findChild(arg_1_0.viewGO, "root/right/#btn_library/#go_libraryreddot")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "root/#go_arrow")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "root/#go_topright")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmanor:AddClickListener(arg_2_0._btnmanorOnClick, arg_2_0)
	arg_2_0._btndevelop:AddClickListener(arg_2_0._btndevelopOnClick, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnlibrary:AddClickListener(arg_2_0._btnlibraryOnClick, arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onBeginDragMap, arg_2_0)
	arg_2_0._drag:AddDragListener(arg_2_0._onDragMap, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onEndDragMap, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnClickQuestItem, arg_2_0._onClickQuestItem, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnFinishQuest, arg_2_0._onFinishQuest, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnUnlockQuestContent, arg_2_0._onUnlockQuestContent, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnAllAssassinOutSideInfoUpdate, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UpdateCoinNum, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UnlockBuildings, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UpdateLibraryReddot, arg_2_0.refreshLibraryRedDot, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_2_0._onCloseFullView, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmanor:RemoveClickListener()
	arg_3_0._btndevelop:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnlibrary:RemoveClickListener()
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.OnClickQuestItem, arg_3_0._onClickQuestItem, arg_3_0)
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.OnFinishQuest, arg_3_0._onFinishQuest, arg_3_0)
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.OnUnlockQuestContent, arg_3_0._onUnlockQuestContent, arg_3_0)
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.OnAllAssassinOutSideInfoUpdate, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.UpdateCoinNum, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.UnlockBuildings, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.UpdateLibraryReddot, arg_3_0.refreshLibraryRedDot, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_3_0._onCloseFullView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._btnmanorOnClick(arg_4_0)
	AssassinController.instance:openAssassinBuildingMapView()
end

function var_0_0._btndevelopOnClick(arg_5_0)
	AssassinController.instance:openAssassinHeroView()
end

function var_0_0._btntaskOnClick(arg_6_0)
	AssassinController.instance:openAssassinTaskView()
end

function var_0_0._btnlibraryOnClick(arg_7_0)
	AssassinController.instance:openAssassinLibraryView()
end

function var_0_0._onBeginDragMap(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._startDragPos = recthelper.screenPosToAnchorPos(arg_8_2.position, arg_8_0._transdrag)
	arg_8_0._startMapPosX, arg_8_0._startMapPosY = transformhelper.getLocalPos(arg_8_0._transmap)
end

function var_0_0._onDragMap(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._startDragPos then
		return
	end

	local var_9_0 = recthelper.screenPosToAnchorPos(arg_9_2.position, arg_9_0._transdrag) - arg_9_0._startDragPos
	local var_9_1 = arg_9_0._startMapPosX + var_9_0.x
	local var_9_2 = arg_9_0._startMapPosY + var_9_0.y

	arg_9_0:setMapPos(var_9_1, var_9_2)
	arg_9_0:updateAllArrow()
end

function var_0_0._onEndDragMap(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._startDragPos = nil
end

function var_0_0._onClickQuestItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0._showQuestItemDict[arg_11_1]

	if not var_11_0 then
		return
	end

	arg_11_0._targetQuestId = arg_11_1
	arg_11_0._fightReturn = arg_11_2

	arg_11_0:killTween()

	if arg_11_3 then
		local var_11_1 = var_11_0:getGoPosition()
		local var_11_2 = arg_11_0._transmap:InverseTransformPoint(var_11_1)

		arg_11_0:tweenMapPos(-var_11_2.x, -var_11_2.y)
	else
		arg_11_0:_focusQuestItemFinish()
	end
end

function var_0_0._focusQuestItemFinish(arg_12_0)
	arg_12_0:updateAllArrow()
	arg_12_0:_enterAssassinStealthGame()
end

function var_0_0._enterAssassinStealthGame(arg_13_0)
	if arg_13_0._targetQuestId then
		local var_13_0 = arg_13_0._showQuestItemDict[arg_13_0._targetQuestId]
		local var_13_1 = var_13_0 and var_13_0:getGoPosition()

		AssassinController.instance:openAssassinQuestDetailView(arg_13_0._targetQuestId, arg_13_0._fightReturn, var_13_1)
	end

	arg_13_0._targetQuestId = nil
	arg_13_0._fightReturn = nil
end

function var_0_0._onFinishQuest(arg_14_0)
	arg_14_0:initAllQuestItem()
	arg_14_0:refreshUI()
end

function var_0_0._onUnlockQuestContent(arg_15_0)
	arg_15_0:initAllQuestItem()
	arg_15_0:refreshUI()
end

function var_0_0._onCloseFullView(arg_16_0, arg_16_1)
	if arg_16_1 ~= arg_16_0.viewName then
		arg_16_0:updateAllArrow()
	end

	if arg_16_1 ~= ViewName.AssassinStealthGameView or arg_16_1 == arg_16_0.viewName or not arg_16_0.viewContainer._isVisible then
		return
	end

	arg_16_0._animatorPlayer:Play(UIAnimationName.Open, arg_16_0._afterOpenAnim, arg_16_0)

	if arg_16_0._showQuestItemDict then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._showQuestItemDict) do
			iter_16_1:playOpen()
		end
	end
end

function var_0_0._afterOpenAnim(arg_17_0)
	arg_17_0:checkPlayAnim()
	arg_17_0:checkGuide()
end

function var_0_0._onCloseView(arg_18_0, arg_18_1)
	if arg_18_1 == arg_18_0.viewName then
		return
	end

	arg_18_0:checkPlayAnim()
	arg_18_0:checkGuide()
end

function var_0_0._editableInitView(arg_19_0)
	gohelper.setActive(arg_19_0._goquestItem, false)

	arg_19_0._questItemPool = {}
	arg_19_0._transmap = arg_19_0._gomap.transform

	arg_19_0:calculateDragBorder()

	arg_19_0._transdrag = arg_19_0._godrag.transform
	arg_19_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_19_0._godrag)
	arg_19_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_19_0.viewGO)
	arg_19_0.bgSimageList = arg_19_0:getUserDataTb_()

	local var_19_0 = arg_19_0._gobg:GetComponentsInChildren(typeof(SLFramework.UGUI.SingleImage))
	local var_19_1 = var_19_0 and var_19_0:GetEnumerator()

	if var_19_1 then
		while var_19_1:MoveNext() do
			table.insert(arg_19_0.bgSimageList, var_19_1.Current)
		end
	end

	RedDotController.instance:addRedDot(arg_19_0._gotaskreddot, RedDotEnum.DotNode.AssassinOutsideTask)

	arg_19_0._arrowList = arg_19_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_20_0)
	arg_20_0._mapId = arg_20_0.viewParam.mapId

	arg_20_0:setMapInfo()
	arg_20_0:setQuestTypeInfoItems()
	arg_20_0:initAllQuestItem()
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0._currencyToolView = arg_21_0:openSubView(AssassinCurrencyToolView, nil, arg_21_0._gotopright)

	arg_21_0:onUpdateParam()
	arg_21_0:refreshUI()

	local var_21_0 = arg_21_0.viewParam.questId

	if var_21_0 then
		AssassinController.instance:clickQuestItem(var_21_0, arg_21_0.viewParam.fightReturnStealthGame)
	end
end

function var_0_0.onOpenFinish(arg_22_0)
	arg_22_0:checkPlayAnim()
	arg_22_0:checkGuide()
end

function var_0_0.checkGuide(arg_23_0)
	if GuideModel.instance:isGuideFinish(AssassinEnum.StealthConst.QuestMapGuide) then
		return
	end

	local var_23_0 = AssassinOutsideModel.instance:getMapFinishQuestIdList(arg_23_0._mapId)

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if AssassinConfig.instance:getQuestType(iter_23_1) == AssassinEnum.QuestType.Stealth then
			AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.TriggerGuideAfterFinishStealthGame)

			break
		end
	end
end

function var_0_0.setMapInfo(arg_24_0)
	arg_24_0._txttitle.text = AssassinConfig.instance:getMapTitle(arg_24_0._mapId)

	local var_24_0 = AssassinConfig.instance:getMapBg(arg_24_0._mapId)

	if var_24_0 and arg_24_0.bgSimageList then
		for iter_24_0, iter_24_1 in ipairs(arg_24_0.bgSimageList) do
			local var_24_1 = ResUrl.getSp01AssassinSingleBg(string.format("map/%s_%s", var_24_0, iter_24_0))

			iter_24_1:LoadImage(var_24_1)
		end
	end

	local var_24_2, var_24_3 = AssassinConfig.instance:getMapCenterPos(arg_24_0._mapId)

	transformhelper.setLocalPos(arg_24_0._gobg.transform, var_24_2, var_24_3, 0)
end

function var_0_0.setQuestTypeInfoItems(arg_25_0)
	arg_25_0._questTypeInfoItemList = {}

	local var_25_0 = AssassinConfig.instance:getQuestTypeList()

	gohelper.CreateObjList(arg_25_0, arg_25_0._onCreateQuestTypeInfoItem, var_25_0, arg_25_0._goquestInfo, arg_25_0._goquestInfoItem)
end

function var_0_0._onCreateQuestTypeInfoItem(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_0:getUserDataTb_()

	var_26_0.go = arg_26_1
	var_26_0.questType = arg_26_2
	var_26_0.imageicon = gohelper.findChildImage(arg_26_1, "image_icon")
	var_26_0.txttitle = gohelper.findChildText(arg_26_1, "txt_title")
	var_26_0.txtprogress = gohelper.findChildText(arg_26_1, "txt_progress")
	var_26_0.txttitle.text = AssassinConfig.instance:getQuestTypeName(arg_26_2)

	AssassinHelper.setQuestTypeIcon(arg_26_2, var_26_0.imageicon)

	arg_26_0._questTypeInfoItemList[arg_26_3] = var_26_0
end

function var_0_0.calculateDragBorder(arg_27_0)
	local var_27_0 = arg_27_0.viewGO.transform
	local var_27_1 = recthelper.getWidth(var_27_0)
	local var_27_2 = recthelper.getHeight(var_27_0)
	local var_27_3 = recthelper.getWidth(arg_27_0._transmap)
	local var_27_4 = recthelper.getHeight(arg_27_0._transmap)

	arg_27_0.maxOffsetX = (var_27_3 - var_27_1) / 2
	arg_27_0.maxOffsetY = (var_27_4 - var_27_2) / 2
end

function var_0_0.setMapPos(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_1 or not arg_28_2 then
		arg_28_1, arg_28_2 = transformhelper.getLocalPos(arg_28_0._transmap)
	end

	arg_28_1 = Mathf.Clamp(arg_28_1, -arg_28_0.maxOffsetX, arg_28_0.maxOffsetX)
	arg_28_2 = Mathf.Clamp(arg_28_2, -arg_28_0.maxOffsetY, arg_28_0.maxOffsetY)

	transformhelper.setLocalPosXY(arg_28_0._transmap, arg_28_1, arg_28_2)
end

function var_0_0.tweenMapPos(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_1 or not arg_29_2 then
		return
	end

	AssassinHelper.lockScreen(AssassinEnum.BlockKey.QuestMapTween, true)

	arg_29_0._tweenStartPosX, arg_29_0._tweenStartPosY = transformhelper.getLocalPos(arg_29_0._transmap)
	arg_29_0._tweenTargetPosX = Mathf.Clamp(arg_29_1, -arg_29_0.maxOffsetX, arg_29_0.maxOffsetX)
	arg_29_0._tweenTargetPosY = Mathf.Clamp(arg_29_2, -arg_29_0.maxOffsetY, arg_29_0.maxOffsetY)

	local var_29_0 = AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.QuestMapTweenTime, true) or 0

	arg_29_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, var_29_0, arg_29_0.tweenFrameCallback, arg_29_0.tweenFinishCallback, arg_29_0)

	arg_29_0:tweenFrameCallback(0)
end

function var_0_0.tweenFrameCallback(arg_30_0, arg_30_1)
	local var_30_0 = Mathf.Lerp(arg_30_0._tweenStartPosX, arg_30_0._tweenTargetPosX, arg_30_1)
	local var_30_1 = Mathf.Lerp(arg_30_0._tweenStartPosY, arg_30_0._tweenTargetPosY, arg_30_1)

	arg_30_0:setMapPos(var_30_0, var_30_1)
end

function var_0_0.tweenFinishCallback(arg_31_0)
	arg_31_0:setMapPos(arg_31_0._tweenTargetPosX, arg_31_0._tweenTargetPosY)
	arg_31_0:_focusQuestItemFinish()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.QuestMapTween, false)
end

function var_0_0.killTween(arg_32_0)
	if arg_32_0.tweenId then
		ZProj.TweenHelper.KillById(arg_32_0.tweenId)
	end

	arg_32_0.tweenId = nil

	AssassinHelper.lockScreen(AssassinEnum.BlockKey.QuestMapTween, false)
end

function var_0_0.initAllQuestItem(arg_33_0)
	arg_33_0:clearAllQuestItem()

	local var_33_0 = AssassinOutsideModel.instance:getMapUnlockQuestIdList(arg_33_0._mapId)

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		arg_33_0:addQuestItem(iter_33_1)

		local var_33_1 = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.QuestItemOpenAnim, iter_33_1)

		if not AssassinOutsideModel.instance:getCacheKeyData(var_33_1) then
			local var_33_2 = arg_33_0._showQuestItemDict[iter_33_1]

			if var_33_2 then
				var_33_2:disableItem()
			end
		end
	end

	local var_33_3 = AssassinOutsideModel.instance:getMapFinishQuestIdList(arg_33_0._mapId)

	for iter_33_2, iter_33_3 in ipairs(var_33_3) do
		local var_33_4 = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.QuestItemFinishAnim, iter_33_3)

		if not AssassinOutsideModel.instance:getCacheKeyData(var_33_4) then
			arg_33_0:addQuestItem(iter_33_3)
		end
	end
end

function var_0_0.clearAllQuestItem(arg_34_0)
	if arg_34_0._showQuestItemDict then
		for iter_34_0, iter_34_1 in pairs(arg_34_0._showQuestItemDict) do
			arg_34_0:removeQuestItem(iter_34_0)
		end
	end

	arg_34_0._showQuestItemDict = {}
end

function var_0_0.removeQuestItem(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0._showQuestItemDict[arg_35_1]

	if not var_35_0 then
		return
	end

	var_35_0:remove(arg_35_2)

	arg_35_0._showQuestItemDict[arg_35_1] = nil

	table.insert(arg_35_0._questItemPool, var_35_0)

	local var_35_1 = arg_35_0._arrowList[arg_35_1]

	if var_35_1 then
		var_35_1.arrowClick:RemoveClickListener()

		arg_35_0._arrowList[arg_35_1] = nil

		gohelper.destroy(var_35_1.go)
	end
end

function var_0_0.addQuestItem(arg_36_0, arg_36_1)
	if arg_36_0._showQuestItemDict[arg_36_1] then
		return
	end

	local var_36_0

	if next(arg_36_0._questItemPool) then
		var_36_0 = table.remove(arg_36_0._questItemPool)
	else
		local var_36_1 = gohelper.cloneInPlace(arg_36_0._goquestItem)

		var_36_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_36_1, AssassinQuestItem)
	end

	var_36_0:setData(arg_36_1)

	arg_36_0._showQuestItemDict[arg_36_1] = var_36_0

	local var_36_2 = arg_36_0.viewContainer:getSetting().otherRes[1]
	local var_36_3 = arg_36_0:getResInst(var_36_2, arg_36_0._goarrow)
	local var_36_4 = gohelper.findChild(var_36_3, "mesh")
	local var_36_5, var_36_6, var_36_7 = transformhelper.getLocalRotation(var_36_4.transform)
	local var_36_8 = gohelper.getClick(gohelper.findChild(var_36_3, "click"))

	var_36_8:AddClickListener(arg_36_0._arrowClick, arg_36_0, arg_36_1)

	arg_36_0._arrowList[arg_36_1] = {
		go = var_36_3,
		rotationTrans = var_36_4.transform,
		initRotation = {
			var_36_5,
			var_36_6,
			var_36_7
		},
		arrowClick = var_36_8
	}

	arg_36_0:updateArrow(var_36_0)
end

function var_0_0._arrowClick(arg_37_0, arg_37_1)
	arg_37_0:_onClickQuestItem(arg_37_1, false, true)
end

function var_0_0.checkPlayAnim(arg_38_0)
	if ViewMgr.instance:isOpen(ViewName.LoadingView) then
		return
	end

	local var_38_0 = ViewMgr.instance:getOpenViewNameList()
	local var_38_1 = var_38_0[#var_38_0]

	if var_38_1 ~= arg_38_0.viewName and var_38_1 ~= ViewName.AssassinLibraryToastView and var_38_1 ~= ViewName.GuideView then
		return
	end

	arg_38_0:playFinishedQuest()

	if arg_38_0._currencyToolView then
		arg_38_0._currencyToolView:checkPlayGet()
	end
end

local var_0_1 = 0.67

function var_0_0.playFinishedQuest(arg_39_0)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(arg_39_0._showQuestItemDict) do
		if AssassinOutsideModel.instance:isFinishQuest(iter_39_0) then
			var_39_0[#var_39_0 + 1] = iter_39_0
		end
	end

	if #var_39_0 > 0 then
		local var_39_1 = var_39_0[1]
		local var_39_2 = arg_39_0._showQuestItemDict[var_39_1]

		if var_39_2 then
			local var_39_3 = var_39_2:getGoPosition()
			local var_39_4 = arg_39_0._transmap:InverseTransformPoint(var_39_3)

			arg_39_0:tweenMapPos(-var_39_4.x, -var_39_4.y)
		end

		for iter_39_2, iter_39_3 in ipairs(var_39_0) do
			arg_39_0:removeQuestItem(iter_39_3, true)
		end

		TaskDispatcher.cancelTask(arg_39_0.playNewQuestItem, arg_39_0)
		TaskDispatcher.runDelay(arg_39_0.playNewQuestItem, arg_39_0, var_0_1)
	else
		arg_39_0:playNewQuestItem()
	end
end

function var_0_0.playNewQuestItem(arg_40_0)
	local var_40_0

	for iter_40_0, iter_40_1 in pairs(arg_40_0._showQuestItemDict) do
		local var_40_1 = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.QuestItemOpenAnim, iter_40_0)

		if not AssassinOutsideModel.instance:getCacheKeyData(var_40_1) then
			iter_40_1:playOpen()
			AssassinController.instance:setHasPlayedAnimation(var_40_1)

			if not var_40_0 then
				local var_40_2 = iter_40_1:getGoPosition()
				local var_40_3 = arg_40_0._transmap:InverseTransformPoint(var_40_2)

				arg_40_0:tweenMapPos(-var_40_3.x, -var_40_3.y)

				var_40_0 = true
			end
		end
	end
end

function var_0_0.refreshUI(arg_41_0)
	arg_41_0:refreshMapProgress()
	arg_41_0:refreshQuestTypeInfoProgress()
	arg_41_0:refreshBuildingReddot()
	arg_41_0:refreshLibraryRedDot()
end

function var_0_0.refreshMapProgress(arg_42_0)
	local var_42_0, var_42_1 = AssassinOutsideModel.instance:getQuestMapProgress(arg_42_0._mapId)

	arg_42_0._txtprogress.text = var_42_1

	arg_42_0._sliderprogress:SetValue(var_42_0)
end

function var_0_0.refreshQuestTypeInfoProgress(arg_43_0)
	for iter_43_0, iter_43_1 in ipairs(arg_43_0._questTypeInfoItemList) do
		local var_43_0 = AssassinOutsideModel.instance:getQuestTypeProgressStr(arg_43_0._mapId, iter_43_1.questType)

		iter_43_1.txtprogress.text = var_43_0
	end
end

function var_0_0.refreshBuildingReddot(arg_44_0)
	local var_44_0 = AssassinOutsideModel.instance:getBuildingMapMo()
	local var_44_1 = var_44_0 and var_44_0:isAnyBuildingLevelUp2NextLv()

	gohelper.setActive(arg_44_0._gomanorreddot, var_44_1)
end

function var_0_0.refreshLibraryRedDot(arg_45_0)
	arg_45_0._libraryRedDot = RedDotController.instance:addNotEventRedDot(arg_45_0._golibraryreddot, arg_45_0._libraryRedDotCheckFunc, arg_45_0, AssassinEnum.LibraryReddotStyle)

	arg_45_0._libraryRedDot:refreshRedDot()
end

function var_0_0._libraryRedDotCheckFunc(arg_46_0)
	return AssassinLibraryModel.instance:isAnyLibraryNewUnlock()
end

function var_0_0.onClose(arg_47_0)
	arg_47_0:killTween()
	TaskDispatcher.cancelTask(arg_47_0.playNewQuestItem, arg_47_0)
end

function var_0_0.onDestroyView(arg_48_0)
	arg_48_0._questItemPool = nil
	arg_48_0._showQuestItemDict = nil

	if arg_48_0.bgSimageList then
		for iter_48_0, iter_48_1 in ipairs(arg_48_0.bgSimageList) do
			iter_48_1:UnLoadImage()
		end
	end

	for iter_48_2, iter_48_3 in pairs(arg_48_0._arrowList) do
		iter_48_3.arrowClick:RemoveClickListener()
		gohelper.destroy(iter_48_3.go)
	end
end

function var_0_0.updateAllArrow(arg_49_0)
	for iter_49_0, iter_49_1 in pairs(arg_49_0._showQuestItemDict) do
		arg_49_0:updateArrow(iter_49_1)
	end
end

function var_0_0.updateArrow(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_1.trans
	local var_50_1 = CameraMgr.instance:getUICamera():WorldToViewportPoint(var_50_0.position)
	local var_50_2 = var_50_1.x
	local var_50_3 = var_50_1.y
	local var_50_4 = var_50_2 >= 0 and var_50_2 <= 1 and var_50_3 >= 0 and var_50_3 <= 1
	local var_50_5 = arg_50_0._arrowList[arg_50_1._questId]

	if not var_50_5 then
		return
	end

	gohelper.setActive(var_50_5.go, not var_50_4)

	if var_50_4 then
		return
	end

	local var_50_6 = math.max(0.02, math.min(var_50_2, 0.98))
	local var_50_7 = math.max(0.035, math.min(var_50_3, 0.965))
	local var_50_8 = recthelper.getWidth(arg_50_0._goarrow.transform)
	local var_50_9 = recthelper.getHeight(arg_50_0._goarrow.transform)

	recthelper.setAnchor(var_50_5.go.transform, var_50_8 * (var_50_6 - 0.5), var_50_9 * (var_50_7 - 0.5))

	local var_50_10 = var_50_5.initRotation

	if var_50_2 >= 0 and var_50_2 <= 1 then
		if var_50_3 < 0 then
			transformhelper.setLocalRotation(var_50_5.rotationTrans, var_50_10[1], var_50_10[2], 180)

			return
		elseif var_50_3 > 1 then
			transformhelper.setLocalRotation(var_50_5.rotationTrans, var_50_10[1], var_50_10[2], 0)

			return
		end
	end

	if var_50_3 >= 0 and var_50_3 <= 1 then
		if var_50_2 < 0 then
			transformhelper.setLocalRotation(var_50_5.rotationTrans, var_50_10[1], var_50_10[2], 270)

			return
		elseif var_50_2 > 1 then
			transformhelper.setLocalRotation(var_50_5.rotationTrans, var_50_10[1], var_50_10[2], 90)

			return
		end
	end

	local var_50_11 = 90 - Mathf.Atan2(var_50_3, var_50_2) * Mathf.Rad2Deg

	transformhelper.setLocalRotation(var_50_5.rotationTrans, var_50_10[1], var_50_10[2], var_50_11)
end

return var_0_0

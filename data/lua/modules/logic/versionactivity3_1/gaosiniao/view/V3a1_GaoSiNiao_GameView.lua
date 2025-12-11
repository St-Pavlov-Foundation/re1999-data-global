module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_GameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Mask")
	arg_1_0._goPiecePanel = gohelper.findChild(arg_1_0.viewGO, "#go_PiecePanel")
	arg_1_0._gopieceItem = gohelper.findChild(arg_1_0.viewGO, "#go_PiecePanel/#go_pieceItem")
	arg_1_0._goMap = gohelper.findChild(arg_1_0.viewGO, "#go_Map")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "#go_Map/#go_Item")
	arg_1_0._godragItem = gohelper.findChild(arg_1_0.viewGO, "#go_dragItem")
	arg_1_0._imagedrag = gohelper.findChildImage(arg_1_0.viewGO, "#go_dragItem/#image_drag")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

local var_0_1 = SLFramework.AnimatorPlayer

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)

	arg_4_0._bagObjList = {}
	arg_4_0._gridObjList = {}
end

function var_0_0._btnresetOnClick(arg_5_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.V3a1_GaoSiNiao_GameView_Reset, MsgBoxEnum.BoxType.Yes_No, arg_5_0._restartYesCallback, nil, nil, arg_5_0, nil, nil)
end

function var_0_0._restartYesCallback(arg_6_0)
	UIBlockHelper.instance:startBlock(arg_6_0.viewName, 3)
	arg_6_0.viewContainer:track_reset()

	arg_6_0._tmpBagDataList = nil
	arg_6_0._tmpGridDataList = nil

	arg_6_0:_dragContext():_critical_beforeClear()
	arg_6_0.viewContainer:restart()
	arg_6_0:_dragContext():reset(arg_6_0, arg_6_0._godragItemTran, arg_6_0._imagedrag)
	TaskDispatcher.cancelTask(arg_6_0._restartDelayRefresh, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._restartDelayRefresh, arg_6_0, 0.33)
	arg_6_0:_playAnim_reset(arg_6_0._onResetAnimDone, arg_6_0)
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_reset)
end

function var_0_0._onResetAnimDone(arg_7_0)
	UIBlockHelper.instance:endBlock(arg_7_0.viewName)
end

function var_0_0._restartDelayRefresh(arg_8_0)
	arg_8_0:_refresh()
end

function var_0_0._btnCloseOnClick(arg_9_0)
	if not arg_9_0._allowEmptyClose then
		return
	end

	arg_9_0.viewContainer:exitGame()
end

function var_0_0._onReceiveAct210FinishEpisodeReply(arg_10_0)
	arg_10_0._allowEmptyClose = true

	arg_10_0:_setShowCompleted(true)
end

function var_0_0.completeGame(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_win)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._gridObjList) do
		iter_11_1:onCompleteGame()
	end

	arg_11_0.viewContainer:completeGame()
	arg_11_0:_setShowCompleted(true)
end

function var_0_0._dragContext(arg_12_0)
	return arg_12_0.viewContainer:dragContext()
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._btnCloseGo = arg_13_0._btnClose.gameObject
	arg_13_0._btnresetGo = arg_13_0._btnreset.gameObject
	arg_13_0._godragItemTran = arg_13_0._godragItem.transform
	arg_13_0._TargetGo = gohelper.findChild(arg_13_0.viewGO, "Target")
	arg_13_0._goMapGridCmp = arg_13_0._goMap:GetComponent(gohelper.Type_GridLayoutGroup)
	arg_13_0._goMapTran = arg_13_0._goMap.transform

	gohelper.setActive(arg_13_0._gopieceItem, false)
	gohelper.setActive(arg_13_0._goItem, false)
	gohelper.setActive(arg_13_0._godragItem, false)

	arg_13_0._gofinishAnimator = arg_13_0._gofinish:GetComponent(gohelper.Type_Animator)
	arg_13_0._animatorPlayer = var_0_1.Get(arg_13_0.viewGO)

	arg_13_0:_setShowCompleted(false)
end

function var_0_0.onUpdateParam(arg_14_0)
	arg_14_0._tmpBagDataList = nil
	arg_14_0._tmpGridDataList = nil

	arg_14_0:_dragContext():reset(arg_14_0, arg_14_0._godragItemTran, arg_14_0._imagedrag)

	local var_14_0, var_14_1 = arg_14_0.viewContainer:rowCol()

	arg_14_0._goMapGridCmp.constraintCount = var_14_1

	arg_14_0:_refresh()
end

function var_0_0.onOpen(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_open2)
	arg_15_0:onUpdateParam()
	arg_15_0:addEventCb(GaoSiNiaoController.instance, GaoSiNiaoEvent.onReceiveAct210FinishEpisodeReply, arg_15_0._onReceiveAct210FinishEpisodeReply, arg_15_0)
	arg_15_0:addEventCb(GuideController.instance, GuideEvent.FinishGuideLastStep, arg_15_0._onFinishGuideLastStep, arg_15_0)
	arg_15_0:addEventCb(GuideController.instance, GuideEvent.FinishGuideFail, arg_15_0._onFinishGuideFail, arg_15_0)
end

function var_0_0._onFinishGuideLastStep(arg_16_0, arg_16_1)
	if arg_16_1 ~= arg_16_0.viewContainer:guideId() then
		return
	end

	arg_16_0.viewContainer:saveHasPlayedGuide()
	arg_16_0.viewContainer:trackMO():onGameStart()
end

function var_0_0._onFinishGuideFail(arg_17_0)
	arg_17_0.viewContainer:saveHasPlayedGuide()
	arg_17_0.viewContainer:trackMO():onGameStart()

	local var_17_0 = arg_17_0.viewContainer:guideId()

	arg_17_0.viewContainer:directFinishGuide(var_17_0)
end

function var_0_0.onOpenFinish(arg_18_0)
	if not arg_18_0:_playGuide() then
		arg_18_0.viewContainer:trackMO():onGameStart()
	end
end

function var_0_0._playGuide(arg_19_0)
	if GuideController.instance:isForbidGuides() then
		return false
	end

	local var_19_0 = arg_19_0.viewContainer:guideId()

	if not var_19_0 or var_19_0 == 0 then
		return false
	end

	if arg_19_0.viewContainer:hasPlayedGuide() then
		return false
	end

	if arg_19_0.viewContainer:isGuideRunning(var_19_0) then
		GuideController.instance:execNextStep(var_19_0)
	else
		arg_19_0:addEventCb(GuideController.instance, GuideEvent.onReceiveFinishGuideReply, arg_19_0._onReceiveFinishGuideReply, arg_19_0)
		GuideController.instance:startGudie(var_19_0)
	end

	return true
end

function var_0_0._onReceiveFinishGuideReply(arg_20_0)
	local var_20_0 = arg_20_0.viewContainer:guideId()

	if arg_20_0.viewContainer:isGuideRunning(var_20_0) then
		GuideController.instance:execNextStep(var_20_0)
		arg_20_0:removeEventCb(GuideController.instance, GuideEvent.onReceiveFinishGuideReply, arg_20_0._onReceiveFinishGuideReply, arg_20_0)
	end
end

function var_0_0.onClose(arg_21_0)
	GuideStepController.instance:clearStep()
	TaskDispatcher.cancelTask(arg_21_0._restartDelayRefresh, arg_21_0)
end

function var_0_0.onDestroyView(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._restartDelayRefresh, arg_22_0)
	GameUtil.onDestroyViewMemberList(arg_22_0, "_bagObjList")
	GameUtil.onDestroyViewMemberList(arg_22_0, "_gridObjList")
end

function var_0_0._getBagDataList(arg_23_0)
	if not arg_23_0._tmpBagDataList then
		arg_23_0._tmpBagDataList = arg_23_0.viewContainer:bagDataList()
	end

	return arg_23_0._tmpBagDataList
end

function var_0_0._getGridDataList(arg_24_0)
	if not arg_24_0._tmpGridDataList then
		arg_24_0._tmpGridDataList = arg_24_0.viewContainer:gridDataList()
	end

	return arg_24_0._tmpGridDataList
end

function var_0_0._refresh(arg_25_0)
	arg_25_0:_refreshBagList()
	arg_25_0:_refreshGridList()
end

function var_0_0._refreshBagList(arg_26_0)
	local var_26_0 = arg_26_0:_getBagDataList()

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		local var_26_1

		if iter_26_0 > #arg_26_0._bagObjList then
			var_26_1 = arg_26_0:_create_V3a1_GaoSiNiao_GameView_BagItem(iter_26_0)

			table.insert(arg_26_0._bagObjList, var_26_1)
		else
			var_26_1 = arg_26_0._bagObjList[iter_26_0]
		end

		var_26_1:onUpdateMO(iter_26_1)
		var_26_1:setActive(true)
	end

	for iter_26_2 = #var_26_0 + 1, #arg_26_0._bagObjList do
		arg_26_0._bagObjList[iter_26_2]:setActive(false)
	end
end

function var_0_0._refreshGridList(arg_27_0)
	local var_27_0 = arg_27_0:_getGridDataList()

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		local var_27_1

		if iter_27_0 > #arg_27_0._gridObjList then
			var_27_1 = arg_27_0:_create_V3a1_GaoSiNiao_GameView_GridItem(iter_27_0)

			table.insert(arg_27_0._gridObjList, var_27_1)
		else
			var_27_1 = arg_27_0._gridObjList[iter_27_0]
		end

		var_27_1:onUpdateMO(iter_27_1)
		var_27_1:setActive(true)
	end

	for iter_27_2 = #var_27_0 + 1, #arg_27_0._gridObjList do
		arg_27_0._gridObjList[iter_27_2]:setActive(false)
	end
end

function var_0_0._selectNoneAllGrids(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0._gridObjList) do
		iter_28_1:setSelected(false)
	end
end

function var_0_0.onBeginDrag_BagItemObj(arg_29_0, ...)
	arg_29_0:_dragContext():onBeginDrag_BagItemObj(...)
end

function var_0_0.onDragging_BagItemObj(arg_30_0, ...)
	arg_30_0:_dragContext():onDragging_BagItemObj(...)
end

function var_0_0.onEndDrag_BagItemObj(arg_31_0, ...)
	arg_31_0:_dragContext():onEndDrag_BagItemObj(...)
end

function var_0_0.onBeginDrag_GridItemObj(arg_32_0, ...)
	arg_32_0:_dragContext():onBeginDrag_GridItemObj(...)
end

function var_0_0.onDragging_GridItemObj(arg_33_0, ...)
	arg_33_0:_dragContext():onDragging_GridItemObj(...)
end

function var_0_0.onEndDrag_GridItemObj(arg_34_0, ...)
	arg_34_0:_dragContext():onEndDrag_GridItemObj(...)
end

function var_0_0._create_V3a1_GaoSiNiao_GameView_BagItem(arg_35_0, arg_35_1)
	local var_35_0 = gohelper.cloneInPlace(arg_35_0._gopieceItem)
	local var_35_1 = V3a1_GaoSiNiao_GameView_BagItem.New({
		parent = arg_35_0,
		baseViewContainer = arg_35_0.viewContainer
	})

	var_35_1:setIndex(arg_35_1)
	var_35_1:init(var_35_0)

	return var_35_1
end

function var_0_0._create_V3a1_GaoSiNiao_GameView_GridItem(arg_36_0, arg_36_1)
	local var_36_0 = gohelper.cloneInPlace(arg_36_0._goItem)
	local var_36_1 = V3a1_GaoSiNiao_GameView_GridItem.New({
		parent = arg_36_0,
		baseViewContainer = arg_36_0.viewContainer
	})

	var_36_1:setIndex(arg_36_1)
	var_36_1:init(var_36_0)

	return var_36_1
end

function var_0_0._setShowCompleted(arg_37_0, arg_37_1)
	gohelper.setActive(arg_37_0._btnCloseGo, arg_37_1)
	gohelper.setActive(arg_37_0._gofinish, arg_37_1)
	gohelper.setActive(arg_37_0._btnresetGo, not arg_37_1)
	gohelper.setActive(arg_37_0._goPiecePanel, not arg_37_1)
	gohelper.setActive(arg_37_0._goBackBtns, not arg_37_1)
	gohelper.setActive(arg_37_0._TargetGo, not arg_37_1)

	if arg_37_1 then
		arg_37_0._gofinishAnimator:Play(UIAnimationName.Open)
		AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_win2)
	else
		arg_37_0._gofinishAnimator:Play(UIAnimationName.Idle, -1, 0)
	end
end

function var_0_0._playAnim(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	arg_38_0._animatorPlayer:Play(arg_38_1, arg_38_2 or function()
		return
	end, arg_38_3)
end

function var_0_0._playAnim_reset(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0:_playAnim("reset", arg_40_1, arg_40_2)
end

return var_0_0

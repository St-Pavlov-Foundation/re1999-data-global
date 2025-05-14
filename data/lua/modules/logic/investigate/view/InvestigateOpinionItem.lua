module("modules.logic.investigate.view.InvestigateOpinionItem", package.seeall)

local var_0_0 = class("InvestigateOpinionItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "#go_locked")
	arg_1_0._simagelock = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_locked/#simage_lock")
	arg_1_0._btngoto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_locked/#btn_goto")
	arg_1_0._btnlocktip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_locked/#btn_locktip")
	arg_1_0._gounlink = gohelper.findChild(arg_1_0.viewGO, "#go_unlink")
	arg_1_0._simageopinionunlink = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_unlink/#simage_opinionunlink")
	arg_1_0._btnextendunlink = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_unlink/#btn_extendunlink")
	arg_1_0._gounlinkextend = gohelper.findChild(arg_1_0.viewGO, "#go_unlink_extend")
	arg_1_0._simageopinionunlinkextend = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_unlink_extend/#simage_opinionunlinkextend")
	arg_1_0._txtdecunlinkextend = gohelper.findChildText(arg_1_0.viewGO, "#go_unlink_extend/scroll_des/viewport/content/#txt_decunlinkextend")
	arg_1_0._btncloseunlink = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_unlink_extend/#btn_closeunlink")
	arg_1_0._golinked = gohelper.findChild(arg_1_0.viewGO, "#go_linked")
	arg_1_0._simageopinionlink = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_linked/#simage_opinionlink")
	arg_1_0._btnextendlink = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_linked/#btn_extendlink")
	arg_1_0._golinkedextend = gohelper.findChild(arg_1_0.viewGO, "#go_linked_extend")
	arg_1_0._simageopinionlinkextend = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_linked_extend/#simage_opinionlinkextend")
	arg_1_0._txtdeclinkextend = gohelper.findChildText(arg_1_0.viewGO, "#go_linked_extend/scroll_des/viewport/content/#txt_declinkextend")
	arg_1_0._btncloselink = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_linked_extend/#btn_closelink")
	arg_1_0._golineeffect = gohelper.findChild(arg_1_0.viewGO, "#go_lineeffect")
	arg_1_0._imageline = gohelper.findChildImage(arg_1_0.viewGO, "#go_lineeffect/#image_line")
	arg_1_0._imagelineup = gohelper.findChildImage(arg_1_0.viewGO, "#go_lineeffect/#image_lineup")
	arg_1_0._godot = gohelper.findChild(arg_1_0.viewGO, "#go_lineeffect/#go_dot")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngoto:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)
	arg_2_0._btnlocktip:AddClickListener(arg_2_0._btnlocktipOnClick, arg_2_0)
	arg_2_0._btnextendunlink:AddClickListener(arg_2_0._btnextendunlinkOnClick, arg_2_0)
	arg_2_0._btncloseunlink:AddClickListener(arg_2_0._btncloseunlinkOnClick, arg_2_0)
	arg_2_0._btnextendlink:AddClickListener(arg_2_0._btnextendlinkOnClick, arg_2_0)
	arg_2_0._btncloselink:AddClickListener(arg_2_0._btncloselinkOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngoto:RemoveClickListener()
	arg_3_0._btnlocktip:RemoveClickListener()
	arg_3_0._btnextendunlink:RemoveClickListener()
	arg_3_0._btncloseunlink:RemoveClickListener()
	arg_3_0._btnextendlink:RemoveClickListener()
	arg_3_0._btncloselink:RemoveClickListener()
end

function var_0_0._btnlocktipOnClick(arg_4_0)
	GameFacade.showToast(ToastEnum.InvestigateTip2)
end

function var_0_0._btnextendunlinkOnClick(arg_5_0)
	gohelper.setAsLastSibling(arg_5_0._opinionGo)
	arg_5_0:_updateStatus(InvestigateEnum.OpinionStatus.UnlinkedExtend)
	arg_5_0:_onScreenSizeChange()
	arg_5_0:_hideReddot()
end

function var_0_0._btnextendlinkOnClick(arg_6_0)
	gohelper.setAsLastSibling(arg_6_0._opinionGo)
	arg_6_0:_updateStatus(InvestigateEnum.OpinionStatus.LinkedExtend)
	arg_6_0:_onScreenSizeChange()
end

function var_0_0._btncloseunlinkOnClick(arg_7_0)
	arg_7_0._btncloseunlink.button.enabled = false

	arg_7_0._unlinkextendPlayer:Play(arg_7_0:_getFullAnimName("close"), arg_7_0._closeunlinkHandler, arg_7_0)
end

function var_0_0._closeunlinkHandler(arg_8_0)
	arg_8_0:_updateStatus(InvestigateEnum.OpinionStatus.Unlinked)
end

function var_0_0._btncloselinkOnClick(arg_9_0)
	arg_9_0:_startFrameUpdateLine()

	arg_9_0._btncloselink.button.enabled = false

	arg_9_0._linkextendPlayer:Play(arg_9_0:_getFullAnimName("close"), arg_9_0._closelinkHandler, arg_9_0)
end

function var_0_0._closelinkHandler(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._frameUpdateLine, arg_10_0)
	arg_10_0:_updateStatus(InvestigateEnum.OpinionStatus.Linked)
end

function var_0_0._btngotoOnClick(arg_11_0)
	if not arg_11_0._mapElementConfig then
		return
	end

	local var_11_0 = arg_11_0._mapElementConfig.mapId
	local var_11_1 = string.format("4#%s#1", var_11_0)

	JumpController.instance:jumpTo(var_11_1)
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0._statusHandler = arg_12_0:getUserDataTb_()
	arg_12_0._statusHandler[InvestigateEnum.OpinionStatus.Locked] = arg_12_0._lockHandler
	arg_12_0._statusHandler[InvestigateEnum.OpinionStatus.Unlinked] = arg_12_0._unlinkedHandler
	arg_12_0._statusHandler[InvestigateEnum.OpinionStatus.UnlinkedExtend] = arg_12_0._unlinkedExtendHandler
	arg_12_0._statusHandler[InvestigateEnum.OpinionStatus.Linked] = arg_12_0._linkedHandler
	arg_12_0._statusHandler[InvestigateEnum.OpinionStatus.LinkedExtend] = arg_12_0._linkedExtendHandler
	arg_12_0._statusGoList = arg_12_0:getUserDataTb_()
	arg_12_0._statusGoList[InvestigateEnum.OpinionStatus.Locked] = arg_12_0._golocked
	arg_12_0._statusGoList[InvestigateEnum.OpinionStatus.Unlinked] = arg_12_0._gounlink
	arg_12_0._statusGoList[InvestigateEnum.OpinionStatus.UnlinkedExtend] = arg_12_0._gounlinkextend
	arg_12_0._statusGoList[InvestigateEnum.OpinionStatus.Linked] = arg_12_0._golinked
	arg_12_0._statusGoList[InvestigateEnum.OpinionStatus.LinkedExtend] = arg_12_0._golinkedextend
	arg_12_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_12_0.viewGO)
	arg_12_0._defaultPosX = recthelper.getAnchorX(arg_12_0._gounlinkextend.transform)
	arg_12_0._uiRootTrans = ViewMgr.instance:getUIRoot().transform
	arg_12_0._lockedAnimator = arg_12_0._golocked:GetComponent("Animator")
	arg_12_0._unlinkextendPlayer = ZProj.ProjAnimatorPlayer.Get(arg_12_0._gounlinkextend)
	arg_12_0._linkextendPlayer = ZProj.ProjAnimatorPlayer.Get(arg_12_0._golinkedextend)
	arg_12_0._redDotComp = RedDotController.instance:addNotEventRedDot(arg_12_0._goreddot, arg_12_0._isShowRedDot, arg_12_0)

	local var_12_0 = AudioEnum.VersionActivity2_2Investigate.play_ui_activity_act

	gohelper.addUIClickAudio(arg_12_0._btncloselink.gameObject, var_12_0)
	gohelper.addUIClickAudio(arg_12_0._btncloseunlink.gameObject, var_12_0)
	gohelper.addUIClickAudio(arg_12_0._btnextendlink.gameObject, var_12_0)
	gohelper.addUIClickAudio(arg_12_0._btnextendunlink.gameObject, var_12_0)
end

function var_0_0._isShowRedDot(arg_13_0)
	return not arg_13_0._inExtendView and arg_13_0._mo and InvestigateController.showClueRedDot(arg_13_0._mo.id)
end

function var_0_0._hideReddot(arg_14_0)
	if not arg_14_0._redDotComp.isShowRedDot or not arg_14_0._mo then
		return
	end

	InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.ReddotClue, arg_14_0._mo.id)
	arg_14_0._redDotComp:refreshRedDot()
end

function var_0_0.setInExtendView(arg_15_0, arg_15_1)
	arg_15_0._inExtendView = arg_15_1

	gohelper.setActive(arg_15_0._btnextendunlink, not arg_15_1)
	gohelper.setActive(arg_15_0._btnextendlink, not arg_15_1)
end

function var_0_0._updateStatus(arg_16_0, arg_16_1)
	TaskDispatcher.cancelTask(arg_16_0._frameUpdateLine, arg_16_0)

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._statusGoList) do
		gohelper.setActive(iter_16_1, iter_16_0 == arg_16_1)
	end

	local var_16_0 = arg_16_0._curStatus

	arg_16_0._curStatus = arg_16_1

	arg_16_0._statusHandler[arg_16_1](arg_16_0, var_16_0)
end

function var_0_0._lockHandler(arg_17_0)
	local var_17_0 = DungeonMapModel.instance:getElementById(arg_17_0._mo.mapElement)

	gohelper.setActive(arg_17_0._btngoto, var_17_0)
	gohelper.setActive(arg_17_0._btnlocktip, not var_17_0)
	gohelper.setActive(arg_17_0._btnlocktip, true)
	arg_17_0._simagelock:LoadImage(arg_17_0._mo.mapResLocked)
end

function var_0_0._unlinkedHandler(arg_18_0, arg_18_1)
	if not InvestigateController.hasOnceActionKey(InvestigateEnum.OnceActionType.ClueUnlock, arg_18_0._mo.id) then
		InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.ClueUnlock, arg_18_0._mo.id)
		gohelper.setActive(arg_18_0._golocked, true)
		gohelper.setActive(arg_18_0._btnlocktip, false)
		arg_18_0._lockedAnimator:Play("unlock")
	end
end

function var_0_0._unlinkedExtendHandler(arg_19_0)
	arg_19_0._btncloseunlink.button.enabled = true
	arg_19_0._txtdecunlinkextend.text = arg_19_0._mo.detailedDesc

	arg_19_0._unlinkextendPlayer:Play(arg_19_0:_getFullAnimName("open"), arg_19_0._openunlinkExtendHandler, arg_19_0)
end

function var_0_0._openunlinkExtendHandler(arg_20_0)
	return
end

function var_0_0._linkedHandler(arg_21_0, arg_21_1)
	if arg_21_0._inExtendView then
		gohelper.setActive(arg_21_0._golineeffect, false)

		return
	end

	arg_21_0:_initLineEffect()
	arg_21_0:_setLineStartPos()
	arg_21_0:_setLineEndPos()
	gohelper.setActive(arg_21_0._golineeffect, true)
end

function var_0_0._linkedExtendHandler(arg_22_0, arg_22_1)
	arg_22_0._btncloselink.button.enabled = true
	arg_22_0._txtdeclinkextend.text = arg_22_0._mo.detailedDesc

	gohelper.setActive(arg_22_0._golineeffect, true)

	if arg_22_1 == InvestigateEnum.OpinionStatus.UnlinkedExtend then
		TaskDispatcher.cancelTask(arg_22_0._frameUpdateLine, arg_22_0)
		TaskDispatcher.runDelay(arg_22_0._frameUpdateLine, arg_22_0, 0)
		arg_22_0._linkextendPlayer:Play(arg_22_0:_getFullAnimName("idle"), arg_22_0._openlinkExtendHandler, arg_22_0)

		return
	end

	arg_22_0:_startFrameUpdateLine()
	arg_22_0._linkextendPlayer:Play(arg_22_0:_getFullAnimName("open"), arg_22_0._openlinkExtendHandler, arg_22_0)
end

function var_0_0._openlinkExtendHandler(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._frameUpdateLine, arg_23_0)
end

function var_0_0._startFrameUpdateLine(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._frameUpdateLine, arg_24_0)
	TaskDispatcher.runRepeat(arg_24_0._frameUpdateLine, arg_24_0, 0)
end

function var_0_0._frameUpdateLine(arg_25_0)
	arg_25_0:_initLineEffect()
	arg_25_0:_setLineStartPos()
	arg_25_0:_setLineEndPos()
end

function var_0_0._editableAddEvents(arg_26_0)
	arg_26_0._drag:AddDragBeginListener(arg_26_0._onDragBegin, arg_26_0)
	arg_26_0._drag:AddDragEndListener(arg_26_0._onDragEnd, arg_26_0)
	arg_26_0._drag:AddDragListener(arg_26_0._onDrag, arg_26_0)
	arg_26_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_26_0._onScreenSizeChange, arg_26_0)
end

function var_0_0._editableRemoveEvents(arg_27_0)
	arg_27_0._drag:RemoveDragBeginListener()
	arg_27_0._drag:RemoveDragListener()
	arg_27_0._drag:RemoveDragEndListener()
end

function var_0_0._onDragBegin(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:_canShowEffect()

	if not arg_28_0._collider2D or var_28_0 or arg_28_0._curStatus == InvestigateEnum.OpinionStatus.Locked then
		return
	end

	arg_28_0._dragBeginPos = arg_28_0:getDragWorldPos(arg_28_2)

	arg_28_0:_initLineEffect()
	arg_28_0:_setLineStartPos(true)
	gohelper.setActive(arg_28_0._golineeffect, true)
	gohelper.setActive(arg_28_0._goDragTip, true)
	arg_28_0:_hideReddot()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_gudu_kaishi)
end

function var_0_0._onDragEnd(arg_29_0, arg_29_1, arg_29_2)
	gohelper.setActive(arg_29_0._goDragTip, false)

	if not arg_29_0._dragBeginPos then
		return
	end

	arg_29_0._dragBeginPos = nil

	local var_29_0 = arg_29_0:getDragWorldPos(arg_29_2)

	if arg_29_0._collider2D and arg_29_0._collider2D:OverlapPoint(var_29_0) then
		local var_29_1 = arg_29_0._curStatus == InvestigateEnum.OpinionStatus.Unlinked and InvestigateEnum.OpinionStatus.Linked or InvestigateEnum.OpinionStatus.LinkedExtend

		arg_29_0:_updateStatus(var_29_1)
		InvestigateRpc.instance:sendPutClueRequest(arg_29_0._mo.infoID, arg_29_0._mo.id)
	end

	local var_29_2 = arg_29_0:_canShowEffect()

	gohelper.setActive(arg_29_0._golineeffect, var_29_2)
end

function var_0_0._canShowEffect(arg_30_0)
	return arg_30_0._curStatus == InvestigateEnum.OpinionStatus.Linked or arg_30_0._curStatus == InvestigateEnum.OpinionStatus.LinkedExtend
end

function var_0_0._onDrag(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_0._dragBeginPos then
		return
	end

	local var_31_0 = arg_31_0:getDragWorldPos(arg_31_2)
	local var_31_1, var_31_2 = recthelper.rectToRelativeAnchorPos2(var_31_0, arg_31_0._uiRootTrans)

	arg_31_0:_setLinePosition(arg_31_0._imagelineMat, arg_31_0._endKey, var_31_1, var_31_2)
	arg_31_0:_setLinePosition(arg_31_0._imagelineupMat, arg_31_0._endKey, var_31_1, var_31_2)

	arg_31_0._godot.transform.position = var_31_0
end

function var_0_0.getDragWorldPos(arg_32_0, arg_32_1)
	local var_32_0 = CameraMgr.instance:getUICamera()
	local var_32_1 = arg_32_0.viewGO.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_32_1.position, var_32_0, var_32_1))
end

function var_0_0._initLineEffect(arg_33_0)
	if arg_33_0._startKey then
		return
	end

	arg_33_0._imagelineMat = UnityEngine.GameObject.Instantiate(arg_33_0._imageline.material)
	arg_33_0._imageline.material = arg_33_0._imagelineMat
	arg_33_0._imagelineupMat = UnityEngine.GameObject.Instantiate(arg_33_0._imagelineup.material)
	arg_33_0._imagelineup.material = arg_33_0._imagelineupMat
	arg_33_0._matTempVector = Vector4(0, 0, 0, 0)

	local var_33_0 = UnityEngine.Shader

	arg_33_0._startKey = var_33_0.PropertyToID("_StartVec")
	arg_33_0._endKey = var_33_0.PropertyToID("_EndVec")
end

function var_0_0._setLineStartPos(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0._statusGoList[arg_34_0._curStatus]
	local var_34_1 = gohelper.findChild(var_34_0, "img_hole").transform.position
	local var_34_2, var_34_3 = recthelper.rectToRelativeAnchorPos2(var_34_1, arg_34_0._uiRootTrans)

	arg_34_0:_setLinePosition(arg_34_0._imagelineMat, arg_34_0._startKey, var_34_2, var_34_3)
	arg_34_0:_setLinePosition(arg_34_0._imagelineupMat, arg_34_0._startKey, var_34_2, var_34_3)

	if arg_34_1 then
		gohelper.setAsLastSibling(arg_34_0._opinionGo)
	end
end

function var_0_0._setLineEndPos(arg_35_0)
	local var_35_0 = arg_35_0._nodeEndGo.transform.position
	local var_35_1, var_35_2 = recthelper.rectToRelativeAnchorPos2(var_35_0, arg_35_0._uiRootTrans)

	arg_35_0:_setLinePosition(arg_35_0._imagelineMat, arg_35_0._endKey, var_35_1, var_35_2)
	arg_35_0:_setLinePosition(arg_35_0._imagelineupMat, arg_35_0._endKey, var_35_1, var_35_2)

	arg_35_0._godot.transform.position = var_35_0
end

function var_0_0._setLinePosition(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	arg_36_0._matTempVector.x = arg_36_3
	arg_36_0._matTempVector.y = arg_36_4

	arg_36_1:SetVector(arg_36_2, arg_36_0._matTempVector)
end

function var_0_0._onScreenSizeChange(arg_37_0)
	return
end

function var_0_0._doScreenSizeChange(arg_38_0)
	local var_38_0

	if arg_38_0._curStatus == InvestigateEnum.OpinionStatus.LinkedExtend or arg_38_0._curStatus == InvestigateEnum.OpinionStatus.UnlinkedExtend then
		var_38_0 = arg_38_0._statusGoList[arg_38_0._curStatus]
	end

	if not var_38_0 then
		return
	end

	local var_38_1 = var_38_0.transform
	local var_38_2 = arg_38_0._uiRootTrans
	local var_38_3 = recthelper.getWidth(var_38_1)

	recthelper.setAnchorX(var_38_1, arg_38_0._defaultPosX)

	local var_38_4 = arg_38_0._defaultPosX
	local var_38_5 = recthelper.rectToRelativeAnchorPos(var_38_1.position, var_38_2).x
	local var_38_6 = recthelper.getWidth(var_38_2) * 0.5 - var_38_3 * 0.5
	local var_38_7 = -var_38_6

	if var_38_5 < var_38_7 then
		recthelper.setAnchorX(var_38_1, var_38_4 + var_38_7 - var_38_5)

		return
	end

	local var_38_8 = var_38_6

	if var_38_8 < var_38_5 then
		recthelper.setAnchorX(var_38_1, var_38_4 + var_38_8 - var_38_5)

		return
	end
end

function var_0_0.setIndex(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0._index = arg_39_1
	arg_39_0._num = arg_39_2
end

function var_0_0._getFullAnimName(arg_40_0, arg_40_1)
	return (string.format("%s_%s", arg_40_0:_getPosAnimName(), arg_40_1))
end

function var_0_0._getPosAnimName(arg_41_0)
	if arg_41_0._num == 1 then
		return InvestigateEnum.ExtendAnimName.Middle
	end

	if arg_41_0._num == 3 and arg_41_0._index == 2 then
		return InvestigateEnum.ExtendAnimName.Middle
	end

	if arg_41_0._index == 1 then
		return InvestigateEnum.ExtendAnimName.Left
	end

	return InvestigateEnum.ExtendAnimName.Right
end

function var_0_0.onUpdateMO(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5)
	arg_42_0._mo = arg_42_1
	arg_42_0._collider2D = arg_42_2
	arg_42_0._opinionGo = arg_42_3
	arg_42_0._nodeEndGo = arg_42_4
	arg_42_0._goDragTip = arg_42_5
	arg_42_0._mapElementConfig = arg_42_0._mo.mapElement ~= 0 and lua_chapter_map_element.configDict[arg_42_0._mo.mapElement]

	if arg_42_0:_isUnlocked() then
		local var_42_0 = InvestigateOpinionModel.instance:getLinkedStatus(arg_42_0._mo.id) and InvestigateEnum.OpinionStatus.Linked or InvestigateEnum.OpinionStatus.Unlinked

		arg_42_0:_updateStatus(var_42_0)
	else
		arg_42_0:_updateStatus(InvestigateEnum.OpinionStatus.Locked)
	end

	local var_42_1 = arg_42_0._mo.res

	arg_42_0._simageopinionlink:LoadImage(var_42_1)
	arg_42_0._simageopinionlinkextend:LoadImage(var_42_1)
	arg_42_0._simageopinionunlink:LoadImage(var_42_1)
	arg_42_0._simageopinionunlinkextend:LoadImage(var_42_1)
	arg_42_0._redDotComp:refreshRedDot()
end

function var_0_0._isUnlocked(arg_43_0)
	return InvestigateOpinionModel.instance:isUnlocked(arg_43_0._mo.id)
end

function var_0_0.onSelect(arg_44_0, arg_44_1)
	return
end

function var_0_0.onDestroyView(arg_45_0)
	arg_45_0._dragBeginPos = nil

	TaskDispatcher.cancelTask(arg_45_0._frameUpdateLine, arg_45_0)
end

return var_0_0

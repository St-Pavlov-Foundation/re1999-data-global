module("modules.logic.investigate.view.InvestigateOpinionItem", package.seeall)

slot0 = class("InvestigateOpinionItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._golocked = gohelper.findChild(slot0.viewGO, "#go_locked")
	slot0._simagelock = gohelper.findChildSingleImage(slot0.viewGO, "#go_locked/#simage_lock")
	slot0._btngoto = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_locked/#btn_goto")
	slot0._btnlocktip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_locked/#btn_locktip")
	slot0._gounlink = gohelper.findChild(slot0.viewGO, "#go_unlink")
	slot0._simageopinionunlink = gohelper.findChildSingleImage(slot0.viewGO, "#go_unlink/#simage_opinionunlink")
	slot0._btnextendunlink = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_unlink/#btn_extendunlink")
	slot0._gounlinkextend = gohelper.findChild(slot0.viewGO, "#go_unlink_extend")
	slot0._simageopinionunlinkextend = gohelper.findChildSingleImage(slot0.viewGO, "#go_unlink_extend/#simage_opinionunlinkextend")
	slot0._txtdecunlinkextend = gohelper.findChildText(slot0.viewGO, "#go_unlink_extend/scroll_des/viewport/content/#txt_decunlinkextend")
	slot0._btncloseunlink = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_unlink_extend/#btn_closeunlink")
	slot0._golinked = gohelper.findChild(slot0.viewGO, "#go_linked")
	slot0._simageopinionlink = gohelper.findChildSingleImage(slot0.viewGO, "#go_linked/#simage_opinionlink")
	slot0._btnextendlink = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_linked/#btn_extendlink")
	slot0._golinkedextend = gohelper.findChild(slot0.viewGO, "#go_linked_extend")
	slot0._simageopinionlinkextend = gohelper.findChildSingleImage(slot0.viewGO, "#go_linked_extend/#simage_opinionlinkextend")
	slot0._txtdeclinkextend = gohelper.findChildText(slot0.viewGO, "#go_linked_extend/scroll_des/viewport/content/#txt_declinkextend")
	slot0._btncloselink = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_linked_extend/#btn_closelink")
	slot0._golineeffect = gohelper.findChild(slot0.viewGO, "#go_lineeffect")
	slot0._imageline = gohelper.findChildImage(slot0.viewGO, "#go_lineeffect/#image_line")
	slot0._imagelineup = gohelper.findChildImage(slot0.viewGO, "#go_lineeffect/#image_lineup")
	slot0._godot = gohelper.findChild(slot0.viewGO, "#go_lineeffect/#go_dot")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#go_reddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	slot0._btnlocktip:AddClickListener(slot0._btnlocktipOnClick, slot0)
	slot0._btnextendunlink:AddClickListener(slot0._btnextendunlinkOnClick, slot0)
	slot0._btncloseunlink:AddClickListener(slot0._btncloseunlinkOnClick, slot0)
	slot0._btnextendlink:AddClickListener(slot0._btnextendlinkOnClick, slot0)
	slot0._btncloselink:AddClickListener(slot0._btncloselinkOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btngoto:RemoveClickListener()
	slot0._btnlocktip:RemoveClickListener()
	slot0._btnextendunlink:RemoveClickListener()
	slot0._btncloseunlink:RemoveClickListener()
	slot0._btnextendlink:RemoveClickListener()
	slot0._btncloselink:RemoveClickListener()
end

function slot0._btnlocktipOnClick(slot0)
	GameFacade.showToast(ToastEnum.InvestigateTip2)
end

function slot0._btnextendunlinkOnClick(slot0)
	gohelper.setAsLastSibling(slot0._opinionGo)
	slot0:_updateStatus(InvestigateEnum.OpinionStatus.UnlinkedExtend)
	slot0:_onScreenSizeChange()
	slot0:_hideReddot()
end

function slot0._btnextendlinkOnClick(slot0)
	gohelper.setAsLastSibling(slot0._opinionGo)
	slot0:_updateStatus(InvestigateEnum.OpinionStatus.LinkedExtend)
	slot0:_onScreenSizeChange()
end

function slot0._btncloseunlinkOnClick(slot0)
	slot0._btncloseunlink.button.enabled = false

	slot0._unlinkextendPlayer:Play(slot0:_getFullAnimName("close"), slot0._closeunlinkHandler, slot0)
end

function slot0._closeunlinkHandler(slot0)
	slot0:_updateStatus(InvestigateEnum.OpinionStatus.Unlinked)
end

function slot0._btncloselinkOnClick(slot0)
	slot0:_startFrameUpdateLine()

	slot0._btncloselink.button.enabled = false

	slot0._linkextendPlayer:Play(slot0:_getFullAnimName("close"), slot0._closelinkHandler, slot0)
end

function slot0._closelinkHandler(slot0)
	TaskDispatcher.cancelTask(slot0._frameUpdateLine, slot0)
	slot0:_updateStatus(InvestigateEnum.OpinionStatus.Linked)
end

function slot0._btngotoOnClick(slot0)
	if not slot0._mapElementConfig then
		return
	end

	JumpController.instance:jumpTo(string.format("4#%s#1", slot0._mapElementConfig.mapId))
end

function slot0._editableInitView(slot0)
	slot0._statusHandler = slot0:getUserDataTb_()
	slot0._statusHandler[InvestigateEnum.OpinionStatus.Locked] = slot0._lockHandler
	slot0._statusHandler[InvestigateEnum.OpinionStatus.Unlinked] = slot0._unlinkedHandler
	slot0._statusHandler[InvestigateEnum.OpinionStatus.UnlinkedExtend] = slot0._unlinkedExtendHandler
	slot0._statusHandler[InvestigateEnum.OpinionStatus.Linked] = slot0._linkedHandler
	slot0._statusHandler[InvestigateEnum.OpinionStatus.LinkedExtend] = slot0._linkedExtendHandler
	slot0._statusGoList = slot0:getUserDataTb_()
	slot0._statusGoList[InvestigateEnum.OpinionStatus.Locked] = slot0._golocked
	slot0._statusGoList[InvestigateEnum.OpinionStatus.Unlinked] = slot0._gounlink
	slot0._statusGoList[InvestigateEnum.OpinionStatus.UnlinkedExtend] = slot0._gounlinkextend
	slot0._statusGoList[InvestigateEnum.OpinionStatus.Linked] = slot0._golinked
	slot0._statusGoList[InvestigateEnum.OpinionStatus.LinkedExtend] = slot0._golinkedextend
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0.viewGO)
	slot0._defaultPosX = recthelper.getAnchorX(slot0._gounlinkextend.transform)
	slot0._uiRootTrans = ViewMgr.instance:getUIRoot().transform
	slot0._lockedAnimator = slot0._golocked:GetComponent("Animator")
	slot0._unlinkextendPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._gounlinkextend)
	slot0._linkextendPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._golinkedextend)
	slot0._redDotComp = RedDotController.instance:addNotEventRedDot(slot0._goreddot, slot0._isShowRedDot, slot0)
	slot1 = AudioEnum.VersionActivity2_2Investigate.play_ui_activity_act

	gohelper.addUIClickAudio(slot0._btncloselink.gameObject, slot1)
	gohelper.addUIClickAudio(slot0._btncloseunlink.gameObject, slot1)
	gohelper.addUIClickAudio(slot0._btnextendlink.gameObject, slot1)
	gohelper.addUIClickAudio(slot0._btnextendunlink.gameObject, slot1)
end

function slot0._isShowRedDot(slot0)
	return not slot0._inExtendView and slot0._mo and InvestigateController.showClueRedDot(slot0._mo.id)
end

function slot0._hideReddot(slot0)
	if not slot0._redDotComp.isShowRedDot or not slot0._mo then
		return
	end

	InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.ReddotClue, slot0._mo.id)
	slot0._redDotComp:refreshRedDot()
end

function slot0.setInExtendView(slot0, slot1)
	slot0._inExtendView = slot1

	gohelper.setActive(slot0._btnextendunlink, not slot1)
	gohelper.setActive(slot0._btnextendlink, not slot1)
end

function slot0._updateStatus(slot0, slot1)
	slot5 = slot0

	TaskDispatcher.cancelTask(slot0._frameUpdateLine, slot5)

	for slot5, slot6 in ipairs(slot0._statusGoList) do
		gohelper.setActive(slot6, slot5 == slot1)
	end

	slot0._curStatus = slot1

	slot0._statusHandler[slot1](slot0, slot0._curStatus)
end

function slot0._lockHandler(slot0)
	slot1 = DungeonMapModel.instance:getElementById(slot0._mo.mapElement)

	gohelper.setActive(slot0._btngoto, slot1)
	gohelper.setActive(slot0._btnlocktip, not slot1)
	gohelper.setActive(slot0._btnlocktip, true)
	slot0._simagelock:LoadImage(slot0._mo.mapResLocked)
end

function slot0._unlinkedHandler(slot0, slot1)
	if not InvestigateController.hasOnceActionKey(InvestigateEnum.OnceActionType.ClueUnlock, slot0._mo.id) then
		InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.ClueUnlock, slot0._mo.id)
		gohelper.setActive(slot0._golocked, true)
		gohelper.setActive(slot0._btnlocktip, false)
		slot0._lockedAnimator:Play("unlock")
	end
end

function slot0._unlinkedExtendHandler(slot0)
	slot0._btncloseunlink.button.enabled = true
	slot0._txtdecunlinkextend.text = slot0._mo.detailedDesc

	slot0._unlinkextendPlayer:Play(slot0:_getFullAnimName("open"), slot0._openunlinkExtendHandler, slot0)
end

function slot0._openunlinkExtendHandler(slot0)
end

function slot0._linkedHandler(slot0, slot1)
	if slot0._inExtendView then
		gohelper.setActive(slot0._golineeffect, false)

		return
	end

	slot0:_initLineEffect()
	slot0:_setLineStartPos()
	slot0:_setLineEndPos()
	gohelper.setActive(slot0._golineeffect, true)
end

function slot0._linkedExtendHandler(slot0, slot1)
	slot0._btncloselink.button.enabled = true
	slot0._txtdeclinkextend.text = slot0._mo.detailedDesc

	gohelper.setActive(slot0._golineeffect, true)

	if slot1 == InvestigateEnum.OpinionStatus.UnlinkedExtend then
		TaskDispatcher.cancelTask(slot0._frameUpdateLine, slot0)
		TaskDispatcher.runDelay(slot0._frameUpdateLine, slot0, 0)
		slot0._linkextendPlayer:Play(slot0:_getFullAnimName("idle"), slot0._openlinkExtendHandler, slot0)

		return
	end

	slot0:_startFrameUpdateLine()
	slot0._linkextendPlayer:Play(slot0:_getFullAnimName("open"), slot0._openlinkExtendHandler, slot0)
end

function slot0._openlinkExtendHandler(slot0)
	TaskDispatcher.cancelTask(slot0._frameUpdateLine, slot0)
end

function slot0._startFrameUpdateLine(slot0)
	TaskDispatcher.cancelTask(slot0._frameUpdateLine, slot0)
	TaskDispatcher.runRepeat(slot0._frameUpdateLine, slot0, 0)
end

function slot0._frameUpdateLine(slot0)
	slot0:_initLineEffect()
	slot0:_setLineStartPos()
	slot0:_setLineEndPos()
end

function slot0._editableAddEvents(slot0)
	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenSizeChange, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()
end

function slot0._onDragBegin(slot0, slot1, slot2)
	if not slot0._collider2D or slot0:_canShowEffect() or slot0._curStatus == InvestigateEnum.OpinionStatus.Locked then
		return
	end

	slot0._dragBeginPos = slot0:getDragWorldPos(slot2)

	slot0:_initLineEffect()
	slot0:_setLineStartPos(true)
	gohelper.setActive(slot0._golineeffect, true)
	gohelper.setActive(slot0._goDragTip, true)
	slot0:_hideReddot()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_gudu_kaishi)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	gohelper.setActive(slot0._goDragTip, false)

	if not slot0._dragBeginPos then
		return
	end

	slot0._dragBeginPos = nil

	if slot0._collider2D and slot0._collider2D:OverlapPoint(slot0:getDragWorldPos(slot2)) then
		slot0:_updateStatus(slot0._curStatus == InvestigateEnum.OpinionStatus.Unlinked and InvestigateEnum.OpinionStatus.Linked or InvestigateEnum.OpinionStatus.LinkedExtend)
		InvestigateRpc.instance:sendPutClueRequest(slot0._mo.infoID, slot0._mo.id)
	end

	gohelper.setActive(slot0._golineeffect, slot0:_canShowEffect())
end

function slot0._canShowEffect(slot0)
	return slot0._curStatus == InvestigateEnum.OpinionStatus.Linked or slot0._curStatus == InvestigateEnum.OpinionStatus.LinkedExtend
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0._dragBeginPos then
		return
	end

	slot3 = slot0:getDragWorldPos(slot2)
	slot4, slot5 = recthelper.rectToRelativeAnchorPos2(slot3, slot0._uiRootTrans)

	slot0:_setLinePosition(slot0._imagelineMat, slot0._endKey, slot4, slot5)
	slot0:_setLinePosition(slot0._imagelineupMat, slot0._endKey, slot4, slot5)

	slot0._godot.transform.position = slot3
end

function slot0.getDragWorldPos(slot0, slot1)
	return SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(slot1.position, CameraMgr.instance:getUICamera(), slot0.viewGO.transform.position)
end

function slot0._initLineEffect(slot0)
	if slot0._startKey then
		return
	end

	slot0._imagelineMat = UnityEngine.GameObject.Instantiate(slot0._imageline.material)
	slot0._imageline.material = slot0._imagelineMat
	slot0._imagelineupMat = UnityEngine.GameObject.Instantiate(slot0._imagelineup.material)
	slot0._imagelineup.material = slot0._imagelineupMat
	slot0._matTempVector = Vector4(0, 0, 0, 0)
	slot1 = UnityEngine.Shader
	slot0._startKey = slot1.PropertyToID("_StartVec")
	slot0._endKey = slot1.PropertyToID("_EndVec")
end

function slot0._setLineStartPos(slot0, slot1)
	slot5, slot6 = recthelper.rectToRelativeAnchorPos2(gohelper.findChild(slot0._statusGoList[slot0._curStatus], "img_hole").transform.position, slot0._uiRootTrans)

	slot0:_setLinePosition(slot0._imagelineMat, slot0._startKey, slot5, slot6)
	slot0:_setLinePosition(slot0._imagelineupMat, slot0._startKey, slot5, slot6)

	if slot1 then
		gohelper.setAsLastSibling(slot0._opinionGo)
	end
end

function slot0._setLineEndPos(slot0)
	slot1 = slot0._nodeEndGo.transform.position
	slot2, slot3 = recthelper.rectToRelativeAnchorPos2(slot1, slot0._uiRootTrans)

	slot0:_setLinePosition(slot0._imagelineMat, slot0._endKey, slot2, slot3)
	slot0:_setLinePosition(slot0._imagelineupMat, slot0._endKey, slot2, slot3)

	slot0._godot.transform.position = slot1
end

function slot0._setLinePosition(slot0, slot1, slot2, slot3, slot4)
	slot0._matTempVector.x = slot3
	slot0._matTempVector.y = slot4

	slot1:SetVector(slot2, slot0._matTempVector)
end

function slot0._onScreenSizeChange(slot0)
end

function slot0._doScreenSizeChange(slot0)
	slot1 = nil

	if slot0._curStatus == InvestigateEnum.OpinionStatus.LinkedExtend or slot0._curStatus == InvestigateEnum.OpinionStatus.UnlinkedExtend then
		slot1 = slot0._statusGoList[slot0._curStatus]
	end

	if not slot1 then
		return
	end

	slot2 = slot1.transform
	slot3 = slot0._uiRootTrans

	recthelper.setAnchorX(slot2, slot0._defaultPosX)

	if recthelper.rectToRelativeAnchorPos(slot2.position, slot3).x < -(recthelper.getWidth(slot3) * 0.5 - recthelper.getWidth(slot2) * 0.5) then
		recthelper.setAnchorX(slot2, slot0._defaultPosX + slot10 - slot7)

		return
	end

	if slot9 < slot7 then
		recthelper.setAnchorX(slot2, slot5 + slot11 - slot7)

		return
	end
end

function slot0.setIndex(slot0, slot1, slot2)
	slot0._index = slot1
	slot0._num = slot2
end

function slot0._getFullAnimName(slot0, slot1)
	return string.format("%s_%s", slot0:_getPosAnimName(), slot1)
end

function slot0._getPosAnimName(slot0)
	if slot0._num == 1 then
		return InvestigateEnum.ExtendAnimName.Middle
	end

	if slot0._num == 3 and slot0._index == 2 then
		return InvestigateEnum.ExtendAnimName.Middle
	end

	if slot0._index == 1 then
		return InvestigateEnum.ExtendAnimName.Left
	end

	return InvestigateEnum.ExtendAnimName.Right
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._mo = slot1
	slot0._collider2D = slot2
	slot0._opinionGo = slot3
	slot0._nodeEndGo = slot4
	slot0._goDragTip = slot5
	slot0._mapElementConfig = slot0._mo.mapElement ~= 0 and lua_chapter_map_element.configDict[slot0._mo.mapElement]

	if slot0:_isUnlocked() then
		slot0:_updateStatus(InvestigateOpinionModel.instance:getLinkedStatus(slot0._mo.id) and InvestigateEnum.OpinionStatus.Linked or InvestigateEnum.OpinionStatus.Unlinked)
	else
		slot0:_updateStatus(InvestigateEnum.OpinionStatus.Locked)
	end

	slot6 = slot0._mo.res

	slot0._simageopinionlink:LoadImage(slot6)
	slot0._simageopinionlinkextend:LoadImage(slot6)
	slot0._simageopinionunlink:LoadImage(slot6)
	slot0._simageopinionunlinkextend:LoadImage(slot6)
	slot0._redDotComp:refreshRedDot()
end

function slot0._isUnlocked(slot0)
	return InvestigateOpinionModel.instance:isUnlocked(slot0._mo.id)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._dragBeginPos = nil

	TaskDispatcher.cancelTask(slot0._frameUpdateLine, slot0)
end

return slot0

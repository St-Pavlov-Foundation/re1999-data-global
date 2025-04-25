module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoGameView", package.seeall)

slot0 = class("FeiLinShiDuoGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._imagecolorBg = gohelper.findChildImage(slot0.viewGO, "bg/#image_colorBg")
	slot0._simageDec = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_Dec")
	slot0._goscene = gohelper.findChild(slot0.viewGO, "bg/#go_scene")
	slot0._btnmoveLeft = gohelper.findChildButton(slot0.viewGO, "#btn_moveLeft")
	slot0._btnmoveRight = gohelper.findChildButton(slot0.viewGO, "#btn_moveRight")
	slot0._btnoption = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_option", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	slot0._gocanOption = gohelper.findChild(slot0.viewGO, "#btn_option/#go_canOption")
	slot0._gonotOption = gohelper.findChild(slot0.viewGO, "#btn_option/#go_notOption")
	slot0._gocolorPlane = gohelper.findChild(slot0.viewGO, "#go_colorPlane")
	slot0._btncolor1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_colorPlane/#btn_color1", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	slot0._gocolor1selected = gohelper.findChild(slot0.viewGO, "#go_colorPlane/#btn_color1/#go_color1selected")
	slot0._btncolor2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_colorPlane/#btn_color2", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	slot0._gocolor2selected = gohelper.findChild(slot0.viewGO, "#go_colorPlane/#btn_color2/#go_color2selected")
	slot0._btncolor3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_colorPlane/#btn_color3", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	slot0._gocolor3selected = gohelper.findChild(slot0.viewGO, "#go_colorPlane/#btn_color3/#go_color3selected")
	slot0._btncolor4 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_colorPlane/#btn_color4", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	slot0._gocolor4selected = gohelper.findChild(slot0.viewGO, "#go_colorPlane/#btn_color4/#go_color4selected")
	slot0._btnchangColor = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_changColor", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	slot0._gonormalIcon = gohelper.findChild(slot0.viewGO, "#btn_changColor/#go_normalIcon")
	slot0._goblindnessIcon = gohelper.findChild(slot0.viewGO, "#btn_changColor/#go_blindnessIcon")
	slot0._btnclosePlane = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closePlane")
	slot0._btnReset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Reset", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	slot0._toggleBlindness = gohelper.findChildToggle(slot0.viewGO, "#toggle_Blindness")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._optionAnimPlayer = SLFramework.AnimatorPlayer.Get(slot0._btnoption.gameObject)
	slot0._optionAnim = slot0._btnoption.gameObject:GetComponent(gohelper.Type_Animator)
	slot0._changeColorAnimPlayer = SLFramework.AnimatorPlayer.Get(slot0._btnchangColor.gameObject)
	slot0._changeColorAnim = slot0._btnchangColor.gameObject:GetComponent(gohelper.Type_Animator)
	slot0._colorPlaneAnimPlayer = SLFramework.AnimatorPlayer.Get(slot0._gocolorPlane)
	slot0._colorPlaneAnim = slot0._gocolorPlane:GetComponent(gohelper.Type_Animator)
	slot0._godeadEffect = gohelper.findChild(slot0.viewGO, "vx_dead")
	slot0._vxMaskAnim = gohelper.findChild(slot0.viewGO, "bg/vx_mask"):GetComponent(gohelper.Type_Animator)
	slot0._btnMoveLeftAnim = slot0._btnmoveLeft.gameObject:GetComponent(gohelper.Type_Animator)
	slot0._btnMoveRightAnim = slot0._btnmoveRight.gameObject:GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnoption:AddClickListener(slot0._btnoptionOnClick, slot0)
	slot0._btncolor1:AddClickListener(slot0._btncolor1OnClick, slot0)
	slot0._btncolor2:AddClickListener(slot0._btncolor2OnClick, slot0)
	slot0._btncolor3:AddClickListener(slot0._btncolor3OnClick, slot0)
	slot0._btncolor4:AddClickListener(slot0._btncolor4OnClick, slot0)
	slot0._btnchangColor:AddClickListener(slot0._btnchangColorOnClick, slot0)
	slot0._btnclosePlane:AddClickListener(slot0._btnclosePlaneOnClick, slot0)
	slot0._btnReset:AddClickListener(slot0._btnResetOnClick, slot0)
	slot0._toggleBlindness:AddOnValueChanged(slot0._toggleBlindnessOnClick, slot0)

	slot0._leftClick = SLFramework.UGUI.UIClickListener.Get(slot0._btnmoveLeft.gameObject)

	slot0._leftClick:AddClickDownListener(slot0._onLeftClickDown, slot0)
	slot0._leftClick:AddClickUpListener(slot0._onLeftClickUp, slot0)

	slot0._rightClick = SLFramework.UGUI.UIClickListener.Get(slot0._btnmoveRight.gameObject)

	slot0._rightClick:AddClickDownListener(slot0._onRightClickDown, slot0)
	slot0._rightClick:AddClickUpListener(slot0._onRightClickUp, slot0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.playerChangeAnim, slot0.refreshChangeColorUI, slot0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.ResultResetGame, slot0.resetGame, slot0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.OnClickGuideRightMoveUpBtn, slot0._onRightClickUp, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0, LuaEventSystem.Low)
end

function slot0.removeEvents(slot0)
	slot0._btnoption:RemoveClickListener()
	slot0._btncolor1:RemoveClickListener()
	slot0._btncolor2:RemoveClickListener()
	slot0._btncolor3:RemoveClickListener()
	slot0._btncolor4:RemoveClickListener()
	slot0._btnchangColor:RemoveClickListener()
	slot0._btnclosePlane:RemoveClickListener()
	slot0._btnReset:RemoveClickListener()
	slot0._toggleBlindness:RemoveOnValueChanged()
	slot0._leftClick:RemoveClickDownListener()
	slot0._leftClick:RemoveClickUpListener()
	slot0._rightClick:RemoveClickDownListener()
	slot0._rightClick:RemoveClickUpListener()
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.playerChangeAnim, slot0.refreshChangeColorUI, slot0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.ResultResetGame, slot0.resetGame, slot0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.OnClickGuideRightMoveUpBtn, slot0._onRightClickUp, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
end

function slot0._btnResetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.FeiLinShiDuoResetTip, MsgBoxEnum.BoxType.Yes_No, slot0.resetGame, nil, , slot0)
end

function slot0._btncolor1OnClick(slot0)
	slot0:onChangeColor(FeiLinShiDuoEnum.ColorType.Red)
end

function slot0._btncolor2OnClick(slot0)
	slot0:onChangeColor(FeiLinShiDuoEnum.ColorType.Green)
end

function slot0._btncolor3OnClick(slot0)
	slot0:onChangeColor(FeiLinShiDuoEnum.ColorType.Blue)
end

function slot0._btncolor4OnClick(slot0)
	slot0:onChangeColor(FeiLinShiDuoEnum.ColorType.Yellow)
end

function slot0._btnclosePlaneOnClick(slot0)
	if not FeiLinShiDuoGameModel.instance:getBlindnessModeState() and FeiLinShiDuoGameModel.instance:getCurColor() == FeiLinShiDuoEnum.ColorType.Yellow then
		slot1 = FeiLinShiDuoEnum.ColorType.Red
	elseif slot2 and slot1 == FeiLinShiDuoEnum.ColorType.Red then
		slot1 = FeiLinShiDuoEnum.ColorType.Yellow
	end

	slot0:onChangeColor(slot1)
end

function slot0._toggleBlindnessOnClick(slot0, slot1, slot2)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	FeiLinShiDuoGameModel.instance:setBlindnessModeState(slot2)
	GameUtil.playerPrefsSetNumberByUserId(FeiLinShiDuoEnum.BlindnessModeKey, slot2 and 1 or 0)
	slot0:refreshBlindnessModeUI()
end

function slot0._onLeftClickDown(slot0)
	if slot0.playerComp then
		slot0.playerComp:setUIClickLeftDown()
		slot0:leftClickDown()
	end
end

function slot0.leftClickDown(slot0)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	ZProj.UGUIHelper.SetColorAlpha(slot0.imageMoveLeftBtn, 1)
	ZProj.UGUIHelper.SetColorAlpha(slot0.imageMoveRightBtn, 0.5)
end

function slot0._onLeftClickUp(slot0)
	if slot0.playerComp then
		slot0.playerComp:setUIClickLeftUp()
		slot0:leftClickUp()
	end
end

function slot0.leftClickUp(slot0)
	ZProj.UGUIHelper.SetColorAlpha(slot0.imageMoveLeftBtn, 0.5)
	ZProj.UGUIHelper.SetColorAlpha(slot0.imageMoveRightBtn, 0.5)
end

function slot0._onRightClickDown(slot0)
	if slot0.playerComp then
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.OnClickGuideRightMoveBtn)
		slot0.playerComp:setUIClickRightDown()
		slot0:rightClickDown()
	end
end

function slot0.rightClickDown(slot0)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	ZProj.UGUIHelper.SetColorAlpha(slot0.imageMoveLeftBtn, 0.5)
	ZProj.UGUIHelper.SetColorAlpha(slot0.imageMoveRightBtn, 1)
end

function slot0._onRightClickUp(slot0)
	if slot0.playerComp then
		slot0.playerComp:setUIClickRightUp()
		slot0:rightClickUp()
	end
end

function slot0.rightClickUp(slot0)
	ZProj.UGUIHelper.SetColorAlpha(slot0.imageMoveLeftBtn, 0.5)
	ZProj.UGUIHelper.SetColorAlpha(slot0.imageMoveRightBtn, 0.5)
end

function slot0._btnoptionOnClick(slot0)
	if slot0.playerComp and not slot0.isOptionBtnAniming then
		slot0.playerComp:startClimbStairs()
	end
end

function slot0._btnchangColorOnClick(slot0)
	if not slot0.playerCurIdleState or GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FeiLinShiDuoBanOper) or slot0.isColorBtnAniming then
		return
	end

	slot0._changeColorAnimPlayer:Play("out", slot0.closeChangeColorBtnFinish, slot0)

	slot0.isColorBtnAniming = true
	slot0._colorPlaneAnim.enabled = true
	slot0.isOpenColorPlane = true

	gohelper.setActive(slot0._gocolorPlane, true)
	gohelper.setActive(slot0._btnclosePlane.gameObject, true)
	slot0._btnMoveLeftAnim:Play("out", 0, 0)
	slot0._btnMoveRightAnim:Play("out", 0, 0)

	if slot0._btnoption.gameObject.activeSelf then
		slot0._optionAnimPlayer:Play("out", slot0.playOptionAnimFinish, slot0)
	end

	FeiLinShiDuoGameModel.instance:setIsPlayerInColorChanging(true)

	if not FeiLinShiDuoGameModel.instance:getInterElementMap() or not slot0.sceneview:getElementGOMap() then
		logError("获取不到场景的元件物体，请检查")

		return
	end

	for slot6, slot7 in pairs(slot1) do
		gohelper.setActive(slot2[slot7.id].elementGO, true)
	end

	slot3 = FeiLinShiDuoGameModel.instance:getCurColor() or FeiLinShiDuoEnum.ColorType.None

	for slot7 = 1, 4 do
		gohelper.setActive(slot0["_gocolor" .. slot7 .. "selected"], false)

		if slot3 == FeiLinShiDuoEnum.ColorType.Red or slot3 == FeiLinShiDuoEnum.ColorType.Yellow then
			ZProj.UGUIHelper.SetColorAlpha(slot0.colorPlaneImageMap[slot7], (slot7 == FeiLinShiDuoEnum.ColorType.Red or slot7 == FeiLinShiDuoEnum.ColorType.Yellow) and 1 or 0.3)
		else
			ZProj.UGUIHelper.SetColorAlpha(slot0.colorPlaneImageMap[slot7], slot7 == slot3 and 1 or 0.3)
		end
	end

	FeiLinShiDuoGameModel.instance:showAllElementState()
	slot0._vxMaskAnim:Play("in", 0, 0)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.changePlayerColor, FeiLinShiDuoEnum.ColorType.None)
end

function slot0.closeChangeColorBtnFinish(slot0)
	gohelper.setActive(slot0._btnchangColor.gameObject, false)

	slot0.isColorBtnAniming = false
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._btnoption.gameObject, false)
	gohelper.setActive(slot0._btnchangColor.gameObject, true)
	gohelper.setActive(slot0._gocolorPlane, false)
	gohelper.setActive(slot0._btnclosePlane.gameObject, false)

	slot0.canShowOption = false
	slot0.canDoOption = false
	slot0.playerCurIdleState = true
	slot0.normalColorCanvasGroup = slot0._gonormalIcon:GetComponent(gohelper.Type_CanvasGroup)
	slot0.blindnessColorCanvasGroup = slot0._goblindnessIcon:GetComponent(gohelper.Type_CanvasGroup)
	slot0.imageMoveLeftBtn = gohelper.findChildImage(slot0.viewGO, "#btn_moveLeft/icon")
	slot0.imageMoveRightBtn = gohelper.findChildImage(slot0.viewGO, "#btn_moveRight/icon")
	slot0.normalColorCanvasGroup.alpha = 1
	slot0.blindnessColorCanvasGroup.alpha = 1

	ZProj.UGUIHelper.SetColorAlpha(slot0.imageMoveLeftBtn, 0.5)
	ZProj.UGUIHelper.SetColorAlpha(slot0.imageMoveRightBtn, 0.5)

	for slot4 = 1, 4 do
		gohelper.setActive(slot0["_gocolor" .. slot4 .. "selected"], false)
	end

	FeiLinShiDuoGameModel.instance:setElememntShowStateByColor(FeiLinShiDuoEnum.ColorType.None)

	slot0.isOptionBtnAniming = false
	slot0.isColorBtnAniming = false

	slot0:initColorPlaneData()
	slot0:initBlindnessMode()
	FeiLinShiDuoStatHelper.instance:initGameStartTime()
	FeiLinShiDuoStatHelper.instance:initResetStartTime()
end

function slot0.initBlindnessMode(slot0)
	slot2 = GameUtil.playerPrefsGetNumberByUserId(FeiLinShiDuoEnum.BlindnessModeKey, 0) == 1
	slot0._toggleBlindness.isOn = slot2

	FeiLinShiDuoGameModel.instance:setBlindnessModeState(slot2)
end

function slot0.initColorPlaneData(slot0)
	slot0.isOpenColorPlane = false
	slot0.originTrans = gohelper.findChild(slot0.viewGO, "#go_colorPlane/#go_originPos").transform
	slot0.startPosTrans = gohelper.findChild(slot0.viewGO, "#go_colorPlane/#go_startPos").transform
	slot6 = 0
	slot0.startVector = Vector3(slot0.startPosTrans.localPosition.x - slot0.originTrans.localPosition.x, slot0.startPosTrans.localPosition.y - slot0.originTrans.localPosition.y, slot6)
	slot0.colorPlaneRect = slot0._gocolorPlane:GetComponent(gohelper.Type_RectTransform)
	slot0.mouseCheckRadius = 270
	slot0.colorPlaneImageMap = slot0:getUserDataTb_()

	for slot6 = 1, 4 do
		slot0.colorPlaneImageMap[slot6] = slot0["_btncolor" .. slot6].gameObject:GetComponent(gohelper.Type_Image)
	end
end

function slot0.onOpen(slot0)
	slot0.sceneview = slot0.viewContainer:getSceneView()
	slot0.playerComp = slot0.sceneview and slot0.sceneview:getPlayerComp()
	slot0.playerAnimComp = slot0.sceneview and slot0.sceneview:getPlayerAnimComp()

	slot0.viewContainer:setOverrideCloseClick(slot0.onCloseBtnClick, slot0)
	slot0:refreshUI()
	TaskDispatcher.runRepeat(slot0.refreshColorPlane, slot0, 0.1)
end

function slot0.refreshUI(slot0)
	slot0:refreshChangeColorUI()
	slot0:refreshBlindnessModeUI()
	slot0:refreshColorPlane()
end

function slot0.refreshChangeColorUI(slot0)
	if slot0.playerCurIdleState ~= FeiLinShiDuoGameModel.instance:getPlayerIsIdleState() then
		slot0.playerCurIdleState = slot1
		slot0.normalColorCanvasGroup.alpha = slot0.playerCurIdleState and 1 or 0.5
		slot0.blindnessColorCanvasGroup.alpha = slot0.playerCurIdleState and 1 or 0.5
	end
end

function slot0.refreshBlindnessModeUI(slot0)
	slot1 = FeiLinShiDuoGameModel.instance:getBlindnessModeState()
	slot0._toggleBlindness.isOn = slot1

	gohelper.setActive(slot0._gonormalIcon, not slot1)
	gohelper.setActive(slot0._goblindnessIcon, slot1)
	gohelper.setActive(slot0._btncolor1, not slot1)
	gohelper.setActive(slot0._btncolor4, slot1)
	slot0.sceneview:refreshBlindnessMode()

	if FeiLinShiDuoGameModel.instance:getCurColor() == FeiLinShiDuoEnum.ColorType.Red or slot2 == FeiLinShiDuoEnum.ColorType.Yellow then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._imagecolorBg, slot1 and FeiLinShiDuoEnum.ColorStr[FeiLinShiDuoEnum.ColorType.Yellow] or FeiLinShiDuoEnum.ColorStr[FeiLinShiDuoEnum.ColorType.Red])
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.changePlayerColor, slot1 and FeiLinShiDuoEnum.ColorType.Yellow or FeiLinShiDuoEnum.ColorType.Red)
	end

	for slot6 = 1, 4 do
		if slot2 == FeiLinShiDuoEnum.ColorType.Red or slot2 == FeiLinShiDuoEnum.ColorType.Yellow then
			ZProj.UGUIHelper.SetColorAlpha(slot0.colorPlaneImageMap[slot6], (slot6 == FeiLinShiDuoEnum.ColorType.Red or slot6 == FeiLinShiDuoEnum.ColorType.Yellow) and 1 or 0.3)
		else
			ZProj.UGUIHelper.SetColorAlpha(slot0.colorPlaneImageMap[slot6], slot6 == slot2 and 1 or 0.3)
		end
	end
end

function slot0.refreshColorPlane(slot0)
	if not slot0.isOpenColorPlane or slot0.isColorBtnAniming then
		return
	end

	slot1, slot2 = recthelper.screenPosToAnchorPos2(GamepadController.instance:getMousePosition(), slot0.colorPlaneRect)
	slot0.mouseVector = Vector3(slot1 - slot0.originTrans.localPosition.x, slot2 - slot0.originTrans.localPosition.y, 0)
	slot3 = Vector2.Dot(slot0.startVector, slot0.mouseVector)
	slot5 = Vector2.Magnitude(slot0.mouseVector)

	if Vector2.Magnitude(slot0.startVector) == 0 or slot5 == 0 then
		return 0
	end

	if slot0.mouseCheckRadius < slot5 or Vector3.Cross(slot0.startVector, slot0.mouseVector).z >= 0 then
		for slot10 = 1, 4 do
			gohelper.setActive(slot0["_gocolor" .. slot10 .. "selected"], false)
		end

		return
	end

	slot10 = FeiLinShiDuoGameModel.instance:getCurColor() or FeiLinShiDuoEnum.ColorType.None
	slot11 = false

	if Mathf.Acos(Mathf.Clamp(slot3 / (slot4 * slot5), -1, 1)) * Mathf.Rad2Deg > 120 and slot8 <= 180 and not FeiLinShiDuoGameModel.instance:getBlindnessModeState() then
		slot10 = FeiLinShiDuoEnum.ColorType.Red
		slot11 = true
	elseif slot8 > 120 and slot8 <= 180 and slot9 then
		slot10 = FeiLinShiDuoEnum.ColorType.Yellow
		slot11 = true
	elseif slot8 >= 0 and slot8 <= 60 then
		slot10 = FeiLinShiDuoEnum.ColorType.Green
		slot11 = true
	elseif slot8 > 60 and slot8 <= 120 then
		slot10 = FeiLinShiDuoEnum.ColorType.Blue
		slot11 = true
	end

	for slot15 = 1, 4 do
		gohelper.setActive(slot0["_gocolor" .. slot15 .. "selected"], slot15 == slot10 and slot11)
		ZProj.UGUIHelper.SetColorAlpha(slot0.colorPlaneImageMap[slot15], slot15 == slot10 and 1 or 0.3)
	end
end

function slot0.onChangeColor(slot0, slot1, slot2)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FeiLinShiDuoBanOper) or slot0.isColorBtnAniming then
		return
	end

	slot0._changeColorAnim.enabled = true

	gohelper.setActive(slot0._btnchangColor.gameObject, true)

	if slot0._gocolorPlane.activeSelf then
		slot0.isOpenColorPlane = false

		slot0._colorPlaneAnimPlayer:Play("out", slot0.closeColorPlaneFinish, slot0)

		if not slot2 then
			slot0._vxMaskAnim:Play("out", 0, 0)
		else
			slot0._vxMaskAnim:Play("idle", 0, 0)
		end

		slot0._btnMoveLeftAnim:Play("in", 0, 0)
		slot0._btnMoveRightAnim:Play("in", 0, 0)
	end

	slot0.isColorBtnAniming = true

	gohelper.setActive(slot0._btnclosePlane.gameObject, false)

	if slot0:checkIntersect() then
		GameFacade.showToast(ToastEnum.Act185ChangeColorWithSamePos)

		slot1 = FeiLinShiDuoGameModel.instance:getCurColor()
	end

	FeiLinShiDuoGameModel.instance:setElememntShowStateByColor(slot1)

	if slot0.sceneview then
		slot0.sceneview:changeSceneColor(slot1)
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagecolorBg, FeiLinShiDuoEnum.ColorStr[slot1])
	FeiLinShiDuoGameModel.instance:setIsPlayerInColorChanging(false)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.changePlayerColor, slot1)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_scene_switch)
end

function slot0.closeColorPlaneFinish(slot0)
	gohelper.setActive(slot0._gocolorPlane, false)

	slot0.isColorBtnAniming = false
end

function slot0.checkIntersect(slot0)
	slot2 = {}

	for slot7, slot8 in pairs(FeiLinShiDuoGameModel.instance:getElementMap()[FeiLinShiDuoEnum.ObjectType.Box] or {}) do
		table.insert(slot2, slot8)
	end

	for slot7, slot8 in pairs(slot2) do
		for slot12, slot13 in pairs(slot2) do
			if slot8.id ~= slot13.id and FeiLinShiDuoGameModel.instance:getElementShowState(slot13) and FeiLinShiDuoGameModel.instance:getElementShowState(slot8) and Mathf.Abs(slot8.pos[1] + slot8.width / 2 - (slot13.pos[1] + slot13.width / 2)) < slot8.width / 2 + slot13.width / 2 - FeiLinShiDuoEnum.touchCheckRange and Mathf.Abs(slot8.pos[2] - slot13.pos[2]) < FeiLinShiDuoEnum.HalfSlotWidth / 4 then
				return true
			end
		end
	end

	return false
end

function slot0.showOptionState(slot0, slot1, slot2)
	if slot0.canShowOption == slot1 then
		return
	end

	slot0.canShowOption = slot1

	if not slot0.canShowOption and not slot2 then
		if slot0._btnoption.gameObject.activeSelf then
			slot0._optionAnimPlayer:Play("out", slot0.playOptionAnimFinish, slot0)
		end

		slot0.isOptionBtnAniming = true
	else
		slot0._optionAnim.enabled = true

		gohelper.setActive(slot0._btnoption.gameObject, slot1)

		slot0.isOptionBtnAniming = false
	end
end

function slot0.playOptionAnimFinish(slot0)
	slot0.isOptionBtnAniming = false
	slot0.canShowOption = false

	gohelper.setActive(slot0._btnoption.gameObject, false)
end

function slot0.showOptionCanDoState(slot0, slot1)
	if slot0.canDoOption == slot1 then
		return
	end

	slot0.canDoOption = slot1

	gohelper.setActive(slot0._gocanOption, slot0.canDoOption)
	gohelper.setActive(slot0._gonotOption, not slot0.canDoOption)
end

function slot0.resetGame(slot0)
	slot0:showOptionState(false, true)

	slot1 = FeiLinShiDuoEnum.ColorType.None

	FeiLinShiDuoGameModel.instance:showAllElementState()

	if slot0.sceneview then
		FeiLinShiDuoStatHelper.instance:sendResetGameMap(slot0.sceneview:getPlayerGO())
		slot0.sceneview:resetData()
	end

	slot0:onChangeColor(slot1, true)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.resetGame)

	slot0.canDoOption = false
	slot0.playerCurIdleState = true
	slot0.isOptionBtnAniming = false
	slot0.isColorBtnAniming = false
	slot0.isOpenColorPlane = false

	slot0._btnMoveLeftAnim:Play("idle", 0, 0)
	slot0._btnMoveRightAnim:Play("idle", 0, 0)
end

function slot0.onCloseBtnClick(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FeiLinShiDuoBanOper) then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.FeiLinShiDuoQuitGameTip, MsgBoxEnum.BoxType.Yes_No, slot0.openGameResultView, nil, , slot0)
end

function slot0.openGameResultView(slot0)
	FeiLinShiDuoGameController.instance:openGameResultView({
		isSuccess = false
	})
	FeiLinShiDuoStatHelper.instance:sendExitGameMap(slot0.sceneview:getPlayerGO())
end

function slot0.showDeadEffect(slot0)
	gohelper.setActive(slot0._godeadEffect, false)
	gohelper.setActive(slot0._godeadEffect, true)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_revival)
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.GuideView then
		slot0:_onLeftClickUp()
		slot0:_onRightClickUp()
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshColorPlane, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

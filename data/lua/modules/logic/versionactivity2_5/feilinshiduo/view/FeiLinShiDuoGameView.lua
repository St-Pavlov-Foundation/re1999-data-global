module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoGameView", package.seeall)

local var_0_0 = class("FeiLinShiDuoGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagecolorBg = gohelper.findChildImage(arg_1_0.viewGO, "bg/#image_colorBg")
	arg_1_0._simageDec = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_Dec")
	arg_1_0._goscene = gohelper.findChild(arg_1_0.viewGO, "bg/#go_scene")
	arg_1_0._btnmoveLeft = gohelper.findChildButton(arg_1_0.viewGO, "#btn_moveLeft")
	arg_1_0._btnmoveRight = gohelper.findChildButton(arg_1_0.viewGO, "#btn_moveRight")
	arg_1_0._btnoption = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_option", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	arg_1_0._gocanOption = gohelper.findChild(arg_1_0.viewGO, "#btn_option/#go_canOption")
	arg_1_0._gonotOption = gohelper.findChild(arg_1_0.viewGO, "#btn_option/#go_notOption")
	arg_1_0._gocolorPlane = gohelper.findChild(arg_1_0.viewGO, "#go_colorPlane")
	arg_1_0._btncolor1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_colorPlane/#btn_color1", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	arg_1_0._gocolor1selected = gohelper.findChild(arg_1_0.viewGO, "#go_colorPlane/#btn_color1/#go_color1selected")
	arg_1_0._btncolor2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_colorPlane/#btn_color2", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	arg_1_0._gocolor2selected = gohelper.findChild(arg_1_0.viewGO, "#go_colorPlane/#btn_color2/#go_color2selected")
	arg_1_0._btncolor3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_colorPlane/#btn_color3", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	arg_1_0._gocolor3selected = gohelper.findChild(arg_1_0.viewGO, "#go_colorPlane/#btn_color3/#go_color3selected")
	arg_1_0._btncolor4 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_colorPlane/#btn_color4", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	arg_1_0._gocolor4selected = gohelper.findChild(arg_1_0.viewGO, "#go_colorPlane/#btn_color4/#go_color4selected")
	arg_1_0._btnchangColor = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_changColor", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	arg_1_0._gonormalIcon = gohelper.findChild(arg_1_0.viewGO, "#btn_changColor/#go_normalIcon")
	arg_1_0._goblindnessIcon = gohelper.findChild(arg_1_0.viewGO, "#btn_changColor/#go_blindnessIcon")
	arg_1_0._btnclosePlane = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closePlane")
	arg_1_0._btnReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Reset", AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	arg_1_0._toggleBlindness = gohelper.findChildToggle(arg_1_0.viewGO, "#toggle_Blindness")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._optionAnimPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0._btnoption.gameObject)
	arg_1_0._optionAnim = arg_1_0._btnoption.gameObject:GetComponent(gohelper.Type_Animator)
	arg_1_0._changeColorAnimPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0._btnchangColor.gameObject)
	arg_1_0._changeColorAnim = arg_1_0._btnchangColor.gameObject:GetComponent(gohelper.Type_Animator)
	arg_1_0._colorPlaneAnimPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0._gocolorPlane)
	arg_1_0._colorPlaneAnim = arg_1_0._gocolorPlane:GetComponent(gohelper.Type_Animator)
	arg_1_0._godeadEffect = gohelper.findChild(arg_1_0.viewGO, "vx_dead")
	arg_1_0._vxMaskAnim = gohelper.findChild(arg_1_0.viewGO, "bg/vx_mask"):GetComponent(gohelper.Type_Animator)
	arg_1_0._btnMoveLeftAnim = arg_1_0._btnmoveLeft.gameObject:GetComponent(gohelper.Type_Animator)
	arg_1_0._btnMoveRightAnim = arg_1_0._btnmoveRight.gameObject:GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnoption:AddClickListener(arg_2_0._btnoptionOnClick, arg_2_0)
	arg_2_0._btncolor1:AddClickListener(arg_2_0._btncolor1OnClick, arg_2_0)
	arg_2_0._btncolor2:AddClickListener(arg_2_0._btncolor2OnClick, arg_2_0)
	arg_2_0._btncolor3:AddClickListener(arg_2_0._btncolor3OnClick, arg_2_0)
	arg_2_0._btncolor4:AddClickListener(arg_2_0._btncolor4OnClick, arg_2_0)
	arg_2_0._btnchangColor:AddClickListener(arg_2_0._btnchangColorOnClick, arg_2_0)
	arg_2_0._btnclosePlane:AddClickListener(arg_2_0._btnclosePlaneOnClick, arg_2_0)
	arg_2_0._btnReset:AddClickListener(arg_2_0._btnResetOnClick, arg_2_0)
	arg_2_0._toggleBlindness:AddOnValueChanged(arg_2_0._toggleBlindnessOnClick, arg_2_0)

	arg_2_0._leftClick = SLFramework.UGUI.UIClickListener.Get(arg_2_0._btnmoveLeft.gameObject)

	arg_2_0._leftClick:AddClickDownListener(arg_2_0._onLeftClickDown, arg_2_0)
	arg_2_0._leftClick:AddClickUpListener(arg_2_0._onLeftClickUp, arg_2_0)

	arg_2_0._rightClick = SLFramework.UGUI.UIClickListener.Get(arg_2_0._btnmoveRight.gameObject)

	arg_2_0._rightClick:AddClickDownListener(arg_2_0._onRightClickDown, arg_2_0)
	arg_2_0._rightClick:AddClickUpListener(arg_2_0._onRightClickUp, arg_2_0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.playerChangeAnim, arg_2_0.refreshChangeColorUI, arg_2_0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.ResultResetGame, arg_2_0.resetGame, arg_2_0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.OnClickGuideRightMoveUpBtn, arg_2_0._onRightClickUp, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onCloseViewFinish, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnoption:RemoveClickListener()
	arg_3_0._btncolor1:RemoveClickListener()
	arg_3_0._btncolor2:RemoveClickListener()
	arg_3_0._btncolor3:RemoveClickListener()
	arg_3_0._btncolor4:RemoveClickListener()
	arg_3_0._btnchangColor:RemoveClickListener()
	arg_3_0._btnclosePlane:RemoveClickListener()
	arg_3_0._btnReset:RemoveClickListener()
	arg_3_0._toggleBlindness:RemoveOnValueChanged()
	arg_3_0._leftClick:RemoveClickDownListener()
	arg_3_0._leftClick:RemoveClickUpListener()
	arg_3_0._rightClick:RemoveClickDownListener()
	arg_3_0._rightClick:RemoveClickUpListener()
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.playerChangeAnim, arg_3_0.refreshChangeColorUI, arg_3_0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.ResultResetGame, arg_3_0.resetGame, arg_3_0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.OnClickGuideRightMoveUpBtn, arg_3_0._onRightClickUp, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0.onCloseViewFinish, arg_3_0)
end

function var_0_0._btnResetOnClick(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.FeiLinShiDuoResetTip, MsgBoxEnum.BoxType.Yes_No, arg_4_0.resetGame, nil, nil, arg_4_0)
end

function var_0_0._btncolor1OnClick(arg_5_0)
	local var_5_0 = FeiLinShiDuoEnum.ColorType.Red

	arg_5_0:onChangeColor(var_5_0)
end

function var_0_0._btncolor2OnClick(arg_6_0)
	local var_6_0 = FeiLinShiDuoEnum.ColorType.Green

	arg_6_0:onChangeColor(var_6_0)
end

function var_0_0._btncolor3OnClick(arg_7_0)
	local var_7_0 = FeiLinShiDuoEnum.ColorType.Blue

	arg_7_0:onChangeColor(var_7_0)
end

function var_0_0._btncolor4OnClick(arg_8_0)
	local var_8_0 = FeiLinShiDuoEnum.ColorType.Yellow

	arg_8_0:onChangeColor(var_8_0)
end

function var_0_0._btnclosePlaneOnClick(arg_9_0)
	local var_9_0 = FeiLinShiDuoGameModel.instance:getCurColor()
	local var_9_1 = FeiLinShiDuoGameModel.instance:getBlindnessModeState()

	if not var_9_1 and var_9_0 == FeiLinShiDuoEnum.ColorType.Yellow then
		var_9_0 = FeiLinShiDuoEnum.ColorType.Red
	elseif var_9_1 and var_9_0 == FeiLinShiDuoEnum.ColorType.Red then
		var_9_0 = FeiLinShiDuoEnum.ColorType.Yellow
	end

	arg_9_0:onChangeColor(var_9_0)
end

function var_0_0._toggleBlindnessOnClick(arg_10_0, arg_10_1, arg_10_2)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	FeiLinShiDuoGameModel.instance:setBlindnessModeState(arg_10_2)

	local var_10_0 = arg_10_2 and 1 or 0

	GameUtil.playerPrefsSetNumberByUserId(FeiLinShiDuoEnum.BlindnessModeKey, var_10_0)
	arg_10_0:refreshBlindnessModeUI()
end

function var_0_0._onLeftClickDown(arg_11_0)
	if arg_11_0.playerComp then
		arg_11_0.playerComp:setUIClickLeftDown()
		arg_11_0:leftClickDown()
	end
end

function var_0_0.leftClickDown(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	ZProj.UGUIHelper.SetColorAlpha(arg_12_0.imageMoveLeftBtn, 1)
	ZProj.UGUIHelper.SetColorAlpha(arg_12_0.imageMoveRightBtn, 0.5)
end

function var_0_0._onLeftClickUp(arg_13_0)
	if arg_13_0.playerComp then
		arg_13_0.playerComp:setUIClickLeftUp()
		arg_13_0:leftClickUp()
	end
end

function var_0_0.leftClickUp(arg_14_0)
	ZProj.UGUIHelper.SetColorAlpha(arg_14_0.imageMoveLeftBtn, 0.5)
	ZProj.UGUIHelper.SetColorAlpha(arg_14_0.imageMoveRightBtn, 0.5)
end

function var_0_0._onRightClickDown(arg_15_0)
	if arg_15_0.playerComp then
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.OnClickGuideRightMoveBtn)
		arg_15_0.playerComp:setUIClickRightDown()
		arg_15_0:rightClickDown()
	end
end

function var_0_0.rightClickDown(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_formationsave)
	ZProj.UGUIHelper.SetColorAlpha(arg_16_0.imageMoveLeftBtn, 0.5)
	ZProj.UGUIHelper.SetColorAlpha(arg_16_0.imageMoveRightBtn, 1)
end

function var_0_0._onRightClickUp(arg_17_0)
	if arg_17_0.playerComp then
		arg_17_0.playerComp:setUIClickRightUp()
		arg_17_0:rightClickUp()
	end
end

function var_0_0.rightClickUp(arg_18_0)
	ZProj.UGUIHelper.SetColorAlpha(arg_18_0.imageMoveLeftBtn, 0.5)
	ZProj.UGUIHelper.SetColorAlpha(arg_18_0.imageMoveRightBtn, 0.5)
end

function var_0_0._btnoptionOnClick(arg_19_0)
	if arg_19_0.playerComp and not arg_19_0.isOptionBtnAniming then
		arg_19_0.playerComp:startClimbStairs()
	end
end

function var_0_0._btnchangColorOnClick(arg_20_0)
	if not arg_20_0.playerCurIdleState or GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FeiLinShiDuoBanOper) or arg_20_0.isColorBtnAniming then
		return
	end

	arg_20_0._changeColorAnimPlayer:Play("out", arg_20_0.closeChangeColorBtnFinish, arg_20_0)

	arg_20_0.isColorBtnAniming = true
	arg_20_0._colorPlaneAnim.enabled = true
	arg_20_0.isOpenColorPlane = true

	gohelper.setActive(arg_20_0._gocolorPlane, true)
	gohelper.setActive(arg_20_0._btnclosePlane.gameObject, true)
	arg_20_0._btnMoveLeftAnim:Play("out", 0, 0)
	arg_20_0._btnMoveRightAnim:Play("out", 0, 0)

	if arg_20_0._btnoption.gameObject.activeSelf then
		arg_20_0._optionAnimPlayer:Play("out", arg_20_0.playOptionAnimFinish, arg_20_0)
	end

	FeiLinShiDuoGameModel.instance:setIsPlayerInColorChanging(true)

	local var_20_0 = FeiLinShiDuoGameModel.instance:getInterElementMap()
	local var_20_1 = arg_20_0.sceneview:getElementGOMap()

	if not var_20_0 or not var_20_1 then
		logError("获取不到场景的元件物体，请检查")

		return
	end

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		gohelper.setActive(var_20_1[iter_20_1.id].elementGO, true)
	end

	local var_20_2 = FeiLinShiDuoGameModel.instance:getCurColor() or FeiLinShiDuoEnum.ColorType.None

	for iter_20_2 = 1, 4 do
		gohelper.setActive(arg_20_0["_gocolor" .. iter_20_2 .. "selected"], false)

		if var_20_2 == FeiLinShiDuoEnum.ColorType.Red or var_20_2 == FeiLinShiDuoEnum.ColorType.Yellow then
			ZProj.UGUIHelper.SetColorAlpha(arg_20_0.colorPlaneImageMap[iter_20_2], (iter_20_2 == FeiLinShiDuoEnum.ColorType.Red or iter_20_2 == FeiLinShiDuoEnum.ColorType.Yellow) and 1 or 0.3)
		else
			ZProj.UGUIHelper.SetColorAlpha(arg_20_0.colorPlaneImageMap[iter_20_2], iter_20_2 == var_20_2 and 1 or 0.3)
		end
	end

	FeiLinShiDuoGameModel.instance:showAllElementState()
	arg_20_0._vxMaskAnim:Play("in", 0, 0)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.changePlayerColor, FeiLinShiDuoEnum.ColorType.None)
end

function var_0_0.closeChangeColorBtnFinish(arg_21_0)
	gohelper.setActive(arg_21_0._btnchangColor.gameObject, false)

	arg_21_0.isColorBtnAniming = false
end

function var_0_0._editableInitView(arg_22_0)
	gohelper.setActive(arg_22_0._btnoption.gameObject, false)
	gohelper.setActive(arg_22_0._btnchangColor.gameObject, true)
	gohelper.setActive(arg_22_0._gocolorPlane, false)
	gohelper.setActive(arg_22_0._btnclosePlane.gameObject, false)

	arg_22_0.canShowOption = false
	arg_22_0.canDoOption = false
	arg_22_0.playerCurIdleState = true
	arg_22_0.normalColorCanvasGroup = arg_22_0._gonormalIcon:GetComponent(gohelper.Type_CanvasGroup)
	arg_22_0.blindnessColorCanvasGroup = arg_22_0._goblindnessIcon:GetComponent(gohelper.Type_CanvasGroup)
	arg_22_0.imageMoveLeftBtn = gohelper.findChildImage(arg_22_0.viewGO, "#btn_moveLeft/icon")
	arg_22_0.imageMoveRightBtn = gohelper.findChildImage(arg_22_0.viewGO, "#btn_moveRight/icon")
	arg_22_0.normalColorCanvasGroup.alpha = 1
	arg_22_0.blindnessColorCanvasGroup.alpha = 1

	ZProj.UGUIHelper.SetColorAlpha(arg_22_0.imageMoveLeftBtn, 0.5)
	ZProj.UGUIHelper.SetColorAlpha(arg_22_0.imageMoveRightBtn, 0.5)

	for iter_22_0 = 1, 4 do
		gohelper.setActive(arg_22_0["_gocolor" .. iter_22_0 .. "selected"], false)
	end

	FeiLinShiDuoGameModel.instance:setElememntShowStateByColor(FeiLinShiDuoEnum.ColorType.None)

	arg_22_0.isOptionBtnAniming = false
	arg_22_0.isColorBtnAniming = false

	arg_22_0:initColorPlaneData()
	arg_22_0:initBlindnessMode()
	FeiLinShiDuoStatHelper.instance:initGameStartTime()
	FeiLinShiDuoStatHelper.instance:initResetStartTime()
end

function var_0_0.initBlindnessMode(arg_23_0)
	local var_23_0 = GameUtil.playerPrefsGetNumberByUserId(FeiLinShiDuoEnum.BlindnessModeKey, 0) == 1

	arg_23_0._toggleBlindness.isOn = var_23_0

	FeiLinShiDuoGameModel.instance:setBlindnessModeState(var_23_0)
end

function var_0_0.initColorPlaneData(arg_24_0)
	arg_24_0.isOpenColorPlane = false

	local var_24_0 = gohelper.findChild(arg_24_0.viewGO, "#go_colorPlane/#go_startPos")

	arg_24_0.originTrans = gohelper.findChild(arg_24_0.viewGO, "#go_colorPlane/#go_originPos").transform
	arg_24_0.startPosTrans = var_24_0.transform
	arg_24_0.startVector = Vector3(arg_24_0.startPosTrans.localPosition.x - arg_24_0.originTrans.localPosition.x, arg_24_0.startPosTrans.localPosition.y - arg_24_0.originTrans.localPosition.y, 0)
	arg_24_0.colorPlaneRect = arg_24_0._gocolorPlane:GetComponent(gohelper.Type_RectTransform)
	arg_24_0.mouseCheckRadius = 270
	arg_24_0.colorPlaneImageMap = arg_24_0:getUserDataTb_()

	for iter_24_0 = 1, 4 do
		arg_24_0.colorPlaneImageMap[iter_24_0] = arg_24_0["_btncolor" .. iter_24_0].gameObject:GetComponent(gohelper.Type_Image)
	end
end

function var_0_0.onOpen(arg_25_0)
	arg_25_0.sceneview = arg_25_0.viewContainer:getSceneView()
	arg_25_0.playerComp = arg_25_0.sceneview and arg_25_0.sceneview:getPlayerComp()
	arg_25_0.playerAnimComp = arg_25_0.sceneview and arg_25_0.sceneview:getPlayerAnimComp()

	arg_25_0.viewContainer:setOverrideCloseClick(arg_25_0.onCloseBtnClick, arg_25_0)
	arg_25_0:refreshUI()
	TaskDispatcher.runRepeat(arg_25_0.refreshColorPlane, arg_25_0, 0.1)
end

function var_0_0.refreshUI(arg_26_0)
	arg_26_0:refreshChangeColorUI()
	arg_26_0:refreshBlindnessModeUI()
	arg_26_0:refreshColorPlane()
end

function var_0_0.refreshChangeColorUI(arg_27_0)
	local var_27_0 = FeiLinShiDuoGameModel.instance:getPlayerIsIdleState()

	if arg_27_0.playerCurIdleState ~= var_27_0 then
		arg_27_0.playerCurIdleState = var_27_0
		arg_27_0.normalColorCanvasGroup.alpha = arg_27_0.playerCurIdleState and 1 or 0.5
		arg_27_0.blindnessColorCanvasGroup.alpha = arg_27_0.playerCurIdleState and 1 or 0.5
	end
end

function var_0_0.refreshBlindnessModeUI(arg_28_0)
	local var_28_0 = FeiLinShiDuoGameModel.instance:getBlindnessModeState()

	arg_28_0._toggleBlindness.isOn = var_28_0

	gohelper.setActive(arg_28_0._gonormalIcon, not var_28_0)
	gohelper.setActive(arg_28_0._goblindnessIcon, var_28_0)
	gohelper.setActive(arg_28_0._btncolor1, not var_28_0)
	gohelper.setActive(arg_28_0._btncolor4, var_28_0)
	arg_28_0.sceneview:refreshBlindnessMode()

	local var_28_1 = FeiLinShiDuoGameModel.instance:getCurColor()

	if var_28_1 == FeiLinShiDuoEnum.ColorType.Red or var_28_1 == FeiLinShiDuoEnum.ColorType.Yellow then
		local var_28_2 = var_28_0 and FeiLinShiDuoEnum.ColorStr[FeiLinShiDuoEnum.ColorType.Yellow] or FeiLinShiDuoEnum.ColorStr[FeiLinShiDuoEnum.ColorType.Red]
		local var_28_3 = var_28_0 and FeiLinShiDuoEnum.ColorType.Yellow or FeiLinShiDuoEnum.ColorType.Red

		SLFramework.UGUI.GuiHelper.SetColor(arg_28_0._imagecolorBg, var_28_2)
		FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.changePlayerColor, var_28_3)
	end

	for iter_28_0 = 1, 4 do
		if var_28_1 == FeiLinShiDuoEnum.ColorType.Red or var_28_1 == FeiLinShiDuoEnum.ColorType.Yellow then
			ZProj.UGUIHelper.SetColorAlpha(arg_28_0.colorPlaneImageMap[iter_28_0], (iter_28_0 == FeiLinShiDuoEnum.ColorType.Red or iter_28_0 == FeiLinShiDuoEnum.ColorType.Yellow) and 1 or 0.3)
		else
			ZProj.UGUIHelper.SetColorAlpha(arg_28_0.colorPlaneImageMap[iter_28_0], iter_28_0 == var_28_1 and 1 or 0.3)
		end
	end
end

function var_0_0.refreshColorPlane(arg_29_0)
	if not arg_29_0.isOpenColorPlane or arg_29_0.isColorBtnAniming then
		return
	end

	local var_29_0, var_29_1 = recthelper.screenPosToAnchorPos2(GamepadController.instance:getMousePosition(), arg_29_0.colorPlaneRect)

	arg_29_0.mouseVector = Vector3(var_29_0 - arg_29_0.originTrans.localPosition.x, var_29_1 - arg_29_0.originTrans.localPosition.y, 0)

	local var_29_2 = Vector2.Dot(arg_29_0.startVector, arg_29_0.mouseVector)
	local var_29_3 = Vector2.Magnitude(arg_29_0.startVector)
	local var_29_4 = Vector2.Magnitude(arg_29_0.mouseVector)

	if var_29_3 == 0 or var_29_4 == 0 then
		return 0
	end

	local var_29_5 = Vector3.Cross(arg_29_0.startVector, arg_29_0.mouseVector)

	if var_29_4 > arg_29_0.mouseCheckRadius or var_29_5.z >= 0 then
		for iter_29_0 = 1, 4 do
			gohelper.setActive(arg_29_0["_gocolor" .. iter_29_0 .. "selected"], false)
		end

		return
	end

	local var_29_6 = var_29_2 / (var_29_3 * var_29_4)
	local var_29_7 = Mathf.Clamp(var_29_6, -1, 1)
	local var_29_8 = Mathf.Acos(var_29_7) * Mathf.Rad2Deg
	local var_29_9 = FeiLinShiDuoGameModel.instance:getBlindnessModeState()
	local var_29_10 = FeiLinShiDuoGameModel.instance:getCurColor() or FeiLinShiDuoEnum.ColorType.None
	local var_29_11 = false

	if var_29_8 > 120 and var_29_8 <= 180 and not var_29_9 then
		var_29_10 = FeiLinShiDuoEnum.ColorType.Red
		var_29_11 = true
	elseif var_29_8 > 120 and var_29_8 <= 180 and var_29_9 then
		var_29_10 = FeiLinShiDuoEnum.ColorType.Yellow
		var_29_11 = true
	elseif var_29_8 >= 0 and var_29_8 <= 60 then
		var_29_10 = FeiLinShiDuoEnum.ColorType.Green
		var_29_11 = true
	elseif var_29_8 > 60 and var_29_8 <= 120 then
		var_29_10 = FeiLinShiDuoEnum.ColorType.Blue
		var_29_11 = true
	end

	for iter_29_1 = 1, 4 do
		gohelper.setActive(arg_29_0["_gocolor" .. iter_29_1 .. "selected"], iter_29_1 == var_29_10 and var_29_11)
		ZProj.UGUIHelper.SetColorAlpha(arg_29_0.colorPlaneImageMap[iter_29_1], iter_29_1 == var_29_10 and 1 or 0.3)
	end
end

function var_0_0.onChangeColor(arg_30_0, arg_30_1, arg_30_2)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FeiLinShiDuoBanOper) or arg_30_0.isColorBtnAniming then
		return
	end

	arg_30_0._changeColorAnim.enabled = true

	gohelper.setActive(arg_30_0._btnchangColor.gameObject, true)

	if arg_30_0._gocolorPlane.activeSelf then
		arg_30_0.isOpenColorPlane = false

		arg_30_0._colorPlaneAnimPlayer:Play("out", arg_30_0.closeColorPlaneFinish, arg_30_0)

		if not arg_30_2 then
			arg_30_0._vxMaskAnim:Play("out", 0, 0)
		else
			arg_30_0._vxMaskAnim:Play("idle", 0, 0)
		end

		arg_30_0._btnMoveLeftAnim:Play("in", 0, 0)
		arg_30_0._btnMoveRightAnim:Play("in", 0, 0)
	end

	arg_30_0.isColorBtnAniming = true

	gohelper.setActive(arg_30_0._btnclosePlane.gameObject, false)

	if arg_30_0:checkIntersect() then
		GameFacade.showToast(ToastEnum.Act185ChangeColorWithSamePos)

		arg_30_1 = FeiLinShiDuoGameModel.instance:getCurColor()
	end

	FeiLinShiDuoGameModel.instance:setElememntShowStateByColor(arg_30_1)

	if arg_30_0.sceneview then
		arg_30_0.sceneview:changeSceneColor(arg_30_1)
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_30_0._imagecolorBg, FeiLinShiDuoEnum.ColorStr[arg_30_1])
	FeiLinShiDuoGameModel.instance:setIsPlayerInColorChanging(false)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.changePlayerColor, arg_30_1)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_scene_switch)
end

function var_0_0.closeColorPlaneFinish(arg_31_0)
	gohelper.setActive(arg_31_0._gocolorPlane, false)

	arg_31_0.isColorBtnAniming = false
end

function var_0_0.checkIntersect(arg_32_0)
	local var_32_0 = FeiLinShiDuoGameModel.instance:getElementMap()
	local var_32_1 = {}
	local var_32_2 = var_32_0[FeiLinShiDuoEnum.ObjectType.Box] or {}

	for iter_32_0, iter_32_1 in pairs(var_32_2) do
		table.insert(var_32_1, iter_32_1)
	end

	for iter_32_2, iter_32_3 in pairs(var_32_1) do
		for iter_32_4, iter_32_5 in pairs(var_32_1) do
			if iter_32_3.id ~= iter_32_5.id and FeiLinShiDuoGameModel.instance:getElementShowState(iter_32_5) and FeiLinShiDuoGameModel.instance:getElementShowState(iter_32_3) then
				local var_32_3 = iter_32_3.pos[1] + iter_32_3.width / 2
				local var_32_4 = iter_32_5.pos[1] + iter_32_5.width / 2

				if Mathf.Abs(var_32_3 - var_32_4) < iter_32_3.width / 2 + iter_32_5.width / 2 - FeiLinShiDuoEnum.touchCheckRange and Mathf.Abs(iter_32_3.pos[2] - iter_32_5.pos[2]) < FeiLinShiDuoEnum.HalfSlotWidth / 4 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.showOptionState(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_0.canShowOption == arg_33_1 then
		return
	end

	arg_33_0.canShowOption = arg_33_1

	if not arg_33_0.canShowOption and not arg_33_2 then
		if arg_33_0._btnoption.gameObject.activeSelf then
			arg_33_0._optionAnimPlayer:Play("out", arg_33_0.playOptionAnimFinish, arg_33_0)
		end

		arg_33_0.isOptionBtnAniming = true
	else
		arg_33_0._optionAnim.enabled = true

		gohelper.setActive(arg_33_0._btnoption.gameObject, arg_33_1)

		arg_33_0.isOptionBtnAniming = false
	end
end

function var_0_0.playOptionAnimFinish(arg_34_0)
	arg_34_0.isOptionBtnAniming = false
	arg_34_0.canShowOption = false

	gohelper.setActive(arg_34_0._btnoption.gameObject, false)
end

function var_0_0.showOptionCanDoState(arg_35_0, arg_35_1)
	if arg_35_0.canDoOption == arg_35_1 then
		return
	end

	arg_35_0.canDoOption = arg_35_1

	gohelper.setActive(arg_35_0._gocanOption, arg_35_0.canDoOption)
	gohelper.setActive(arg_35_0._gonotOption, not arg_35_0.canDoOption)
end

function var_0_0.resetGame(arg_36_0)
	arg_36_0:showOptionState(false, true)

	local var_36_0 = FeiLinShiDuoEnum.ColorType.None

	FeiLinShiDuoGameModel.instance:showAllElementState()

	if arg_36_0.sceneview then
		local var_36_1 = arg_36_0.sceneview:getPlayerGO()

		FeiLinShiDuoStatHelper.instance:sendResetGameMap(var_36_1)
		arg_36_0.sceneview:resetData()
	end

	arg_36_0:onChangeColor(var_36_0, true)
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.resetGame)

	arg_36_0.canDoOption = false
	arg_36_0.playerCurIdleState = true
	arg_36_0.isOptionBtnAniming = false
	arg_36_0.isColorBtnAniming = false
	arg_36_0.isOpenColorPlane = false

	arg_36_0._btnMoveLeftAnim:Play("idle", 0, 0)
	arg_36_0._btnMoveRightAnim:Play("idle", 0, 0)
end

function var_0_0.onCloseBtnClick(arg_37_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FeiLinShiDuoBanOper) then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.FeiLinShiDuoQuitGameTip, MsgBoxEnum.BoxType.Yes_No, arg_37_0.openGameResultView, nil, nil, arg_37_0)
end

function var_0_0.openGameResultView(arg_38_0)
	local var_38_0 = {}

	var_38_0.isSuccess = false

	FeiLinShiDuoGameController.instance:openGameResultView(var_38_0)

	local var_38_1 = arg_38_0.sceneview:getPlayerGO()

	FeiLinShiDuoStatHelper.instance:sendExitGameMap(var_38_1)
end

function var_0_0.showDeadEffect(arg_39_0)
	gohelper.setActive(arg_39_0._godeadEffect, false)
	gohelper.setActive(arg_39_0._godeadEffect, true)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_revival)
end

function var_0_0.onCloseViewFinish(arg_40_0, arg_40_1)
	if arg_40_1 == ViewName.GuideView then
		arg_40_0:_onLeftClickUp()
		arg_40_0:_onRightClickUp()
	end
end

function var_0_0.onClose(arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0.refreshColorPlane, arg_41_0)
end

function var_0_0.onDestroyView(arg_42_0)
	return
end

return var_0_0

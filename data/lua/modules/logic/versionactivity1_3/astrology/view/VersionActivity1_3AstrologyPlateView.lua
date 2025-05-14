module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyPlateView", package.seeall)

local var_0_0 = class("VersionActivity1_3AstrologyPlateView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goAstrologyPlate = gohelper.findChild(arg_1_0.viewGO, "#go_AstrologyPlate")
	arg_1_0._simagePlate = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_AstrologyPlate/#simage_Plate")
	arg_1_0._imageeffect = gohelper.findChildImage(arg_1_0.viewGO, "#go_AstrologyPlate/#simage_Plate/#image_effect")
	arg_1_0._gotaiyang = gohelper.findChild(arg_1_0.viewGO, "#go_AstrologyPlate/Planets/#go_taiyang")
	arg_1_0._goshuixing = gohelper.findChild(arg_1_0.viewGO, "#go_AstrologyPlate/Planets/#go_shuixing")
	arg_1_0._gojinxing = gohelper.findChild(arg_1_0.viewGO, "#go_AstrologyPlate/Planets/#go_jinxing")
	arg_1_0._goyueliang = gohelper.findChild(arg_1_0.viewGO, "#go_AstrologyPlate/Planets/#go_yueliang")
	arg_1_0._gohuoxing = gohelper.findChild(arg_1_0.viewGO, "#go_AstrologyPlate/Planets/#go_huoxing")
	arg_1_0._gomuxing = gohelper.findChild(arg_1_0.viewGO, "#go_AstrologyPlate/Planets/#go_muxing")
	arg_1_0._gotuxing = gohelper.findChild(arg_1_0.viewGO, "#go_AstrologyPlate/Planets/#go_tuxing")
	arg_1_0._goLeftInfo = gohelper.findChild(arg_1_0.viewGO, "#go_LeftInfo")
	arg_1_0._goleftbtn = gohelper.findChild(arg_1_0.viewGO, "#go_LeftInfo/#go_leftbtn")
	arg_1_0._btnLeftArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_LeftInfo/#go_leftbtn/#btn_LeftArrow")
	arg_1_0._txtLeftAngle = gohelper.findChildText(arg_1_0.viewGO, "#go_LeftInfo/#go_leftbtn/#txt_LeftAngle")
	arg_1_0._gorightbtn = gohelper.findChild(arg_1_0.viewGO, "#go_LeftInfo/#go_rightbtn")
	arg_1_0._btnRightArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_LeftInfo/#go_rightbtn/#btn_RightArrow")
	arg_1_0._txtRightAngle = gohelper.findChildText(arg_1_0.viewGO, "#go_LeftInfo/#go_rightbtn/#txt_RightAngle")
	arg_1_0._gorightbtndisable = gohelper.findChild(arg_1_0.viewGO, "#go_LeftInfo/#go_rightbtndisable")
	arg_1_0._btnRightArrowDisable = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_LeftInfo/#go_rightbtndisable/#btn_RightArrowDisable")
	arg_1_0._txtRightAngledisable = gohelper.findChildText(arg_1_0.viewGO, "#go_LeftInfo/#go_rightbtndisable/#txt_RightAngledisable")
	arg_1_0._goleftbtndisable = gohelper.findChild(arg_1_0.viewGO, "#go_LeftInfo/#go_leftbtndisable")
	arg_1_0._btnLeftArrowDisable = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_LeftInfo/#go_leftbtndisable/#btn_LeftArrowDisable")
	arg_1_0._txtLeftAngleDisable = gohelper.findChildText(arg_1_0.viewGO, "#go_LeftInfo/#go_leftbtndisable/#txt_LeftAngleDisable")
	arg_1_0._btnAstrology = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_LeftInfo/#btn_Astrology")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_LeftInfo/#btn_Astrology/#go_reddot")
	arg_1_0._gomodel = gohelper.findChild(arg_1_0.viewGO, "#go_model")
	arg_1_0._goDecText = gohelper.findChild(arg_1_0.viewGO, "#go_DecText")
	arg_1_0._txtDecText = gohelper.findChildText(arg_1_0.viewGO, "#go_DecText/#txt_DecText")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnLeftArrow:AddClickListener(arg_2_0._btnLeftArrowOnClick, arg_2_0)
	arg_2_0._btnRightArrow:AddClickListener(arg_2_0._btnRightArrowOnClick, arg_2_0)
	arg_2_0._btnRightArrowDisable:AddClickListener(arg_2_0._btnRightArrowDisableOnClick, arg_2_0)
	arg_2_0._btnLeftArrowDisable:AddClickListener(arg_2_0._btnLeftArrowDisableOnClick, arg_2_0)
	arg_2_0._btnAstrology:AddClickListener(arg_2_0._btnAstrologyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnLeftArrow:RemoveClickListener()
	arg_3_0._btnRightArrow:RemoveClickListener()
	arg_3_0._btnRightArrowDisable:RemoveClickListener()
	arg_3_0._btnLeftArrowDisable:RemoveClickListener()
	arg_3_0._btnAstrology:RemoveClickListener()
end

function var_0_0._btnRightArrowDisableOnClick(arg_4_0)
	arg_4_0:_disableTip()
end

function var_0_0._btnLeftArrowDisableOnClick(arg_5_0)
	arg_5_0:_disableTip()
end

function var_0_0._disableTip(arg_6_0)
	if arg_6_0._planetMo.num <= 0 then
		GameFacade.showToast(ToastEnum.Activity126_tip7)

		return
	end

	GameFacade.showToast(ToastEnum.Activity126_tip4)
end

function var_0_0._btnLeftArrowOnClick(arg_7_0)
	arg_7_0:_rotate(VersionActivity1_3AstrologyEnum.Angle)
end

function var_0_0._btnRightArrowOnClick(arg_8_0)
	arg_8_0:_rotate(-VersionActivity1_3AstrologyEnum.Angle)
end

function var_0_0._rotate(arg_9_0, arg_9_1)
	if not arg_9_0._selectedItem then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_move)
	arg_9_0:_createGhost(arg_9_0._selectedItem:getId())
	arg_9_0:_tweenRotate(arg_9_0._selectedItem:getId(), arg_9_1)
	arg_9_0._planetMo:updatePreviewAngle(arg_9_1)
	arg_9_0:_updateBtnStatus()
	VersionActivity1_3AstrologyController.instance:dispatchEvent(VersionActivity1_3AstrologyEvent.adjustPreviewAngle)
	arg_9_0:_showPreviewStar()
end

function var_0_0._tweenRotate(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0._tweenList[arg_10_1]

	if not var_10_0 then
		var_10_0 = {
			self = arg_10_0,
			planetId = arg_10_1,
			mo = VersionActivity1_3AstrologyModel.instance:getPlanetMo(arg_10_1)
		}
		var_10_0.tweenId = nil
		arg_10_0._tweenList[arg_10_1] = var_10_0
	end

	if var_10_0.tweenId then
		ZProj.TweenHelper.KillById(var_10_0.tweenId)

		var_10_0.tweenId = nil
		var_10_0.curAngle = var_10_0.curAngle + var_10_0.prevAngle
		var_10_0.prevAngle = 0
	else
		var_10_0.prevAngle = 0
		var_10_0.curAngle = var_10_0.mo.previewAngle
		var_10_0.targetAngle = var_10_0.mo.previewAngle
	end

	var_10_0.targetAngle = var_10_0.targetAngle + arg_10_2
	var_10_0.tweenAngle = var_10_0.targetAngle - var_10_0.curAngle
	var_10_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, var_10_0.tweenAngle, 0.5, arg_10_0._tweenRotateFrame, arg_10_0._tweenRotateFinish, var_10_0, nil, EaseType.Linear)
end

function var_0_0._tweenRotateFrame(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.self

	var_11_0:_rotateAround(arg_11_0.planetId, -arg_11_0.prevAngle + arg_11_1)

	arg_11_0.prevAngle = arg_11_1

	var_11_0:_sortPlanets(true)
end

function var_0_0._tweenRotateFinish(arg_12_0)
	local var_12_0 = arg_12_0.self

	var_12_0:_rotateAround(arg_12_0.planetId, -arg_12_0.prevAngle + arg_12_0.tweenAngle)

	arg_12_0.prevAngle = arg_12_0.tweenAngle
	arg_12_0.tweenId = nil

	var_12_0:_sortPlanets()
end

function var_0_0._showRotateEffect(arg_13_0)
	if not arg_13_0._selectedItem then
		gohelper.setActive(arg_13_0._imageeffect, false)

		return
	end

	local var_13_0 = arg_13_0._selectedItem:getId()
	local var_13_1 = arg_13_0._planetList[var_13_0]

	if not var_13_1 or not var_13_1._ghostGoInfo then
		gohelper.setActive(arg_13_0._imageeffect, false)

		return
	end

	local var_13_2 = var_13_1._ghostGoInfo.go

	if not var_13_2 or not var_13_2.activeSelf then
		gohelper.setActive(arg_13_0._imageeffect, false)

		return
	end

	local var_13_3 = arg_13_0._tweenList[var_13_0]

	if not var_13_3 then
		return
	end

	gohelper.setActive(arg_13_0._imageeffect, true)

	local var_13_4
	local var_13_5
	local var_13_6 = var_13_1._ghostGoInfo.limitAngle

	if var_13_0 == VersionActivity1_3AstrologyEnum.Planet.shuixing then
		local var_13_7 = arg_13_0._modelPlanetList[var_13_0]
		local var_13_8, var_13_9, var_13_10 = transformhelper.getLocalRotation(var_13_7)

		var_13_4 = var_13_1._ghostGoInfo.ghostAngle % 360
		var_13_5 = var_13_9 % 360
	else
		var_13_4 = arg_13_0:_getAngle(var_13_2.transform)
		var_13_5 = arg_13_0:_getAngle(var_13_1[1])
	end

	local var_13_11 = false

	if var_13_4 < var_13_6 then
		var_13_11 = var_13_4 <= var_13_5 and var_13_5 < var_13_6
	elseif var_13_4 <= var_13_5 and var_13_5 <= 360 or var_13_5 >= 0 and var_13_5 < var_13_6 then
		var_13_11 = true
	end

	if math.abs(var_13_5 - var_13_6) <= 10 then
		var_13_11 = var_13_3.lastForward
	end

	if var_13_11 then
		if var_13_5 < var_13_4 then
			var_13_5 = var_13_5 + 360
		end
	elseif var_13_4 < var_13_6 and var_13_4 < var_13_5 then
		var_13_5 = var_13_5 - 360
	end

	var_13_3.lastForward = var_13_11
	arg_13_0._matParamVec.x = var_13_4
	arg_13_0._matParamVec.y = var_13_5

	arg_13_0._matEffect:SetVector(arg_13_0._matKey, arg_13_0._matParamVec)
end

function var_0_0._getAngle(arg_14_0, arg_14_1)
	local var_14_0, var_14_1 = recthelper.getAnchor(arg_14_1)

	return (-Mathf.Atan2(var_14_1 - 152, var_14_0) * Mathf.Rad2Deg - 90) % 360
end

function var_0_0._sortPlanets(arg_15_0, arg_15_1)
	for iter_15_0 = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		local var_15_0 = arg_15_0._planetList[iter_15_0]
		local var_15_1 = var_15_0[1]
		local var_15_2 = VersionActivity1_3AstrologyModel.instance:getPlanetMo(iter_15_0)

		if var_15_0._ghostGoInfo then
			local var_15_3 = var_15_0._ghostGoInfo.go

			if var_15_0._ghostGoInfo.isFront then
				gohelper.setAsLastSibling(var_15_3)
			else
				gohelper.setAsFirstSibling(var_15_3)
			end

			if arg_15_1 and not var_15_2:hasAdjust() then
				-- block empty
			else
				gohelper.setActive(var_15_3, var_15_2:hasAdjust())
			end
		end

		local var_15_4 = var_15_2:isFront()
		local var_15_5 = arg_15_0._tweenList[iter_15_0]

		if var_15_5 and var_15_5.tweenId then
			var_15_4 = var_15_2:isFront(var_15_5.curAngle + var_15_5.prevAngle)
		end

		if var_15_4 then
			gohelper.setAsLastSibling(var_15_1.gameObject)
		else
			gohelper.setAsFirstSibling(var_15_1.gameObject)
		end
	end

	arg_15_0:_showRotateEffect()
end

function var_0_0._hideGhosts(arg_16_0)
	for iter_16_0 = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		local var_16_0 = arg_16_0._planetList[iter_16_0]
		local var_16_1 = var_16_0[1]
		local var_16_2 = VersionActivity1_3AstrologyModel.instance:getPlanetMo(iter_16_0)

		if var_16_0._ghostGoInfo then
			local var_16_3 = var_16_0._ghostGoInfo.go

			gohelper.setActive(var_16_3, false)

			var_16_0._ghostGoInfo._isRefresh = nil
		end
	end
end

function var_0_0._btnAstrologyOnClick(arg_17_0)
	local var_17_0 = VersionActivity1_3AstrologyModel.instance:getQuadrantResult()

	Activity126Rpc.instance:sendHoroscopeRequest(VersionActivity1_3Enum.ActivityId.Act310, var_17_0)
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0._matEffect = arg_18_0._imageeffect.material
	arg_18_0._matKey = UnityEngine.Shader.PropertyToID("_RotateAngle")
	arg_18_0._matParamVec = arg_18_0._matEffect:GetVector(arg_18_0._matKey)

	arg_18_0._simagePlate:LoadImage(ResUrl.getV1a3AstrologySinglebg("v1a3_astrology_plate"))

	arg_18_0._tweenList = {}
	arg_18_0._planetsTransform = gohelper.findChild(arg_18_0.viewGO, "#go_AstrologyPlate/Planets").transform
	arg_18_0._prevNum = Activity126Model.instance:getStarNum()

	RedDotController.instance:addRedDot(arg_18_0._goreddot, RedDotEnum.DotNode.Activity1_3RedDot4)

	arg_18_0._tipAnimator = arg_18_0._goDecText:GetComponent(typeof(UnityEngine.Animator))

	arg_18_0:_setDecVisible(false)
end

function var_0_0._worldPosToRelativeAnchorPos(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0._modelCamera:WorldToScreenPoint(arg_19_1)
	local var_19_1 = CameraMgr.instance:getUICamera()

	return SLFramework.UGUI.RectTrHelper.ScreenPosToAnchorPos(var_19_0, arg_19_2, var_19_1)
end

function var_0_0.calcFOV(arg_20_0, arg_20_1)
	local var_20_0 = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	if var_20_0 < 1 then
		arg_20_1 = arg_20_1 / var_20_0
	elseif var_20_0 > 1 then
		arg_20_1 = arg_20_1 * var_20_0 * 0.85
	end

	return arg_20_1
end

function var_0_0._createGhost(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._planetList[arg_21_1]
	local var_21_1 = var_21_0[1].gameObject

	if not var_21_0._ghostGoInfo then
		local var_21_2 = gohelper.cloneInPlace(var_21_1, var_21_1.name .. "_ghost")
		local var_21_3 = gohelper.findChild(var_21_2, "go_selected")

		gohelper.setActive(var_21_3, false)

		local var_21_4 = var_21_2.transform
		local var_21_5 = var_21_4.childCount

		for iter_21_0 = 1, var_21_5 do
			local var_21_6 = var_21_4:GetChild(iter_21_0 - 1):GetComponent(gohelper.Type_Image)

			if var_21_6 then
				local var_21_7 = var_21_6.color

				var_21_7.a = 0.5
				var_21_6.color = var_21_7
			end
		end

		var_21_0._ghostGoInfo = arg_21_0:getUserDataTb_()
		var_21_0._ghostGoInfo.go = var_21_2
	end

	local var_21_8 = var_21_0._ghostGoInfo

	if not var_21_8._isRefresh then
		var_21_8.go.transform.position = var_21_1.transform.position
		var_21_8.isFront = VersionActivity1_3AstrologyModel.instance:getPlanetMo(arg_21_1):isFront()

		local var_21_9 = arg_21_0._modelPlanetList[arg_21_1]
		local var_21_10, var_21_11, var_21_12 = transformhelper.getLocalRotation(var_21_9)

		var_21_8.ghostAngle = var_21_11
		var_21_8._isRefresh = true

		arg_21_0:_rotateAround(arg_21_1, 180)

		var_21_8.limitAngle = arg_21_0:_getAngle(var_21_0[1])

		arg_21_0:_rotateAround(arg_21_1, -180)
	end
end

function var_0_0._rotateAround(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0._modelPlanetList[VersionActivity1_3AstrologyEnum.Planet.taiyang]
	local var_22_1 = arg_22_0._modelPlanetList[arg_22_1]
	local var_22_2 = arg_22_0._planetList[arg_22_1][1]

	var_22_1:RotateAround(var_22_0.position, Vector3.up, arg_22_2)
	arg_22_0:_syncPlanetPos(arg_22_1)
end

function var_0_0._syncPlanetPos(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._modelPlanetList[arg_23_1]
	local var_23_1 = arg_23_0._planetList[arg_23_1][1]
	local var_23_2 = arg_23_0:_worldPosToRelativeAnchorPos(var_23_0.position, arg_23_0._planetsTransform)

	recthelper.setAnchor(var_23_1, var_23_2.x + VersionActivity1_3AstrologyEnum.PlanetOffsetX, var_23_2.y + VersionActivity1_3AstrologyEnum.PlanetOffsetY)
end

function var_0_0._init(arg_24_0)
	arg_24_0._txtLeftAngle.text = string.format("%s°", VersionActivity1_3AstrologyEnum.Angle)
	arg_24_0._txtLeftAngleDisable.text = string.format("%s°", VersionActivity1_3AstrologyEnum.Angle)
	arg_24_0._txtRightAngle.text = string.format("-%s°", VersionActivity1_3AstrologyEnum.Angle)
	arg_24_0._txtRightAngledisable.text = string.format("-%s°", VersionActivity1_3AstrologyEnum.Angle)
end

function var_0_0._initStars(arg_25_0)
	arg_25_0._lightStarList = arg_25_0:getUserDataTb_()
	arg_25_0._lightStarAnimatorList = arg_25_0:getUserDataTb_()
	arg_25_0._lightStarPreviewList = {}

	for iter_25_0 = 1, VersionActivity1_3AstrologyEnum.MaxStarNum do
		local var_25_0 = gohelper.findChild(arg_25_0.viewGO, string.format("#go_LeftInfo/Stars/image_Star%s/image_StarBG/lightStar", iter_25_0))

		gohelper.setActive(var_25_0, false)

		arg_25_0._lightStarList[iter_25_0] = var_25_0

		local var_25_1 = gohelper.findChild(arg_25_0.viewGO, string.format("#go_LeftInfo/Stars/image_Star%s", iter_25_0)):GetComponent(typeof(UnityEngine.Animator))

		arg_25_0._lightStarAnimatorList[iter_25_0] = var_25_1
	end
end

function var_0_0._showStar(arg_26_0)
	local var_26_0 = Activity126Model.instance:getStarNum()
	local var_26_1 = 0

	for iter_26_0, iter_26_1 in ipairs(arg_26_0._lightStarList) do
		local var_26_2 = iter_26_0 <= var_26_0

		gohelper.setActive(iter_26_1, var_26_2)

		if var_26_2 then
			var_26_1 = var_26_1 + 1

			arg_26_0._lightStarAnimatorList[iter_26_0]:Play("idle")
		end
	end

	gohelper.setActive(arg_26_0._btnAstrology, var_26_0 >= #arg_26_0._lightStarList)
	arg_26_0:_showTip(var_26_1)

	if arg_26_0._prevNum and arg_26_0._prevNum < 10 and var_26_0 >= 10 then
		GameFacade.showToast(ToastEnum.Activity126_tip5)
		VersionActivity1_3AstrologyController.instance:dispatchEvent(VersionActivity1_3AstrologyEvent.guideOnAstrologyBtnShow)
	end

	arg_26_0._prevNum = var_26_0
end

function var_0_0._showPreviewStar(arg_27_0)
	local var_27_0 = VersionActivity1_3AstrologyModel.instance:getAdjustNum()
	local var_27_1 = Activity126Model.instance:getStarNum()
	local var_27_2 = 0

	for iter_27_0, iter_27_1 in ipairs(arg_27_0._lightStarList) do
		local var_27_3 = iter_27_0 <= var_27_1 + var_27_0

		gohelper.setActive(iter_27_1, var_27_3)

		arg_27_0._lightStarPreviewList[iter_27_0] = false

		if var_27_3 and var_27_1 < iter_27_0 then
			arg_27_0._lightStarAnimatorList[iter_27_0]:Play("loop", 0, 0)

			arg_27_0._lightStarPreviewList[iter_27_0] = true
		end
	end
end

function var_0_0._showStarOpen(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0._lightStarList) do
		if arg_28_0._lightStarPreviewList[iter_28_0] then
			arg_28_0._lightStarAnimatorList[iter_28_0]:Play("open", 0, 0)
		end

		arg_28_0._lightStarPreviewList[iter_28_0] = false
	end
end

function var_0_0._showTip(arg_29_0, arg_29_1)
	if arg_29_1 <= 0 then
		arg_29_0:_setDecVisible(false)

		return
	end

	arg_29_0:_setDecVisible(true)
end

function var_0_0._checkResult(arg_30_0)
	local var_30_0 = Activity126Model.instance:receiveHoroscope()
	local var_30_1 = var_30_0 and var_30_0 > 0

	gohelper.setActive(arg_30_0._goLeftInfo, not var_30_1)
	gohelper.setActive(arg_30_0._txtDecText, not var_30_1)

	if var_30_1 then
		arg_30_0:_setDecVisible(false)
	end
end

function var_0_0._setDecVisible(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0._goDecText.activeSelf

	gohelper.setActive(arg_31_0._goDecText, arg_31_1)

	if arg_31_1 then
		if var_31_0 then
			return
		end

		arg_31_0:_delayShowTip()
	else
		TaskDispatcher.cancelTask(arg_31_0._delaySwitch, arg_31_0)
		TaskDispatcher.cancelTask(arg_31_0._delayShowTip, arg_31_0)
	end
end

function var_0_0._delaySwitch(arg_32_0)
	arg_32_0._tipAnimator:Play("close", 0, 0)
	TaskDispatcher.cancelTask(arg_32_0._delayShowTip, arg_32_0)
	TaskDispatcher.runDelay(arg_32_0._delayShowTip, arg_32_0, 3)
end

function var_0_0._delayShowTip(arg_33_0)
	arg_33_0:_randomTip()
	arg_33_0._tipAnimator:Play("open", 0, 0)
	TaskDispatcher.cancelTask(arg_33_0._delaySwitch, arg_33_0)
	TaskDispatcher.runDelay(arg_33_0._delaySwitch, arg_33_0, 5)
end

function var_0_0._randomTip(arg_34_0)
	local var_34_0 = arg_34_0:_randomPos()
	local var_34_1 = var_34_0[1] or 0
	local var_34_2 = var_34_0[2] or 0

	recthelper.setAnchor(arg_34_0._goDecText.transform, var_34_1, var_34_2)

	local var_34_3 = arg_34_0:_randomTipConfig()

	arg_34_0._txtDecText.text = var_34_3.tip
end

function var_0_0._randomPos(arg_35_0)
	local var_35_0 = 3

	while true do
		var_35_0 = var_35_0 - 1

		local var_35_1 = math.random(#VersionActivity1_3AstrologyEnum.TipPos)

		if arg_35_0._randomPosIndex ~= var_35_1 or var_35_0 <= 0 then
			arg_35_0._randomPosIndex = var_35_1

			break
		end
	end

	return VersionActivity1_3AstrologyEnum.TipPos[arg_35_0._randomPosIndex]
end

function var_0_0._randomTipConfig(arg_36_0)
	local var_36_0 = Activity126Model.instance:getStarNum()
	local var_36_1 = math.min(var_36_0, VersionActivity1_3AstrologyEnum.MaxStarNum)
	local var_36_2 = 3

	while true do
		var_36_2 = var_36_2 - 1

		local var_36_3 = math.random(var_36_1)

		if arg_36_0._randomTipConfigIndex ~= var_36_3 or var_36_2 <= 0 then
			arg_36_0._randomTipConfigIndex = var_36_3

			break
		end
	end

	return (Activity126Config.instance:getStarConfig(VersionActivity1_3Enum.ActivityId.Act310, arg_36_0._randomTipConfigIndex))
end

function var_0_0.onOpen(arg_37_0)
	transformhelper.setLocalScale(arg_37_0.viewContainer.viewGO.transform, 1, 1, 1)
	arg_37_0:_init()
	arg_37_0:_initStars()
	arg_37_0:_initPlanets()
	arg_37_0:_initModel()
	arg_37_0:_onScreenSizeChange()
	arg_37_0:_initPlanetsAngles()
	arg_37_0:_sortPlanets()
	arg_37_0:_showStar()
	arg_37_0:_checkResult()
	arg_37_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_37_0._onScreenSizeChange, arg_37_0)
	arg_37_0:addEventCb(VersionActivity1_3AstrologyController.instance, VersionActivity1_3AstrologyEvent.selectPlanetItem, arg_37_0._selectPlanetItem, arg_37_0)
	arg_37_0:addEventCb(Activity126Controller.instance, Activity126Event.onUpdateProgressReply, arg_37_0._onUpdateProgressReply, arg_37_0)
	arg_37_0:addEventCb(Activity126Controller.instance, Activity126Event.onHoroscopeReply, arg_37_0._onHoroscopeReply, arg_37_0)
	arg_37_0:addEventCb(Activity126Controller.instance, Activity126Event.onResetProgressReply, arg_37_0._onResetProgressReply, arg_37_0)
	arg_37_0:addEventCb(Activity126Controller.instance, Activity126Event.onBeforeResetProgressReply, arg_37_0._onBeforeResetProgressReply, arg_37_0)
	arg_37_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_37_0._onCloseViewFinish, arg_37_0)
end

function var_0_0._onCloseViewFinish(arg_38_0, arg_38_1)
	if arg_38_1 == ViewName.VersionActivity1_3AstrologySuccessView then
		arg_38_0.viewContainer:switchTab(2)
	end
end

function var_0_0._onBeforeResetProgressReply(arg_39_0)
	for iter_39_0, iter_39_1 in pairs(arg_39_0._modelPlanetPosList) do
		local var_39_0 = arg_39_0._modelPlanetList[iter_39_0]

		var_39_0.position = iter_39_1

		local var_39_1 = arg_39_0._modelPlanetRotationList[iter_39_0]

		transformhelper.setLocalRotation(var_39_0, var_39_1[1], var_39_1[2], var_39_1[3])
	end
end

function var_0_0._onResetProgressReply(arg_40_0)
	arg_40_0._prevNum = Activity126Model.instance:getStarNum()

	arg_40_0:_checkResult()
	arg_40_0:_updateSelectedFlag()
	arg_40_0:_initPlanetsAngles()
	arg_40_0:_sortPlanets()
end

function var_0_0._onHoroscopeReply(arg_41_0)
	VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologySuccessView()
	arg_41_0:_checkResult()
	arg_41_0:_hideGhosts()
	arg_41_0:_updateSelectedFlagById(nil)
end

function var_0_0._onUpdateProgressReply(arg_42_0, arg_42_1)
	if arg_42_1 and arg_42_1.fromReset then
		arg_42_0:_showStar()
	else
		local var_42_0 = arg_42_0.viewContainer:getSendPlanetList()

		arg_42_0:_showAdjustEffect(var_42_0)
		arg_42_0:_showStarOpen()
		GameFacade.showToast(ToastEnum.Activity126_tip9)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("AstrologyDelayShowReply")
		TaskDispatcher.cancelTask(arg_42_0._delayShowReply, arg_42_0)
		TaskDispatcher.runDelay(arg_42_0._delayShowReply, arg_42_0, 2)
	end

	arg_42_0:_hideGhosts()
	arg_42_0:_updateBtnStatus()
	arg_42_0:_showRotateEffect()
end

function var_0_0._delayShowReply(arg_43_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AstrologyDelayShowReply")
	arg_43_0:_showStar()
	arg_43_0:_hideAdjustEffect()

	local var_43_0 = VersionActivity1_3AstrologyModel.instance:getStarReward()

	if var_43_0 then
		VersionActivity1_3AstrologyModel.instance:setStarReward(nil)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_43_0)
	end
end

function var_0_0._showAdjustEffect(arg_44_0, arg_44_1)
	if not arg_44_1 then
		return
	end

	for iter_44_0, iter_44_1 in pairs(arg_44_1) do
		local var_44_0 = arg_44_0._planetList[iter_44_0][3]

		gohelper.setActive(var_44_0, true)
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_confirm)
end

function var_0_0._hideAdjustEffect(arg_45_0)
	for iter_45_0, iter_45_1 in pairs(arg_45_0._planetList) do
		local var_45_0 = iter_45_1[3]

		gohelper.setActive(var_45_0, false)
	end
end

function var_0_0._selectPlanetItem(arg_46_0, arg_46_1)
	arg_46_0._selectedItem = arg_46_1
	arg_46_0._planetMo = arg_46_0._selectedItem:getPlanetMo()

	arg_46_0:_updateBtnStatus()
	arg_46_0:_updateSelectedFlag()
	arg_46_0:_showRotateEffect()
end

function var_0_0._updateSelectedFlag(arg_47_0)
	local var_47_0 = arg_47_0._selectedItem and arg_47_0._selectedItem:getId()

	arg_47_0:_updateSelectedFlagById(var_47_0)
end

function var_0_0._updateSelectedFlagById(arg_48_0, arg_48_1)
	for iter_48_0, iter_48_1 in pairs(arg_48_0._planetList) do
		gohelper.setActive(iter_48_1[2], iter_48_0 == arg_48_1)
	end
end

function var_0_0._updateBtnStatus(arg_49_0)
	if not arg_49_0._planetMo then
		return
	end

	local var_49_0 = arg_49_0._planetMo.num
	local var_49_1 = var_49_0 > 0
	local var_49_2 = var_49_0 > 0
	local var_49_3 = arg_49_0._planetMo:getRemainNum()

	if var_49_0 > 0 and var_49_0 < 3 and var_49_3 == 0 then
		local var_49_4 = arg_49_0._planetMo:minDeltaAngle()
		local var_49_5 = arg_49_0._planetMo.previewAngle % 360
		local var_49_6 = arg_49_0._planetMo.angle % 360

		var_49_2 = (var_49_5 - var_49_4) % 360 == var_49_6
		var_49_1 = not var_49_2
	end

	gohelper.setActive(arg_49_0._goleftbtn, var_49_1)
	gohelper.setActive(arg_49_0._goleftbtndisable, not var_49_1)
	gohelper.setActive(arg_49_0._gorightbtn, var_49_2)
	gohelper.setActive(arg_49_0._gorightbtndisable, not var_49_2)
end

function var_0_0._onScreenSizeChange(arg_50_0)
	arg_50_0._modelCamera.fieldOfView = arg_50_0:calcFOV(48)
end

function var_0_0._initPlanets(arg_51_0)
	arg_51_0._planetList = arg_51_0:getUserDataTb_()

	for iter_51_0, iter_51_1 in pairs(VersionActivity1_3AstrologyEnum.Planet) do
		local var_51_0 = arg_51_0["_go" .. iter_51_0]
		local var_51_1 = gohelper.findChild(var_51_0, "go_selected")
		local var_51_2 = gohelper.findChild(var_51_0, "vx")
		local var_51_3 = arg_51_0:getUserDataTb_()

		var_51_3[1] = var_51_0.transform
		var_51_3[2] = var_51_1
		var_51_3[3] = var_51_2
		arg_51_0._planetList[iter_51_1] = var_51_3
	end
end

function var_0_0._initPlanetsAngles(arg_52_0)
	for iter_52_0 = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		local var_52_0 = VersionActivity1_3AstrologyModel.instance:getPlanetMo(iter_52_0)

		arg_52_0:_rotateAround(iter_52_0, -90 + var_52_0.angle)
	end
end

function var_0_0._initModel(arg_53_0)
	arg_53_0._modelCamera = gohelper.findChild(arg_53_0._gomodel, "cam"):GetComponent("Camera")
	arg_53_0._modelPlanetList = arg_53_0:getUserDataTb_()
	arg_53_0._modelPlanetPosList = arg_53_0:getUserDataTb_()
	arg_53_0._modelPlanetRotationList = arg_53_0:getUserDataTb_()

	for iter_53_0, iter_53_1 in pairs(VersionActivity1_3AstrologyEnum.Planet) do
		arg_53_0:_addPlanet(iter_53_1, iter_53_0)
	end
end

function var_0_0._addPlanet(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = gohelper.findChild(arg_54_0._gomodel, "zhanxingpan/xingqiu/" .. arg_54_2).transform

	arg_54_0._modelPlanetList[arg_54_1] = var_54_0
	arg_54_0._modelPlanetPosList[arg_54_1] = var_54_0.position

	local var_54_1, var_54_2, var_54_3 = transformhelper.getLocalRotation(var_54_0)

	arg_54_0._modelPlanetRotationList[arg_54_1] = {
		var_54_1,
		var_54_2,
		var_54_3
	}
end

function var_0_0.onClose(arg_55_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AstrologyDelayShowReply")

	for iter_55_0, iter_55_1 in pairs(arg_55_0._tweenList) do
		if iter_55_1.tweenId then
			ZProj.TweenHelper.KillById(iter_55_1.tweenId)

			iter_55_1.tweenId = nil
		end
	end

	TaskDispatcher.cancelTask(arg_55_0._delayShowReply, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._delaySwitch, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._delayShowTip, arg_55_0)
end

function var_0_0.onDestroyView(arg_56_0)
	arg_56_0._simagePlate:UnLoadImage()
end

return var_0_0

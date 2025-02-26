module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyPlateView", package.seeall)

slot0 = class("VersionActivity1_3AstrologyPlateView", BaseView)

function slot0.onInitView(slot0)
	slot0._goAstrologyPlate = gohelper.findChild(slot0.viewGO, "#go_AstrologyPlate")
	slot0._simagePlate = gohelper.findChildSingleImage(slot0.viewGO, "#go_AstrologyPlate/#simage_Plate")
	slot0._imageeffect = gohelper.findChildImage(slot0.viewGO, "#go_AstrologyPlate/#simage_Plate/#image_effect")
	slot0._gotaiyang = gohelper.findChild(slot0.viewGO, "#go_AstrologyPlate/Planets/#go_taiyang")
	slot0._goshuixing = gohelper.findChild(slot0.viewGO, "#go_AstrologyPlate/Planets/#go_shuixing")
	slot0._gojinxing = gohelper.findChild(slot0.viewGO, "#go_AstrologyPlate/Planets/#go_jinxing")
	slot0._goyueliang = gohelper.findChild(slot0.viewGO, "#go_AstrologyPlate/Planets/#go_yueliang")
	slot0._gohuoxing = gohelper.findChild(slot0.viewGO, "#go_AstrologyPlate/Planets/#go_huoxing")
	slot0._gomuxing = gohelper.findChild(slot0.viewGO, "#go_AstrologyPlate/Planets/#go_muxing")
	slot0._gotuxing = gohelper.findChild(slot0.viewGO, "#go_AstrologyPlate/Planets/#go_tuxing")
	slot0._goLeftInfo = gohelper.findChild(slot0.viewGO, "#go_LeftInfo")
	slot0._goleftbtn = gohelper.findChild(slot0.viewGO, "#go_LeftInfo/#go_leftbtn")
	slot0._btnLeftArrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_LeftInfo/#go_leftbtn/#btn_LeftArrow")
	slot0._txtLeftAngle = gohelper.findChildText(slot0.viewGO, "#go_LeftInfo/#go_leftbtn/#txt_LeftAngle")
	slot0._gorightbtn = gohelper.findChild(slot0.viewGO, "#go_LeftInfo/#go_rightbtn")
	slot0._btnRightArrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_LeftInfo/#go_rightbtn/#btn_RightArrow")
	slot0._txtRightAngle = gohelper.findChildText(slot0.viewGO, "#go_LeftInfo/#go_rightbtn/#txt_RightAngle")
	slot0._gorightbtndisable = gohelper.findChild(slot0.viewGO, "#go_LeftInfo/#go_rightbtndisable")
	slot0._btnRightArrowDisable = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_LeftInfo/#go_rightbtndisable/#btn_RightArrowDisable")
	slot0._txtRightAngledisable = gohelper.findChildText(slot0.viewGO, "#go_LeftInfo/#go_rightbtndisable/#txt_RightAngledisable")
	slot0._goleftbtndisable = gohelper.findChild(slot0.viewGO, "#go_LeftInfo/#go_leftbtndisable")
	slot0._btnLeftArrowDisable = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_LeftInfo/#go_leftbtndisable/#btn_LeftArrowDisable")
	slot0._txtLeftAngleDisable = gohelper.findChildText(slot0.viewGO, "#go_LeftInfo/#go_leftbtndisable/#txt_LeftAngleDisable")
	slot0._btnAstrology = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_LeftInfo/#btn_Astrology")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#go_LeftInfo/#btn_Astrology/#go_reddot")
	slot0._gomodel = gohelper.findChild(slot0.viewGO, "#go_model")
	slot0._goDecText = gohelper.findChild(slot0.viewGO, "#go_DecText")
	slot0._txtDecText = gohelper.findChildText(slot0.viewGO, "#go_DecText/#txt_DecText")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnLeftArrow:AddClickListener(slot0._btnLeftArrowOnClick, slot0)
	slot0._btnRightArrow:AddClickListener(slot0._btnRightArrowOnClick, slot0)
	slot0._btnRightArrowDisable:AddClickListener(slot0._btnRightArrowDisableOnClick, slot0)
	slot0._btnLeftArrowDisable:AddClickListener(slot0._btnLeftArrowDisableOnClick, slot0)
	slot0._btnAstrology:AddClickListener(slot0._btnAstrologyOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnLeftArrow:RemoveClickListener()
	slot0._btnRightArrow:RemoveClickListener()
	slot0._btnRightArrowDisable:RemoveClickListener()
	slot0._btnLeftArrowDisable:RemoveClickListener()
	slot0._btnAstrology:RemoveClickListener()
end

function slot0._btnRightArrowDisableOnClick(slot0)
	slot0:_disableTip()
end

function slot0._btnLeftArrowDisableOnClick(slot0)
	slot0:_disableTip()
end

function slot0._disableTip(slot0)
	if slot0._planetMo.num <= 0 then
		GameFacade.showToast(ToastEnum.Activity126_tip7)

		return
	end

	GameFacade.showToast(ToastEnum.Activity126_tip4)
end

function slot0._btnLeftArrowOnClick(slot0)
	slot0:_rotate(VersionActivity1_3AstrologyEnum.Angle)
end

function slot0._btnRightArrowOnClick(slot0)
	slot0:_rotate(-VersionActivity1_3AstrologyEnum.Angle)
end

function slot0._rotate(slot0, slot1)
	if not slot0._selectedItem then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_move)
	slot0:_createGhost(slot0._selectedItem:getId())
	slot0:_tweenRotate(slot0._selectedItem:getId(), slot1)
	slot0._planetMo:updatePreviewAngle(slot1)
	slot0:_updateBtnStatus()
	VersionActivity1_3AstrologyController.instance:dispatchEvent(VersionActivity1_3AstrologyEvent.adjustPreviewAngle)
	slot0:_showPreviewStar()
end

function slot0._tweenRotate(slot0, slot1, slot2)
	if not slot0._tweenList[slot1] then
		slot0._tweenList[slot1] = {
			self = slot0,
			planetId = slot1,
			mo = VersionActivity1_3AstrologyModel.instance:getPlanetMo(slot1),
			tweenId = nil
		}
	end

	if slot3.tweenId then
		ZProj.TweenHelper.KillById(slot3.tweenId)

		slot3.tweenId = nil
		slot3.curAngle = slot3.curAngle + slot3.prevAngle
		slot3.prevAngle = 0
	else
		slot3.prevAngle = 0
		slot3.curAngle = slot3.mo.previewAngle
		slot3.targetAngle = slot3.mo.previewAngle
	end

	slot3.targetAngle = slot3.targetAngle + slot2
	slot3.tweenAngle = slot3.targetAngle - slot3.curAngle
	slot3.tweenId = ZProj.TweenHelper.DOTweenFloat(0, slot3.tweenAngle, 0.5, slot0._tweenRotateFrame, slot0._tweenRotateFinish, slot3, nil, EaseType.Linear)
end

function slot0._tweenRotateFrame(slot0, slot1)
	slot2 = slot0.self

	slot2:_rotateAround(slot0.planetId, -slot0.prevAngle + slot1)

	slot0.prevAngle = slot1

	slot2:_sortPlanets(true)
end

function slot0._tweenRotateFinish(slot0)
	slot1 = slot0.self

	slot1:_rotateAround(slot0.planetId, -slot0.prevAngle + slot0.tweenAngle)

	slot0.prevAngle = slot0.tweenAngle
	slot0.tweenId = nil

	slot1:_sortPlanets()
end

function slot0._showRotateEffect(slot0)
	if not slot0._selectedItem then
		gohelper.setActive(slot0._imageeffect, false)

		return
	end

	if not slot0._planetList[slot0._selectedItem:getId()] or not slot2._ghostGoInfo then
		gohelper.setActive(slot0._imageeffect, false)

		return
	end

	if not slot2._ghostGoInfo.go or not slot3.activeSelf then
		gohelper.setActive(slot0._imageeffect, false)

		return
	end

	if not slot0._tweenList[slot1] then
		return
	end

	gohelper.setActive(slot0._imageeffect, true)

	slot5, slot6 = nil
	slot7 = slot2._ghostGoInfo.limitAngle

	if slot1 == VersionActivity1_3AstrologyEnum.Planet.shuixing then
		slot9, slot10, slot11 = transformhelper.getLocalRotation(slot0._modelPlanetList[slot1])
		slot5 = slot2._ghostGoInfo.ghostAngle % 360
		slot6 = slot10 % 360
	else
		slot5 = slot0:_getAngle(slot3.transform)
		slot6 = slot0:_getAngle(slot2[1])
	end

	slot8 = false

	if slot5 < slot7 then
		slot8 = slot5 <= slot6 and slot6 < slot7
	elseif slot5 <= slot6 and slot6 <= 360 or slot6 >= 0 and slot6 < slot7 then
		slot8 = true
	end

	if math.abs(slot6 - slot7) <= 10 then
		slot8 = slot4.lastForward
	end

	if slot8 then
		if slot6 < slot5 then
			slot6 = slot6 + 360
		end
	elseif slot5 < slot7 and slot5 < slot6 then
		slot6 = slot6 - 360
	end

	slot4.lastForward = slot8
	slot0._matParamVec.x = slot5
	slot0._matParamVec.y = slot6

	slot0._matEffect:SetVector(slot0._matKey, slot0._matParamVec)
end

function slot0._getAngle(slot0, slot1)
	slot2, slot3 = recthelper.getAnchor(slot1)

	return (-Mathf.Atan2(slot3 - 152, slot2) * Mathf.Rad2Deg - 90) % 360
end

function slot0._sortPlanets(slot0, slot1)
	for slot5 = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		slot6 = slot0._planetList[slot5]
		slot7 = slot6[1]
		slot8 = VersionActivity1_3AstrologyModel.instance:getPlanetMo(slot5)

		if slot6._ghostGoInfo then
			if slot6._ghostGoInfo.isFront then
				gohelper.setAsLastSibling(slot6._ghostGoInfo.go)
			else
				gohelper.setAsFirstSibling(slot9)
			end

			if not slot1 or slot8:hasAdjust() then
				gohelper.setActive(slot9, slot8:hasAdjust())
			end
		end

		slot9 = slot8:isFront()

		if slot0._tweenList[slot5] and slot10.tweenId then
			slot9 = slot8:isFront(slot10.curAngle + slot10.prevAngle)
		end

		if slot9 then
			gohelper.setAsLastSibling(slot7.gameObject)
		else
			gohelper.setAsFirstSibling(slot7.gameObject)
		end
	end

	slot0:_showRotateEffect()
end

function slot0._hideGhosts(slot0)
	for slot4 = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		slot5 = slot0._planetList[slot4]
		slot6 = slot5[1]
		slot7 = VersionActivity1_3AstrologyModel.instance:getPlanetMo(slot4)

		if slot5._ghostGoInfo then
			gohelper.setActive(slot5._ghostGoInfo.go, false)

			slot5._ghostGoInfo._isRefresh = nil
		end
	end
end

function slot0._btnAstrologyOnClick(slot0)
	Activity126Rpc.instance:sendHoroscopeRequest(VersionActivity1_3Enum.ActivityId.Act310, VersionActivity1_3AstrologyModel.instance:getQuadrantResult())
end

function slot0._editableInitView(slot0)
	slot0._matEffect = slot0._imageeffect.material
	slot0._matKey = UnityEngine.Shader.PropertyToID("_RotateAngle")
	slot0._matParamVec = slot0._matEffect:GetVector(slot0._matKey)

	slot0._simagePlate:LoadImage(ResUrl.getV1a3AstrologySinglebg("v1a3_astrology_plate"))

	slot0._tweenList = {}
	slot0._planetsTransform = gohelper.findChild(slot0.viewGO, "#go_AstrologyPlate/Planets").transform
	slot0._prevNum = Activity126Model.instance:getStarNum()

	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.Activity1_3RedDot4)

	slot0._tipAnimator = slot0._goDecText:GetComponent(typeof(UnityEngine.Animator))

	slot0:_setDecVisible(false)
end

function slot0._worldPosToRelativeAnchorPos(slot0, slot1, slot2)
	return SLFramework.UGUI.RectTrHelper.ScreenPosToAnchorPos(slot0._modelCamera:WorldToScreenPoint(slot1), slot2, CameraMgr.instance:getUICamera())
end

function slot0.calcFOV(slot0, slot1)
	if 1.7777777777777777 * UnityEngine.Screen.height / UnityEngine.Screen.width < 1 then
		slot1 = slot1 / slot2
	elseif slot2 > 1 then
		slot1 = slot1 * slot2 * 0.85
	end

	return slot1
end

function slot0._createGhost(slot0, slot1)
	slot2 = slot0._planetList[slot1]
	slot3 = slot2[1].gameObject

	if not slot2._ghostGoInfo then
		slot4 = gohelper.cloneInPlace(slot3, slot3.name .. "_ghost")

		gohelper.setActive(gohelper.findChild(slot4, "go_selected"), false)

		for slot11 = 1, slot4.transform.childCount do
			if slot6:GetChild(slot11 - 1):GetComponent(gohelper.Type_Image) then
				slot14 = slot13.color
				slot14.a = 0.5
				slot13.color = slot14
			end
		end

		slot2._ghostGoInfo = slot0:getUserDataTb_()
		slot2._ghostGoInfo.go = slot4
	end

	if not slot2._ghostGoInfo._isRefresh then
		slot4.go.transform.position = slot3.transform.position
		slot4.isFront = VersionActivity1_3AstrologyModel.instance:getPlanetMo(slot1):isFront()
		slot7, slot4.ghostAngle, slot9 = transformhelper.getLocalRotation(slot0._modelPlanetList[slot1])
		slot4._isRefresh = true

		slot0:_rotateAround(slot1, 180)

		slot4.limitAngle = slot0:_getAngle(slot2[1])

		slot0:_rotateAround(slot1, -180)
	end
end

function slot0._rotateAround(slot0, slot1, slot2)
	slot5 = slot0._planetList[slot1][1]

	slot0._modelPlanetList[slot1]:RotateAround(slot0._modelPlanetList[VersionActivity1_3AstrologyEnum.Planet.taiyang].position, Vector3.up, slot2)
	slot0:_syncPlanetPos(slot1)
end

function slot0._syncPlanetPos(slot0, slot1)
	slot4 = slot0:_worldPosToRelativeAnchorPos(slot0._modelPlanetList[slot1].position, slot0._planetsTransform)

	recthelper.setAnchor(slot0._planetList[slot1][1], slot4.x + VersionActivity1_3AstrologyEnum.PlanetOffsetX, slot4.y + VersionActivity1_3AstrologyEnum.PlanetOffsetY)
end

function slot0._init(slot0)
	slot0._txtLeftAngle.text = string.format("%s°", VersionActivity1_3AstrologyEnum.Angle)
	slot0._txtLeftAngleDisable.text = string.format("%s°", VersionActivity1_3AstrologyEnum.Angle)
	slot0._txtRightAngle.text = string.format("-%s°", VersionActivity1_3AstrologyEnum.Angle)
	slot0._txtRightAngledisable.text = string.format("-%s°", VersionActivity1_3AstrologyEnum.Angle)
end

function slot0._initStars(slot0)
	slot0._lightStarList = slot0:getUserDataTb_()
	slot0._lightStarAnimatorList = slot0:getUserDataTb_()
	slot0._lightStarPreviewList = {}

	for slot4 = 1, VersionActivity1_3AstrologyEnum.MaxStarNum do
		slot5 = gohelper.findChild(slot0.viewGO, string.format("#go_LeftInfo/Stars/image_Star%s/image_StarBG/lightStar", slot4))

		gohelper.setActive(slot5, false)

		slot0._lightStarList[slot4] = slot5
		slot0._lightStarAnimatorList[slot4] = gohelper.findChild(slot0.viewGO, string.format("#go_LeftInfo/Stars/image_Star%s", slot4)):GetComponent(typeof(UnityEngine.Animator))
	end
end

function slot0._showStar(slot0)
	slot1 = Activity126Model.instance:getStarNum()

	for slot6, slot7 in ipairs(slot0._lightStarList) do
		slot8 = slot6 <= slot1

		gohelper.setActive(slot7, slot8)

		if slot8 then
			slot2 = 0 + 1

			slot0._lightStarAnimatorList[slot6]:Play("idle")
		end
	end

	gohelper.setActive(slot0._btnAstrology, slot1 >= #slot0._lightStarList)
	slot0:_showTip(slot2)

	if slot0._prevNum and slot0._prevNum < 10 and slot1 >= 10 then
		GameFacade.showToast(ToastEnum.Activity126_tip5)
		VersionActivity1_3AstrologyController.instance:dispatchEvent(VersionActivity1_3AstrologyEvent.guideOnAstrologyBtnShow)
	end

	slot0._prevNum = slot1
end

function slot0._showPreviewStar(slot0)
	slot2 = Activity126Model.instance:getStarNum()
	slot3 = 0

	for slot7, slot8 in ipairs(slot0._lightStarList) do
		slot9 = slot7 <= slot2 + VersionActivity1_3AstrologyModel.instance:getAdjustNum()

		gohelper.setActive(slot8, slot9)

		slot0._lightStarPreviewList[slot7] = false

		if slot9 and slot2 < slot7 then
			slot0._lightStarAnimatorList[slot7]:Play("loop", 0, 0)

			slot0._lightStarPreviewList[slot7] = true
		end
	end
end

function slot0._showStarOpen(slot0)
	for slot4, slot5 in ipairs(slot0._lightStarList) do
		if slot0._lightStarPreviewList[slot4] then
			slot0._lightStarAnimatorList[slot4]:Play("open", 0, 0)
		end

		slot0._lightStarPreviewList[slot4] = false
	end
end

function slot0._showTip(slot0, slot1)
	if slot1 <= 0 then
		slot0:_setDecVisible(false)

		return
	end

	slot0:_setDecVisible(true)
end

function slot0._checkResult(slot0)
	slot2 = Activity126Model.instance:receiveHoroscope() and slot1 > 0

	gohelper.setActive(slot0._goLeftInfo, not slot2)
	gohelper.setActive(slot0._txtDecText, not slot2)

	if slot2 then
		slot0:_setDecVisible(false)
	end
end

function slot0._setDecVisible(slot0, slot1)
	gohelper.setActive(slot0._goDecText, slot1)

	if slot1 then
		if slot0._goDecText.activeSelf then
			return
		end

		slot0:_delayShowTip()
	else
		TaskDispatcher.cancelTask(slot0._delaySwitch, slot0)
		TaskDispatcher.cancelTask(slot0._delayShowTip, slot0)
	end
end

function slot0._delaySwitch(slot0)
	slot0._tipAnimator:Play("close", 0, 0)
	TaskDispatcher.cancelTask(slot0._delayShowTip, slot0)
	TaskDispatcher.runDelay(slot0._delayShowTip, slot0, 3)
end

function slot0._delayShowTip(slot0)
	slot0:_randomTip()
	slot0._tipAnimator:Play("open", 0, 0)
	TaskDispatcher.cancelTask(slot0._delaySwitch, slot0)
	TaskDispatcher.runDelay(slot0._delaySwitch, slot0, 5)
end

function slot0._randomTip(slot0)
	recthelper.setAnchor(slot0._goDecText.transform, slot0:_randomPos()[1] or 0, slot1[2] or 0)

	slot0._txtDecText.text = slot0:_randomTipConfig().tip
end

function slot0._randomPos(slot0)
	while true do
		if slot0._randomPosIndex ~= math.random(#VersionActivity1_3AstrologyEnum.TipPos) or 3 - 1 <= 0 then
			slot0._randomPosIndex = slot2

			break
		end
	end

	return VersionActivity1_3AstrologyEnum.TipPos[slot0._randomPosIndex]
end

function slot0._randomTipConfig(slot0)
	while true do
		if slot0._randomTipConfigIndex ~= math.random(math.min(Activity126Model.instance:getStarNum(), VersionActivity1_3AstrologyEnum.MaxStarNum)) or 3 - 1 <= 0 then
			slot0._randomTipConfigIndex = slot3

			break
		end
	end

	return Activity126Config.instance:getStarConfig(VersionActivity1_3Enum.ActivityId.Act310, slot0._randomTipConfigIndex)
end

function slot0.onOpen(slot0)
	transformhelper.setLocalScale(slot0.viewContainer.viewGO.transform, 1, 1, 1)
	slot0:_init()
	slot0:_initStars()
	slot0:_initPlanets()
	slot0:_initModel()
	slot0:_onScreenSizeChange()
	slot0:_initPlanetsAngles()
	slot0:_sortPlanets()
	slot0:_showStar()
	slot0:_checkResult()
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenSizeChange, slot0)
	slot0:addEventCb(VersionActivity1_3AstrologyController.instance, VersionActivity1_3AstrologyEvent.selectPlanetItem, slot0._selectPlanetItem, slot0)
	slot0:addEventCb(Activity126Controller.instance, Activity126Event.onUpdateProgressReply, slot0._onUpdateProgressReply, slot0)
	slot0:addEventCb(Activity126Controller.instance, Activity126Event.onHoroscopeReply, slot0._onHoroscopeReply, slot0)
	slot0:addEventCb(Activity126Controller.instance, Activity126Event.onResetProgressReply, slot0._onResetProgressReply, slot0)
	slot0:addEventCb(Activity126Controller.instance, Activity126Event.onBeforeResetProgressReply, slot0._onBeforeResetProgressReply, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_3AstrologySuccessView then
		slot0.viewContainer:switchTab(2)
	end
end

function slot0._onBeforeResetProgressReply(slot0)
	for slot4, slot5 in pairs(slot0._modelPlanetPosList) do
		slot6 = slot0._modelPlanetList[slot4]
		slot6.position = slot5
		slot7 = slot0._modelPlanetRotationList[slot4]

		transformhelper.setLocalRotation(slot6, slot7[1], slot7[2], slot7[3])
	end
end

function slot0._onResetProgressReply(slot0)
	slot0._prevNum = Activity126Model.instance:getStarNum()

	slot0:_checkResult()
	slot0:_updateSelectedFlag()
	slot0:_initPlanetsAngles()
	slot0:_sortPlanets()
end

function slot0._onHoroscopeReply(slot0)
	VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologySuccessView()
	slot0:_checkResult()
	slot0:_hideGhosts()
	slot0:_updateSelectedFlagById(nil)
end

function slot0._onUpdateProgressReply(slot0, slot1)
	if slot1 and slot1.fromReset then
		slot0:_showStar()
	else
		slot0:_showAdjustEffect(slot0.viewContainer:getSendPlanetList())
		slot0:_showStarOpen()
		GameFacade.showToast(ToastEnum.Activity126_tip9)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("AstrologyDelayShowReply")
		TaskDispatcher.cancelTask(slot0._delayShowReply, slot0)
		TaskDispatcher.runDelay(slot0._delayShowReply, slot0, 2)
	end

	slot0:_hideGhosts()
	slot0:_updateBtnStatus()
	slot0:_showRotateEffect()
end

function slot0._delayShowReply(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AstrologyDelayShowReply")
	slot0:_showStar()
	slot0:_hideAdjustEffect()

	if VersionActivity1_3AstrologyModel.instance:getStarReward() then
		VersionActivity1_3AstrologyModel.instance:setStarReward(nil)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot1)
	end
end

function slot0._showAdjustEffect(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in pairs(slot1) do
		gohelper.setActive(slot0._planetList[slot5][3], true)
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_confirm)
end

function slot0._hideAdjustEffect(slot0)
	for slot4, slot5 in pairs(slot0._planetList) do
		gohelper.setActive(slot5[3], false)
	end
end

function slot0._selectPlanetItem(slot0, slot1)
	slot0._selectedItem = slot1
	slot0._planetMo = slot0._selectedItem:getPlanetMo()

	slot0:_updateBtnStatus()
	slot0:_updateSelectedFlag()
	slot0:_showRotateEffect()
end

function slot0._updateSelectedFlag(slot0)
	slot0:_updateSelectedFlagById(slot0._selectedItem and slot0._selectedItem:getId())
end

function slot0._updateSelectedFlagById(slot0, slot1)
	for slot5, slot6 in pairs(slot0._planetList) do
		gohelper.setActive(slot6[2], slot5 == slot1)
	end
end

function slot0._updateBtnStatus(slot0)
	if not slot0._planetMo then
		return
	end

	slot2 = slot0._planetMo.num > 0
	slot3 = slot1 > 0

	if slot1 > 0 and slot1 < 3 and slot0._planetMo:getRemainNum() == 0 then
		slot2 = not ((slot0._planetMo.previewAngle % 360 - slot0._planetMo:minDeltaAngle()) % 360 == slot0._planetMo.angle % 360)
	end

	gohelper.setActive(slot0._goleftbtn, slot2)
	gohelper.setActive(slot0._goleftbtndisable, not slot2)
	gohelper.setActive(slot0._gorightbtn, slot3)
	gohelper.setActive(slot0._gorightbtndisable, not slot3)
end

function slot0._onScreenSizeChange(slot0)
	slot0._modelCamera.fieldOfView = slot0:calcFOV(48)
end

function slot0._initPlanets(slot0)
	slot0._planetList = slot0:getUserDataTb_()

	for slot4, slot5 in pairs(VersionActivity1_3AstrologyEnum.Planet) do
		slot6 = slot0["_go" .. slot4]
		slot9 = slot0:getUserDataTb_()
		slot9[1] = slot6.transform
		slot9[2] = gohelper.findChild(slot6, "go_selected")
		slot9[3] = gohelper.findChild(slot6, "vx")
		slot0._planetList[slot5] = slot9
	end
end

function slot0._initPlanetsAngles(slot0)
	for slot4 = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		slot0:_rotateAround(slot4, -90 + VersionActivity1_3AstrologyModel.instance:getPlanetMo(slot4).angle)
	end
end

function slot0._initModel(slot0)
	slot0._modelCamera = gohelper.findChild(slot0._gomodel, "cam"):GetComponent("Camera")
	slot0._modelPlanetList = slot0:getUserDataTb_()
	slot0._modelPlanetPosList = slot0:getUserDataTb_()
	slot0._modelPlanetRotationList = slot0:getUserDataTb_()

	for slot5, slot6 in pairs(VersionActivity1_3AstrologyEnum.Planet) do
		slot0:_addPlanet(slot6, slot5)
	end
end

function slot0._addPlanet(slot0, slot1, slot2)
	slot4 = gohelper.findChild(slot0._gomodel, "zhanxingpan/xingqiu/" .. slot2).transform
	slot0._modelPlanetList[slot1] = slot4
	slot0._modelPlanetPosList[slot1] = slot4.position
	slot5, slot6, slot7 = transformhelper.getLocalRotation(slot4)
	slot0._modelPlanetRotationList[slot1] = {
		slot5,
		slot6,
		slot7
	}
end

function slot0.onClose(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AstrologyDelayShowReply")

	for slot4, slot5 in pairs(slot0._tweenList) do
		if slot5.tweenId then
			ZProj.TweenHelper.KillById(slot5.tweenId)

			slot5.tweenId = nil
		end
	end

	TaskDispatcher.cancelTask(slot0._delayShowReply, slot0)
	TaskDispatcher.cancelTask(slot0._delaySwitch, slot0)
	TaskDispatcher.cancelTask(slot0._delayShowTip, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagePlate:UnLoadImage()
end

return slot0

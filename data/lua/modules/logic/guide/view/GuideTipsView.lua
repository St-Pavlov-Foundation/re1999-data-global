module("modules.logic.guide.view.GuideTipsView", package.seeall)

slot0 = class("GuideTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtContent1 = gohelper.findChildText(slot0.viewGO, "tips/hasIcon/go_normalcontent/txt_contentcn")
	slot0._hasIconImgBgGo = gohelper.findChild(slot0.viewGO, "tips/hasIcon/imgBg")
	slot0._hasIconImgBgTrans = slot0._hasIconImgBgGo.transform
	slot0._hasIconImgBgGoDefaultX = recthelper.getAnchorX(slot0._hasIconImgBgTrans) or 0
	slot0._tipsGO = gohelper.findChild(slot0.viewGO, "tips")
	slot0._hasIconGO = gohelper.findChild(slot0.viewGO, "tips/hasIcon")
	slot0._noIconGO = gohelper.findChild(slot0.viewGO, "tips/noIcon")
	slot0._txtContent2 = gohelper.findChildText(slot0.viewGO, "tips/noIcon/imgBg/go_normalcontent/txt_contentcn")
	slot0._tipsTr = slot0._tipsGO.transform
	slot0._goHeroIcon = gohelper.findChild(slot0.viewGO, "tips/hasIcon/icon")
	slot0._goNormalContent = gohelper.findChild(slot0.viewGO, "tips/hasIcon/go_normalcontent")
	slot0._imgHero = gohelper.findChildSingleImage(slot0.viewGO, "tips/hasIcon/icon/imgHero")
	slot0._txtName1 = gohelper.findChildText(slot0.viewGO, "tips/hasIcon/icon/nameBg/txtName")
	slot0._txtName2 = gohelper.findChildText(slot0.viewGO, "tips/noIcon/txtName")
	slot0._iconGO = gohelper.findChild(slot0.viewGO, "tips/hasIcon")
	slot0._noIconGO = gohelper.findChild(slot0.viewGO, "tips/noIcon")
	slot0._root2DTrs = ViewMgr.instance:getTopUICanvas().transform
end

function slot0.onOpen(slot0)
	slot0:_updateUI()
	slot0:_updateUIPos()
	slot0:addEventCb(GuideController.instance, GuideEvent.UpdateMaskView, slot0._updateUIPos, slot0)
	slot0:addEventCb(GuideController.instance, GuideEvent.SetMaskPosition, slot0._setMaskCustomPos, slot0)
	slot0:_checkAddFrameUpdate()
end

function slot0.onUpdateParam(slot0)
	slot0:_updateUI()
	slot0:_updateUIPos()
	slot0:removeEventCb(GuideController.instance, GuideEvent.UpdateMaskView, slot0._updateUIPos, slot0)
	slot0:removeEventCb(GuideController.instance, GuideEvent.SetMaskPosition, slot0._setMaskCustomPos, slot0)
	slot0:_checkAddFrameUpdate()
end

function slot0._checkAddFrameUpdate(slot0)
	if not gohelper.isNil(slot0._targetTrs) then
		TaskDispatcher.runRepeat(slot0._onFrameUpdate, slot0, 0.01)
	else
		TaskDispatcher.cancelTask(slot0._onFrameUpdate, slot0)
	end
end

function slot0._onFrameUpdate(slot0)
	if gohelper.isNil(slot0._targetTrs) then
		return
	end

	slot1 = slot0._targetTrs.position
	slot2 = slot1.x
	slot3 = slot1.y

	if not slot0._lastx or not slot0._lasty or math.abs(slot2 - slot0._lastx) > 0.001 or math.abs(slot3 - slot0._lasty) > 0.001 then
		slot0._lastx = slot2
		slot0._lasty = slot3

		slot0:_updateUIPos()
	end
end

function slot0._updateUI(slot0)
	if not slot0.viewParam then
		return
	end

	gohelper.setActive(slot0._tipsGO, false)
	gohelper.setActive(slot0._tipsGO, slot0.viewParam.hasTips)

	if not slot0.viewParam.hasTips then
		return
	end

	if slot0._goPath ~= slot0.viewParam.goPath then
		slot0._targetGO = nil
	end

	slot0._goPath = slot0.viewParam.goPath
	slot0._tipsPosX = slot0.viewParam.tipsPos[1] or 0
	slot0._tipsPosY = slot0.viewParam.tipsPos[2] or 0

	if slot0._hasIconDialogItem then
		slot0._hasIconDialogItem:hideDialog()
		TaskDispatcher.cancelTask(slot0._showHasIconDialog, slot0)
	end

	slot1 = string.gsub(slot0.viewParam.tipsContent, " ", " ")

	if LangSettings.instance:getCurLang() == LangSettings.kr or LangSettings.instance:isEn() then
		slot1 = slot0.viewParam.tipsContent
	end

	slot0._hasHeroIcon = not string.nilorempty(slot0.viewParam.tipsHead)

	gohelper.setActive(slot0._imgHero.gameObject, slot0._hasHeroIcon)

	if slot0._hasHeroIcon then
		if slot0.viewParam.maskChangeAlpha then
			slot0._txtContent1.text = ""

			TaskDispatcher.runDelay(slot0._showHasIconDialog, slot0, 0.3)
		else
			slot0:_showHasIconDialog()
		end

		slot0._txtName1.text = slot0.viewParam.tipsTalker

		slot0._imgHero:LoadImage(ResUrl.getHeadIconSmall(slot0.viewParam.tipsHead))
		recthelper.setAnchorX(slot0._goHeroIcon.transform, slot0.viewParam.tipsDir == 2 and 920 or 0)
		recthelper.setAnchorX(slot0._goNormalContent.transform, slot0.viewParam.tipsDir == 2 and 382 or 529.2)
	else
		slot0._txtContent2.text = slot1
		slot0._txtName2.text = slot0.viewParam.tipsTalker

		if GameConfig:GetCurLangType() ~= LangSettings.zh and slot0.viewParam.guideId == 509 and slot0.viewParam.stepId == 3 then
			slot2 = gohelper.findChild(slot0._noIconGO, "imgBg")

			if gohelper.findChild(slot0._targetTrs.gameObject, "guiderect") then
				slot2.transform.sizeDelta = slot3.transform.sizeDelta

				transformhelper.setLocalPosXY(slot2.transform, slot3.transform.localPosition.x, slot3.transform.localPosition.y)
			end
		end
	end

	gohelper.setActive(slot0._iconGO, slot0._hasHeroIcon)
	gohelper.setActive(slot0._noIconGO, not slot0._hasHeroIcon)

	if slot0._hasHeroIcon then
		slot2 = slot0.viewParam.tipsDir == 2

		if LangSettings.instance:isEn() then
			recthelper.setAnchorX(slot0._goNormalContent.transform, slot2 and 225 or 529.2)
			recthelper.setAnchorX(slot0._hasIconImgBgTrans, slot2 and 380 or 529.91)
		else
			recthelper.setAnchorX(slot0._goNormalContent.transform, slot2 and 382 or 529.2)
			recthelper.setAnchorX(slot0._hasIconImgBgTrans, slot0._hasIconImgBgGoDefaultX)
		end
	end
end

function slot0._updateUIPos(slot0)
	if not slot0.viewParam then
		return
	end

	gohelper.setActive(slot0._tipsGO, slot0.viewParam.hasTips)

	if not slot0.viewParam.hasTips then
		return
	end

	if not string.nilorempty(slot0._goPath) and not slot0._hasHeroIcon then
		slot0:_updatePos()
	else
		recthelper.setAnchor(slot0._tipsTr, slot0._tipsPosX, slot0._tipsPosY)
	end
end

function slot0._updatePos(slot0)
	slot0:initTargetGo()

	if not gohelper.isNil(slot0._targetGO) then
		if slot0._targetIs2D then
			slot1 = ZProj.GuideMaskHole.CalculateRelativeRectTransformBounds(slot0._root2DTrs, slot0._targetTrs)

			recthelper.setAnchor(slot0._tipsTr, (slot0._customCenterPos and slot0._customCenterPos.x or slot1.center.x) + slot0._tipsPosX, (slot0._customCenterPos and slot0._customCenterPos.y or slot1.center.y) + slot0._tipsPosY)
		else
			transformhelper.setLocalPosXY(slot0._tipsTr, (slot0._customCenterPos and slot0._customCenterPos.x or 0) + slot0._tipsPosX, (slot0._customCenterPos and slot0._customCenterPos.y or 0) + slot0._tipsPosY)
		end
	end
end

function slot0._showHasIconDialog(slot0)
	slot1 = string.gsub(slot0.viewParam.tipsContent, " ", " ")

	if LangSettings.instance:getCurLang() == LangSettings.kr or slot2 == LangSettings.en then
		slot1 = slot0.viewParam.tipsContent
	end

	if not slot0._hasIconDialogItem then
		slot0._hasIconDialogItem = MonoHelper.addLuaComOnceToGo(slot0._hasIconGO, TMPFadeIn)

		slot0._hasIconDialogItem:setTopOffset(0, -4.5)
	end

	slot0._hasIconDialogItem:playNormalText(slot1)
end

function slot0.initTargetGo(slot0)
	slot0._targetGO = gohelper.find(slot0._goPath)

	if slot0._targetGO then
		slot0._targetTrs = slot0._targetGO.transform
		slot0._targetIs2D = slot0._targetGO:GetComponent("RectTransform") ~= nil
	end
end

function slot0._setMaskCustomPos(slot0, slot1, slot2)
	if slot2 then
		slot1 = recthelper.worldPosToAnchorPos(slot1, slot0.viewGO.transform, CameraMgr.instance:getUICamera(), CameraMgr.instance:getMainCamera())
	end

	slot0._customCenterPos = slot1

	slot0:_updateUIPos()
end

function slot0.onClose(slot0)
	GameUtil.onDestroyViewMember(slot0, "_hasIconDialogItem")
	slot0._imgHero:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._showHasIconDialog, slot0)
	TaskDispatcher.cancelTask(slot0._onFrameUpdate, slot0)
end

return slot0

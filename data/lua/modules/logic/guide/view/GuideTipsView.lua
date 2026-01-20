-- chunkname: @modules/logic/guide/view/GuideTipsView.lua

module("modules.logic.guide.view.GuideTipsView", package.seeall)

local GuideTipsView = class("GuideTipsView", BaseView)

function GuideTipsView:onInitView()
	self._txtContent1 = gohelper.findChildText(self.viewGO, "tips/hasIcon/go_normalcontent/txt_contentcn")
	self._hasIconImgBgGo = gohelper.findChild(self.viewGO, "tips/hasIcon/imgBg")
	self._hasIconImgBgTrans = self._hasIconImgBgGo.transform
	self._hasIconImgBgGoDefaultX = recthelper.getAnchorX(self._hasIconImgBgTrans) or 0
	self._tipsGO = gohelper.findChild(self.viewGO, "tips")
	self._hasIconGO = gohelper.findChild(self.viewGO, "tips/hasIcon")
	self._noIconGO = gohelper.findChild(self.viewGO, "tips/noIcon")
	self._txtContent2 = gohelper.findChildText(self.viewGO, "tips/noIcon/imgBg/go_normalcontent/txt_contentcn")
	self._tipsTr = self._tipsGO.transform
	self._goHeroIcon = gohelper.findChild(self.viewGO, "tips/hasIcon/icon")
	self._goNormalContent = gohelper.findChild(self.viewGO, "tips/hasIcon/go_normalcontent")
	self._imgHero = gohelper.findChildSingleImage(self.viewGO, "tips/hasIcon/icon/imgHero")
	self._txtName1 = gohelper.findChildText(self.viewGO, "tips/hasIcon/icon/nameBg/txtName")
	self._txtName2 = gohelper.findChildText(self.viewGO, "tips/noIcon/txtName")
	self._iconGO = gohelper.findChild(self.viewGO, "tips/hasIcon")
	self._noIconGO = gohelper.findChild(self.viewGO, "tips/noIcon")
	self._root2DTrs = ViewMgr.instance:getTopUICanvas().transform
end

function GuideTipsView:onOpen()
	self:_updateUI()
	self:_updateUIPos()
	self:addEventCb(GuideController.instance, GuideEvent.UpdateMaskView, self._updateUIPos, self)
	self:addEventCb(GuideController.instance, GuideEvent.SetMaskPosition, self._setMaskCustomPos, self)
	self:_checkAddFrameUpdate()
end

function GuideTipsView:onUpdateParam()
	self:_updateUI()
	self:_updateUIPos()
	self:removeEventCb(GuideController.instance, GuideEvent.UpdateMaskView, self._updateUIPos, self)
	self:removeEventCb(GuideController.instance, GuideEvent.SetMaskPosition, self._setMaskCustomPos, self)
	self:_checkAddFrameUpdate()
end

function GuideTipsView:_checkAddFrameUpdate()
	if not gohelper.isNil(self._targetTrs) then
		TaskDispatcher.runRepeat(self._onFrameUpdate, self, 0.01)
	else
		TaskDispatcher.cancelTask(self._onFrameUpdate, self)
	end
end

function GuideTipsView:_onFrameUpdate()
	if gohelper.isNil(self._targetTrs) then
		return
	end

	local pos = self._targetTrs.position
	local posx = pos.x
	local posy = pos.y

	if not self._lastx or not self._lasty or math.abs(posx - self._lastx) > 0.001 or math.abs(posy - self._lasty) > 0.001 then
		self._lastx = posx
		self._lasty = posy

		self:_updateUIPos()
	end
end

function GuideTipsView:_updateUI()
	if not self.viewParam then
		return
	end

	gohelper.setActive(self._tipsGO, false)
	gohelper.setActive(self._tipsGO, self.viewParam.hasTips)

	if not self.viewParam.hasTips then
		return
	end

	if self._goPath ~= self.viewParam.goPath then
		self._targetGO = nil
	end

	self._goPath = self.viewParam.goPath
	self._tipsPosX = self.viewParam.tipsPos[1] or 0
	self._tipsPosY = self.viewParam.tipsPos[2] or 0

	if self._hasIconDialogItem then
		self._hasIconDialogItem:hideDialog()
		TaskDispatcher.cancelTask(self._showHasIconDialog, self)
	end

	local content = string.gsub(self.viewParam.tipsContent, " ", " ")

	if LangSettings.instance:getCurLang() == LangSettings.kr or LangSettings.instance:isEn() then
		content = self.viewParam.tipsContent
	end

	self._hasHeroIcon = not string.nilorempty(self.viewParam.tipsHead)

	gohelper.setActive(self._imgHero.gameObject, self._hasHeroIcon)

	if self._hasHeroIcon then
		if self.viewParam.maskChangeAlpha then
			self._txtContent1.text = ""

			TaskDispatcher.runDelay(self._showHasIconDialog, self, 0.3)
		else
			self:_showHasIconDialog()
		end

		self._txtName1.text = self.viewParam.tipsTalker

		self._imgHero:LoadImage(ResUrl.getHeadIconSmall(self.viewParam.tipsHead))
		recthelper.setAnchorX(self._goHeroIcon.transform, self.viewParam.tipsDir == 2 and 920 or 0)
		recthelper.setAnchorX(self._goNormalContent.transform, self.viewParam.tipsDir == 2 and 382 or 529.2)
	else
		self._txtContent2.text = content
		self._txtName2.text = self.viewParam.tipsTalker

		if GameConfig:GetCurLangType() ~= LangSettings.zh and self.viewParam.guideId == 509 and self.viewParam.stepId == 3 then
			local guideRect = gohelper.findChild(self._noIconGO, "imgBg")
			local targetRact = gohelper.findChild(self._targetTrs.gameObject, "guiderect")

			if targetRact then
				guideRect.transform.sizeDelta = targetRact.transform.sizeDelta

				transformhelper.setLocalPosXY(guideRect.transform, targetRact.transform.localPosition.x, targetRact.transform.localPosition.y)
			end
		end
	end

	gohelper.setActive(self._iconGO, self._hasHeroIcon)
	gohelper.setActive(self._noIconGO, not self._hasHeroIcon)

	if self._hasHeroIcon then
		local isRight = self.viewParam.tipsDir == 2

		if LangSettings.instance:isEn() then
			recthelper.setAnchorX(self._goNormalContent.transform, isRight and 225 or 529.2)
			recthelper.setAnchorX(self._hasIconImgBgTrans, isRight and 380 or 529.91)
		else
			recthelper.setAnchorX(self._goNormalContent.transform, isRight and 382 or 529.2)
			recthelper.setAnchorX(self._hasIconImgBgTrans, self._hasIconImgBgGoDefaultX)
		end
	end
end

function GuideTipsView:_updateUIPos()
	if not self.viewParam then
		return
	end

	gohelper.setActive(self._tipsGO, self.viewParam.hasTips)

	if not self.viewParam.hasTips then
		return
	end

	if not string.nilorempty(self._goPath) and not self._hasHeroIcon then
		self:_updatePos()
	else
		recthelper.setAnchor(self._tipsTr, self._tipsPosX, self._tipsPosY)
	end
end

function GuideTipsView:_updatePos()
	self:initTargetGo()

	if not gohelper.isNil(self._targetGO) then
		if self._targetIs2D then
			local bounds = ZProj.GuideMaskHole.CalculateRelativeRectTransformBounds(self._root2DTrs, self._targetTrs)
			local posX = self._customCenterPos and self._customCenterPos.x or bounds.center.x
			local posY = self._customCenterPos and self._customCenterPos.y or bounds.center.y

			recthelper.setAnchor(self._tipsTr, posX + self._tipsPosX, posY + self._tipsPosY)
		else
			local posX = self._customCenterPos and self._customCenterPos.x or 0
			local posY = self._customCenterPos and self._customCenterPos.y or 0

			transformhelper.setLocalPosXY(self._tipsTr, posX + self._tipsPosX, posY + self._tipsPosY)
		end
	end
end

function GuideTipsView:_showHasIconDialog()
	local content = string.gsub(self.viewParam.tipsContent, " ", " ")
	local curLange = LangSettings.instance:getCurLang()

	if curLange == LangSettings.kr or curLange == LangSettings.en then
		content = self.viewParam.tipsContent
	end

	if not self._hasIconDialogItem then
		self._hasIconDialogItem = MonoHelper.addLuaComOnceToGo(self._hasIconGO, TMPFadeIn)

		self._hasIconDialogItem:setTopOffset(0, -4.5)
	end

	self._hasIconDialogItem:playNormalText(content)
end

function GuideTipsView:initTargetGo()
	self._targetGO = gohelper.find(self._goPath)

	if self._targetGO then
		self._targetTrs = self._targetGO.transform
		self._targetIs2D = self._targetGO:GetComponent("RectTransform") ~= nil
	end
end

function GuideTipsView:_setMaskCustomPos(pos, isWorldPos)
	if isWorldPos then
		local uiCamera = CameraMgr.instance:getUICamera()
		local mainCamera = CameraMgr.instance:getMainCamera()

		pos = recthelper.worldPosToAnchorPos(pos, self.viewGO.transform, uiCamera, mainCamera)
	end

	self._customCenterPos = pos

	self:_updateUIPos()
end

function GuideTipsView:onClose()
	GameUtil.onDestroyViewMember(self, "_hasIconDialogItem")
	self._imgHero:UnLoadImage()
	TaskDispatcher.cancelTask(self._showHasIconDialog, self)
	TaskDispatcher.cancelTask(self._onFrameUpdate, self)
end

return GuideTipsView

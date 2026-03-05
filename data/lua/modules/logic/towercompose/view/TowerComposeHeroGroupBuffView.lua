-- chunkname: @modules/logic/towercompose/view/TowerComposeHeroGroupBuffView.lua

module("modules.logic.towercompose.view.TowerComposeHeroGroupBuffView", package.seeall)

local TowerComposeHeroGroupBuffView = class("TowerComposeHeroGroupBuffView", BaseView)

function TowerComposeHeroGroupBuffView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosupportView = gohelper.findChild(self.viewGO, "Tips/#go_supportView")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Tips/#go_supportView/#txt_desc")
	self._scrollsupportList = gohelper.findChildScrollRect(self.viewGO, "Tips/#go_supportView/#scroll_supportList")
	self._gosupportContent = gohelper.findChild(self.viewGO, "Tips/#go_supportView/#scroll_supportList/Viewport/#go_supportContent")
	self._gosupportItem = gohelper.findChild(self.viewGO, "Tips/#go_supportView/#scroll_supportList/Viewport/#go_supportContent/#go_supportItem")
	self._goresearchView = gohelper.findChild(self.viewGO, "Tips/#go_researchView")
	self._scrollresearchList = gohelper.findChildScrollRect(self.viewGO, "Tips/#go_researchView/#scroll_researchList")
	self._goresearchContent = gohelper.findChild(self.viewGO, "Tips/#go_researchView/#scroll_researchList/Viewport/#go_researchContent")
	self._goresearchItem = gohelper.findChild(self.viewGO, "Tips/#go_researchView/#scroll_researchList/Viewport/#go_researchContent/#go_researchItem")
	self._goonePlane = gohelper.findChild(self.viewGO, "#go_onePlane")
	self._gotwoPlane = gohelper.findChild(self.viewGO, "#go_twoPlane")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeHeroGroupBuffView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self:addEventCb(TowerComposeController.instance, TowerComposeEvent.HeroGroupSelectBuff, self.refreshUI, self)
end

function TowerComposeHeroGroupBuffView:removeEvents()
	self._btnclose:RemoveClickListener()
	self:removeEventCb(TowerComposeController.instance, TowerComposeEvent.HeroGroupSelectBuff, self.refreshUI, self)
end

function TowerComposeHeroGroupBuffView:_btncloseOnClick()
	self:closeThis()
end

function TowerComposeHeroGroupBuffView:_onResearchItemClick(researchItem)
	if not researchItem.unlockState then
		GameFacade.showToast(ToastEnum.TowerComposeNotHave, researchItem.config.name)

		return
	end

	if not self.isNormalEpisode and researchItem.inPlaneId == 0 or researchItem.inPlaneId == -1 then
		TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Research, researchItem.config.id)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.HeroGroupSelectBuff)
	elseif self.curPlaneId == researchItem.inPlaneId then
		TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Research, 0)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.HeroGroupSelectBuff)
	elseif self.curPlaneId ~= researchItem.inPlaneId then
		self.curResearchItem = researchItem

		GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerComposeReplaceMod, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self.replaceTipCallBack, nil, nil, self)
	end
end

function TowerComposeHeroGroupBuffView:replaceTipCallBack()
	TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curResearchItem.inPlaneId, TowerComposeEnum.TeamBuffType.Research, 0)
	TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Research, self.curResearchItem.config.id)

	self.curResearchItem = nil

	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.HeroGroupSelectBuff)
end

function TowerComposeHeroGroupBuffView:_onSupportSlotClick(planeSlotItem)
	TowerComposeHeroGroupModel.instance:setCurSelectPlaneIdAndType(planeSlotItem.planeId, TowerComposeEnum.TeamBuffType.Support)
	self:refreshUI()
end

function TowerComposeHeroGroupBuffView:_onResearchSlotClick(planeSlotItem)
	TowerComposeHeroGroupModel.instance:setCurSelectPlaneIdAndType(planeSlotItem.planeId, TowerComposeEnum.TeamBuffType.Research)
	self:refreshUI()
end

function TowerComposeHeroGroupBuffView:_editableInitView()
	self.supportItemList = self:getUserDataTb_()
	self.researchItemList = self:getUserDataTb_()
	self.planeSlotItemMap = self:getUserDataTb_()
	self._goTwoPlane1 = gohelper.findChild(self.viewGO, "#go_twoPlane/plane1")
	self._goTwoPlane2 = gohelper.findChild(self.viewGO, "#go_twoPlane/plane2")

	gohelper.setActive(self._gosupportItem, false)
	gohelper.setActive(self._goresearchItem, false)
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function TowerComposeHeroGroupBuffView:onUpdateParam()
	return
end

function TowerComposeHeroGroupBuffView:onOpen()
	self.fightParam = TowerComposeModel.instance:getRecordFightParam()
	self.themeId = self.fightParam.themeId
	self.layerId = self.fightParam.layerId
	self.towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(self.themeId, self.layerId)
	self.isNormalEpisode = self.towerEpisodeConfig.plane == 0
	self.showTwoPlane = self.towerEpisodeConfig.plane > 1
	self.episodeId = self.fightParam.episodeId

	local supportHeroCoList = TowerComposeConfig.instance:getAllSupportCoList(self.themeId)

	self.heroCoList = self:buildHeroCoList(supportHeroCoList, false)

	self:refreshUI()
end

function TowerComposeHeroGroupBuffView:refreshUI()
	self.curPlaneId, self.curBuffType = TowerComposeHeroGroupModel.instance:getCurSelectPlaneIdAndType()

	gohelper.setActive(self._gosupportView, self.curBuffType == TowerComposeEnum.TeamBuffType.Support)
	gohelper.setActive(self._goresearchView, self.curBuffType == TowerComposeEnum.TeamBuffType.Research)

	if self.curBuffType == TowerComposeEnum.TeamBuffType.Research then
		self:refreshResearchView()
	end

	if self.curBuffType == TowerComposeEnum.TeamBuffType.Support then
		self:refreshSupportView()
	end

	self:refreshPlaneSlot()
end

function TowerComposeHeroGroupBuffView:refreshResearchView()
	self.curAllResearchCoList = TowerComposeConfig.instance:getAllResearchCoList(self.themeId)

	for index, researchCo in ipairs(self.curAllResearchCoList) do
		local researchItem = self.researchItemList[index]

		if not researchItem then
			researchItem = {
				go = gohelper.clone(self._goresearchItem, self._goresearchContent, "researchItem" .. researchCo.id)
			}
			researchItem.goSelect1 = gohelper.findChild(researchItem.go, "go_Selected1")
			researchItem.goSelect2 = gohelper.findChild(researchItem.go, "go_Selected2")
			researchItem.goIsIn1 = gohelper.findChild(researchItem.go, "go_isIn1")
			researchItem.goIsIn2 = gohelper.findChild(researchItem.go, "go_isIn2")
			researchItem.imageIcon = gohelper.findChildImage(researchItem.go, "image_Icon")
			researchItem.txtDesc = gohelper.findChildText(researchItem.go, "txtLayout/txt_Desc")
			researchItem.txtName = gohelper.findChildText(researchItem.go, "txtLayout/txt_Name")
			researchItem.goMask = gohelper.findChild(researchItem.go, "go_mask")
			researchItem.btnClick = gohelper.findChildButtonWithAudio(researchItem.go, "btn_click")
			self.researchItemList[index] = researchItem
		end

		gohelper.setActive(researchItem.go, true)
		researchItem.btnClick:AddClickListener(self._onResearchItemClick, self, researchItem)

		researchItem.config = researchCo
		researchItem.unlockState = TowerComposeModel.instance:checkCurThemeResearchUnlock(self.themeId, researchCo.id)
		researchItem.txtName.text = researchItem.unlockState and researchCo.name or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towercompose_notHave"), researchCo.name)
		researchItem.txtDesc.text = SkillHelper.buildDesc(researchCo.desc)

		UISpriteSetMgr.instance:setTower2Sprite(researchItem.imageIcon, researchCo.icon)

		researchItem.inPlaneId = TowerComposeHeroGroupModel.instance:checkBuffInPlane(self.themeId, TowerComposeEnum.TeamBuffType.Research, researchCo.id, self.isNormalEpisode)

		gohelper.setActive(researchItem.goSelect1, researchItem.inPlaneId == 1 and self.curPlaneId == 1 or self.isNormalEpisode and researchItem.inPlaneId == 0)
		gohelper.setActive(researchItem.goSelect2, researchItem.inPlaneId == 2 and self.curPlaneId == 2)
		gohelper.setActive(researchItem.goIsIn1, researchItem.inPlaneId == 1 or self.isNormalEpisode and researchItem.inPlaneId == 0)
		gohelper.setActive(researchItem.goIsIn2, researchItem.inPlaneId == 2)
		gohelper.setActive(researchItem.goMask, not researchItem.unlockState)
	end

	for index = #self.curAllResearchCoList + 1, #self.researchItemList do
		gohelper.setActive(self.researchItemList[index].go, false)
	end
end

function TowerComposeHeroGroupBuffView:refreshSupportView()
	for index, heroCoData in ipairs(self.heroCoList) do
		local supportItem = self.supportItemList[index]

		if not supportItem then
			supportItem = {
				go = gohelper.clone(self._gosupportItem, self._gosupportContent, "supportItem" .. heroCoData.config.id)
			}
			supportItem.comp = MonoHelper.addNoUpdateLuaComOnceToGo(supportItem.go, TowerComposeHeroGroupSupportItem, {
				heroCoData = heroCoData
			})
			self.supportItemList[index] = supportItem
		end

		gohelper.setActive(supportItem.go, true)
		supportItem.comp:refreshUI()
	end

	for index = #self.heroCoList + 1, #self.supportItemList do
		gohelper.setActive(self.supportItemList[index].go, false)
	end
end

function TowerComposeHeroGroupBuffView:buildHeroCoList(heroCoList)
	local newHeroCoList = {}
	local heroIdMap = {}

	for index, heroCo in ipairs(heroCoList) do
		if not heroIdMap[heroCo.heroId] then
			local coData = {}

			coData.index = index
			coData.heroMo = HeroModel.instance:getByHeroId(heroCo.heroId)

			local curSupportCo = TowerComposeConfig.instance:getThemeCurLvHeroIdSupportCo(heroCo.themeId, heroCo.heroId, coData.heroMo and coData.heroMo.exSkillLevel or 0)

			coData.config = curSupportCo
			coData.heroConfig = HeroConfig.instance:getHeroCO(heroCo.heroId)
			coData.canShow = coData.heroMo ~= nil

			table.insert(newHeroCoList, coData)

			heroIdMap[heroCo.heroId] = coData
		end
	end

	table.sort(newHeroCoList, function(a, b)
		if a.canShow ~= b.canShow then
			return a.canShow
		elseif a.heroConfig.rare ~= b.heroConfig.rare then
			return a.heroConfig.rare > b.heroConfig.rare
		else
			return a.index < b.index
		end
	end)

	return newHeroCoList
end

function TowerComposeHeroGroupBuffView:refreshPlaneSlot()
	gohelper.setActive(self._goonePlane, not self.showTwoPlane)
	gohelper.setActive(self._gotwoPlane, self.showTwoPlane)

	local totalPlane = self.showTwoPlane and 2 or 1

	for planeId = 1, totalPlane do
		local planeSlotItem = self.planeSlotItemMap[planeId]

		if not planeSlotItem then
			local planeGO = self.showTwoPlane and (planeId == 1 and self._goTwoPlane1 or self._goTwoPlane2) or self._goonePlane

			planeSlotItem = self:buildPlaneSlot(planeGO)
			self.planeSlotItemMap[planeId] = planeSlotItem
		end

		planeSlotItem.planeId = self.towerEpisodeConfig.plane > 0 and planeId or 0

		self:refreshPlaneSlotUI(planeSlotItem)
	end
end

function TowerComposeHeroGroupBuffView:buildPlaneSlot(planeGO)
	local planeSlotItem = {}

	planeSlotItem.go = planeGO
	planeSlotItem.goSupport = gohelper.findChild(planeGO, "support")
	planeSlotItem.gosupportNormal = gohelper.findChild(planeSlotItem.goSupport, "normal")
	planeSlotItem.goSupportSelect = gohelper.findChild(planeSlotItem.goSupport, "selected")
	planeSlotItem.goSupportEquip = gohelper.findChild(planeSlotItem.goSupport, "equiped")
	planeSlotItem.simageSupport = gohelper.findChildSingleImage(planeSlotItem.goSupport, "equiped/simage_support")
	planeSlotItem.btnSupport = gohelper.findChildButtonWithAudio(planeSlotItem.goSupport, "btn_support")
	planeSlotItem.animSupport = planeSlotItem.goSupport:GetComponent(typeof(UnityEngine.Animator))
	planeSlotItem.goResearch = gohelper.findChild(planeGO, "research")
	planeSlotItem.goresearchNormal = gohelper.findChild(planeSlotItem.goResearch, "normal")
	planeSlotItem.goResearchSelect = gohelper.findChild(planeSlotItem.goResearch, "selected")
	planeSlotItem.goResearchEquip = gohelper.findChild(planeSlotItem.goResearch, "equiped")
	planeSlotItem.imageResearch = gohelper.findChildImage(planeSlotItem.goResearch, "equiped/image_research")
	planeSlotItem.btnResearch = gohelper.findChildButtonWithAudio(planeSlotItem.goResearch, "btn_research")
	planeSlotItem.animResearch = planeSlotItem.goResearch:GetComponent(typeof(UnityEngine.Animator))

	planeSlotItem.btnSupport:AddClickListener(self._onSupportSlotClick, self, planeSlotItem)
	planeSlotItem.btnResearch:AddClickListener(self._onResearchSlotClick, self, planeSlotItem)

	return planeSlotItem
end

function TowerComposeHeroGroupBuffView:refreshPlaneSlotUI(planeSlotItem)
	planeSlotItem.supportBuffId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(self.themeId, planeSlotItem.planeId, TowerComposeEnum.TeamBuffType.Support)
	planeSlotItem.researchBuffId = TowerComposeHeroGroupModel.instance:getThemePlaneBuffId(self.themeId, planeSlotItem.planeId, TowerComposeEnum.TeamBuffType.Research)

	local isPlaneLayerUnlock = TowerComposeModel.instance:checkHasPlaneLayerUnlock(self.themeId)

	gohelper.setActive(planeSlotItem.goResearch, isPlaneLayerUnlock)
	gohelper.setActive(planeSlotItem.goSupportSelect, self.curBuffType == TowerComposeEnum.TeamBuffType.Support and self.curPlaneId == planeSlotItem.planeId)
	gohelper.setActive(planeSlotItem.goSupportEquip, planeSlotItem.supportBuffId > 0)
	gohelper.setActive(planeSlotItem.gosupportNormal, planeSlotItem.supportBuffId == 0)
	gohelper.setActive(planeSlotItem.goResearchSelect, self.curBuffType == TowerComposeEnum.TeamBuffType.Research and self.curPlaneId == planeSlotItem.planeId)
	gohelper.setActive(planeSlotItem.goResearchEquip, planeSlotItem.researchBuffId > 0)
	gohelper.setActive(planeSlotItem.goresearchNormal, planeSlotItem.researchBuffId == 0)

	if planeSlotItem.supportBuffId > 0 then
		local supportConfig = TowerComposeConfig.instance:getSupportCo(planeSlotItem.supportBuffId)
		local heroMo = HeroModel.instance:getByHeroId(supportConfig.heroId)
		local heroConfig = HeroConfig.instance:getHeroCO(supportConfig.heroId)
		local skinId = heroMo and heroMo.skin or heroConfig.skinId
		local skinConfig = SkinConfig.instance:getSkinCo(skinId)

		planeSlotItem.simageSupport:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
	end

	if planeSlotItem.researchBuffId > 0 then
		local researchCo = TowerComposeConfig.instance:getResearchCo(planeSlotItem.researchBuffId)

		UISpriteSetMgr.instance:setTower2Sprite(planeSlotItem.imageResearch, researchCo.icon)
	end

	planeSlotItem.lastSupportBuffId = not planeSlotItem.lastSupportBuffId and planeSlotItem.supportBuffId or planeSlotItem.lastSupportBuffId
	planeSlotItem.lastResearchBuffId = not planeSlotItem.lastResearchBuffId and planeSlotItem.researchBuffId or planeSlotItem.lastResearchBuffId

	if planeSlotItem.lastSupportBuffId ~= planeSlotItem.supportBuffId then
		planeSlotItem.lastSupportBuffId = planeSlotItem.supportBuffId

		if planeSlotItem.supportBuffId > 0 then
			planeSlotItem.animSupport:Play("add", 0, 0)
			planeSlotItem.animSupport:Update(0)
			AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_ly_card_close)
		end
	end

	if planeSlotItem.lastResearchBuffId ~= planeSlotItem.researchBuffId then
		planeSlotItem.lastResearchBuffId = planeSlotItem.researchBuffId

		if planeSlotItem.researchBuffId > 0 then
			planeSlotItem.animResearch:Play("add", 0, 0)
			planeSlotItem.animResearch:Update(0)
			AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_ly_card_close)
		end
	end
end

function TowerComposeHeroGroupBuffView:onClose()
	TowerComposeHeroGroupModel.instance:saveThemePlaneBuffData()
end

function TowerComposeHeroGroupBuffView:onDestroyView()
	for _, slotItem in pairs(self.planeSlotItemMap) do
		slotItem.btnSupport:RemoveClickListener()
		slotItem.btnResearch:RemoveClickListener()
		slotItem.simageSupport:UnLoadImage()
	end

	for _, researchItem in ipairs(self.researchItemList) do
		researchItem.btnClick:RemoveClickListener()
	end
end

return TowerComposeHeroGroupBuffView

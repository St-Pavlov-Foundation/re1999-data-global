-- chunkname: @modules/logic/towercompose/view/TowerComposeHeroGroupSupportItem.lua

module("modules.logic.towercompose.view.TowerComposeHeroGroupSupportItem", package.seeall)

local TowerComposeHeroGroupSupportItem = class("TowerComposeHeroGroupSupportItem", LuaCompBase)

function TowerComposeHeroGroupSupportItem:ctor(param)
	self.param = param
	self.heroCoData = self.param.heroCoData
	self.supportConfig = self.heroCoData.config
	self.heroId = self.heroCoData.config.heroId
	self.themeId = self.heroCoData.config.themeId
end

function TowerComposeHeroGroupSupportItem:init(go)
	self:__onInit()

	self.go = go
	self.goSelect1 = gohelper.findChild(self.go, "go_Selected1")
	self.goSelect2 = gohelper.findChild(self.go, "go_Selected2")
	self.goIsIn1 = gohelper.findChild(self.go, "go_isIn1")
	self.goIsIn2 = gohelper.findChild(self.go, "go_isIn2")
	self.imageRare = gohelper.findChildImage(self.go, "role/rare")
	self.simageHeroIcon = gohelper.findChildSingleImage(self.go, "role/heroicon")
	self.imageCareer = gohelper.findChildImage(self.go, "role/career")
	self.txtLevel = gohelper.findChildText(self.go, "role/txt_level")
	self.goExskill = gohelper.findChild(self.go, "role/go_exskill")
	self.imageExskill = gohelper.findChildImage(self.go, "role/go_exskill/image_exskill")
	self.rankList = {}

	for rankLv = 1, 3 do
		self.rankList[rankLv] = gohelper.findChild(self.go, "role/Rank/rank" .. rankLv)
	end

	self.goRank = gohelper.findChild(self.go, "role/Rank")
	self.txtName = gohelper.findChildText(self.go, "txtLayout/txt_name")
	self.txtActive = gohelper.findChildText(self.go, "txtLayout/txt_active")
	self.txtDesc = gohelper.findChildText(self.go, "txtLayout/txt_desc")

	SkillHelper.addHyperLinkClick(self.txtDesc, self._onHyperLinkClick, self)

	self.goMask = gohelper.findChild(self.go, "go_mask")
	self.btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeHeroGroupSupportItem:addEventListeners()
	self.btnClick:AddClickListener(self._onSupportItemClick, self)
end

function TowerComposeHeroGroupSupportItem:removeEventListeners()
	self.btnClick:RemoveClickListener()
end

function TowerComposeHeroGroupSupportItem:_onSupportItemClick()
	if not self.heroMo then
		GameFacade.showToast(ToastEnum.TowerComposeNotHaveHero)

		return
	end

	if self.isHeroInTeams then
		GameFacade.showToast(ToastEnum.TowerComposeHeroInTeams)

		return
	end

	local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.themeId, self.curPlaneId)
	local themeMo = TowerComposeModel.instance:getThemeMo(self.themeId)
	local planeMo = themeMo:getPlaneMo(self.curPlaneId)

	if isPlaneLock and planeMo.hasFight then
		GameFacade.showToast(ToastEnum.TowerComposeRecordRoleLock)

		return
	end

	if not self.isNormalEpisode and self.inPlaneId == 0 or self.inPlaneId == -1 then
		TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Support, self.supportConfig.id)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.HeroGroupSelectBuff)
	elseif self.curPlaneId == self.inPlaneId then
		TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Support, 0)
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.HeroGroupSelectBuff)
	elseif self.curPlaneId ~= self.inPlaneId then
		local isInPlaneLock = TowerComposeModel.instance:checkPlaneLock(self.themeId, self.inPlaneId)
		local inPlaneMo = themeMo:getPlaneMo(self.inPlaneId)

		if isInPlaneLock and inPlaneMo.hasFight then
			GameFacade.showToast(ToastEnum.TowerComposeRecordRoleLock)

			return
		end

		GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerComposeReplaceMod, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self.replaceTipCallBack, nil, nil, self)
	end
end

function TowerComposeHeroGroupSupportItem:replaceTipCallBack()
	TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.inPlaneId, TowerComposeEnum.TeamBuffType.Support, 0)
	TowerComposeHeroGroupModel.instance:setThemePlaneBuffId(self.themeId, self.curPlaneId, TowerComposeEnum.TeamBuffType.Support, self.supportConfig.id)
	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.HeroGroupSelectBuff)
end

function TowerComposeHeroGroupSupportItem:_editableInitView()
	local fightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = fightParam.themeId
	local layerId = fightParam.layerId

	self.towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)
	self.isNormalEpisode = self.towerEpisodeConfig.plane == 0
	self.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self.txtDesc.gameObject, FixTmpBreakLine)
end

function TowerComposeHeroGroupSupportItem:refreshUI()
	gohelper.setActive(self.itemGO, true)

	self.inPlaneId = TowerComposeHeroGroupModel.instance:checkBuffInPlane(self.themeId, TowerComposeEnum.TeamBuffType.Support, self.supportConfig.id, self.isNormalEpisode)
	self.curPlaneId, self.curBuffType = TowerComposeHeroGroupModel.instance:getCurSelectPlaneIdAndType()

	gohelper.setActive(self.goSelect1, self.inPlaneId == 1 and self.curPlaneId == 1 or self.isNormalEpisode and self.inPlaneId == 0)
	gohelper.setActive(self.goSelect2, self.inPlaneId == 2 and self.curPlaneId == 2)
	gohelper.setActive(self.goIsIn1, self.inPlaneId == 1 or self.isNormalEpisode and self.inPlaneId == 0)
	gohelper.setActive(self.goIsIn2, self.inPlaneId == 2)

	self.heroMo = HeroModel.instance:getByHeroId(self.heroId)

	local heroConfig = HeroConfig.instance:getHeroCO(self.heroId)

	self.isHeroInTeams = TowerComposeHeroGroupModel.instance:checkHeroIsInTeam(self.heroId)

	if self.heroMo then
		self.txtName.text = self.isHeroInTeams and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towercompose_inTeams"), heroConfig.name) or heroConfig.name
	else
		self.txtName.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towercompose_notHave"), heroConfig.name)
	end

	local activeDesc = self.supportConfig.activeType == TowerComposeEnum.ActiveType.Active and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towercompose_activeEffect"), self.supportConfig.coldTime) or luaLang("towercompose_passiveEffect")
	local heroTag = luaLang("towercompose_heroTag" .. self.supportConfig.heroTag) or ""

	self.txtActive.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towercompose_activeEffectDesc"), heroTag, activeDesc)

	local replaceDesc = SkillHelper.buildDesc(self.supportConfig.desc)

	self.txtDesc.text = TowerComposeModel.instance:replaceLevelSkillDesc(replaceDesc, self.heroMo and self.heroMo.exSkillLevel or 0)

	self.descFixTmpBreakLine:refreshTmpContent(self.txtDesc)
	gohelper.setActive(self.txtLevel, self.heroMo ~= nil)
	gohelper.setActive(self.goExskill, self.heroMo ~= nil)
	gohelper.setActive(self.goMask, self.heroMo == nil)

	if self.heroMo then
		self.imageExskill.fillAmount = SummonCustomPickChoiceItem.exSkillFillAmount[self.heroMo.exSkillLevel] or 0

		local showLevel, rank = HeroConfig.instance:getShowLevel(self.heroMo.level)
		local tmpRank = rank - 1

		for index, rankItem in ipairs(self.rankList) do
			gohelper.setActive(rankItem, index == tmpRank)
		end

		gohelper.setActive(self.goRank, tmpRank > 0)

		self.txtLevel.text = string.format("Lv.%s", showLevel)

		local skinId = self.heroMo.skin
		local skinConfig = SkinConfig.instance:getSkinCo(skinId)

		self.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
	else
		local skinId = heroConfig.skinId
		local skinConfig = SkinConfig.instance:getSkinCo(skinId)

		self.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
		gohelper.setActive(self.goRank, false)
	end

	local rare = heroConfig.rare

	UISpriteSetMgr.instance:setCommonSprite(self.imageRare, "equipbar" .. CharacterEnum.Color[rare])

	local strCareer = tostring(heroConfig.career)

	UISpriteSetMgr.instance:setCommonSprite(self.imageCareer, "lssx_" .. strCareer)
end

function TowerComposeHeroGroupSupportItem:_onHyperLinkClick(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipView(tonumber(effId), clickPosition)
end

function TowerComposeHeroGroupSupportItem:onDestroy()
	return
end

return TowerComposeHeroGroupSupportItem

-- chunkname: @modules/logic/tower/view/TowerHeroTrialView.lua

module("modules.logic.tower.view.TowerHeroTrialView", package.seeall)

local TowerHeroTrialView = class("TowerHeroTrialView", BaseView)

function TowerHeroTrialView:onInitView()
	self._btncloseFullView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeFullView")
	self._scrollhero = gohelper.findChildScrollRect(self.viewGO, "#scroll_hero")
	self._goheroContent = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/#go_heroContent")
	self._goheroItem = gohelper.findChild(self.viewGO, "#scroll_hero/Viewport/#go_heroContent/#go_heroItem")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_desc")
	self._godescContent = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/#go_descContent")
	self._godescItem = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem")
	self._btnrule = gohelper.findChildButtonWithAudio(self.viewGO, "title/txt/#btn_rule")
	self._goruleTip = gohelper.findChild(self.viewGO, "#go_ruleTip")
	self._btncloseRuleTip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ruleTip/#btn_closeRuleTip")
	self._txtrule = gohelper.findChildText(self.viewGO, "#go_ruleTip/#txt_rule")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._imagefacetsIcon = gohelper.findChildImage(self.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/facets/image_facetsIcon")
	self._txtfacets = gohelper.findChildText(self.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/facets/txt_facets")
	self._gofacetsDesc = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/go_facetsDesc")
	self._gofacetsDescItem = gohelper.findChild(self.viewGO, "#scroll_desc/Viewport/#go_descContent/#go_descItem/go_facetsDesc/txt_facetsDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerHeroTrialView:addEvents()
	self._btncloseFullView:AddClickListener(self._btncloseFullViewOnClick, self)
	self._btnrule:AddClickListener(self._btnruleOnClick, self)
	self._btncloseRuleTip:AddClickListener(self._btncloseRuleTipOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function TowerHeroTrialView:removeEvents()
	self._btncloseFullView:RemoveClickListener()
	self._btnrule:RemoveClickListener()
	self._btncloseRuleTip:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function TowerHeroTrialView:_btncloseFullViewOnClick()
	self:_btncloseOnClick()
end

function TowerHeroTrialView:_btnruleOnClick()
	gohelper.setActive(self._goruleTip, true)
end

function TowerHeroTrialView:_btncloseRuleTipOnClick()
	gohelper.setActive(self._goruleTip, false)
end

function TowerHeroTrialView:_btncloseOnClick()
	self:closeThis()
end

function TowerHeroTrialView:onHeroTrialItemClick(selectHeroItem)
	for index, heroItem in ipairs(self.HeroItemList) do
		if heroItem.trialHeroId == selectHeroItem.trialHeroId then
			gohelper.setActive(heroItem.goSelect, true)

			self.curSelectHeroItem = heroItem

			self:createOrRefreshDesc()
		else
			gohelper.setActive(heroItem.goSelect, false)
		end
	end
end

function TowerHeroTrialView:_editableInitView()
	self.HeroItemList = self:getUserDataTb_()
	self.descItemList = self:getUserDataTb_()
end

function TowerHeroTrialView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_bubbles)
	gohelper.setActive(self._goruleTip, false)
	gohelper.setActive(self._goheroItem, false)
	self:refreshUI()
end

function TowerHeroTrialView:refreshUI()
	self.curSeason = TowerModel.instance:getTrialHeroSeason()
	self._txtrule.text = TowerConfig.instance:getTowerConstLangConfig(TowerEnum.ConstId.HeroTrialRule)

	self:createOrRefreshTrialHero()
	self:createOrRefreshDesc()
end

function TowerHeroTrialView:createOrRefreshTrialHero()
	local trialConfig = TowerConfig.instance:getHeroTrialConfig(self.curSeason)
	local heroIds = string.splitToNumber(trialConfig.heroIds, "|")

	for index, trialHeroId in ipairs(heroIds) do
		local heroItem = self.HeroItemList[index]

		if not heroItem then
			heroItem = {
				go = gohelper.clone(self._goheroItem, self._goheroContent, trialHeroId)
			}
			heroItem.rare = gohelper.findChildImage(heroItem.go, "role/rare")
			heroItem.heroIcon = gohelper.findChildSingleImage(heroItem.go, "role/heroicon")
			heroItem.career = gohelper.findChildImage(heroItem.go, "role/career")
			heroItem.name = gohelper.findChildText(heroItem.go, "role/name")
			heroItem.nameEn = gohelper.findChildText(heroItem.go, "role/name/nameEn")
			heroItem.goSelect = gohelper.findChild(heroItem.go, "go_select")
			heroItem.btnClick = gohelper.findChildButtonWithAudio(heroItem.go, "btn_click")

			heroItem.btnClick:AddClickListener(self.onHeroTrialItemClick, self, heroItem)

			self.HeroItemList[index] = heroItem
		end

		gohelper.setActive(heroItem.go, true)

		heroItem.trialHeroId = trialHeroId
		heroItem.trialConfig = lua_hero_trial.configDict[trialHeroId][0]

		local heroConfig = HeroConfig.instance:getHeroCO(heroItem.trialConfig.heroId)
		local skinConfig = SkinConfig.instance:getSkinCo(heroItem.trialConfig.skin)

		heroItem.heroIcon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))

		heroItem.name.text = heroConfig.name
		heroItem.nameEn.text = heroConfig.nameEng

		UISpriteSetMgr.instance:setCommonSprite(heroItem.career, "lssx_" .. heroConfig.career)
		UISpriteSetMgr.instance:setCommonSprite(heroItem.rare, "bgequip" .. CharacterEnum.Color[heroConfig.rare])
	end

	for i = #heroIds + 1, #self.HeroItemList do
		gohelper.setActive(self.HeroItemList[i].go, false)
	end

	if not self.curSelectHeroItem then
		self.curSelectHeroItem = self.HeroItemList[1]

		gohelper.setActive(self.curSelectHeroItem.goSelect, true)
	end
end

function TowerHeroTrialView:createOrRefreshDesc()
	local facetsId = self.curSelectHeroItem.trialConfig.facetsId
	local facetslevel = self.curSelectHeroItem.trialConfig.facetslevel
	local destinyCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(facetsId)

	if not destinyCo then
		logError(self.curSelectHeroItem.trialConfig.id .. "角色命石消耗表中狂想配置不存在，请检查： " .. facetsId)

		return
	end

	local tenp = CharacterDestinyEnum.SlotTend[destinyCo.tend]
	local tendIcon = tenp.TitleIconName

	UISpriteSetMgr.instance:setUiCharacterSprite(self._imagefacetsIcon, tendIcon)

	self._txtfacets.color = GameUtil.parseColor(tenp.TitleColor)
	self._txtfacets.text = destinyCo.name

	local facetsDataList = {}

	for level = 1, facetslevel do
		local facetsCo = CharacterDestinyConfig.instance:getDestinyFacets(facetsId, level)

		table.insert(facetsDataList, facetsCo)
	end

	gohelper.CreateObjList(self, self.showFacetsDescItem, facetsDataList, self._gofacetsDesc, self._gofacetsDescItem)
end

function TowerHeroTrialView:showFacetsDescItem(obj, data, index)
	local txtItem = self:getUserDataTb_()

	txtItem.txtdesc = obj:GetComponent(gohelper.Type_TextMesh)
	txtItem.txtdesc.text = data.desc
	txtItem.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SkillDescComp)

	txtItem.skillDesc:updateInfo(txtItem.txtdesc, data.desc, self.curSelectHeroItem.trialConfig.heroId)
	txtItem.skillDesc:setTipParam(0, Vector2(-200, 100))
end

function TowerHeroTrialView:onClose()
	for _, heroItem in ipairs(self.HeroItemList) do
		heroItem.btnClick:RemoveClickListener()
		heroItem.heroIcon:UnLoadImage()
	end
end

function TowerHeroTrialView:onDestroyView()
	return
end

return TowerHeroTrialView

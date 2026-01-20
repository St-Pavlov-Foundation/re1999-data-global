-- chunkname: @modules/logic/herogroup/view/HeroGroupRecommendGroupItem.lua

module("modules.logic.herogroup.view.HeroGroupRecommendGroupItem", package.seeall)

local HeroGroupRecommendGroupItem = class("HeroGroupRecommendGroupItem", ListScrollCell)

function HeroGroupRecommendGroupItem:init(go)
	self._txtrank = gohelper.findChildText(go, "#go_info/rankhead/#txt_rank")
	self._txtnum = gohelper.findChildText(go, "#go_info/#txt_num")
	self._txtherogrouprate = gohelper.findChildText(go, "#go_info/#txt_herogrouprate")
	self._goherogrouplist = gohelper.findChild(go, "#go_info/herogrouplist")
	self._goheroitem = gohelper.findChild(go, "#go_info/herogrouplist/#go_heroitem")
	self._simagecloth = gohelper.findChildSingleImage(go, "#go_info/#simage_cloth")
	self._btnuse = gohelper.findChildButtonWithAudio(go, "#go_info/#btn_use")
	self._goinfo = gohelper.findChild(go, "#go_info")
	self._gonull = gohelper.findChild(go, "#go_null")
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
	self._simagebg = gohelper.findChildSingleImage(go, "#simage_bg")
	self._gobossItem = gohelper.findChild(go, "#go_info/#go_bossitem")
	self._gobossEmpty = gohelper.findChild(go, "#go_info/#go_bossitem/go_empty")
	self._gobossContainer = gohelper.findChild(go, "#go_info/#go_bossitem/go_container")
	self._simageBossIcon = gohelper.findChildSingleImage(go, "#go_info/#go_bossitem/go_container/simage_bossicon")
	self._imageBossCareer = gohelper.findChildImage(go, "#go_info/#go_bossitem/go_container/image_career")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupRecommendGroupItem:addEventListeners()
	self._btnuse:AddClickListener(self._btnuseOnClick, self)
end

function HeroGroupRecommendGroupItem:removeEventListeners()
	self._btnuse:RemoveClickListener()
end

function HeroGroupRecommendGroupItem:_btnuseOnClick()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnUseRecommendGroup)

	local heroDataList = self._mo.heroDataList
	local uidList = {}
	local battleId = HeroGroupModel.instance.battleId
	local battleConfig = lua_battle.configDict[battleId]
	local configAids = {}

	if not string.nilorempty(battleConfig.aid) then
		configAids = string.splitToNumber(battleConfig.aid, "#")
	end

	local configTrial = {}
	local curBattleTrialHeros = HeroGroupHandler.getTrialHeros(HeroGroupModel.instance.episodeId)

	if not string.nilorempty(curBattleTrialHeros) then
		configTrial = GameUtil.splitString2(curBattleTrialHeros, true)
	end

	local allUseTrialHeros = {}

	for _, v in pairs(configTrial) do
		if v[3] then
			local co = lua_hero_trial.configDict[v[1]][v[2]]

			allUseTrialHeros[co.heroId] = true
		end
	end

	for i = 1, #heroDataList do
		local heroId = heroDataList[i].heroId

		if heroId and heroId > 0 then
			local heroMO = HeroModel.instance:getByHeroId(heroId)

			if HeroGroupModel.instance:isAdventureOrWeekWalk() then
				local cd = WeekWalkModel.instance:getCurMapHeroCd(heroId)

				if cd > 0 then
					GameFacade.showToast(ToastEnum.HeroGroupEdit)

					heroMO = nil
				end
			elseif heroMO and HeroGroupModel.instance:isRestrict(heroMO.uid) then
				local battleCo = HeroGroupModel.instance:getCurrentBattleConfig()
				local restrictReason = battleCo and battleCo.restrictReason

				if not string.nilorempty(restrictReason) then
					ToastController.instance:showToastWithString(restrictReason)
				end

				heroMO = nil
			end

			if allUseTrialHeros[heroId] then
				heroMO = nil
			end

			if heroMO then
				table.insert(uidList, heroMO.uid)
			else
				table.insert(uidList, "0")
			end
		else
			table.insert(uidList, "0")
		end
	end

	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local clothId = 0

	if self._mo.cloth and self._mo.cloth ~= 0 and PlayerClothModel.instance:canUse(self._mo.cloth) then
		clothId = self._mo.cloth
	elseif OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		local list = PlayerClothModel.instance:getList()

		for _, clothMO in ipairs(list) do
			if PlayerClothModel.instance:hasCloth(clothMO.id) then
				clothId = clothMO.id

				break
			end
		end
	end

	local info = {
		groupId = heroGroupMO.id,
		name = heroGroupMO.name,
		clothId = clothId,
		heroList = uidList
	}

	if TowerModel.instance:isInTowerBattle() then
		self:onTowerUse(info, heroGroupMO, configAids, battleConfig.roleNum, battleConfig.playerMax, true, configTrial)

		return
	end

	heroGroupMO:initWithBattle(info, configAids, battleConfig.roleNum, battleConfig.playerMax, true, configTrial)
	HeroSingleGroupModel.instance:setSingleGroup(heroGroupMO, true)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
	ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnUseRecommendGroupFinish)
end

function HeroGroupRecommendGroupItem:onTowerUse(info, heroGroupMO, ...)
	local towerFightParam = TowerModel.instance:getRecordFightParam()

	if towerFightParam and towerFightParam.isHeroGroupLock then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)
		ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)

		return
	end

	local assistBossId = self._mo.assistBossId

	if assistBossId and assistBossId > 0 and towerFightParam and not towerFightParam.isHeroGroupLock and not TowerModel.instance:isBossBan(assistBossId) and not TowerModel.instance:isLimitTowerBossBan(towerFightParam.towerType, towerFightParam.towerId, assistBossId) then
		local bossMo = TowerAssistBossModel.instance:getById(assistBossId)

		if bossMo then
			local bossIsOpen = TowerController.instance:isBossTowerOpen()

			if bossIsOpen then
				info.assistBossId = assistBossId
			end
		end
	end

	for i, v in ipairs(info.heroList) do
		local mo = HeroModel.instance:getById(v)

		if mo and TowerModel.instance:isHeroBan(mo.heroId) then
			info.heroList[i] = tostring(0)
		end
	end

	heroGroupMO:initWithBattle(info, ...)
	HeroSingleGroupModel.instance:setSingleGroup(heroGroupMO, true)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
	ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)
end

function HeroGroupRecommendGroupItem:_editableInitView()
	gohelper.setActive(self._goheroitem, false)

	self._heroItemList = {}

	self._simagebg:LoadImage(ResUrl.getHeroGroupBg("biandui_youdi"))

	self._imagebg = self._simagebg:GetComponent(gohelper.Type_Image)
	self._isFiveHeroEpisode = DungeonController.checkEpisodeFiveHero(HeroGroupModel.instance.episodeId)

	if self._isFiveHeroEpisode then
		recthelper.setAnchorX(self._goherogrouplist.transform, -97.5)

		local layoutGroup = self._goherogrouplist:GetComponent(gohelper.Type_HorizontalLayoutGroup)

		layoutGroup.spacing = -40
	end
end

function HeroGroupRecommendGroupItem:onUpdateMO(mo)
	self._mo = mo

	gohelper.setActive(self._gonull, self._mo.isEmpty)
	gohelper.setActive(self._goinfo, not self._mo.isEmpty)
	ZProj.UGUIHelper.SetColorAlpha(self._imagebg, self._mo.isEmpty and 0.5 or 1)

	if self._mo.isEmpty then
		return
	end

	self._txtrank.text = string.format("%d", self._index)
	self._txtherogrouprate.text = string.format("%s%%", math.floor(self._mo.rate * 10000) / 100)

	local clothConfig = self._mo.cloth and self._mo.cloth ~= 0 and lua_cloth.configDict[self._mo.cloth]

	gohelper.setActive(self._simagecloth.gameObject, clothConfig)

	if clothConfig then
		self._simagecloth:LoadImage(ResUrl.getPlayerClothIcon(clothConfig.icon))
	end

	self:_refreshHeroItem()

	self._txtnum.text = GameUtil.getEnglishOrderNumber(self._index)

	self:refreshTowerBossUI()
end

function HeroGroupRecommendGroupItem:_refreshHeroItem()
	local heroDataList = self._mo.heroDataList
	local num = self._isFiveHeroEpisode and ModuleEnum.FiveHeroEnum.MaxHeroNum or ModuleEnum.MaxHeroCountInGroup

	for i = 1, num do
		local heroData = heroDataList[i]
		local heroItem = self._heroItemList[i]

		if not heroItem then
			heroItem = self:getUserDataTb_()
			heroItem.go = gohelper.cloneInPlace(self._goheroitem, "item" .. i)
			heroItem.gocontainer = gohelper.findChild(heroItem.go, "go_container")
			heroItem.simageheroicon = gohelper.findChildSingleImage(heroItem.go, "go_container/simage_heroicon")
			heroItem.imagecareer = gohelper.findChildImage(heroItem.go, "go_container/image_career")
			heroItem.goaidtag = gohelper.findChild(heroItem.go, "go_container/go_aidtag")
			heroItem.gostorytag = gohelper.findChild(heroItem.go, "go_container/go_storytag")
			heroItem.imageinsight = gohelper.findChildImage(heroItem.go, "go_container/level/layout/image_insight")
			heroItem.txtlevel = gohelper.findChildText(heroItem.go, "go_container/level/layout/txt_level")
			heroItem.goempty = gohelper.findChild(heroItem.go, "go_empty")

			table.insert(self._heroItemList, heroItem)
		end

		gohelper.setActive(heroItem.gocontainer, heroData)
		gohelper.setActive(heroItem.goempty, not heroData)

		if heroData then
			gohelper.setActive(heroItem.gostorytag, false)
			gohelper.setActive(heroItem.goaidtag, false)

			local heroId = heroData.heroId
			local showLevel, rankLevel = HeroConfig.instance:getShowLevel(heroDataList[i].level)

			heroItem.txtlevel.text = self:getShowLevelText(showLevel)

			if rankLevel > 1 then
				UISpriteSetMgr.instance:setHeroGroupSprite(heroItem.imageinsight, "biandui_dongxi_" .. tostring(rankLevel - 1))
				gohelper.setActive(heroItem.imageinsight.gameObject, true)
			else
				gohelper.setActive(heroItem.imageinsight.gameObject, false)
			end

			local heroConfig = HeroConfig.instance:getHeroCO(heroId)
			local skinConfig = SkinConfig.instance:getSkinCo(heroConfig.skinId)

			heroItem.simageheroicon:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
			UISpriteSetMgr.instance:setCommonSprite(heroItem.imagecareer, "lssx_" .. tostring(heroConfig.career))

			local heroMO = HeroModel.instance:getByHeroId(heroId)

			ZProj.UGUIHelper.SetGrayscale(heroItem.simageheroicon.gameObject, not heroMO)
			ZProj.UGUIHelper.SetGrayscale(heroItem.imagecareer.gameObject, not heroMO)
		end

		gohelper.setActive(heroItem.go, true)
	end
end

function HeroGroupRecommendGroupItem:refreshTowerBossUI()
	local clothConfig = self._mo.cloth and self._mo.cloth ~= 0 and lua_cloth.configDict[self._mo.cloth]
	local hasCloth = clothConfig ~= nil
	local isInTowerBattle = TowerModel.instance:isInTowerBattle()
	local bossId = self._mo.assistBossId
	local hasAssistBoss = bossId and bossId > 0

	gohelper.setActive(self._simagecloth.gameObject, clothConfig and not isInTowerBattle)
	gohelper.setActive(self._gobossItem, isInTowerBattle)
	gohelper.setActive(self._gobossEmpty, isInTowerBattle and not hasAssistBoss)
	gohelper.setActive(self._gobossContainer, isInTowerBattle and hasAssistBoss)

	if isInTowerBattle and hasAssistBoss then
		local bossConfig = TowerConfig.instance:getAssistBossConfig(bossId)

		UISpriteSetMgr.instance:setCommonSprite(self._imageBossCareer, string.format("lssx_%s", bossConfig.career))

		local skinConfig = FightConfig.instance:getSkinCO(bossConfig.skinId)

		self._simageBossIcon:LoadImage(ResUrl.monsterHeadIcon(skinConfig and skinConfig.headIcon))
	end
end

function HeroGroupRecommendGroupItem:getShowLevelText(showLevel)
	return "<size=12>Lv.</size>" .. tostring(showLevel)
end

function HeroGroupRecommendGroupItem:getAnimator()
	return self._anim
end

function HeroGroupRecommendGroupItem:onDestroy()
	self._simagecloth:UnLoadImage()
	self._simagebg:UnLoadImage()
	self._simageBossIcon:UnLoadImage()

	for i, heroItem in ipairs(self._heroItemList) do
		heroItem.simageheroicon:UnLoadImage()
	end
end

return HeroGroupRecommendGroupItem

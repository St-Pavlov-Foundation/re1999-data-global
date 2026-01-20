-- chunkname: @modules/logic/survival/view/map/SurvivalInitHeroSelectView.lua

module("modules.logic.survival.view.map.SurvivalInitHeroSelectView", package.seeall)

local SurvivalInitHeroSelectView = class("SurvivalInitHeroSelectView", BaseView)

function SurvivalInitHeroSelectView:onInitView()
	self._gononecharacter = gohelper.findChild(self.viewGO, "characterinfo/#go_nonecharacter")
	self._gocharacterinfo = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo")
	self._imagedmgtype = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	self._imagecareericon = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	self._txtname = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	self._gospecialitem = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem")
	self._golevel = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/level")
	self._txtlevel = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/level/#txt_level")
	self._txtlevelmax = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/level/#txt_level/#txt_levelmax")
	self._btncharacter = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/level/#btn_character")
	self._btntrial = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/level/#btn_trial")
	self._goBalance = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/level/#go_balance")
	self._goheroLvTxt = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/level/Text")
	self._golevelWithTalent = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent")
	self._txtlevelWithTalent = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level")
	self._txtlevelmaxWithTalent = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level/#txt_levelmax")
	self._btncharacterWithTalent = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_character")
	self._btntrialWithTalent = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_trial")
	self._goBalanceWithTalent = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#go_balance")
	self._goheroLvTxtWithTalent = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/Text")
	self._txttalent = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talent")
	self._txttalentType = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talentType")
	self._btnattribute = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/attribute/#btn_attribute")
	self._goattribute = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	self._goskill = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	self._btnpassiveskill = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	self._txtpassivename = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	self._gopassiveskills = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	self._gorolecontainer = gohelper.findChild(self.viewGO, "#go_rolecontainer")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/#scroll_card")
	self._goScrollContent = gohelper.findChild(self.viewGO, "#go_rolecontainer/#scroll_card/scrollcontent")
	self._scrollquickedit = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/#scroll_quickedit")
	self._gorolesort = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort")
	self._btnlvrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	self._btnexskillrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	self._btnclassify = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	self._btnquickedit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_quickedit")
	self._goexarrow = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")
	self._gosearchfilter = gohelper.findChild(self.viewGO, "#go_searchfilter")
	self._btnclosefilterview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/#btn_closefilterview")
	self._godmgitem = gohelper.findChild(self.viewGO, "#go_searchfilter/container/dmgContainer/#go_dmgitem")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_searchfilter/container/attrContainer/#go_attritem")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/#btn_reset")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/#btn_ok")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_cancel")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalInitHeroSelectView:addEvents()
	self._btnlvrank:AddClickListener(self._btnlvrankOnClick, self)
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnexskillrank:AddClickListener(self._btnexskillrankOnClick, self)
	self._btnclassify:AddClickListener(self._btnclassifyOnClick, self)
	self._btncharacter:AddClickListener(self._btncharacterOnClick, self)
	self._btntrial:AddClickListener(self._btntrialOnClick, self)
	self._btncharacterWithTalent:AddClickListener(self._btncharacterOnClick, self)
	self._btntrialWithTalent:AddClickListener(self._btntrialOnClick, self)
	self._btnattribute:AddClickListener(self._btnattributeOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnpassiveskill:AddClickListener(self._btnpassiveskillOnClick, self)
	self._btnquickedit:AddClickListener(self._btnquickeditOnClick, self)
	self._btnclosefilterview:AddClickListener(self._btncloseFilterViewOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
end

function SurvivalInitHeroSelectView:removeEvents()
	self._btnlvrank:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
	self._btnexskillrank:RemoveClickListener()
	self._btnclassify:RemoveClickListener()
	self._btncharacter:RemoveClickListener()
	self._btntrial:RemoveClickListener()
	self._btncharacterWithTalent:RemoveClickListener()
	self._btntrialWithTalent:RemoveClickListener()
	self._btnattribute:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnpassiveskill:RemoveClickListener()
	self._btnquickedit:RemoveClickListener()
	self._btnclosefilterview:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnok:RemoveClickListener()
end

function SurvivalInitHeroSelectView:_btncloseFilterViewOnClick()
	self._selectDmgs = LuaUtil.deepCopy(self._curDmgs)
	self._selectAttrs = LuaUtil.deepCopy(self._curAttrs)
	self._selectLocations = LuaUtil.deepCopy(self._curLocations)

	self:_refreshBtnIcon()
	gohelper.setActive(self._gosearchfilter, false)
end

function SurvivalInitHeroSelectView:_btnclassifyOnClick()
	gohelper.setActive(self._gosearchfilter, true)
	self:_refreshFilterView()
end

function SurvivalInitHeroSelectView:_btnresetOnClick()
	for i = 1, 2 do
		self._selectDmgs[i] = false
	end

	for i = 1, 6 do
		self._selectAttrs[i] = false
	end

	for i = 1, 6 do
		self._selectLocations[i] = false
	end

	self:_refreshBtnIcon()
	self:_refreshFilterView()
end

function SurvivalInitHeroSelectView:_btnokOnClick()
	gohelper.setActive(self._gosearchfilter, false)

	local dmgs = {}

	for i = 1, 2 do
		if self._selectDmgs[i] then
			table.insert(dmgs, i)
		end
	end

	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			table.insert(careers, i)
		end
	end

	local locations = {}

	for i = 1, 6 do
		if self._selectLocations[i] then
			table.insert(locations, i)
		end
	end

	if #dmgs == 0 then
		dmgs = {
			1,
			2
		}
	end

	if #careers == 0 then
		careers = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #locations == 0 then
		locations = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)

	local filterParam = {}

	filterParam.dmgs = dmgs
	filterParam.careers = careers
	filterParam.locations = locations

	CharacterModel.instance:filterCardListByDmgAndCareer(filterParam, false, CharacterEnum.FilterType.Survival)

	self._curDmgs = LuaUtil.deepCopy(self._selectDmgs)
	self._curAttrs = LuaUtil.deepCopy(self._selectAttrs)
	self._curLocations = LuaUtil.deepCopy(self._selectLocations)

	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
	ViewMgr.instance:closeView(ViewName.CharacterLevelUpView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function SurvivalInitHeroSelectView:_btnpassiveskillOnClick()
	if not self._heroMO then
		return
	end

	local info = {}

	info.tag = "passiveskill"
	info.heroid = self._heroMO.heroId
	info.heroMo = self._heroMO
	info.tipPos = Vector2.New(851, -59)
	info.buffTipsX = 1603
	info.anchorParams = {
		Vector2.New(0, 0.5),
		Vector2.New(0, 0.5)
	}
	info.isBalance = true

	CharacterController.instance:openCharacterTipView(info)
end

function SurvivalInitHeroSelectView:_btnconfirmOnClick()
	if self._isShowQuickEdit then
		self:closeThis()

		return
	end

	self._groupModel:trySetHeroMo(self._heroMO)
	self:closeThis()
end

function SurvivalInitHeroSelectView:_btncancelOnClick()
	self:closeThis()
end

function SurvivalInitHeroSelectView:_btncharacterOnClick()
	if self._heroMO then
		local heroMoList = self._groupModel:getList()

		CharacterController.instance:openCharacterView(self._heroMO, heroMoList)
	end
end

function SurvivalInitHeroSelectView:_btntrialOnClick()
	return
end

function SurvivalInitHeroSelectView:_btnattributeOnClick()
	if self._heroMO then
		local info = {}

		info.tag = "attribute"
		info.heroid = self._heroMO.heroId
		info.showExtraAttr = true
		info.fromSurvivalHeroGroupEditView = true
		info.heroMo = self._heroMO
		info.isBalance = true

		CharacterController.instance:openCharacterTipView(info)
	end
end

function SurvivalInitHeroSelectView:_btnexskillrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.Survival)
	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
end

function SurvivalInitHeroSelectView:_btnlvrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.Survival)
	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
end

function SurvivalInitHeroSelectView:_btnrarerankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.Survival)
	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
end

function SurvivalInitHeroSelectView:_btnquickeditOnClick()
	self._isShowQuickEdit = not self._isShowQuickEdit

	self:_refreshBtnIcon()
	self:_refreshEditMode()

	if self._isShowQuickEdit then
		local heroMo = self._groupModel:getList()[1]

		if heroMo then
			self._groupModel:selectCell(1, true)
			self:_onHeroItemClick(heroMo)
		else
			self:_onHeroItemClick(nil)
		end
	else
		self:_onHeroItemClick(self._groupModel:getList()[1])

		for index, heroMo in ipairs(self._groupModel:getList()) do
			if self._groupModel:getMoIndex(heroMo) > 0 then
				self._groupModel:selectCell(index, true)
			end
		end
	end
end

function SurvivalInitHeroSelectView:_attrBtnOnClick(i)
	self._selectAttrs[i] = not self._selectAttrs[i]

	self:_refreshFilterView()
end

function SurvivalInitHeroSelectView:_dmgBtnOnClick(i)
	if not self._selectDmgs[i] then
		self._selectDmgs[3 - i] = self._selectDmgs[i]
	end

	self._selectDmgs[i] = not self._selectDmgs[i]

	self:_refreshFilterView()
end

function SurvivalInitHeroSelectView:_locationBtnOnClick(i)
	self._selectLocations[i] = not self._selectLocations[i]

	self:_refreshFilterView()
end

function SurvivalInitHeroSelectView:_onHeroItemClick(heroMO)
	self._heroMO = heroMO

	self:_refreshCharacterInfo()
end

function SurvivalInitHeroSelectView:_refreshCharacterInfo()
	if self._heroMO then
		gohelper.setActive(self._gononecharacter, false)
		gohelper.setActive(self._gocharacterinfo, true)
		self:_refreshSkill()
		self:_refreshMainInfo()
		self:_refreshAttribute()
		self:_refreshPassiveSkill()
	else
		gohelper.setActive(self._gononecharacter, true)
		gohelper.setActive(self._gocharacterinfo, false)
	end
end

function SurvivalInitHeroSelectView:_refreshMainInfo()
	if self._heroMO then
		gohelper.setActive(self._btntrial.gameObject, self._heroMO:isTrial())
		gohelper.setActive(self._btntrialWithTalent.gameObject, self._heroMO:isTrial())
		UISpriteSetMgr.instance:setCommonSprite(self._imagecareericon, "sx_biandui_" .. tostring(self._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(self._imagedmgtype, "dmgtype" .. tostring(self._heroMO.config.dmgType))

		self._txtname.text = self._heroMO:getHeroName()
		self._txtnameen.text = self._heroMO.config.nameEng

		local isShowTalent = self._heroMO.rank >= CharacterEnum.TalentRank and self._heroMO.talent > 0

		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
			isShowTalent = false
		end

		local balanceLv = 0
		local balanceRank = 0
		local balanceTalent = 0
		local isShowBalanceTalent = false

		if not self._heroMO:isTrial() then
			balanceLv, balanceRank, balanceTalent = SurvivalBalanceHelper.getHeroBalanceInfo(self._heroMO.heroId)

			if balanceRank and balanceRank >= CharacterEnum.TalentRank and balanceTalent > 0 then
				isShowBalanceTalent = true
			end
		end

		local isBalance = balanceLv and balanceLv > self._heroMO.level
		local isBalanceTalent = isShowBalanceTalent and (not isShowTalent or balanceTalent > self._heroMO.talent)

		if isShowTalent or isShowBalanceTalent then
			gohelper.setActive(self._golevel, false)
			gohelper.setActive(self._golevelWithTalent, true)
			gohelper.setActive(self._goBalanceWithTalent, isBalance or isBalanceTalent)
			gohelper.setActive(self._goheroLvTxtWithTalent, true)

			if isBalance then
				local showLevel, rank = HeroConfig.instance:getShowLevel(balanceLv)
				local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, rank)[1]
				local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

				self._txtlevelWithTalent.text = "<color=#8fb1cc>" .. tostring(showLevel)
				self._txtlevelmaxWithTalent.text = string.format("/%d", showMaxLevel)
			else
				local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, self._heroMO.rank)[1]
				local showLevel = HeroConfig.instance:getShowLevel(self._heroMO.level)
				local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

				self._txtlevelWithTalent.text = tostring(showLevel)
				self._txtlevelmaxWithTalent.text = string.format("/%d", showMaxLevel)
			end

			if isBalanceTalent then
				self._txttalent.text = "<color=#8fb1cc>Lv.<size=40>" .. tostring(balanceTalent)
			else
				self._txttalent.text = "Lv.<size=40>" .. tostring(self._heroMO.talent)
			end

			self._txttalentType.text = luaLang("talent_character_talentcn" .. self._heroMO:getTalentTxtByHeroType())
		else
			gohelper.setActive(self._golevel, true)
			gohelper.setActive(self._golevelWithTalent, false)
			gohelper.setActive(self._goBalance, isBalance)
			gohelper.setActive(self._goheroLvTxt, not isBalance)

			if isBalance then
				local showLevel, rank = HeroConfig.instance:getShowLevel(balanceLv)
				local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, rank)[1]
				local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

				self._txtlevel.text = "<color=#8fb1cc>" .. tostring(showLevel)
				self._txtlevelmax.text = string.format("/%d", showMaxLevel)
			else
				local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, self._heroMO.rank)[1]
				local showLevel = HeroConfig.instance:getShowLevel(self._heroMO.level)
				local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

				self._txtlevel.text = tostring(showLevel)
				self._txtlevelmax.text = string.format("/%d", showMaxLevel)
			end
		end

		local tags = {}

		if not string.nilorempty(self._heroMO.config.battleTag) then
			tags = string.split(self._heroMO.config.battleTag, "#")
		end

		for i = 1, #tags do
			local careerTable = self._careerGOs[i]

			if not careerTable then
				careerTable = self:getUserDataTb_()
				careerTable.go = gohelper.cloneInPlace(self._gospecialitem, "item" .. i)
				careerTable.textfour = gohelper.findChildText(careerTable.go, "#go_fourword/name")
				careerTable.textthree = gohelper.findChildText(careerTable.go, "#go_threeword/name")
				careerTable.texttwo = gohelper.findChildText(careerTable.go, "#go_twoword/name")
				careerTable.containerfour = gohelper.findChild(careerTable.go, "#go_fourword")
				careerTable.containerthree = gohelper.findChild(careerTable.go, "#go_threeword")
				careerTable.containertwo = gohelper.findChild(careerTable.go, "#go_twoword")

				table.insert(self._careerGOs, careerTable)
			end

			local desc = HeroConfig.instance:getBattleTagConfigCO(tags[i]).tagName
			local wordCount = GameUtil.utf8len(desc)

			gohelper.setActive(careerTable.containertwo, wordCount <= 2)
			gohelper.setActive(careerTable.containerthree, wordCount == 3)
			gohelper.setActive(careerTable.containerfour, wordCount >= 4)

			if wordCount <= 2 then
				careerTable.texttwo.text = desc
			elseif wordCount == 3 then
				careerTable.textthree.text = desc
			else
				careerTable.textfour.text = desc
			end

			gohelper.setActive(careerTable.go, true)
		end

		for i = #tags + 1, #self._careerGOs do
			gohelper.setActive(self._careerGOs[i].go, false)
		end
	end
end

function SurvivalInitHeroSelectView:_refreshAttribute()
	if self._heroMO then
		local mo = HeroGroupTrialModel.instance:getById(self._originalHeroUid)
		local trialEquipMo

		if mo then
			trialEquipMo = mo.trialEquipMo
		end

		local attrDict = self._heroMO:getTotalBaseAttrDict(self._equips, nil, nil, true, trialEquipMo, SurvivalBalanceHelper.getHeroBalanceInfo)

		for index, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
			local co = HeroConfig.instance:getHeroAttributeCO(attrId)

			self._attributevalues[index].name.text = co.name
			self._attributevalues[index].value.text = attrDict[attrId]

			CharacterController.instance:SetAttriIcon(self._attributevalues[index].icon, attrId)
		end
	end
end

function SurvivalInitHeroSelectView:_refreshPassiveSkill()
	if not self._heroMO then
		return
	end

	local pskills = self._heroMO:getpassiveskillsCO()
	local firstSkill = pskills[1]
	local skillId = firstSkill.skillPassive
	local passiveSkillConfig = lua_skill.configDict[skillId]

	if not passiveSkillConfig then
		logError("找不到角色被动技能, skillId: " .. tostring(skillId))
	else
		self._txtpassivename.text = passiveSkillConfig.name
	end

	local balanceLv = 0

	if not self._heroMO:isTrial() then
		balanceLv = SurvivalBalanceHelper.getHeroBalanceLv(self._heroMO.heroId)
	end

	local isBalance = balanceLv > self._heroMO.level
	local passiveLevel, rank = SkillConfig.instance:getHeroExSkillLevelByLevel(self._heroMO.heroId, math.max(self._heroMO.level, balanceLv))

	for i = 1, #pskills do
		local unlock = i <= passiveLevel

		gohelper.setActive(self._passiveskillitems[i].on, unlock and not isBalance)
		gohelper.setActive(self._passiveskillitems[i].off, not unlock)
		gohelper.setActive(self._passiveskillitems[i].balance, unlock and isBalance)
		gohelper.setActive(self._passiveskillitems[i].go, true)
	end

	for i = #pskills + 1, #self._passiveskillitems do
		gohelper.setActive(self._passiveskillitems[i].go, false)
	end

	if pskills[0] then
		gohelper.setActive(self._passiveskillitems[0].on, true)
		gohelper.setActive(self._passiveskillitems[0].off, false)
		gohelper.setActive(self._passiveskillitems[0].balance, isBalance)
		gohelper.setActive(self._passiveskillitems[0].go, true)
	else
		gohelper.setActive(self._passiveskillitems[0].go, false)
	end
end

function SurvivalInitHeroSelectView:_refreshSkill()
	self._skillContainer:onUpdateMO(self._heroMO and self._heroMO.heroId, nil, self._heroMO, true)
end

function SurvivalInitHeroSelectView:_refreshBtnIcon()
	local state = CharacterModel.instance:getRankState()
	local tag = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.Survival)

	gohelper.setActive(self._lvBtns[1], tag ~= 1)
	gohelper.setActive(self._lvBtns[2], tag == 1)
	gohelper.setActive(self._rareBtns[1], tag ~= 2)
	gohelper.setActive(self._rareBtns[2], tag == 2)

	local hasFilter = false

	for _, v in pairs(self._selectDmgs) do
		if v then
			hasFilter = true
		end
	end

	for _, v in pairs(self._selectAttrs) do
		if v then
			hasFilter = true
		end
	end

	for _, v in pairs(self._selectLocations) do
		if v then
			hasFilter = true
		end
	end

	gohelper.setActive(self._classifyBtns[1], not hasFilter)
	gohelper.setActive(self._classifyBtns[2], hasFilter)
	HeroGroupTrialModel.instance:sortByLevelAndRare(tag == 1, state[tag] == 1)
	transformhelper.setLocalScale(self._lvArrow[1], 1, state[1], 1)
	transformhelper.setLocalScale(self._lvArrow[2], 1, state[1], 1)
	transformhelper.setLocalScale(self._rareArrow[1], 1, state[2], 1)
	transformhelper.setLocalScale(self._rareArrow[2], 1, state[2], 1)
end

function SurvivalInitHeroSelectView:_refreshFilterView()
	for i = 1, 2 do
		gohelper.setActive(self._dmgUnselects[i], not self._selectDmgs[i])
		gohelper.setActive(self._dmgSelects[i], self._selectDmgs[i])
	end

	for i = 1, 6 do
		gohelper.setActive(self._attrUnselects[i], not self._selectAttrs[i])
		gohelper.setActive(self._attrSelects[i], self._selectAttrs[i])
	end

	for i = 1, 6 do
		gohelper.setActive(self._locationUnselects[i], not self._selectLocations[i])
		gohelper.setActive(self._locationSelects[i], self._selectLocations[i])
	end
end

function SurvivalInitHeroSelectView:_updateHeroList()
	local dmgs = {}

	for i = 1, 2 do
		if self._selectDmgs[i] then
			table.insert(dmgs, i)
		end
	end

	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			table.insert(careers, i)
		end
	end

	local locations = {}

	for i = 1, 6 do
		if self._selectLocations[i] then
			table.insert(locations, i)
		end
	end

	if #dmgs == 0 then
		dmgs = {
			1,
			2
		}
	end

	if #careers == 0 then
		careers = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #locations == 0 then
		locations = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local filterParam = {}

	filterParam.dmgs = dmgs
	filterParam.careers = careers
	filterParam.locations = locations

	CharacterModel.instance:filterCardListByDmgAndCareer(filterParam, false, CharacterEnum.FilterType.Survival)
	self:_refreshBtnIcon()
	self._groupModel:initHeroList()
end

function SurvivalInitHeroSelectView:_onAttributeChanged(level, heroId)
	CharacterModel.instance:setFakeLevel(heroId, level)
end

function SurvivalInitHeroSelectView:_refreshEditMode()
	gohelper.setActive(self._scrollquickedit, self._isShowQuickEdit)
	gohelper.setActive(self._scrollcard, not self._isShowQuickEdit)
	gohelper.setActive(self._goBtnEditQuickMode, self._isShowQuickEdit)
	gohelper.setActive(self._goBtnEditNormalMode, not self._isShowQuickEdit)
end

function SurvivalInitHeroSelectView:_refreshCurScrollBySort()
	self._groupModel:initHeroList()
end

function SurvivalInitHeroSelectView:_editableInitView()
	gohelper.setActive(self._gospecialitem, false)

	self._careerGOs = {}
	self._imgBg = gohelper.findChildSingleImage(self.viewGO, "bg/bgimg")
	self._simageredlight = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_redlight")

	self._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	self._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))

	self._lvBtns = self:getUserDataTb_()
	self._lvArrow = self:getUserDataTb_()
	self._rareBtns = self:getUserDataTb_()
	self._rareArrow = self:getUserDataTb_()
	self._classifyBtns = self:getUserDataTb_()
	self._selectDmgs = {}
	self._dmgSelects = self:getUserDataTb_()
	self._dmgUnselects = self:getUserDataTb_()
	self._dmgBtnClicks = self:getUserDataTb_()
	self._selectAttrs = {}
	self._attrSelects = self:getUserDataTb_()
	self._attrUnselects = self:getUserDataTb_()
	self._attrBtnClicks = self:getUserDataTb_()
	self._selectLocations = {}
	self._locationSelects = self:getUserDataTb_()
	self._locationUnselects = self:getUserDataTb_()
	self._locationBtnClicks = self:getUserDataTb_()
	self._curDmgs = {}
	self._curAttrs = {}
	self._curLocations = {}

	for i = 1, 2 do
		self._lvBtns[i] = gohelper.findChild(self._btnlvrank.gameObject, "btn" .. tostring(i))
		self._lvArrow[i] = gohelper.findChild(self._lvBtns[i], "txt/arrow").transform
		self._rareBtns[i] = gohelper.findChild(self._btnrarerank.gameObject, "btn" .. tostring(i))
		self._rareArrow[i] = gohelper.findChild(self._rareBtns[i], "txt/arrow").transform
		self._classifyBtns[i] = gohelper.findChild(self._btnclassify.gameObject, "btn" .. tostring(i))
		self._dmgUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/unselected")
		self._dmgSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/selected")
		self._dmgBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/click")

		self._dmgBtnClicks[i]:AddClickListener(self._dmgBtnOnClick, self, i)
	end

	for i = 1, 6 do
		self._attrUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/unselected")
		self._attrSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/selected")
		self._attrBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/click")

		self._attrBtnClicks[i]:AddClickListener(self._attrBtnOnClick, self, i)
	end

	for i = 1, 6 do
		self._locationUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/unselected")
		self._locationSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/selected")
		self._locationBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/click")

		self._locationBtnClicks[i]:AddClickListener(self._locationBtnOnClick, self, i)
	end

	self._goBtnEditQuickMode = gohelper.findChild(self._btnquickedit.gameObject, "btn2")
	self._goBtnEditNormalMode = gohelper.findChild(self._btnquickedit.gameObject, "btn1")
	self._attributevalues = {}

	for i = 1, 5 do
		local o = self:getUserDataTb_()

		o.value = gohelper.findChildText(self._goattribute, "attribute" .. tostring(i) .. "/txt_attribute")
		o.name = gohelper.findChildText(self._goattribute, "attribute" .. tostring(i) .. "/name")
		o.icon = gohelper.findChildImage(self._goattribute, "attribute" .. tostring(i) .. "/icon")
		self._attributevalues[i] = o
	end

	self._passiveskillitems = {}

	for i = 1, 3 do
		self._passiveskillitems[i] = self:_findPassiveskillitems(i)
	end

	self._passiveskillitems[0] = self:_findPassiveskillitems(4)
	self._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(self._goskill, CharacterSkillContainer)

	gohelper.setActive(self._gononecharacter, false)
	gohelper.setActive(self._gocharacterinfo, false)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function SurvivalInitHeroSelectView:_findPassiveskillitems(index)
	local o = self:getUserDataTb_()

	o.go = gohelper.findChild(self._gopassiveskills, "passiveskill" .. index)
	o.on = gohelper.findChild(o.go, "on")
	o.off = gohelper.findChild(o.go, "off")
	o.balance = gohelper.findChild(o.go, "balance")

	return o
end

function SurvivalInitHeroSelectView:getGroupModel()
	return SurvivalMapModel.instance:getInitGroup()
end

function SurvivalInitHeroSelectView:onOpen()
	self._groupModel = self:getGroupModel()
	self._isShowQuickEdit = false
	self._scrollcard.verticalNormalizedPosition = 1
	self._scrollquickedit.verticalNormalizedPosition = 1

	for i = 1, 2 do
		self._selectDmgs[i] = false
	end

	for i = 1, 6 do
		self._selectAttrs[i] = false
	end

	for i = 1, 6 do
		self._selectLocations[i] = false
	end

	self._heroMO = self._groupModel:getList()[self._groupModel.defaultIndex]

	self:_refreshEditMode()
	self:_refreshBtnIcon()
	self:_refreshCharacterInfo()
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, self._onHeroItemClick, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, self._refreshCharacterInfo, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshCharacterInfo, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshCharacterInfo, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshCharacterInfo, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshCharacterInfo, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, self._onAttributeChanged, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, self._showCharacterRankUpView, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, self._markFavorSuccess, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, self._refreshCharacterInfo, self)
	self:addEventCb(AudioMgr.instance, AudioMgr.Evt_Trigger, self._onAudioTrigger, self)
	gohelper.addUIClickAudio(self._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, self._initScrollContentPosY = transformhelper.getLocalPos(self._goScrollContent.transform)
end

function SurvivalInitHeroSelectView:onClose()
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, self._onHeroItemClick, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, self._refreshCharacterInfo, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshCharacterInfo, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshCharacterInfo, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshCharacterInfo, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshCharacterInfo, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, self._onAttributeChanged, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, self._showCharacterRankUpView, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, self._markFavorSuccess, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, self._refreshCharacterInfo, self)
	self:removeEventCb(AudioMgr.instance, AudioMgr.Evt_Trigger, self._onAudioTrigger, self)
	CharacterModel.instance:setFakeLevel()
	self._groupModel:clear()
	CommonHeroHelper.instance:resetGrayState()

	self._selectDmgs = {}
	self._selectAttrs = {}
	self._selectLocations = {}
end

function SurvivalInitHeroSelectView:_onAudioTrigger(audioId)
	return
end

function SurvivalInitHeroSelectView:_onOpenView(viewName)
	return
end

function SurvivalInitHeroSelectView:_markFavorSuccess()
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.Survival)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function SurvivalInitHeroSelectView:_onCloseView(viewName)
	return
end

function SurvivalInitHeroSelectView:_showCharacterRankUpView(func)
	func()
end

function SurvivalInitHeroSelectView:onDestroyView()
	self._imgBg:UnLoadImage()
	self._simageredlight:UnLoadImage()

	self._imgBg = nil
	self._simageredlight = nil

	for i = 1, 2 do
		self._dmgBtnClicks[i]:RemoveClickListener()
	end

	for i = 1, 6 do
		self._attrBtnClicks[i]:RemoveClickListener()
	end

	for i = 1, 6 do
		self._locationBtnClicks[i]:RemoveClickListener()
	end
end

return SurvivalInitHeroSelectView

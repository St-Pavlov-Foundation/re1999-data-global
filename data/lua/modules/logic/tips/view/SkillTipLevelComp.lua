-- chunkname: @modules/logic/tips/view/SkillTipLevelComp.lua

module("modules.logic.tips.view.SkillTipLevelComp", package.seeall)

local SkillTipLevelComp = class("SkillTipLevelComp", LuaCompBase)

function SkillTipLevelComp:ctor(viewComp)
	self.viewComp = viewComp
end

function SkillTipLevelComp:init(go)
	self._gonewskilltip = go
	self._scrollSkilltip = gohelper.findChildScrollRect(go, "skilltipScrollview")
	self._goContentSkilltip = gohelper.findChild(go, "skilltipScrollview/Viewport/Content")
	self._gospecialitem = gohelper.findChild(self._goContentSkilltip, "name/special/#go_specialitem")
	self._goline = gohelper.findChild(self._goContentSkilltip, "#go_line")
	self._goskillspecial = gohelper.findChild(self._goContentSkilltip, "skillspecial")
	self._goskillspecialitem = gohelper.findChild(self._goContentSkilltip, "skillspecial/#go_skillspecialitem")
	self._goarrow = gohelper.findChild(go, "bottombg/#go_arrow")
	self._gostoryDesc = gohelper.findChild(self._goContentSkilltip, "#go_storyDesc")
	self._txtstory = gohelper.findChildText(self._goContentSkilltip, "#go_storyDesc/#txt_story")
	self._btnupgradeShow = gohelper.findChildButtonWithAudio(go, "#btn_upgradeShow")
	self._goBtnNormal = gohelper.findChild(self._btnupgradeShow.gameObject, "#go_normal")
	self._goBtnUpgraded = gohelper.findChild(self._btnupgradeShow.gameObject, "#go_upgraded")
	self._goshowSelect = gohelper.findChild(go, "#go_showSelect")
	self._btnsupplement = gohelper.findChildButtonWithAudio(go, "#btn_supplement")
	self._goBtnsupplementNormal = gohelper.findChild(self._btnsupplement.gameObject, "#go_normal")
	self._goBtnsupplement = gohelper.findChild(self._btnsupplement.gameObject, "#go_supplement")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SkillTipLevelComp:addEventListeners()
	self._btnupgradeShow:AddClickListener(self._btnUpgradeShowOnClick, self)
	self._btnsupplement:AddClickListener(self._btnSupplementOnClick, self)
end

function SkillTipLevelComp:removeEventListeners()
	self._btnupgradeShow:RemoveClickListener()
	self._btnsupplement:RemoveClickListener()
end

SkillTipLevelComp.skillTypeColor = {
	"#405874",
	"#8c4e31",
	"#9b7039"
}

function SkillTipLevelComp:_refreshArrow()
	local goTipHeight = recthelper.getHeight(self._goContentSkilltip.transform)
	local scrollTipHeight = recthelper.getHeight(self._scrollSkilltip.transform)

	if scrollTipHeight < goTipHeight and self._scrollSkilltip.verticalNormalizedPosition > 0.01 then
		gohelper.setActive(self._goarrow, true)
	else
		gohelper.setActive(self._goarrow, false)
	end
end

function SkillTipLevelComp:_editableInitView()
	self._scrollSkilltip:AddOnValueChanged(self._refreshArrow, self)

	self._newskillitems = {}

	for i = 1, 3 do
		local item = gohelper.findChild(self._gonewskilltip, "normal/skillicon" .. tostring(i))
		local o = self:getUserDataTb_()

		o.go = item
		o.icon = gohelper.findChildSingleImage(item, "imgIcon")
		o.btn = gohelper.findChildButtonWithAudio(item, "bg")
		o.selectframe = gohelper.findChild(item, "selectframe")
		o.selectarrow = gohelper.findChild(item, "selectarrow")
		o.aggrandizement = gohelper.findChild(item, "aggrandizement")
		o.index = i

		o.btn:AddClickListener(self._skillItemClick, self, o.index)

		o.tag = gohelper.findChildSingleImage(item, "tag/tagIcon")
		self._newskillitems[i] = o
	end

	self._newsuperskill = self:getUserDataTb_()

	local superskillitem = gohelper.findChild(self._gonewskilltip, "super")

	self._newsuperskill.icon = gohelper.findChildSingleImage(superskillitem, "imgIcon")
	self._newsuperskill.tag = gohelper.findChildSingleImage(superskillitem, "tag/tagIcon")
	self._newsuperskill.aggrandizement = gohelper.findChild(superskillitem, "aggrandizement")
	self._newskilltips = self:getUserDataTb_()
	self._newskilltips[1] = gohelper.findChild(self._gonewskilltip, "normal")
	self._newskilltips[2] = gohelper.findChild(self._gonewskilltip, "super")
	self._newskillname = gohelper.findChildText(self._goContentSkilltip, "name")
	self._newskilldesc = gohelper.findChildText(self._goContentSkilltip, "desc")
	self._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self._newskilldesc.gameObject, FixTmpBreakLine)

	SkillHelper.addHyperLinkClick(self._newskilldesc, self._onHyperLinkClick, self)

	self._skillTagGOs = self:getUserDataTb_()
	self._skillEffectGOs = self:getUserDataTb_()

	gohelper.setActive(self._gospecialitem, false)
	gohelper.setActive(self._goskillspecialitem, false)
	gohelper.setActive(self._btnsupplement.gameObject, false)

	self._goarrow1 = gohelper.findChild(self._gonewskilltip, "normal/arrow1")
	self._goarrow2 = gohelper.findChild(self._gonewskilltip, "normal/arrow2")
	self._upgradeSelectShow = false
	self._canShowUpgradeBtn = true
	self._canShowUpgradeBtn = true
	self._supplement = false

	self:_refreshSupplementUI()
end

function SkillTipLevelComp:_skillItemClick(level)
	if level == self._curSkillLevel then
		return
	end

	if self.viewComp then
		self.viewComp:onClickSkillItem(level)
	else
		self:_refreshSkill(level)
	end
end

function SkillTipLevelComp:_setNewSkills(skillIdList, super, isCharacter)
	self._curSkillLevel = self._curSkillLevel or nil
	skillIdList = self:_checkReplaceSkill(skillIdList)

	if self._upgradeSelectShow then
		self.hasBreakLevelSkill, self.upgradeSkillIdList = SkillConfig.instance:getHeroUpgradeSkill(skillIdList)
		skillIdList = self.upgradeSkillIdList
	end

	self._skillIdList = skillIdList
	self._super = super

	gohelper.setActive(self._newskilltips[1], not super)
	gohelper.setActive(self._newskilltips[2], super)

	if not super then
		local count = #skillIdList

		for i = 1, count do
			local skillConfig = lua_skill.configDict[skillIdList[i]]

			if skillConfig then
				self._newskillitems[i].icon:LoadImage(ResUrl.getSkillIcon(skillConfig.icon))
				self._newskillitems[i].tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillConfig.showTag))
			else
				logError("找不到技能: " .. skillIdList[i])
			end

			gohelper.setActive(self._newskillitems[i].selectframe, false)
			gohelper.setActive(self._newskillitems[i].selectarrow, false)
			gohelper.setActive(self._newskillitems[i].go, true)
			gohelper.setActive(self._newskillitems[i].aggrandizement, self._upgradeSelectShow)
		end

		for i = count + 1, 3 do
			gohelper.setActive(self._newskillitems[i].go, false)
		end

		gohelper.setActive(self._goarrow1, count > 1)
		gohelper.setActive(self._goarrow2, count > 2)
		self:_refreshSkill(self._curSkillLevel or 1)
	else
		local skillConfig = lua_skill.configDict[skillIdList[1]]

		if skillConfig then
			self._newsuperskill.icon:LoadImage(ResUrl.getSkillIcon(skillConfig.icon))
			self._newsuperskill.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillConfig.showTag))

			self._newskillname.text = skillConfig.name

			local desc = SkillHelper.getSkillDesc(self.monsterName, skillConfig)

			self._newskilldesc.text = desc

			self._fixTmpBreakLine:refreshTmpContent(self._newskilldesc)
			gohelper.setActive(self._newsuperskill.aggrandizement, self._upgradeSelectShow)
			gohelper.setActive(self._gostoryDesc, not string.nilorempty(skillConfig.desc_art))

			self._txtstory.text = skillConfig.desc_art
			self._scrollSkilltip.verticalNormalizedPosition = 1

			self:_refreshSkillSpecial(skillConfig)
		else
			logError("找不到技能: " .. tostring(skillIdList[1]))
		end
	end

	gohelper.setActive(self._gonewskilltip, true)
end

function SkillTipLevelComp:_checkReplaceSkill(skillIdList)
	if skillIdList then
		local heroMo = self.viewParam and self.viewParam.heroMo

		if heroMo then
			skillIdList = heroMo:checkReplaceSkill(skillIdList)
		end
	end

	return skillIdList
end

function SkillTipLevelComp:_refreshSkill(level)
	if not self._skillIdList[level] then
		level = 1
	end

	self._curSkillLevel = level

	for i = 1, 3 do
		gohelper.setActive(self._newskillitems[i].selectframe, i == level)
		gohelper.setActive(self._newskillitems[i].selectarrow, i == level)
	end

	local skillConfig = lua_skill.configDict[tonumber(self._skillIdList[level])]

	if skillConfig then
		self._newskillname.text = skillConfig.name
		self._newskilldesc.text = SkillHelper.getSkillDesc(self.monsterName, skillConfig)

		self._fixTmpBreakLine:refreshTmpContent(self._newskilldesc)
		gohelper.setActive(self._gostoryDesc, not string.nilorempty(skillConfig.desc_art))

		self._txtstory.text = skillConfig.desc_art
		self._scrollSkilltip.verticalNormalizedPosition = 1

		self:_refreshSkillSpecial(skillConfig)
	else
		logError("找不到技能: " .. tostring(self._skillIdList[level]))
		gohelper.setActive(self._btnsupplement.gameObject, false)
	end
end

function SkillTipLevelComp:_refreshSkillSpecial(skillConfig)
	local skillTags = {}

	if skillConfig.battleTag and skillConfig.battleTag ~= "" then
		skillTags = string.split(skillConfig.battleTag, "#")

		for i = 1, #skillTags do
			local skillTagGO = self._skillTagGOs[i]

			if not skillTagGO then
				skillTagGO = gohelper.cloneInPlace(self._gospecialitem, "item" .. i)

				table.insert(self._skillTagGOs, skillTagGO)
			end

			local name = gohelper.findChildText(skillTagGO, "name")
			local tagConfig = HeroConfig.instance:getBattleTagConfigCO(skillTags[i])

			if tagConfig then
				name.text = tagConfig.tagName
			else
				logError("找不到技能BattleTag: " .. tostring(skillTags[i]))
			end

			gohelper.setActive(skillTagGO, true)
		end
	end

	for i = #skillTags + 1, #self._skillTagGOs do
		gohelper.setActive(self._skillTagGOs[i], false)
	end

	gohelper.setActive(self._goline, false)

	local desc = FightConfig.instance:getSkillEffectDesc(self.monsterName, skillConfig)
	local skillEffects = HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(desc)

	for i = #skillEffects, 1, -1 do
		local skillEffectId = tonumber(skillEffects[i])
		local skillEffectConfig = SkillConfig.instance:getSkillEffectDescCo(skillEffectId)

		if skillEffectConfig then
			if not SkillHelper.canShowTag(skillEffectConfig) then
				table.remove(skillEffects, i)
			end
		else
			logError("找不到技能eff_desc: " .. tostring(skillEffectId))
		end
	end

	local index = 1

	for i = 1, #skillEffects do
		local skillEffectId = tonumber(skillEffects[i])
		local skillEffectConfig = SkillConfig.instance:getSkillEffectDescCo(skillEffectId)

		if skillEffectConfig.isSpecialCharacter == 1 then
			gohelper.setActive(self._goline, true)

			local skillEffectGO = self._skillEffectGOs[index]

			if not skillEffectGO then
				skillEffectGO = gohelper.cloneInPlace(self._goskillspecialitem, "item" .. index)

				table.insert(self._skillEffectGOs, skillEffectGO)
			end

			local nameBg = gohelper.findChildImage(skillEffectGO, "titlebg/bg")
			local name = gohelper.findChildText(skillEffectGO, "titlebg/bg/name")
			local desc = gohelper.findChildText(skillEffectGO, "desc")

			SkillHelper.addHyperLinkClick(desc, self._onHyperLinkClick, self)

			local descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(desc.gameObject, FixTmpBreakLine)

			if skillEffectConfig then
				SLFramework.UGUI.GuiHelper.SetColor(nameBg:GetComponent("Image"), SkillTipLevelComp.skillTypeColor[skillEffectConfig.color])

				name.text = SkillHelper.removeRichTag(skillEffectConfig.name)
				desc.text = SkillHelper.getSkillDesc(self.monsterName, skillEffectConfig)

				descFixTmpBreakLine:refreshTmpContent(desc)
			else
				logError("找不到技能eff_desc: " .. tostring(skillEffectId))
			end

			gohelper.setActive(skillEffectGO, true)

			index = index + 1
		end
	end

	for i = index, #self._skillEffectGOs do
		gohelper.setActive(self._skillEffectGOs[i], false)
	end

	self:_refreshArrow()
	self:_refreshSupplement(skillConfig.id)
end

function SkillTipLevelComp:_onHyperLinkClick(effId, clickPosition)
	if self.viewParam and self.viewParam.adjustBuffTip then
		CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(tonumber(effId), self.setTipPosCallback, self)
	else
		CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(effId), CommonBuffTipEnum.Anchor[self.viewName], CommonBuffTipEnum.Pivot.Right, nil, 1)
	end
end

function SkillTipLevelComp:setTipPosCallback(rectTrTipViewGo, rectTrScrollTip)
	local space = 10
	local skillTipTrans = self._gonewskilltip.transform
	local screenPosX, screenPosY = recthelper.uiPosToScreenPos2(skillTipTrans)
	local localPosX, localPosY = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(screenPosX, screenPosY, rectTrTipViewGo, CameraMgr.instance:getUICamera(), nil, nil)
	local halfSkillTipWidth = recthelper.getWidth(skillTipTrans) / 2
	local halfViewW = GameUtil.getViewSize() / 2
	local leftRemainWidth = halfViewW + localPosX - halfSkillTipWidth - space
	local scrollTipWidth = recthelper.getWidth(rectTrScrollTip)
	local showInLeft = scrollTipWidth <= leftRemainWidth
	local anchorX = localPosX

	if showInLeft then
		anchorX = anchorX - halfSkillTipWidth - space
	else
		anchorX = anchorX + halfSkillTipWidth + space + scrollTipWidth
	end

	local skillTipHeight = recthelper.getHeight(skillTipTrans)
	local anchorY = localPosY + skillTipHeight / 2

	rectTrScrollTip.pivot = CommonBuffTipEnum.Pivot.Right

	recthelper.setAnchor(rectTrScrollTip, anchorX, anchorY)
end

function SkillTipLevelComp:initInfo(param)
	self.viewParam = param
	self.srcSkillIdList = param.skillIdList
	self.isSuper = param.super
	self.viewName = param.viewName

	self:updateMonsterName()

	self.srcSkillIdList = param.skillIdList
	self.isSuper = param.super
	self.isCharacter = true
	self.entityMo = FightDataHelper.entityMgr:getById(param.entityId)
	self.entitySkillIndex = param.entitySkillIndex
	self._supplement = false

	self:refreshUpgradeBtn(self.isCharacter)
	self:_setNewSkills(self.srcSkillIdList, self.isSuper, self.isCharacter)
end

function SkillTipLevelComp:updateMonsterName()
	self.monsterName = self.viewParam.monsterName

	if string.nilorempty(self.monsterName) then
		logError("SkillTipLevelComp 缺少 monsterName 参数")

		self.monsterName = ""
	end
end

function SkillTipLevelComp:refreshUpgradeBtn(isCharacter)
	if not self._canShowUpgradeBtn then
		gohelper.setActive(self._btnupgradeShow.gameObject, false)

		return
	end

	if self.viewName ~= ViewName.FightFocusView then
		self:refreshHeroUpgrade()
	else
		self:refreshEntityUpgrade(isCharacter)
	end
end

function SkillTipLevelComp:refreshHeroUpgrade()
	local heroMO = self.viewParam.heroMo
	local skillIndex = self.viewParam.skillIndex
	local exSkillLevel = heroMO and heroMO.exSkillLevel or 0

	self.hasBreakLevelSkill, self.upgradeSkillIdList = SkillConfig.instance:getHeroUpgradeSkill(self.srcSkillIdList)

	self:refreshUpgradeUI()
end

function SkillTipLevelComp:refreshEntityUpgrade(isCharacter)
	if not isCharacter then
		self:refreshUpgradeUI()

		return
	end

	local heroCo = self.entityMo and self.entityMo:getCO()
	local heroId = heroCo and heroCo.id

	if not heroId then
		gohelper.setActive(self._btnupgradeShow.gameObject, false)

		return
	end

	self.hasBreakLevelSkill, self.upgradeSkillIdList = SkillConfig.instance:getHeroUpgradeSkill(self.srcSkillIdList)

	if self.upgradeSkillIdList and self.srcSkillIdList[1] == self.upgradeSkillIdList[1] then
		self.upgraded = true
	else
		self.upgraded = false
	end

	self:refreshUpgradeUI()
end

function SkillTipLevelComp:_btnUpgradeShowOnClick()
	self._upgradeSelectShow = not self._upgradeSelectShow

	self:refreshUpgradeUI()
	self:_setNewSkills(self.srcSkillIdList, self.isSuper, self.isCharacter)
end

function SkillTipLevelComp:refreshUpgradeUI()
	local showBtn = not self.upgraded and self.hasBreakLevelSkill
	local showSelect = self.upgraded or self._upgradeSelectShow

	gohelper.setActive(self._btnupgradeShow, showBtn)
	gohelper.setActive(self._goshowSelect, showSelect)
	gohelper.setActive(self._goBtnUpgraded, self._upgradeSelectShow)
	gohelper.setActive(self._goBtnNormal, not self._upgradeSelectShow)
end

function SkillTipLevelComp:setUpgradebtnShowState(state)
	self._canShowUpgradeBtn = state
end

function SkillTipLevelComp:_btnSupplementOnClick()
	self._supplement = not self._supplement

	self:_refreshSupplementUI()
end

function SkillTipLevelComp:_refreshSupplement(id)
	local footnoteCo = SkillConfig.instance:getFightCardFootnoteConfig(id)

	if not self._footnoteItem then
		self._footnoteItem = self:getUserDataTb_()

		local go = gohelper.findChild(self._goskillspecial, "footnoteItem")

		go = go or gohelper.cloneInPlace(self._goskillspecialitem, "footnoteItem")
		self._footnoteItem.go = go
		self._footnoteItem.gonameBg = gohelper.findChild(go, "titlebg")
		self._footnoteItem.desc = gohelper.findChildText(go, "desc")
	end

	gohelper.setActive(self._footnoteItem.gonameBg.gameObject, false)

	if footnoteCo then
		self._footnoteItem.desc.text = footnoteCo.desc
	else
		self._supplement = false
	end

	gohelper.setActive(self._btnsupplement.gameObject, footnoteCo ~= nil)
	self:_refreshSupplementUI()
end

function SkillTipLevelComp:_refreshSupplementUI()
	gohelper.setActive(self._goBtnsupplementNormal, not self._supplement)
	gohelper.setActive(self._goBtnsupplement, self._supplement)
	gohelper.setActive(self._goline.gameObject, self._supplement)

	if self._footnoteItem then
		gohelper.setActive(self._footnoteItem.go, self._supplement)
	end
end

function SkillTipLevelComp:onDestroyView()
	self._scrollSkilltip:RemoveOnValueChanged()

	if self._newskillitems then
		for k, v in pairs(self._newskillitems) do
			v.icon:UnLoadImage()
			v.btn:RemoveClickListener()
		end
	end
end

function SkillTipLevelComp:SetParent(parentGo)
	self._gonewskilltip.transform:SetParent(parentGo.transform)
end

function SkillTipLevelComp:hideInfo()
	gohelper.setActive(self._gonewskilltip, false)
end

return SkillTipLevelComp

-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8ShowSkillEffectTip.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8ShowSkillEffectTip", package.seeall)

local Season123_1_8ShowSkillEffectTip = class("Season123_1_8ShowSkillEffectTip", LuaCompBase)

function Season123_1_8ShowSkillEffectTip:init(go)
	self._goBuffContainer = go
	self._btnclosebuff = gohelper.findChildButtonWithAudio(self._goBuffContainer, "buff_bg")
	self._goBuffContent = gohelper.findChild(self._goBuffContainer, "#go_buffContent")
	self._goBuffItem = gohelper.findChild(self._goBuffContainer, "#go_buffContent/#go_buffitem")
	self._buffTab = self:getUserDataTb_()

	self._btnclosebuff:AddClickListener(self._btnclosebuffOnClick, self)
	gohelper.setActive(self._goBuffContainer, false)
	gohelper.setActive(self._goBuffItem, false)
end

function Season123_1_8ShowSkillEffectTip:_btnclosebuffOnClick()
	gohelper.setActive(self._goBuffContainer, false)

	for id, item in pairs(self._buffTab) do
		self._buffTab[id] = nil

		gohelper.destroy(item.go)
	end
end

function Season123_1_8ShowSkillEffectTip:addLink(desc)
	if string.nilorempty(desc) then
		return ""
	end

	desc = string.gsub(desc, "%[(.-)%]", Season123_1_8ShowSkillEffectTip.addLinkTag1)
	desc = string.gsub(desc, "%【(.-)%】", Season123_1_8ShowSkillEffectTip.addLinkTag2)

	return desc
end

function Season123_1_8ShowSkillEffectTip.addLinkTag1(skillEffectName)
	skillEffectName = SkillConfig.instance:processSkillDesKeyWords(skillEffectName)

	local effectCo = SkillConfig.instance:getSkillEffectDescCoByName(skillEffectName)

	if not effectCo or effectCo.isNoShow4ActiveSkill == 1 or effectCo.isSpecialCharacter == 1 then
		return string.format("[%s]", skillEffectName)
	end

	return string.format("<u><link=%s>[%s]</link></u>", effectCo.id, skillEffectName)
end

function Season123_1_8ShowSkillEffectTip.addLinkTag2(skillEffectName)
	skillEffectName = SkillConfig.instance:processSkillDesKeyWords(skillEffectName)

	local effectCo = SkillConfig.instance:getSkillEffectDescCoByName(skillEffectName)

	if not effectCo or effectCo.isNoShow4ActiveSkill == 1 or effectCo.isSpecialCharacter == 1 then
		return string.format("【%s】", skillEffectName)
	end

	return string.format("<u><link=%s>【%s】</link></u>", effectCo.id, skillEffectName)
end

function Season123_1_8ShowSkillEffectTip:addHyperLinkClick(txtDesc)
	local hyperLinkClick = gohelper.onceAddComponent(txtDesc, typeof(ZProj.TMPHyperLinkClick))

	hyperLinkClick:SetClickListener(self.onHyperLinkClick, self)
end

function Season123_1_8ShowSkillEffectTip:onHyperLinkClick(id, clickPosition)
	local effectId = tonumber(id)

	self:createAndGetBufferItem(effectId)

	local reallyClickPosition = recthelper.screenPosToAnchorPos(clickPosition, self._goBuffContainer.transform)
	local y = reallyClickPosition.y

	gohelper.setActive(self._goBuffContainer, true)
	recthelper.setAnchorY(self._goBuffContent.transform, y)
end

function Season123_1_8ShowSkillEffectTip:createAndGetBufferItem(effectId)
	local buffItem = self._buffTab[effectId]

	if not buffItem then
		buffItem = {
			go = gohelper.clone(self._goBuffItem, self._goBuffContent, "go_buffitem" .. effectId)
		}
		buffItem.txtBuffName = gohelper.findChildText(buffItem.go, "title/txt_name")
		buffItem.goBuffTag = gohelper.findChild(buffItem.go, "title/txt_name/go_tag")
		buffItem.txtBuffTagName = gohelper.findChildText(buffItem.go, "title/txt_name/go_tag/bg/txt_tagname")
		buffItem.txtBuffDesc = gohelper.findChildText(buffItem.go, "txt_desc")
		buffItem.config = SkillConfig.instance:getSkillEffectDescCo(effectId)
		self._buffTab[effectId] = buffItem
	end

	gohelper.setActive(buffItem.go, true)

	local buffName = buffItem.config.name

	buffItem.txtBuffName.text = SkillConfig.instance:processSkillDesKeyWords(buffName)

	local buffTagName = FightConfig.instance:getBuffTag(buffName)

	gohelper.setActive(buffItem.goBuffTag, not string.nilorempty(buffTagName))

	buffItem.txtBuffTagName.text = buffTagName
	buffItem.txtBuffDesc.text = self:addLink(HeroSkillModel.instance:skillDesToSpot(buffItem.config.desc))

	self:addChildHyperLinkClick(buffItem.txtBuffDesc, true)
end

function Season123_1_8ShowSkillEffectTip:addChildHyperLinkClick(txtDesc)
	local hyperLinkClick = gohelper.onceAddComponent(txtDesc, typeof(ZProj.TMPHyperLinkClick))

	hyperLinkClick:SetClickListener(self.onChildHyperLinkClick, self)
end

function Season123_1_8ShowSkillEffectTip:onChildHyperLinkClick(id, clickPosition)
	local effectId = tonumber(id)

	self:createAndGetBufferItem(effectId)
end

function Season123_1_8ShowSkillEffectTip:onDestroy()
	self._btnclosebuff:RemoveClickListener()
end

return Season123_1_8ShowSkillEffectTip

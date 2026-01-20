-- chunkname: @modules/logic/versionactivity2_7/towergift/view/DestinyStoneGiftPickChoiceListHeroItem.lua

module("modules.logic.versionactivity2_7.towergift.view.DestinyStoneGiftPickChoiceListHeroItem", package.seeall)

local DestinyStoneGiftPickChoiceListHeroItem = class("DestinyStoneGiftPickChoiceListHeroItem", LuaCompBase)
local exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function DestinyStoneGiftPickChoiceListHeroItem:init(go)
	self._go = go
	self._imagerare = gohelper.findChildImage(self._go, "rare")
	self._simageicon = gohelper.findChildSingleImage(self._go, "heroicon")
	self._imagecareer = gohelper.findChildImage(self._go, "career")
	self._txtname = gohelper.findChildText(self._go, "name")
	self._goexskill = gohelper.findChild(go, "#go_exskill")
	self._imageexskill = gohelper.findChildImage(go, "#go_exskill/#image_exskill")
	self._goRankBg = gohelper.findChild(go, "Rank")
	self._goranks = self:getUserDataTb_()

	for i = 1, 3 do
		self._goranks[i] = gohelper.findChild(go, "Rank/rank" .. i)
	end

	self:addEvents()
end

function DestinyStoneGiftPickChoiceListHeroItem:addEvents()
	return
end

function DestinyStoneGiftPickChoiceListHeroItem:removeEvents()
	return
end

function DestinyStoneGiftPickChoiceListHeroItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function DestinyStoneGiftPickChoiceListHeroItem:setLock()
	self._btnClick:RemoveClickListener()
end

function DestinyStoneGiftPickChoiceListHeroItem:refreshUI()
	local heroCo = HeroConfig.instance:getHeroCO(self._mo.id)

	if not heroCo then
		logError("DestinyStoneGiftPickChoiceListHeroItem.onUpdateMO error, heroConfig is nil, id:" .. tostring(self._mo.id))

		return
	end

	self:refreshBaseInfo(heroCo)
	self:refreshExSkill()
end

function DestinyStoneGiftPickChoiceListHeroItem:refreshBaseInfo(heroCo)
	local skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)

	if not skinConfig then
		logError("DestinyStoneGiftPickChoiceListHeroItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(heroCo.skinId))

		return
	end

	self._simageicon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. heroCo.career)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. tostring(CharacterEnum.Color[heroCo.rare]))

	self._txtname.text = heroCo.name

	local rank = self._mo.rank
	local rankIconIndex = rank - 1
	local isShowRanIcon = false

	for i = 1, 3 do
		local isCurRanIcon = i == rankIconIndex

		gohelper.setActive(self._goranks[i], isCurRanIcon)

		isShowRanIcon = isShowRanIcon or isCurRanIcon
	end

	gohelper.setActive(self._goRankBg, isShowRanIcon)
end

function DestinyStoneGiftPickChoiceListHeroItem:refreshExSkill()
	if not self._mo:hasHero() or self._mo:getSkillLevel() <= 0 then
		gohelper.setActive(self._goexskill, false)

		return
	end

	gohelper.setActive(self._goexskill, true)

	self._imageexskill.fillAmount = exSkillFillAmount[self._mo:getSkillLevel()] or 1
end

function DestinyStoneGiftPickChoiceListHeroItem:onDestroy()
	if not self._isDisposed then
		self._simageicon:UnLoadImage()
		self:removeEvents()

		self._isDisposed = true
	end
end

return DestinyStoneGiftPickChoiceListHeroItem

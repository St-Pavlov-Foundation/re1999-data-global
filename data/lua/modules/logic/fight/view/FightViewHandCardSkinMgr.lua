-- chunkname: @modules/logic/fight/view/FightViewHandCardSkinMgr.lua

module("modules.logic.fight.view.FightViewHandCardSkinMgr", package.seeall)

local FightViewHandCardSkinMgr = class("FightViewHandCardSkinMgr", FightBaseClass)

function FightViewHandCardSkinMgr:onConstructor()
	self.cardSkin = FightCardDataHelper.getCardSkin()

	if self.cardSkin == 672802 then
		self:newClass(FightViewHandCardSkin672802)
	end
end

function FightViewHandCardSkinMgr:onDestructor()
	return
end

return FightViewHandCardSkinMgr

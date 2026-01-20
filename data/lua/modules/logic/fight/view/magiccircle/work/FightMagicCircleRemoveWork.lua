-- chunkname: @modules/logic/fight/view/magiccircle/work/FightMagicCircleRemoveWork.lua

module("modules.logic.fight.view.magiccircle.work.FightMagicCircleRemoveWork", package.seeall)

local FightMagicCircleRemoveWork = class("FightMagicCircleRemoveWork", BaseWork)

function FightMagicCircleRemoveWork:ctor(magicItem)
	self.magicItem = magicItem
end

function FightMagicCircleRemoveWork:onStart()
	if self.magicItem then
		self.magicItem:playAnim("close", self.onCloseAnimDone, self)
	else
		self:onCloseAnimDone()
	end
end

function FightMagicCircleRemoveWork:onCloseAnimDone()
	if self.magicItem then
		self.magicItem:onRemoveMagic()
	end

	self:onDone(true)
end

function FightMagicCircleRemoveWork:onDestroy()
	if self.magicItem then
		self.magicItem:onRemoveMagic()
	end

	self.magicItem = nil
end

return FightMagicCircleRemoveWork

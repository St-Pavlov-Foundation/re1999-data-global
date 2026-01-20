-- chunkname: @modules/logic/dungeon/view/DungeonChapterMiniItem.lua

module("modules.logic.dungeon.view.DungeonChapterMiniItem", package.seeall)

local DungeonChapterMiniItem = class("DungeonChapterMiniItem", DungeonChapterItem)

function DungeonChapterMiniItem:_setLockStatus(isLock)
	DungeonChapterMiniItem.super._setLockStatus(self, isLock)

	if not self._goSpecial then
		self._goSpecial = gohelper.findChild(self.viewGO, "anim/image_Special")
	end

	if not isLock then
		local specialTxt = luaLang(DungeonEnum.SpecialMainPlot[self._mo.id])

		if not self._txtSpecial then
			self._txtSpecial = gohelper.findChildTextMesh(self.viewGO, "anim/image_Special/txt_Special")
		end

		self._txtSpecial.text = specialTxt
	end

	gohelper.setActive(self._goSpecial, not isLock)
end

function DungeonChapterMiniItem:_getInAnimName()
	return "dungeonchapterminiitem_in"
end

function DungeonChapterMiniItem:_getUnlockAnimName()
	return "dungeonchapterminiitem_unlock"
end

function DungeonChapterMiniItem:_getIdleAnimName()
	return "dungeonchapterminiitem_idle"
end

function DungeonChapterMiniItem:_getCloseAnimName()
	return "dungeonchapterminiitem_close"
end

return DungeonChapterMiniItem

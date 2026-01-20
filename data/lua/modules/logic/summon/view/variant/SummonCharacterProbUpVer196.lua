-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer196.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer196", package.seeall)

local SummonCharacterProbUpVer196 = class("SummonCharacterProbUpVer196", SummonMainCharacterProbUp)

SummonCharacterProbUpVer196.preloadList = {
	"singlebg/summon/heroversion_1_3/rabbit/full/v1a5_rabbit_newplayerbg.png"
}

function SummonCharacterProbUpVer196:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._g = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/bg")
	self._rrow = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/arrow/arrow")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer196.super._editableInitView(self)
end

function SummonCharacterProbUpVer196:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer196:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._g:UnLoadImage()
	self._rrow:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer196

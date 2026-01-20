-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer209.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer209", package.seeall)

local SummonCharacterProbUpVer209 = class("SummonCharacterProbUpVer209", SummonMainCharacterProbUp)

SummonCharacterProbUpVer209.preloadList = {
	"singlebg/summon/heroversion_newplayer/rabbit/rabbit_newplayerbg.png"
}

function SummonCharacterProbUpVer209:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer209.super._editableInitView(self)
end

function SummonCharacterProbUpVer209:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer209:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer209

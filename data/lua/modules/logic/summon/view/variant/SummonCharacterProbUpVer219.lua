-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer219.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer219", package.seeall)

local SummonCharacterProbUpVer219 = class("SummonCharacterProbUpVer219", SummonMainCharacterProbUp)

SummonCharacterProbUpVer219.preloadList = {
	"singlebg/summon/heroversion_newplayer/sufubi/sufubi_newplayer_fullbg.png",
	"singlebg/summon/heroversion_newplayer/sufubi/sufubi_newplayer_role.png"
}

function SummonCharacterProbUpVer219:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad3")
	self._simagead3dec = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad3dec")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer219.super._editableInitView(self)
end

function SummonCharacterProbUpVer219:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer219:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead3:UnLoadImage()
	self._simagead3dec:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer219

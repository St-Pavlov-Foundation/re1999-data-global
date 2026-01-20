-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer176.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer176", package.seeall)

local SummonCharacterProbUpVer176 = class("SummonCharacterProbUpVer176", SummonMainCharacterProbUp)

SummonCharacterProbUpVer176.preloadList = {
	"singlebg/summon/heroversion_1_7/sufubi/v1a7_sufubi_fullbg.png",
	"singlebg/summon/heroversion_1_7/sufubi/v1a7_sufubi_role1.png"
}

function SummonCharacterProbUpVer176:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad3")
	self._simagead3dec = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad3dec")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer176.super._editableInitView(self)
end

function SummonCharacterProbUpVer176:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer176:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead3:UnLoadImage()
	self._simagead3dec:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer176

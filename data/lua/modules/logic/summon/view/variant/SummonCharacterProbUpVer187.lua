-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer187.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer187", package.seeall)

local SummonCharacterProbUpVer187 = class("SummonCharacterProbUpVer187", SummonMainCharacterProbUp)

SummonCharacterProbUpVer187.preloadList = {
	"singlebg/summon/heroversion_1_1/full/bg_fjs.png"
}

function SummonCharacterProbUpVer187:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_ad3")
	self._simagead2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_ad2")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer187.super._editableInitView(self)
end

function SummonCharacterProbUpVer187:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer187:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead3:UnLoadImage()
	self._simagead2:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer187

-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer227.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer227", package.seeall)

local SummonCharacterProbUpVer227 = class("SummonCharacterProbUpVer227", SummonMainCharacterProbUp)

SummonCharacterProbUpVer227.preloadList = {
	"singlebg/summon/heroversion_1_2/jiaxika/full/bg.png",
	"singlebg/summon/heroversion_1_2/jiaxika/img_juese1.png",
	"singlebg/summon/heroversion_1_2/jiaxika/full/img_qianjing.png"
}

function SummonCharacterProbUpVer227:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._simagefrontbg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_frontbg")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/image_deadline/#txt_deadline/#simage_line")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/current/image_deadline/#txt_deadline")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer227.super._editableInitView(self)
end

function SummonCharacterProbUpVer227:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer227:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagefrontbg:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer227

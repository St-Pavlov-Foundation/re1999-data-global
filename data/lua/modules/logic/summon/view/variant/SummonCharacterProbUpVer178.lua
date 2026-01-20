-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer178.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer178", package.seeall)

local SummonCharacterProbUpVer178 = class("SummonCharacterProbUpVer178", SummonMainCharacterProbUp)

SummonCharacterProbUpVer178.preloadList = {
	"singlebg/summon/heroversion_1_1/full/bg_hnj.png",
	"singlebg/summon/heroversion_1_1/hongnujian/img_role_hongnujian.png"
}

function SummonCharacterProbUpVer178:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._mgcirbg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/img_cirbg")
	self._simagead2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_ad2")
	self._simagead3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_ad3")
	self._mgcirbgoutline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/img_cirbgoutline")
	self._ip = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip")
	self._g = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/bg")
	self._rrow = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/tip/arrow/arrow")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer178.super._editableInitView(self)
end

function SummonCharacterProbUpVer178:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer178:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._mgcirbg:UnLoadImage()
	self._simagead2:UnLoadImage()
	self._simagead3:UnLoadImage()
	self._mgcirbgoutline:UnLoadImage()
	self._ip:UnLoadImage()
	self._g:UnLoadImage()
	self._rrow:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer178

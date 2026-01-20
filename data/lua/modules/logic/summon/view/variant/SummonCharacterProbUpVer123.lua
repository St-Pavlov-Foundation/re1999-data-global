-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer123.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer123", package.seeall)

local SummonCharacterProbUpVer123 = class("SummonCharacterProbUpVer123", SummonMainCharacterProbUp)

SummonCharacterProbUpVer123.SIMAGE_COUNT = 3
SummonCharacterProbUpVer123.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_2/yuanlv/full/img_bg")
}

function SummonCharacterProbUpVer123:_editableInitView()
	for i = 1, SummonCharacterProbUpVer123.SIMAGE_COUNT do
		self["_simagead" .. i] = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad" .. i)
	end

	SummonCharacterProbUpVer123.super._editableInitView(self)
end

function SummonCharacterProbUpVer123:refreshSingleImage()
	self._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/yuanlv/full/img_bg"))
	self._simagead1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/yuanlv/img_chara_yl"))
	self._simagead2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/yuanlv/img_wx_fgr"))
	self._simagead3:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/yuanlv/img_wx_pma"))
	self._simagefrontbg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_2/yuanlv/mask"))
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer123:unloadSingleImage()
	for i = 1, SummonCharacterProbUpVer123.SIMAGE_COUNT do
		self["_simagead" .. i]:UnLoadImage()
	end

	self._simagebg:UnLoadImage()
	self._simagefrontbg:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer123

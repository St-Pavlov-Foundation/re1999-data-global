-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer245.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer245", package.seeall)

local SummonCharacterProbUpVer245 = class("SummonCharacterProbUpVer245", SummonCharacterProbDoubleUpBase)

SummonCharacterProbUpVer245.preloadList = {
	"singlebg/summon/heroversion_2_4/v2a4_lake/v2a4_lake_fullbg.png",
	"singlebg/summon/heroversion_2_4/v2a4_lake/v2a4_lake_role2.png",
	"singlebg/summon/heroversion_2_4/v2a4_lake/v2a4_lake_fullmake.png"
}

function SummonCharacterProbUpVer245:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad2")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad1")
	self._simagefullmask = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_fullmask")
	self._charaterItemCount = 2

	SummonCharacterProbUpVer245.super._editableInitView(self)
end

function SummonCharacterProbUpVer245:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer245:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead2:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagefullmask:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer245

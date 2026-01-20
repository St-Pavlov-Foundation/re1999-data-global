-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer239.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer239", package.seeall)

local SummonCharacterProbUpVer239 = class("SummonCharacterProbUpVer239", SummonCharacterProbDoubleUpBase)

SummonCharacterProbUpVer239.preloadList = {
	"singlebg/summon/heroversion_2_3/v2a3_lake/v2a3_lake_fulllbg.png",
	"singlebg/summon/heroversion_2_3/v2a3_lake/v2a3_lake_role1.png"
}

function SummonCharacterProbUpVer239:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad1")
	self._simagead2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad2")
	self._charaterItemCount = 2

	SummonCharacterProbUpVer239.super._editableInitView(self)
end

function SummonCharacterProbUpVer239:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer239:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagead2:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer239

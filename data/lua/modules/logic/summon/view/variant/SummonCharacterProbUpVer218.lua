-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer218.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer218", package.seeall)

local SummonCharacterProbUpVer218 = class("SummonCharacterProbUpVer218", SummonCharacterProbDoubleUpBase)

SummonCharacterProbUpVer218.preloadList = {
	"singlebg/summon/heroversion_2_1/v2a1_lake/v2a1_summonlake_fullbg.png",
	"singlebg/summon/heroversion_2_1/v2a1_lake/v2a1_summonlake_role2.png"
}

function SummonCharacterProbUpVer218:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad1")
	self._simagead2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_ad2")
	self._charaterItemCount = 2

	SummonCharacterProbUpVer218.super._editableInitView(self)
end

function SummonCharacterProbUpVer218:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer218:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagead2:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer218

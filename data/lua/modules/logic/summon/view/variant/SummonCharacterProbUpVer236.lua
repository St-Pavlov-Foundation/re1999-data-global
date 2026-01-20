-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer236.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer236", package.seeall)

local SummonCharacterProbUpVer236 = class("SummonCharacterProbUpVer236", SummonMainCharacterProbUp)

SummonCharacterProbUpVer236.preloadList = {
	"singlebg/summon/heroversion_1_7/yisuerde/full/bg.png",
	"singlebg/summon/heroversion_1_7/yisuerde/yisuoerde.png"
}

function SummonCharacterProbUpVer236:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_role1")
	self._simagerole3 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_role3")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_role2")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer236.super._editableInitView(self)
end

function SummonCharacterProbUpVer236:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer236:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagerole3:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer236

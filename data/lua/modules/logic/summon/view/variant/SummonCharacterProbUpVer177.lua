-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer177.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer177", package.seeall)

local SummonCharacterProbUpVer177 = class("SummonCharacterProbUpVer177", SummonMainCharacterProbUp)

SummonCharacterProbUpVer177.preloadList = {
	"singlebg/summon/heroversion_1_7/v1a7_role6/v1a7_role6_summon_fullbg.png",
	"singlebg/summon/heroversion_1_4/role6/v1a4_role6_summon_6.png",
	"singlebg/summon/heroversion_1_4/role6/v1a4_role6_bottombg.png"
}

function SummonCharacterProbUpVer177:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagead1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_ad1")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role2")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node2/#simage_role1")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bottom")
	self._charaterItemCount = 1

	SummonCharacterProbUpVer177.super._editableInitView(self)
end

function SummonCharacterProbUpVer177:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer177:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagead1:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagebottom:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer177

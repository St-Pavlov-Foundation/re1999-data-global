-- chunkname: @modules/logic/summon/view/variant/SummonCharacterProbUpVer157.lua

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer157", package.seeall)

local SummonCharacterProbUpVer157 = class("SummonCharacterProbUpVer157", SummonMainCharacterProbUp)

SummonCharacterProbUpVer157.preloadList = {
	"singlebg/summon/heroversion_1_5/hopeofthelake/full/bg.png",
	"singlebg/summon/heroversion_1_5/hopeofthelake/v1a5_hopeofthelake_and.png",
	"singlebg/summon/heroversion_1_5/hopeofthelake/v1a5_hopeofthelake_curve.png",
	"singlebg/summon/heroversion_1_5/hopeofthelake/v1a5_hopeofthelake_paopao.png"
}

function SummonCharacterProbUpVer157:_editableInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagemiddle = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_middle")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bottom")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_role1")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_role2")
	self._imagemiddledec = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/simage_middledec")
	self._charaterItemCount = 2

	SummonCharacterProbUpVer157.super._editableInitView(self)
end

function SummonCharacterProbUpVer157:refreshSingleImage()
	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function SummonCharacterProbUpVer157:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simagemiddle:UnLoadImage()
	self._simagebottom:UnLoadImage()
	self._simagerole1:UnLoadImage()
	self._simagerole2:UnLoadImage()
	self._imagemiddledec:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonCharacterProbUpVer157

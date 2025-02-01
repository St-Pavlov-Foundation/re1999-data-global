module("modules.logic.summon.view.variant.SummonCharacterProbUpVer196", package.seeall)

slot0 = class("SummonCharacterProbUpVer196", SummonMainCharacterProbUp)
slot0.preloadList = {
	"singlebg/summon/heroversion_1_3/rabbit/full/v1a5_rabbit_newplayerbg.png"
}

function slot0._editableInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._g = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/tip/bg")
	slot0._rrow = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/tip/arrow/arrow")
	slot0._charaterItemCount = 1

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._g:UnLoadImage()
	slot0._rrow:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0

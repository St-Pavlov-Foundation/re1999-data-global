module("modules.logic.summon.view.variant.SummonCharacterProbUpVer239", package.seeall)

slot0 = class("SummonCharacterProbUpVer239", SummonCharacterProbDoubleUpBase)
slot0.preloadList = {
	"singlebg/summon/heroversion_2_3/v2a3_lake/v2a3_lake_fulllbg.png",
	"singlebg/summon/heroversion_2_3/v2a3_lake/v2a3_lake_role1.png"
}

function slot0._editableInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simagead1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_ad1")
	slot0._simagead2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_ad2")
	slot0._charaterItemCount = 2

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagead1:UnLoadImage()
	slot0._simagead2:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0

module("modules.logic.summon.view.variant.SummonCharacterProbUpVer219", package.seeall)

slot0 = class("SummonCharacterProbUpVer219", SummonMainCharacterProbUp)
slot0.preloadList = {
	"singlebg/summon/heroversion_newplayer/sufubi/sufubi_newplayer_fullbg.png",
	"singlebg/summon/heroversion_newplayer/sufubi/sufubi_newplayer_role.png"
}

function slot0._editableInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simagead3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_ad3")
	slot0._simagead3dec = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_ad3dec")
	slot0._charaterItemCount = 1

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagead3:UnLoadImage()
	slot0._simagead3dec:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0

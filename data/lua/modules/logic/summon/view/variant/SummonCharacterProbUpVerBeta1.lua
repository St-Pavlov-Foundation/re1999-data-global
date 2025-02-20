module("modules.logic.summon.view.variant.SummonCharacterProbUpVerBeta1", package.seeall)

slot0 = class("SummonCharacterProbUpVerBeta1", SummonMainCharacterProbUp)
slot0.SIMAGE_COUNT = 3
slot0.preloadList = {
	ResUrl.getSummonCoverBg("hero/full/bg2"),
	ResUrl.getSummonCoverBg("hero/full/mask"),
	ResUrl.getSummonCoverBg("hero/leftdown"),
	ResUrl.getSummonCoverBg("hero/rightup")
}

for slot5 = 1, slot0.SIMAGE_COUNT do
	table.insert(slot0.preloadList, ({
		ResUrl.getSummonCoverBg("hero/bolinyidong"),
		ResUrl.getSummonCoverBg("hero/tannante"),
		ResUrl.getSummonCoverBg("hero/kaige")
	})[slot5])
end

function slot0._editableInitView(slot0)
	slot0._simageleft = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_left")
	slot0._simageright = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_right")
	slot0._simagejian = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_ad3/#simage_jian")
	slot4 = "#go_ui/current/#simage_mask"
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, slot4)

	for slot4 = 1, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4] = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_ad" .. slot4)
	end

	uv0.super._editableInitView(slot0)
end

function slot0.refreshSingleImage(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSummonCoverBg("hero/full/bg2"))
	slot0._simagemask:LoadImage(ResUrl.getSummonCoverBg("hero/full/mask"))
	slot0._simageleft:LoadImage(ResUrl.getSummonCoverBg("hero/leftdown"))
	slot0._simageright:LoadImage(ResUrl.getSummonCoverBg("hero/rightup"))
	slot0._simagejian:LoadImage(ResUrl.getSummonCoverBg("hero/tianshi"))

	slot4 = ResUrl.getSummonHeroIcon

	slot0._simageline:LoadImage(slot4("title_img_deco"))

	for slot4 = 1, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4]:LoadImage(uv1[slot4], slot0._adLoaded, slot0)
	end
end

function slot0.unloadSingleImage(slot0)
	for slot4 = 1, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4]:UnLoadImage()
	end

	slot0._simagebg:UnLoadImage()
	slot0._simageleft:UnLoadImage()
	slot0._simageright:UnLoadImage()
	slot0._simagejian:UnLoadImage()
	slot0._simagemask:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0

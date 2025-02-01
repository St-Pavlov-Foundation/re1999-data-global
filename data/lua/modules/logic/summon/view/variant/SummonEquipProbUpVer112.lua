module("modules.logic.summon.view.variant.SummonEquipProbUpVer112", package.seeall)

slot0 = class("SummonEquipProbUpVer112", SummonMainEquipProbUp)
slot0.preloadList = {
	ResUrl.getSummonCoverBg("equipversion_1_1/full/bg1"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip4"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip5"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip6"),
	ResUrl.getSummonCoverBg("hero/title_img_deco")
}

function slot0.refreshSingleImage(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/full/bg1"))
	slot0._simageequip1:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip4"))
	slot0._simageequip2:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip5"))
	slot0._simageequip3:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip6"))
	slot0._simageline:LoadImage(ResUrl.getSummonCoverBg("hero/title_img_deco"))
end

function slot0.unloadSingleImage(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageequip1:UnLoadImage()
	slot0._simageequip2:UnLoadImage()
	slot0._simageequip3:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

return slot0

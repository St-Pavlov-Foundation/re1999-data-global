module("modules.logic.summon.view.variant.SummonEquipProbUpVer112", package.seeall)

local var_0_0 = class("SummonEquipProbUpVer112", SummonMainEquipProbUp)

var_0_0.preloadList = {
	ResUrl.getSummonCoverBg("equipversion_1_1/full/bg1"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip4"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip5"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip6"),
	ResUrl.getSummonCoverBg("hero/title_img_deco")
}

function var_0_0.refreshSingleImage(arg_1_0)
	arg_1_0._simagebg:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/full/bg1"))
	arg_1_0._simageequip1:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip4"))
	arg_1_0._simageequip2:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip5"))
	arg_1_0._simageequip3:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip6"))
	arg_1_0._simageline:LoadImage(ResUrl.getSummonCoverBg("hero/title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_2_0)
	arg_2_0._simagebg:UnLoadImage()
	arg_2_0._simageequip1:UnLoadImage()
	arg_2_0._simageequip2:UnLoadImage()
	arg_2_0._simageequip3:UnLoadImage()
	arg_2_0._simageline:UnLoadImage()
	arg_2_0._simagecurrency1:UnLoadImage()
	arg_2_0._simagecurrency10:UnLoadImage()
end

return var_0_0

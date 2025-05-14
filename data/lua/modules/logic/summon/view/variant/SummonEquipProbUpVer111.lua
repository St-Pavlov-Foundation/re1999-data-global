module("modules.logic.summon.view.variant.SummonEquipProbUpVer111", package.seeall)

local var_0_0 = class("SummonEquipProbUpVer111", SummonMainEquipProbUp)

var_0_0.preloadList = {
	ResUrl.getSummonCoverBg("equipversion_1_1/full/bg"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip1"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip2"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip3"),
	ResUrl.getSummonCoverBg("hero/title_img_deco")
}

function var_0_0.refreshSingleImage(arg_1_0)
	arg_1_0._simagebg:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/full/bg"))
	arg_1_0._simageequip1:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip1"))
	arg_1_0._simageequip2:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip2"))
	arg_1_0._simageequip3:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip3"))
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

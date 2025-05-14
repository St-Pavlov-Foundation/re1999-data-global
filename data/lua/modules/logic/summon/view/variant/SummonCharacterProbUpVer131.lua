module("modules.logic.summon.view.variant.SummonCharacterProbUpVer131", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer131", SummonMainCharacterProbUp)

var_0_0.SIMAGE_COUNT = 0
var_0_0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/full/v1a3_rabbit_bg")
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagedog = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_dog")
	arg_1_0._simageround = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_round")
	arg_1_0._simagerole1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_role1")
	arg_1_0._simagerole2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_role2")
	arg_1_0._simagecircle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_circle")
	arg_1_0._simageendec = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_endec")

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/full/v1a3_rabbit_bg"))
	arg_2_0._simagedog:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/v1a3_rabbit_dog"))
	arg_2_0._simageround:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/v1a3_rabbit_roledec"))
	arg_2_0._simagerole1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/v1a3_rabbit_2"))
	arg_2_0._simagerole2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/v1a3_rabbit_role1"))
	arg_2_0._simagecircle:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/v1a3_rabbit_rolecircle"))
	arg_2_0._simageendec:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/rabbit/v1a3_rabbit_endec"))
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_3_0)
	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simagedog:UnLoadImage()
	arg_3_0._simageround:UnLoadImage()
	arg_3_0._simagerole1:UnLoadImage()
	arg_3_0._simagerole2:UnLoadImage()
	arg_3_0._simagecircle:UnLoadImage()
	arg_3_0._simageendec:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

return var_0_0

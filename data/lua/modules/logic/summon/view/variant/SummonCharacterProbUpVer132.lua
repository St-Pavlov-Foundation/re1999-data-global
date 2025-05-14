module("modules.logic.summon.view.variant.SummonCharacterProbUpVer132", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer132", SummonMainCharacterProbUp)

var_0_0.SIMAGE_COUNT = 0
var_0_0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/full/v1a3_zongmaoshali_bg_full"),
	ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/full/v1a3_zongmaoshali_bg_light"),
	ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/full/v1a3_zongmaoshali_bg_middle")
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagemiddle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_middle")
	arg_1_0._simagerole1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_role1")
	arg_1_0._simagerole2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_role2")
	arg_1_0._simagerole3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_role3")
	arg_1_0._simagelight = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_light")
	arg_1_0._charaterItemCount = 2

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simagebg:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/full/v1a3_zongmaoshali_bg_full"))
	arg_2_0._simagemiddle:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/full/v1a3_zongmaoshali_bg_middle"))
	arg_2_0._simagerole1:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/v1a3_zongmaoshali_role1"))
	arg_2_0._simagerole2:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/v1a3_zongmaoshali_role2"))
	arg_2_0._simagerole3:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/v1a3_zongmaoshali_role3"))
	arg_2_0._simagelight:LoadImage(ResUrl.getSummonCoverBg("heroversion_1_3/zongmaoshali/full/v1a3_zongmaoshali_bg_light"))
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_3_0)
	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simagemiddle:UnLoadImage()
	arg_3_0._simagerole1:UnLoadImage()
	arg_3_0._simagerole2:UnLoadImage()
	arg_3_0._simagerole3:UnLoadImage()
	arg_3_0._simagelight:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

return var_0_0

﻿module("modules.logic.summon.view.variant.SummonCharacterProbUpVer235", package.seeall)

local var_0_0 = class("SummonCharacterProbUpVer235", SummonMainCharacterProbUp)

var_0_0.preloadList = {
	"singlebg/summon/heroversion_2_0/mercury/full/v2a0_mercury_fullbg.png",
	"singlebg/summon/heroversion_2_0/mercury/v2a0_mercury_role1.png"
}

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#simage_bg")
	arg_1_0._simagerole1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/node1/#simage_role1")
	arg_1_0._simagerole3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/node2/#simage_role3")
	arg_1_0._simagerole2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/node2/#simage_role2")
	arg_1_0._charaterItemCount = 1

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshSingleImage(arg_2_0)
	arg_2_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))
end

function var_0_0.unloadSingleImage(arg_3_0)
	arg_3_0._simagebg:UnLoadImage()
	arg_3_0._simagerole1:UnLoadImage()
	arg_3_0._simagerole3:UnLoadImage()
	arg_3_0._simagerole2:UnLoadImage()
	arg_3_0._simageline:UnLoadImage()
	arg_3_0._simagecurrency1:UnLoadImage()
	arg_3_0._simagecurrency10:UnLoadImage()
end

return var_0_0

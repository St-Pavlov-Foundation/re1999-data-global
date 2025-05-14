module("modules.logic.versionactivity1_7.enter.view.VersionActivity1_7EnterViewTabItem1", package.seeall)

local var_0_0 = class("VersionActivity1_7EnterViewTabItem1", VersionActivity1_7EnterViewBaseTabItem)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0.simageSelectTabImg = gohelper.findChildSingleImage(arg_1_0.rootGo, "#go_select/#simage_tabimg")
	arg_1_0.simageUnSelectTabImg = gohelper.findChildSingleImage(arg_1_0.rootGo, "#go_unselect/#simage_tabimg")

	arg_1_0.simageSelectTabImg:LoadImage(VersionActivity1_7Enum.ActId2SelectImgPath[arg_1_0.actId])
	arg_1_0.simageUnSelectTabImg:LoadImage(VersionActivity1_7Enum.ActId2UnSelectImgPath[arg_1_0.actId])
end

function var_0_0.dispose(arg_2_0)
	arg_2_0.simageSelectTabImg:UnLoadImage()
	arg_2_0.simageUnSelectTabImg:UnLoadImage()
	var_0_0.super.dispose(arg_2_0)
end

return var_0_0

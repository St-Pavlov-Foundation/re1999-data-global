module("modules.logic.versionactivity2_0.enter.view.VersionActivity2_0EnterViewTabItem1", package.seeall)

local var_0_0 = class("VersionActivity2_0EnterViewTabItem1", VersionActivity2_0EnterViewTabItemBase)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0.simageSelectTabImg = gohelper.findChildSingleImage(arg_1_0.go, "#go_select/#simage_tabimg")
	arg_1_0.simageUnSelectTabImg = gohelper.findChildSingleImage(arg_1_0.go, "#go_unselect/#simage_tabimg")
end

function var_0_0.afterSetData(arg_2_0)
	var_0_0.super.afterSetData(arg_2_0)

	if not arg_2_0.actId then
		return
	end

	local var_2_0 = VersionActivity2_0Enum.TabSetting
	local var_2_1 = var_2_0.select.act2TabImg[arg_2_0.actId]
	local var_2_2 = var_2_0.unselect.act2TabImg[arg_2_0.actId]

	arg_2_0:setTabImg("simageSelectTabImg", var_2_1)
	arg_2_0:setTabImg("simageUnSelectTabImg", var_2_2)
end

function var_0_0.setTabImg(arg_3_0, arg_3_1, arg_3_2)
	if string.nilorempty(arg_3_1) or string.nilorempty(arg_3_2) or not arg_3_0[arg_3_1] then
		return
	end

	arg_3_0[arg_3_1]:LoadImage(arg_3_2)
end

function var_0_0.dispose(arg_4_0)
	arg_4_0.simageSelectTabImg:UnLoadImage()
	arg_4_0.simageUnSelectTabImg:UnLoadImage()
	var_0_0.super.dispose(arg_4_0)
end

return var_0_0

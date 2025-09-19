module("modules.logic.versionactivity2_8.enter.view.VersionActivity2_8EnterViewTabItem1", package.seeall)

local var_0_0 = class("VersionActivity2_8EnterViewTabItem1", VersionActivity2_8EnterViewTabItemBase)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0.simageSelectTabImg = gohelper.findChildSingleImage(arg_1_0.go, "#go_select/#simage_tabimg")
	arg_1_0.simageUnSelectTabImg = gohelper.findChildSingleImage(arg_1_0.go, "#go_unselect/#simage_tabimg")
end

function var_0_0._getTagPath(arg_2_0)
	return "#go_tag"
end

function var_0_0.afterSetData(arg_3_0)
	var_0_0.super.afterSetData(arg_3_0)

	if not arg_3_0.actId then
		return
	end

	local var_3_0 = VersionActivity2_8Enum.TabSetting
	local var_3_1 = var_3_0.select.act2TabImg[arg_3_0.actId]
	local var_3_2 = var_3_0.unselect.act2TabImg[arg_3_0.actId]

	arg_3_0:setTabImg("simageSelectTabImg", var_3_1)
	arg_3_0:setTabImg("simageUnSelectTabImg", var_3_2)
end

function var_0_0.setTabImg(arg_4_0, arg_4_1, arg_4_2)
	if string.nilorempty(arg_4_1) or string.nilorempty(arg_4_2) or not arg_4_0[arg_4_1] then
		return
	end

	arg_4_0[arg_4_1]:LoadImage(arg_4_2)
end

function var_0_0.dispose(arg_5_0)
	arg_5_0.simageSelectTabImg:UnLoadImage()
	arg_5_0.simageUnSelectTabImg:UnLoadImage()
	var_0_0.super.dispose(arg_5_0)
end

return var_0_0

module("modules.logic.versionactivity2_4.enter.view.VersionActivity2_4EnterViewTabItem1", package.seeall)

local var_0_0 = class("VersionActivity2_4EnterViewTabItem1", VersionActivity2_4EnterViewTabItemBase)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0.simageSelectTabImg = gohelper.findChildSingleImage(arg_1_0.go, "#go_select/#simage_tabimg")
	arg_1_0._goUnSelectTab = gohelper.findChild(arg_1_0.go, "#go_unselect/#simage_tabimg")
	arg_1_0.simageUnSelectTabImg = arg_1_0._goUnSelectTab:GetComponent(typeof(SLFramework.UGUI.SingleImage))
end

function var_0_0._getTagPath(arg_2_0)
	return "#go_tag"
end

function var_0_0.afterSetData(arg_3_0)
	var_0_0.super.afterSetData(arg_3_0)

	if not arg_3_0.actId then
		return
	end

	local var_3_0 = VersionActivity2_4Enum.TabSetting
	local var_3_1 = var_3_0.select.act2TabImg[arg_3_0.actId]
	local var_3_2 = var_3_0.unselect.act2TabImg[arg_3_0.actId]

	arg_3_0:setTabImg("simageSelectTabImg", var_3_1)

	if var_3_2 then
		arg_3_0:setTabImg("simageUnSelectTabImg", var_3_2)
	end
end

function var_0_0.setTabImg(arg_4_0, arg_4_1, arg_4_2)
	if string.nilorempty(arg_4_1) or string.nilorempty(arg_4_2) or not arg_4_0[arg_4_1] then
		return
	end

	arg_4_0[arg_4_1]:LoadImage(arg_4_2)
end

function var_0_0.dispose(arg_5_0)
	if arg_5_0.simageSelectTabImg then
		arg_5_0.simageSelectTabImg:UnLoadImage()
	end

	if arg_5_0.simageUnSelectTabImg then
		arg_5_0.simageUnSelectTabImg:UnLoadImage()
	end

	var_0_0.super.dispose(arg_5_0)
end

return var_0_0

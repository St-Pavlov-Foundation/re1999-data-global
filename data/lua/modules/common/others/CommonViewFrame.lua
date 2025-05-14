module("modules.common.others.CommonViewFrame", package.seeall)

local var_0_0 = class("CommonViewFrame", BaseView)
local var_0_1 = typeof(ZProj.ViewFrame)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._viewFrame = arg_1_0.viewGO:GetComponent(var_0_1)

	if not arg_1_0._viewFrame then
		arg_1_0._viewFrame = arg_1_0.viewGO:GetComponentInChildren(var_0_1, true)
	end

	if arg_1_0._viewFrame then
		arg_1_0._viewFrame:SetLoadCallback(arg_1_0._onFrameLoaded, arg_1_0)
	else
		logError(arg_1_0.viewName .. " 没有挂通用弹框底板脚本 ViewFrame.cs")
	end
end

function var_0_0._onFrameLoaded(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._viewFrame.frameGO

	arg_2_0._txtTitle = gohelper.findChildText(var_2_0, "txt/titlecn")

	if arg_2_0._txtTitle and not string.nilorempty(arg_2_0._viewFrame.cnTitle) then
		arg_2_0._txtTitle.text = luaLang(arg_2_0._viewFrame.cnTitle)
	end

	arg_2_0._txtTitleEn = gohelper.findChildText(var_2_0, "txt/titlecn/titleen")

	if arg_2_0._txtTitleEn then
		arg_2_0._txtTitleEn.text = arg_2_0._viewFrame.enTitle
	end

	arg_2_0._btnclose = gohelper.findChildButtonWithAudio(var_2_0, "#btn_close")

	if arg_2_0._btnclose then
		arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	end

	local var_2_1 = gohelper.findChild(var_2_0, "Mask")

	if var_2_1 then
		arg_2_0._clickMask = SLFramework.UGUI.UIClickListener.Get(var_2_1)

		arg_2_0._clickMask:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	end
end

function var_0_0._btncloseOnClick(arg_3_0)
	arg_3_0:closeThis()
end

function var_0_0.onDestroyView(arg_4_0)
	if arg_4_0._btnclose then
		arg_4_0._btnclose:RemoveClickListener()

		arg_4_0._btnclose = nil
	end

	if arg_4_0._clickMask then
		arg_4_0._clickMask:RemoveClickListener()
	end
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

return var_0_0

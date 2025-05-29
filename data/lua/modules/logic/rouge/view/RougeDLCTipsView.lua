module("modules.logic.rouge.view.RougeDLCTipsView", package.seeall)

local var_0_0 = class("RougeDLCTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "#go_root")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_root/#go_container")
	arg_1_0._txtdlcname = gohelper.findChildText(arg_1_0.viewGO, "#go_root/#go_container/#txt_dlcname")
	arg_1_0._scrollinfo = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_root/#go_container/#scroll_info")
	arg_1_0._simagebanner = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_root/#go_container/#scroll_info/Viewport/Content/bg/#simage_banner")
	arg_1_0._txtdlcdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_root/#go_container/#scroll_info/Viewport/Content/#txt_dlcdesc")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_root/#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshDLCContainer()
end

function var_0_0.refreshDLCContainer(arg_7_0)
	local var_7_0 = arg_7_0.viewParam and arg_7_0.viewParam.dlcId
	local var_7_1 = lua_rouge_season.configDict[var_7_0]

	if var_7_1 then
		arg_7_0._txtdlcname.text = var_7_1.name
		arg_7_0._txtdlcdesc.text = var_7_1.desc

		local var_7_2 = ResUrl.getRougeDLCLangImage("rouge_dlc_banner_" .. var_7_1.id)

		arg_7_0._simagebanner:LoadImage(var_7_2)
	end
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0

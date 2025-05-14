module("modules.logic.rouge.view.RougeDLCSelectView", package.seeall)

local var_0_0 = class("RougeDLCSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "#go_root")
	arg_1_0._scrolldlcs = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_root/#scroll_dlcs")
	arg_1_0._godlcitem = gohelper.findChild(arg_1_0.viewGO, "#go_root/#scroll_dlcs/Viewport/Content/#go_dlcitem")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_root/#go_container")
	arg_1_0._txtdlcname = gohelper.findChildText(arg_1_0.viewGO, "#go_root/#go_container/#txt_dlcname")
	arg_1_0._scrollinfo = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_root/#go_container/#scroll_info")
	arg_1_0._simagebanner = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_root/#go_container/#scroll_info/Viewport/Content/bg/#simage_banner")
	arg_1_0._txtdlcdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_root/#go_container/#scroll_info/Viewport/Content/#txt_dlcdesc")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_root/#go_container/#btn_add")
	arg_1_0._btnremove = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_root/#go_container/#btn_remove")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_root/#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnremove:AddClickListener(arg_2_0._btnremoveOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnremove:RemoveClickListener()
end

function var_0_0._btnaddOnClick(arg_4_0)
	RougeDLCController.instance:addDLC(arg_4_0._selectVersionId)
end

function var_0_0._btnremoveOnClick(arg_5_0)
	RougeDLCController.instance:removeDLC(arg_5_0._selectVersionId)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0:addEventCb(RougeDLCController.instance, RougeEvent.OnSelectDLC, arg_6_0._onSelectDLC, arg_6_0)
	arg_6_0:addEventCb(RougeDLCController.instance, RougeEvent.OnGetVersionInfo, arg_6_0._onGetVersionInfo, arg_6_0)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	RougeDLCSelectListModel.instance:onInit()
end

function var_0_0._onSelectDLC(arg_9_0, arg_9_1)
	arg_9_0._selectVersionId = arg_9_1

	local var_9_0 = lua_rouge_season.configDict[arg_9_0._selectVersionId]

	arg_9_0:refreshDLCContainer(var_9_0)
	arg_9_0:refreshButtons(var_9_0)
end

function var_0_0.refreshDLCContainer(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0._txtdlcname.text = arg_10_1.name
		arg_10_0._txtdlcdesc.text = arg_10_1.desc

		local var_10_0 = ResUrl.getRougeDLCLangImage("rouge_dlc_banner_" .. arg_10_1.id)

		arg_10_0._simagebanner:LoadImage(var_10_0)
	end
end

function var_0_0.refreshButtons(arg_11_0, arg_11_1)
	local var_11_0 = RougeDLCSelectListModel.instance:getCurSelectVersions()
	local var_11_1 = tabletool.indexOf(var_11_0, arg_11_1.id) ~= nil

	gohelper.setActive(arg_11_0._btnadd, not var_11_1)
	gohelper.setActive(arg_11_0._btnremove, var_11_1)
end

function var_0_0._onGetVersionInfo(arg_12_0)
	if arg_12_0._selectVersionId then
		local var_12_0 = lua_rouge_season.configDict[arg_12_0._selectVersionId]

		arg_12_0:refreshButtons(var_12_0)
	end
end

function var_0_0.onClose(arg_13_0)
	RougeDLCController.instance:dispatchEvent(RougeEvent.UpdateRougeVersion)
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0

module("modules.logic.rouge.view.RougeDLCSelectView", package.seeall)

slot0 = class("RougeDLCSelectView", BaseView)

function slot0.onInitView(slot0)
	slot0._goroot = gohelper.findChild(slot0.viewGO, "#go_root")
	slot0._scrolldlcs = gohelper.findChildScrollRect(slot0.viewGO, "#go_root/#scroll_dlcs")
	slot0._godlcitem = gohelper.findChild(slot0.viewGO, "#go_root/#scroll_dlcs/Viewport/Content/#go_dlcitem")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_root/#go_container")
	slot0._txtdlcname = gohelper.findChildText(slot0.viewGO, "#go_root/#go_container/#txt_dlcname")
	slot0._scrollinfo = gohelper.findChildScrollRect(slot0.viewGO, "#go_root/#go_container/#scroll_info")
	slot0._simagebanner = gohelper.findChildSingleImage(slot0.viewGO, "#go_root/#go_container/#scroll_info/Viewport/Content/bg/#simage_banner")
	slot0._txtdlcdesc = gohelper.findChildText(slot0.viewGO, "#go_root/#go_container/#scroll_info/Viewport/Content/#txt_dlcdesc")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_root/#go_container/#btn_add")
	slot0._btnremove = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_root/#go_container/#btn_remove")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_root/#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnremove:AddClickListener(slot0._btnremoveOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnadd:RemoveClickListener()
	slot0._btnremove:RemoveClickListener()
end

function slot0._btnaddOnClick(slot0)
	RougeDLCController.instance:addDLC(slot0._selectVersionId)
end

function slot0._btnremoveOnClick(slot0)
	RougeDLCController.instance:removeDLC(slot0._selectVersionId)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeDLCController.instance, RougeEvent.OnSelectDLC, slot0._onSelectDLC, slot0)
	slot0:addEventCb(RougeDLCController.instance, RougeEvent.OnGetVersionInfo, slot0._onGetVersionInfo, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	RougeDLCSelectListModel.instance:onInit()
end

function slot0._onSelectDLC(slot0, slot1)
	slot0._selectVersionId = slot1
	slot2 = lua_rouge_season.configDict[slot0._selectVersionId]

	slot0:refreshDLCContainer(slot2)
	slot0:refreshButtons(slot2)
end

function slot0.refreshDLCContainer(slot0, slot1)
	if slot1 then
		slot0._txtdlcname.text = slot1.name
		slot0._txtdlcdesc.text = slot1.desc

		slot0._simagebanner:LoadImage(ResUrl.getRougeDLCLangImage("rouge_dlc_banner_" .. slot1.id))
	end
end

function slot0.refreshButtons(slot0, slot1)
	slot3 = tabletool.indexOf(RougeDLCSelectListModel.instance:getCurSelectVersions(), slot1.id) ~= nil

	gohelper.setActive(slot0._btnadd, not slot3)
	gohelper.setActive(slot0._btnremove, slot3)
end

function slot0._onGetVersionInfo(slot0)
	if slot0._selectVersionId then
		slot0:refreshButtons(lua_rouge_season.configDict[slot0._selectVersionId])
	end
end

function slot0.onClose(slot0)
	RougeDLCController.instance:dispatchEvent(RougeEvent.UpdateRougeVersion)
end

function slot0.onDestroyView(slot0)
end

return slot0

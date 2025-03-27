module("modules.logic.rouge.dlc.102.view.RougeCollectionChessView_1_102", package.seeall)

slot0 = class("RougeCollectionChessView_1_102", BaseViewExtended)
slot0.AssetUrl = "ui/viewres/rouge/dlc/102/rougecollectiontrammelview.prefab"
slot0.ParentObjPath = "#go_left"
slot1 = "#A08156"
slot2 = "#616161"
slot3 = 1
slot4 = 0.6
slot5 = "#A08156"
slot6 = "#616161"

function slot0.onInitView(slot0)
	slot0._btntrammel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_trammel")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#btn_trammel/#image_icon")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tips/#btn_close")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_tips/go_content")
	slot0._godecitem = gohelper.findChild(slot0.viewGO, "#go_tips/#go_content/#txt_decitem")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#go_tips/#txt_title")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntrammel:AddClickListener(slot0._btntrammelOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.AdjustBackPack, slot0._adjustBackPack, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntrammel:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btntrammelOnClick(slot0)
	slot0._waitShowTips = true

	slot0:_tryGetTrammelInfoAndRefreshUI()
end

function slot0._tryGetTrammelInfoAndRefreshUI(slot0)
	RougeRpc.instance:sendRougeItemTrammelsRequest(RougeModel.instance:getSeason(), slot0._sendRougeItemTrammelsRequestCallBack, slot0)
end

function slot0._sendRougeItemTrammelsRequestCallBack(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot0._activeIds = slot3.ids
	slot0._activeIdMap = {}
	slot0._activeIdCount = slot0._activeIds and #slot0._activeIds or 0

	for slot7, slot8 in ipairs(slot3.ids) do
		slot0._activeIdMap[slot8] = true
	end

	gohelper.setActive(slot0._gotips, slot0._waitShowTips)
	slot0:_refreshUI()
end

function slot0._adjustBackPack(slot0)
	slot0:_tryGetTrammelInfoAndRefreshUI()
end

function slot0._btncloseOnClick(slot0)
	gohelper.setActive(slot0._gotips, false)

	slot0._waitShowTips = false
end

function slot0.onOpen(slot0)
	slot0:_tryGetTrammelInfoAndRefreshUI()
end

function slot0._refreshUI(slot0)
	UISpriteSetMgr.instance:setRouge4Sprite(slot0._imageicon, string.format("rouge_dlc2_icon" .. slot0._activeIdCount))

	slot3 = {}

	for slot7, slot8 in ipairs(RougeDLCConfig102.instance:getAllCollectionTrammelCo()) do
		table.insert(slot3, string.format("<%s>%s</color>", slot0._activeIdMap and slot0._activeIdMap[slot8.id] and uv0 or uv1, slot8.num))
	end

	slot0._txttitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge_trammels_title"), table.concat(slot3, "/"))

	gohelper.CreateObjList(slot0, slot0.refreshTip, slot2, slot0._gocontent, slot0._godecitem)
end

function slot0.refreshTip(slot0, slot1, slot2, slot3)
	slot1:GetComponent(gohelper.Type_TextMesh).text = slot2.desc
	slot5 = slot0._activeIdMap and slot0._activeIdMap[slot2.id]

	SLFramework.UGUI.GuiHelper.SetColor(slot4, slot5 and uv0 or uv1)
	ZProj.UGUIHelper.SetColorAlpha(slot4, slot5 and uv2 or uv3)
end

return slot0

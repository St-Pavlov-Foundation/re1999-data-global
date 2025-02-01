module("modules.logic.rouge.view.RougerewardThemeTipView", package.seeall)

slot0 = class("RougerewardThemeTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simageblockpackageicon = gohelper.findChildSingleImage(slot0.viewGO, "content/blockpackageiconmask/#simage_blockpackageicon")
	slot0._gosuitcollect = gohelper.findChild(slot0.viewGO, "content/blockpackageiconmask/#go_suitcollect")
	slot0._simagebuildingicon = gohelper.findChildSingleImage(slot0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#simage_buildingicon")
	slot0._btnsuitcollect = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#btn_suitcollect")
	slot0._gocollecticon = gohelper.findChild(slot0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#go_collecticon")
	slot0._txtbuildingname = gohelper.findChildText(slot0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#txt_buildingname")
	slot0._txtcollectdesc = gohelper.findChildText(slot0.viewGO, "content/blockpackageiconmask/#go_suitcollect/#txt_collectdesc")
	slot0._gonormaltitle = gohelper.findChild(slot0.viewGO, "content/title/#go_normaltitle")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "content/title/#go_normaltitle/#txt_name")
	slot0._gohascollect = gohelper.findChild(slot0.viewGO, "content/title/#go_hascollect")
	slot0._txtname2 = gohelper.findChildText(slot0.viewGO, "content/title/#go_hascollect/#txt_name2")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "content/desc/#txt_desc")
	slot0._scrollitem = gohelper.findChildScrollRect(slot0.viewGO, "content/go_scroll/#scroll_item")
	slot0._txtnameitem = gohelper.findChildText(slot0.viewGO, "content/go_scroll/#scroll_item/viewport/content/#txt_nameitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnsuitcollect:AddClickListener(slot0._btnsuitcollectOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnsuitcollect:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnsuitcollectOnClick(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._config = slot0.viewParam

	slot0._simageblockpackageicon:LoadImage(ResUrl.getRougeIcon("reward/rouge_reward_roomskindetail"))
end

function slot0._initUI(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

module("modules.logic.equip.view.EquipStrengthenAlertView", package.seeall)

slot0 = class("EquipStrengthenAlertView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagetipbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_tipbg")
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "#txt_content")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._btnselect = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btns/#btn_select")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_btns/#btn_select/#go_selected")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btns/#btn_cancel")
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btns/#btn_ok")
	slot0._simagebgnum = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg_num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnselect:AddClickListener(slot0._btnselectOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnselect:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0._btnok:RemoveClickListener()
end

function slot0._btnselectOnClick(slot0)
	slot0._isSelected = not slot0._isSelected

	slot0._goselected:SetActive(slot0._isSelected)
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnokOnClick(slot0)
	slot0:closeThis()
	slot0.viewParam.callback(slot0._isSelected)
end

function slot0._editableInitView(slot0)
	slot0._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
	slot0._simagebgnum:LoadImage(ResUrl.getMessageIcon("bg_num"))
	gohelper.addUIClickAudio(slot0._btncancel.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.addUIClickAudio(slot0._btnok.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._txtcontent.text = slot0.viewParam.content
	slot0._isSelected = false

	slot0._goselected:SetActive(slot0._isSelected)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagetipbg:UnLoadImage()
	slot0._simagebgnum:UnLoadImage()
end

return slot0

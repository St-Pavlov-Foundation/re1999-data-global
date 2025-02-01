module("modules.logic.versionactivity1_4.act136.view.Activity136ChoiceView", package.seeall)

slot0 = class("Activity136ChoiceView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bg2")
	slot0._scrollitem = gohelper.findChildScrollRect(slot0.viewGO, "root/#scroll_item")
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_ok")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(Activity136Controller.instance, Activity136Event.SelectCharacter, slot0._onSelectCharacter, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnok:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(Activity136Controller.instance, Activity136Event.SelectCharacter, slot0._onSelectCharacter, slot0)
end

function slot0._btnokOnClick(slot0)
	Activity136Controller.instance:receiveCharacter(slot0._selectCharacterId)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._onSelectCharacter(slot0, slot1)
	slot0._selectCharacterId = slot1

	slot0:refreshReceiveBtn()
end

function slot0._editableInitView(slot0)
	slot0._selectCharacterId = nil
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshReceiveBtn()
	Activity136ChoiceViewListModel.instance:setSelfSelectedCharacterList()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
end

function slot0.refreshReceiveBtn(slot0)
	slot1 = true

	if not Activity136Model.instance:hasReceivedCharacter() then
		slot1 = not slot0._selectCharacterId
	end

	ZProj.UGUIHelper.SetGrayscale(slot0._btnok.gameObject, slot1)
end

function slot0.onClose(slot0)
	slot0._selectCharacterId = nil
end

function slot0.onDestroyView(slot0)
end

return slot0

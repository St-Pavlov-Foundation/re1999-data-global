module("modules.logic.activity.view.LinkageActivity_FullView_Page1", package.seeall)

slot0 = class("LinkageActivity_FullView_Page1", LinkageActivity_Page1)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "view/#simage_bg")
	slot0._simagesignature1 = gohelper.findChildSingleImage(slot0.viewGO, "view/left/role1/#simage_signature1")
	slot0._simagesignature2 = gohelper.findChildSingleImage(slot0.viewGO, "view/left/role2/#simage_signature2")
	slot0._txtdurationTime = gohelper.findChildText(slot0.viewGO, "view/right/time/#txt_durationTime")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/right/#btn_buy")
	slot0._btnChange = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Change")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._btnChange:AddClickListener(slot0._btnChangeOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbuy:RemoveClickListener()
	slot0._btnChange:RemoveClickListener()
end

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._txtdurationTime.text = ""

	slot0:setActive(false)
end

function slot0._btnbuyOnClick(slot0)
	slot0:jump()
end

function slot0._btnChangeOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_switch_20220009)
	slot0:selectedPage(2)
end

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1)

	slot0._txtdurationTime.text = slot0:getDurationTimeStr()
end

return slot0

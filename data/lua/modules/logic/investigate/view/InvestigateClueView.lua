module("modules.logic.investigate.view.InvestigateClueView", package.seeall)

slot0 = class("InvestigateClueView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagerole = gohelper.findChildSingleImage(slot0.viewGO, "#simage_role")
	slot0._gorole1 = gohelper.findChild(slot0.viewGO, "#go_role1")
	slot0._simagerole1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_role1/#simage_role1")
	slot0._simagerole2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_role1/#simage_role2")
	slot0._simagerole3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_role1/#simage_role3")
	slot0._txtrole = gohelper.findChildText(slot0.viewGO, "#txt_role")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	if not lua_investigate_info.configDict[slot0.viewParam.id] then
		return
	end

	slot0._txtrole.text = slot1.unlockDesc
	slot2 = slot1.entrance == 1

	gohelper.setActive(slot0._simagerole, not slot2)
	gohelper.setActive(slot0._gorole1, slot2)

	if slot2 then
		for slot6, slot7 in ipairs(lua_investigate_info.configList) do
			if slot7.group == slot1.group and slot0["_simagerole" .. slot6] then
				slot8:LoadImage(slot7.icon)
			end
		end
	else
		slot0._simagerole:LoadImage(slot1.icon)
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_leimi_celebrity_get)
end

function slot0.onClose(slot0)
	if slot0.viewParam.isGet then
		InvestigateController.instance:dispatchEvent(InvestigateEvent.ShowGetEffect)
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagerole:UnLoadImage()
end

return slot0

module("modules.logic.versionactivity.view.VersionActivityTipsView", package.seeall)

slot0 = class("VersionActivityTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1", AudioEnum.UI.play_ui_help_close)
	slot0._scrollinfo = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_info")
	slot0._goinfoitem = gohelper.findChild(slot0.viewGO, "#scroll_info/Viewport/Content/#go_infoitem")
	slot0._btnclose2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close2", AudioEnum.UI.play_ui_help_close)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose1:AddClickListener(slot0._btnclose1OnClick, slot0)
	slot0._btnclose2:AddClickListener(slot0._btnclose2OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose1:RemoveClickListener()
	slot0._btnclose2:RemoveClickListener()
end

function slot0._btnclose1OnClick(slot0)
	slot0:closeThis()
end

function slot0._btnclose2OnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	for slot6 = 1, #string.split(luaLang("versionactivityexchange_rule"), "|"), 2 do
		slot7 = gohelper.cloneInPlace(slot0._goinfoitem, "infoitem")

		gohelper.setActive(slot7, true)

		gohelper.findChildTextMesh(slot7, "txt_title").text = slot2[slot6]
		gohelper.findChildTextMesh(slot7, "txt_desc").text = slot2[slot6 + 1]
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

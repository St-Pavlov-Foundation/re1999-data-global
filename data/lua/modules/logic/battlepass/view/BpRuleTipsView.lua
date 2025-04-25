module("modules.logic.battlepass.view.BpRuleTipsView", package.seeall)

slot0 = class("BpRuleTipsView", BaseView)

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

slot1 = string.split

function slot0._btnclose1OnClick(slot0)
	slot0:closeThis()
end

function slot0._btnclose2OnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._titlecn = gohelper.findChildText(slot0.viewGO, "title/titlecn")
	slot0._titleen = gohelper.findChildText(slot0.viewGO, "title/titlecn/titleen")
end

function slot0._ruleDesc(slot0)
	if slot0.viewParam and slot0.viewParam.ruleDesc then
		return slot1
	end

	return slot0.viewName == ViewName.BpSPRuleTipsView and luaLang("bp_sp_rule") or luaLang("bp_rule")
end

function slot0._title(slot0)
	return slot0.viewParam and slot0.viewParam.title or luaLang("p_bpruletipsview_title")
end

function slot0._titleEn(slot0)
	return slot0.viewParam and slot0.viewParam.titleEn or "JUKEBOX DETAILS"
end

function slot0.onOpen(slot0)
	slot0._titlecn.text = slot0:_title()
	slot0._titleen.text = slot0:_titleEn()

	for slot5 = 1, #uv0(slot0:_ruleDesc(), "|"), 2 do
		slot6 = gohelper.cloneInPlace(slot0._goinfoitem, "infoitem")

		gohelper.setActive(slot6, true)

		gohelper.findChildTextMesh(slot6, "txt_title").text = slot1[slot5]
		gohelper.findChildTextMesh(slot6, "txt_desc").text = string.gsub(slot1[slot5 + 1] or "", "UTC%+8", ServerTime.GetUTCOffsetStr())
	end
end

return slot0

module("modules.logic.room.view.critter.summon.RoomCritterSummonRuleTipsView", package.seeall)

slot0 = class("RoomCritterSummonRuleTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1")
	slot0._scrollinfo = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_info")
	slot0._goinfoitem = gohelper.findChild(slot0.viewGO, "#scroll_info/Viewport/Content/#go_infoitem")
	slot0._btnclose2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close2")

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
	slot0._txttilte = gohelper.findChildText(slot0.viewGO, "title/titlecn")
	slot0._txttilteEn = gohelper.findChildText(slot0.viewGO, "title/titlecn/titleen")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	for slot8 = 1, #string.split(luaLang(RoomSummonEnum.SummonMode[slot0.viewParam.type].RuleTipDesc.desc), "|"), 2 do
		slot9 = gohelper.cloneInPlace(slot0._goinfoitem, "infoitem")

		gohelper.setActive(slot9, true)

		gohelper.findChildTextMesh(slot9, "txt_title").text = slot4[slot8]
		gohelper.findChildTextMesh(slot9, "txt_desc").text = slot4[slot8 + 1]
	end

	slot0._txttilte.text = luaLang(slot2.titlecn)
	slot0._txttilteEn.text = luaLang(slot2.titleen)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

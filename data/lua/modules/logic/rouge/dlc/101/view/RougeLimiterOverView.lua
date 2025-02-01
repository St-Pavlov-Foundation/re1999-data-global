module("modules.logic.rouge.dlc.101.view.RougeLimiterOverView", package.seeall)

slot0 = class("RougeLimiterOverView", BaseView)
slot0.TabType = {
	Buff = 2,
	Debuff = 1
}

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")
	slot0._btndebuff = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/top/#btn_debuff")
	slot0._btnbuff = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/top/#btn_buff")
	slot0._txtdifficulty = gohelper.findChildText(slot0.viewGO, "root/bottom/difficultybg/#txt_difficulty")
	slot0._txtdec1 = gohelper.findChildText(slot0.viewGO, "root/bottom/#txt_dec1")
	slot0._txtdec2 = gohelper.findChildText(slot0.viewGO, "root/bottom/#txt_dec2")
	slot0._txtdec3 = gohelper.findChildText(slot0.viewGO, "root/bottom/#txt_dec3")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "root/#go_empty")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btndebuff:AddClickListener(slot0._btndebuffOnClick, slot0)
	slot0._btnbuff:AddClickListener(slot0._btnbuffOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btndebuff:RemoveClickListener()
	slot0._btnbuff:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btndebuffOnClick(slot0)
	slot0:try2SwtichTabView(uv0.TabType.Debuff)
end

function slot0._btnbuffOnClick(slot0)
	slot0:try2SwtichTabView(uv0.TabType.Buff)
end

function slot0.try2SwtichTabView(slot0, slot1)
	if slot0._curTabId == slot1 then
		return
	end

	slot0._curTabId = slot1

	slot0.viewContainer:switchTab(slot1)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshBarUI()
	slot0:refreshDifficulty()
	slot0:refreshEmptyUI()
end

function slot0.refreshBarUI(slot0)
	gohelper.setActive(gohelper.findChild(slot0._btndebuff.gameObject, "unselect"), slot0._curTabId ~= uv0.TabType.Debuff)
	gohelper.setActive(gohelper.findChild(slot0._btndebuff.gameObject, "selected"), slot0._curTabId == uv0.TabType.Debuff)
	gohelper.setActive(gohelper.findChild(slot0._btnbuff.gameObject, "unselect"), slot0._curTabId ~= uv0.TabType.Buff)
	gohelper.setActive(gohelper.findChild(slot0._btnbuff.gameObject, "selected"), slot0._curTabId == uv0.TabType.Buff)
end

function slot0.refreshDifficulty(slot0)
	slot0._txtdifficulty.text = RougeDLCConfig101.instance:getRougeRiskCoByRiskValue(slot0.viewParam and slot0.viewParam.totalRiskValue or 0) and slot2.title

	slot0:refreshDesc(slot2 and slot2.desc)
end

function slot0.refreshDesc(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1) then
		for slot7, slot8 in ipairs(string.split(slot1, "|")) do
			slot9 = slot0["_txtdec" .. slot7]
			slot9.text = slot8
			slot2[slot9] = true

			gohelper.setActive(slot9.gameObject, true)
		end
	end

	for slot6 = 1, RougeDLCEnum101.MaxRiskDescCount do
		if slot0["_txtdec" .. slot6] and not slot2[slot7] then
			gohelper.setActive(slot7.gameObject, false)
		end
	end
end

function slot0.refreshEmptyUI(slot0)
	slot1 = false

	if slot0._curTabId == uv0.TabType.Debuff then
		slot2 = slot0.viewParam and slot0.viewParam.limiterIds
		slot1 = (slot2 and #slot2 or 0) <= 0
	elseif slot0._curTabId == uv0.TabType.Buff then
		slot2 = slot0.viewParam and slot0.viewParam.buffIds
		slot1 = (slot2 and #slot2 or 0) <= 0
	end

	gohelper.setActive(slot0._goempty, slot1)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._curTabId = uv0.TabType.Debuff

	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

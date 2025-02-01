module("modules.logic.gm.view.GMErrorItem", package.seeall)

slot0 = class("GMErrorItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._text = gohelper.findChildText(slot1, "text")
	slot0._click = gohelper.getClickWithAudio(slot1)
	slot0._selectGO = gohelper.findChild(slot1, "select")
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClickThis, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._text.text = string.format("%s %s", os.date("%H:%M:%S", slot1.time), slot1.msg)
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._selectGO, slot1)

	if slot1 then
		GMController.instance:dispatchEvent(GMEvent.GMLogView_Select, slot0._mo)
	end
end

function slot0._onClickThis(slot0)
	slot0._view:setSelect(slot0._mo)
end

return slot0

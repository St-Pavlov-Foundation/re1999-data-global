module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandElementBase", package.seeall)

slot0 = class("FairyLandElementBase", LuaCompBase)

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._config = slot2
	slot0._elements = slot1
end

function slot0.getElementId(slot0)
	return slot0._config.id
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._transform = slot1.transform

	slot0:updatePos()
	slot0:onInitView()
	slot0:onRefresh()

	if slot0:getClickGO() then
		slot0.click = gohelper.getClickWithAudio(slot2)

		if slot0.click then
			slot0.click:AddClickListener(slot0.onClick, slot0)
		end
	end
end

function slot0.refresh(slot0)
	slot0:onRefresh()
end

function slot0.finish(slot0)
	slot0:onFinish()
	slot0:onDestroy()
end

function slot0.getPos(slot0)
	return tonumber(slot0._config.pos)
end

function slot0.updatePos(slot0)
	slot3 = slot0:getPos()

	recthelper.setAnchor(slot0._transform, slot3 * 244, -(slot3 * 73))
end

function slot0.hide(slot0)
	gohelper.setActive(slot0._go, false)
end

function slot0.show(slot0)
	gohelper.setActive(slot0._go, true)
end

function slot0.getVisible(slot0)
	return not gohelper.isNil(slot0._go) and slot0._go.activeSelf
end

function slot0.isValid(slot0)
	return not gohelper.isNil(slot0._go)
end

function slot0.onClick(slot0)
end

function slot0.getTransform(slot0)
	return slot0._transform
end

function slot0.onDestroy(slot0)
	slot0:onDestroyElement()

	if slot0.click then
		slot0.click:RemoveClickListener()
	end

	if not gohelper.isNil(slot0._go) then
		gohelper.destroy(slot0._go)

		slot0._go = nil
	end

	slot0:__onDispose()
end

function slot0.getClickGO(slot0)
	return slot0._go
end

function slot0.setFinish(slot0)
	FairyLandRpc.instance:sendRecordElementRequest(slot0:getElementId())
end

function slot0.onInitView(slot0)
end

function slot0.onRefresh(slot0)
end

function slot0.onFinish(slot0)
end

function slot0.onDestroyElement(slot0)
end

return slot0

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogItem", package.seeall)

slot0 = class("AergusiDialogItem", AergusiDialogRoleItemBase)

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
end

function slot0.CreateItem(slot0, slot1, slot2, slot3)
	if not AergusiEnum.DialogItemCls[slot3] then
		logError("un support type dialogue type : " .. tostring(slot3))

		return nil
	end

	slot5 = slot4.New()

	slot5:init(slot0, slot1, slot2, slot3)

	return slot5
end

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0.stepCo = slot1
	slot0.go = slot2
	slot0.type = slot4
	slot0.transform = slot0.go.transform

	recthelper.setAnchorY(slot0.transform, -slot3)
	gohelper.setActive(slot2, true)
	slot0:initView()
	slot0:refresh()
	slot0:calculateHeight()
end

function slot0.initView(slot0)
end

function slot0.refresh(slot0)
end

function slot0.calculateHeight(slot0)
end

function slot0.getHeight(slot0)
	return slot0.height
end

function slot0.onDestroy(slot0)
end

function slot0.destroy(slot0)
	slot0:onDestroy()
	uv0.super.destroy(slot0)
end

return slot0

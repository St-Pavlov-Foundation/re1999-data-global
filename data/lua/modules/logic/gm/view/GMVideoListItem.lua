module("modules.logic.gm.view.GMVideoListItem", package.seeall)

slot0 = class("GMVideoListItem", ListScrollCell)
slot1 = Color.New(1, 0.8, 0.8, 1)
slot2 = Color.white
slot3 = nil

function slot0.init(slot0, slot1)
	slot0._btn = gohelper.findChildButtonWithAudio(slot1, "btn")

	slot0._btn:AddClickListener(slot0._onClickItem, slot0)
	recthelper.setWidth(slot1.transform, 500)
	recthelper.setWidth(slot0._btn.transform, 500)

	slot0._imgBtn = gohelper.findChildImage(slot1, "btn")
	slot0._txtName = gohelper.findChildText(slot1, "btn/Text")
	slot0._txtName.alignment = TMPro.TextAlignmentOptions.MidlineLeft
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtName.text = slot0._mo.id .. ": " .. slot0._mo.video

	slot0:onSelect(slot0._mo.video == uv0)
end

function slot0._onClickItem(slot0)
	uv0 = slot0._mo.video

	slot0._view:setSelect(slot0._mo)
	ViewMgr.instance:openView(ViewName.GMVideoPlayView, slot0._mo.video)
end

function slot0.onSelect(slot0, slot1)
	slot0._imgBtn.color = slot1 and uv0 or uv1
end

function slot0.onDestroy(slot0)
	if slot0._btn then
		slot0._btn:RemoveClickListener()

		slot0._btn = nil
	end
end

return slot0

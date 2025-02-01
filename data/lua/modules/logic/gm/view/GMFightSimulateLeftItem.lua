module("modules.logic.gm.view.GMFightSimulateLeftItem", package.seeall)

slot0 = class("GMFightSimulateLeftItem", ListScrollCell)
slot1 = Color.New(1, 0.8, 0.8, 1)
slot2 = Color.white
slot3 = nil

function slot0.init(slot0, slot1)
	slot0._btn = gohelper.findChildButtonWithAudio(slot1, "btn")

	slot0._btn:AddClickListener(slot0._onClickItem, slot0)

	slot0._imgBtn = gohelper.findChildImage(slot1, "btn")
	slot0._txtName = gohelper.findChildText(slot1, "btn/Text")
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._chapterCO = slot1
	slot0._txtName.text = slot0._chapterCO.name
	slot0._imgBtn.color = slot0._chapterCO.id == uv0 and uv1 or uv2

	if uv0 then
		if slot0._chapterCO.id == uv0 then
			GMFightSimulateRightModel.instance:setChapterId(slot0._chapterCO.id)
		end
	elseif slot0._index == 1 then
		uv0 = slot0._chapterCO.id

		slot0._view:setSelect(slot0._chapterCO)
		GMFightSimulateRightModel.instance:setChapterId(slot0._chapterCO.id)
	end
end

function slot0._onClickItem(slot0)
	uv0 = slot0._chapterCO.id
	slot0._imgBtn.color = uv1

	slot0._view:setSelect(slot0._chapterCO)
	GMFightSimulateRightModel.instance:setChapterId(slot0._chapterCO.id)
end

function slot0.onSelect(slot0, slot1)
	slot0._imgBtn.color = slot0._chapterCO.id == uv0 and uv1 or uv2
end

function slot0.onDestroy(slot0)
	if slot0._btn then
		slot0._btn:RemoveClickListener()

		slot0._btn = nil
	end
end

return slot0

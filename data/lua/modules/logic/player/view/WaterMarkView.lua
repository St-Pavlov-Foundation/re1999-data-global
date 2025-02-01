module("modules.logic.player.view.WaterMarkView", package.seeall)

slot0 = class("WaterMarkView", BaseView)

function slot0.onInitView(slot0)
	slot0.goWaterMarkTemplate = gohelper.findChild(slot0.viewGO, "#txt_template")

	gohelper.setActive(slot0.goWaterMarkTemplate, false)

	slot0.goWaterMarkList = slot0:getUserDataTb_()
	slot1 = ViewMgr.instance:getUILayer(UILayerName.IDCanvasPopUp)
	slot0.maxHeight = recthelper.getHeight(slot1.transform)
	slot0.maxWidth = recthelper.getWidth(slot1.transform)
	slot0.hInterval = 50
	slot0.wInterval = 200
end

function slot0.onOpen(slot0)
	slot0:updateWaterMark(slot0.viewParam.userId)
end

function slot0.updateWaterMark(slot0, slot1)
	if slot1 == slot0.userId then
		return
	end

	slot0.userId = slot1
	slot2 = slot0.wInterval
	slot3 = slot0.hInterval
	slot4, slot5 = nil
	slot6 = 0

	while slot3 <= slot0.maxHeight do
		if not slot0.goWaterMarkList[slot6 + 1] then
			table.insert(slot0.goWaterMarkList, gohelper.cloneInPlace(slot0.goWaterMarkTemplate):GetComponent(gohelper.Type_TextMesh))
		end

		gohelper.setActive(slot4.gameObject, true)

		slot4.text = slot0.userId
		slot4.color = slot6 % 2 == 0 and Color.New(1, 1, 1, 0.16) or Color.New(0, 0, 0, 0.16)

		recthelper.setAnchor(slot4.gameObject.transform, slot2, slot3)
		transformhelper.setLocalRotation(slot4.gameObject.transform, 0, 0, -25)

		slot3 = slot3 + slot0.hInterval

		if slot0.maxWidth <= slot2 + slot0.wInterval then
			slot2 = slot2 - slot0.maxWidth
		end
	end

	for slot10 = slot6 + 1, #slot0.goWaterMarkList do
		gohelper.setActive(slot0.goWaterMarkList[slot10].gameObject, false)
	end
end

function slot0.hideWaterMark(slot0)
	gohelper.setActive(slot0.viewGO, false)
end

function slot0.showWaterMark(slot0)
	gohelper.setActive(slot0.viewGO, true)
end

function slot0.onDestroyView(slot0)
	slot0.goWaterMarkList = nil
end

return slot0

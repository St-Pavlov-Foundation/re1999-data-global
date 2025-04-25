module("modules.logic.versionactivity2_5.liangyue.view.LiangYueDragItem", package.seeall)

slot0 = class("LiangYueDragItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.rectTran = slot1.transform
	slot0._image_illustration = gohelper.findChildSingleImage(slot1, "Piece")
	slot0._image_illustration_frame = gohelper.findChildSingleImage(slot1, "PieceFrame")
	slot0._txtNum = gohelper.findChildTextMesh(slot1, "Tips/image_NumBG/#txt_Num")
	slot0._goTips = gohelper.findChild(slot1, "Tips")
	slot0._goTargetIconOneRow = gohelper.findChild(slot1, "Tips/TargetIconOneRow")
	slot0._goTargetIconTwoColumn = gohelper.findChild(slot1, "Tips/TargetIconTwoColumn")
	slot0._goTargetIconOneColumn = gohelper.findChild(slot1, "Tips/TargetIconOneColumn")

	slot0:initComp()
end

function slot0.initComp(slot0)
	slot0._iconHeight = recthelper.getHeight(slot0._image_illustration.transform)
	slot0._iconWidth = recthelper.getWidth(slot0._image_illustration.transform)
	slot0._attributeItemList = {}

	for slot5, slot6 in ipairs({
		slot0._goTargetIconOneColumn,
		slot0._goTargetIconTwoColumn,
		slot0._goTargetIconOneRow
	}) do
		slot7 = LiangYueAttributeItem.New()

		slot7:init(slot6)
		table.insert(slot0._attributeItemList, slot7)
	end
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.go, slot1)
end

function slot0.setInfo(slot0, slot1, slot2, slot3, slot4)
	slot0.id = slot1
	slot0.config = slot2
	slot0.isStatic = slot3
	slot0.isFinish = slot4

	slot0._image_illustration:LoadImage(ResUrl.getV2a5LiangYueImg(string.format("v2a5_liangyue_game_list_piece%s", slot2.imageId)), slot0.onIllustrationLoadBack, slot0)

	if slot3 then
		slot0._image_illustration_frame:LoadImage(ResUrl.getV2a5LiangYueImg(string.format("v2a5_liangyue_game_pieceframe%s", slot2.imageId)), slot0.onIllustrationBgLoadBack, slot0)
	end

	gohelper.setActive(slot0._goTips, slot3 and not slot4)
	gohelper.setActive(slot0._image_illustration_frame.gameObject, slot3)
end

function slot0.setIndex(slot0, slot1)
	slot0._txtNum.text = slot1
end

function slot0.setAttributeState(slot0, slot1)
	gohelper.setActive(slot0._goTips, slot1)
end

function slot0.onIllustrationBgLoadBack(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0._image_illustration_frame.gameObject)
end

function slot0.onIllustrationLoadBack(slot0)
	slot1 = slot0._image_illustration.transform

	ZProj.UGUIHelper.SetImageSize(slot1.gameObject)

	slot2 = recthelper.getWidth(slot1)
	slot3 = recthelper.getHeight(slot1)
	slot0.width = slot2
	slot0.height = slot3

	recthelper.setSize(slot0.go.transform, slot2, slot3)

	if not slot0.isStatic or slot0.isFinish then
		return
	end

	slot5 = slot0.config

	slot0:setAttributeInfo(slot5.activityId, slot5.id, slot4)
end

function slot0.setAttributeInfo(slot0, slot1, slot2, slot3)
	slot5 = LiangYueConfig.instance:getIllustrationShape(slot1, slot2)
	slot7 = #slot5

	slot0._attributeItemList[Mathf.Clamp(#slot5[1], LiangYueEnum.AttributeType.OneColumn, LiangYueEnum.AttributeType.OneRow)]:setInfo(LiangYueConfig.instance:getIllustrationAttribute(slot1, slot2))

	if slot0._shapeId == slot2 then
		return
	end

	slot0._shapeId = slot2

	for slot13, slot14 in ipairs(slot0._attributeItemList) do
		slot14:setActive(slot13 == slot8)
	end

	for slot13, slot14 in ipairs(slot5) do
		for slot19, slot20 in ipairs(slot14) do
			if slot20 == 1 and 0 + 1 == slot6 then
				slot0._currentItem = slot9

				slot9:setItemPos(slot13, slot7)
				logNormal("第一个最宽的行索引: " .. slot13)

				if slot3 then
					slot0:delayRefreshInfo()
				end

				return
			end
		end
	end

	logError("can not find fixable row")

	slot0._currentItem = slot9

	slot9:setItemPos(1, slot7)

	if slot3 then
		slot0:delayRefreshInfo()
	end
end

function slot0.delayRefreshInfo(slot0)
	ZProj.UGUIHelper.RebuildLayout(slot0._currentItem.go.transform)
	slot0:setAttributeState(false)
	TaskDispatcher.runDelay(slot0.setItemPosY, slot0, 0.1)
end

function slot0.setItemPosY(slot0)
	TaskDispatcher.cancelTask(slot0.setItemPosY, slot0)
	slot0:setAttributeState(true)

	if slot0._currentItem == nil then
		logError("没有找到对应的数值组件")

		return
	end

	slot4 = slot0.height / slot1.columnCount
	slot5 = 0

	ZProj.UGUIHelper.RebuildLayout(slot0._currentItem.go.transform)

	slot6 = LiangYueEnum.AttributeOffset

	recthelper.setAnchorY(slot0._goTips.transform, (slot1.yPos <= 1 and (slot3 - slot2 + 1) * slot4 - slot6 or (slot3 - slot2) * slot4 + slot6) - slot0.height * 0.5)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.setItemPosY, slot0)
end

return slot0

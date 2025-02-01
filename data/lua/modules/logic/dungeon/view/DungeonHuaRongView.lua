module("modules.logic.dungeon.view.DungeonHuaRongView", package.seeall)

slot0 = class("DungeonHuaRongView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#go_container/#go_item")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_container/#go_item/#simage_bg")
	slot0._txtnumber = gohelper.findChildText(slot0.viewGO, "#go_container/#go_item/#txt_number")
	slot0._btnshowsteps = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_showsteps")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnshowsteps:AddClickListener(slot0._btnshowstepsOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnshowsteps:RemoveClickListener()
end

slot0.originData = {
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12,
	13,
	14,
	15
}
slot0.moveDuration = 0.5

function slot0._btnshowstepsOnClick(slot0)
	for slot5 = 1, #slot0.clickedPoses do
		slot1 = "" .. "\n" .. string.format("Vector2(%s, %s),", slot0.clickedPoses[slot5].x, slot0.clickedPoses[slot5].y)
	end

	logWarn(slot1)
end

function slot0._editableInitView(slot0)
	slot0.gridLayoutComp = slot0._gocontainer:GetComponent(gohelper.Type_GridLayoutGroup)

	gohelper.setActive(slot0._goitem, false)
	gohelper.setActive(slot0._btnshowsteps.gameObject, SLFramework.FrameworkSettings.IsEditor)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._callBack = slot0.viewParam.callBack
	slot0._callBackObject = slot0.viewParam.callBackObject
	slot0.itemList = slot0:getEmpty4x4List()
	slot0.clickList = {}
	slot0.emptyPos = Vector2(0, 0)
	slot0.boardData = slot0:initBoardData(uv0.originData)
	slot0.movingCount = 0
	slot0._succ = false

	slot0:resetMoveProperties()
	slot0:refreshBoard(slot0.boardData)

	if SLFramework.FrameworkSettings.IsEditor then
		slot0.clickedPoses = {}
	end
end

function slot0.onOpenFinish(slot0)
	slot0.gridLayoutComp.enabled = false
end

function slot0.initBoardData(slot0, slot1)
	slot2 = slot0:getEmpty4x4List(0)

	for slot6 = 1, #slot1 do
		slot7, slot8 = slot0:_numTo4x4Pos(slot6)
		slot2[slot7][slot8] = slot1[slot6]
	end

	return slot2
end

function slot0.refreshBoard(slot0, slot1)
	for slot5 = 1, #slot1 do
		for slot9 = 1, #slot1[slot5] do
			slot10 = slot0:getUserDataTb_()
			slot10.pos = Vector2(slot5, slot9)
			slot10.data = slot1[slot5][slot9]
			slot10.go = gohelper.clone(slot0._goitem, slot0._gocontainer, string.format("item%s_%s", slot5, slot9))

			gohelper.setActive(slot10.go, true)

			slot10.txtnumber = gohelper.findChildText(slot10.go, "#txt_number")
			slot10.simagebg = gohelper.findChildSingleImage(slot10.go, "#simage_bg")
			slot10.click = gohelper.getClick(slot10.go)

			slot10.click:AddClickListener(slot0._onClickItem, slot0, slot10)

			if slot1[slot5][slot9] ~= 0 then
				slot10.txtnumber.text = slot1[slot5][slot9]

				gohelper.setActive(slot10.txtnumber.gameObject, true)
				gohelper.setActive(slot10.simagebg.gameObject, true)
			else
				slot0.emptyPos = Vector2(slot5, slot9)

				gohelper.setActive(slot10.txtnumber.gameObject, false)
				gohelper.setActive(slot10.simagebg.gameObject, false)
			end

			slot0.itemList[slot5][slot9] = slot10

			table.insert(slot0.clickList, slot10.click)
		end
	end
end

function slot0._onClickItem(slot0, slot1)
	if slot0.movingCount ~= 0 then
		return
	end

	slot3 = slot1.pos.y

	if slot1.pos.x == slot0.emptyPos.x and slot3 == slot0.emptyPos.y then
		return
	end

	if slot2 ~= slot0.emptyPos.x and slot3 ~= slot0.emptyPos.y then
		return
	end

	slot0:resetMoveProperties()

	slot0.clickAnchorPos = slot1.go.transform.anchoredPosition

	if slot2 == slot0.emptyPos.x then
		if slot0.emptyPos.y < slot3 then
			for slot7 = slot0.emptyPos.y + 1, slot3 do
				table.insert(slot0.currSrcTransform, slot0.itemList[slot2][slot7].go.transform)
				table.insert(slot0.currDestTransforms, slot0.itemList[slot2][slot7 - 1].go.transform)
				table.insert(slot0.currSrcPos, Vector2(slot2, slot7))
				table.insert(slot0.currDestPos, Vector2(slot2, slot7 - 1))
			end
		else
			for slot7 = slot0.emptyPos.y - 1, slot3, -1 do
				table.insert(slot0.currSrcTransform, slot0.itemList[slot2][slot7].go.transform)
				table.insert(slot0.currDestTransforms, slot0.itemList[slot2][slot7 + 1].go.transform)
				table.insert(slot0.currSrcPos, Vector2(slot2, slot7))
				table.insert(slot0.currDestPos, Vector2(slot2, slot7 + 1))
			end
		end
	end

	if slot3 == slot0.emptyPos.y then
		if slot0.emptyPos.x < slot2 then
			for slot7 = slot0.emptyPos.x + 1, slot2 do
				table.insert(slot0.currSrcTransform, slot0.itemList[slot7][slot3].go.transform)
				table.insert(slot0.currDestTransforms, slot0.itemList[slot7 - 1][slot3].go.transform)
				table.insert(slot0.currSrcPos, Vector2(slot7, slot3))
				table.insert(slot0.currDestPos, Vector2(slot7 - 1, slot3))
			end
		else
			for slot7 = slot0.emptyPos.x - 1, slot2, -1 do
				table.insert(slot0.currSrcTransform, slot0.itemList[slot7][slot3].go.transform)
				table.insert(slot0.currDestTransforms, slot0.itemList[slot7 + 1][slot3].go.transform)
				table.insert(slot0.currSrcPos, Vector2(slot7, slot3))
				table.insert(slot0.currDestPos, Vector2(slot7 + 1, slot3))
			end
		end
	end

	if SLFramework.FrameworkSettings.IsEditor then
		table.insert(slot0.clickedPoses, slot1.pos)
	end

	slot0:moveItems(slot0.currSrcTransform, slot0.currDestTransforms)
end

function slot0.moveItems(slot0, slot1, slot2)
	slot0.movingCount = #slot1

	for slot6 = 1, #slot1 do
		slot7, slot8 = recthelper.getAnchor(slot2[slot6])

		ZProj.TweenHelper.DOAnchorPos(slot1[slot6], slot7, slot8, uv0.moveDuration, slot0.moveDoneCallback, slot0)
	end
end

function slot0.moveDoneCallback(slot0)
	slot0.movingCount = slot0.movingCount - 1

	if slot0.movingCount == 0 then
		slot0:changeBoardData()
		slot0:checkSuccess()
		slot0:resetMoveProperties()
	end
end

function slot0.changeBoardData(slot0)
	slot0.emptyPos = slot0.currSrcPos[#slot0.currSrcPos]
	slot0.itemList[slot0.emptyPos.x][slot0.emptyPos.y].go.transform.anchoredPosition = slot0.clickAnchorPos

	for slot6 = 1, #slot0.currDestPos do
		slot0.itemList[slot0.currDestPos[slot6].x][slot0.currDestPos[slot6].y] = slot0.itemList[slot0.currSrcPos[slot6].x][slot0.currSrcPos[slot6].y]
		slot0.itemList[slot0.currDestPos[slot6].x][slot0.currDestPos[slot6].y].pos = Vector2(slot0.currDestPos[slot6].x, slot0.currDestPos[slot6].y)
	end

	slot0.itemList[slot1.x][slot1.y] = slot2
end

function slot0.checkSuccess(slot0)
	if slot0:isValidBoard() then
		logWarn("success")

		slot0._succ = true

		for slot4, slot5 in ipairs(slot0.clickList) do
			slot5:RemoveClickListener()
		end
	end
end

function slot0.isValidBoard(slot0)
	for slot4 = 1, 4 do
		for slot8 = 1, 4 do
			if slot0.itemList[slot4][slot8].data + 1 ~= slot0:_4x4ToNumPos(slot4, slot8) then
				return false
			end
		end
	end

	return true
end

function slot0.resetMoveProperties(slot0)
	slot0.currSrcTransform = {}
	slot0.currSrcPos = {}
	slot0.currDestTransforms = {}
	slot0.currDestPos = {}
	slot0.clickAnchorPos = nil
end

function slot0.getEmpty4x4List(slot0, slot1)
	for slot6 = 1, 4 do
		for slot10 = 1, 4 do
			table.insert(slot2[slot6], slot1 or 0)
		end
	end

	return {
		[slot6] = {}
	}
end

function slot0._numTo4x4Pos(slot0, slot1)
	slot2 = math.ceil(slot1 / 4)

	if slot1 % 4 == 0 then
		slot3 = 4
	end

	return slot2, slot3
end

function slot0._4x4ToNumPos(slot0, slot1, slot2)
	return (slot1 - 1) * 4 + slot2
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0.clickList) do
		slot5:RemoveClickListener()
	end

	slot0.itemList = {}

	if slot0._callBack then
		slot0._callBack(slot0._callBackObject, slot0._succ)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0

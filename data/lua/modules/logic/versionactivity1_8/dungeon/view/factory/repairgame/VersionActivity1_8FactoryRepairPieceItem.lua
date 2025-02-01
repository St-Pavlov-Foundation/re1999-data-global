module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairPieceItem", package.seeall)

slot0 = class("VersionActivity1_8FactoryRepairPieceItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "go_content")
	slot0._btnContentDrag = SLFramework.UGUI.UIDragListener.Get(slot0._gocontent)
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "go_content/image_icon")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "go_content/image_NumBG/txt_Num")
	slot0._txtNumZero = gohelper.findChildText(slot0.viewGO, "go_content/image_NumBG/txt_NumZero")
end

function slot0.setTypeId(slot0, slot1)
	slot0._typeId = slot1
end

function slot0.addEventListeners(slot0)
	if slot0._btnContentDrag then
		slot0._btnContentDrag:AddDragBeginListener(slot0._onDragBegin, slot0)
		slot0._btnContentDrag:AddDragListener(slot0._onDragIng, slot0)
		slot0._btnContentDrag:AddDragEndListener(slot0._onDragEnd, slot0)
	end
end

function slot0.removeEventListeners(slot0)
	if slot0._btnContentDrag then
		slot0._btnContentDrag:RemoveDragBeginListener()
		slot0._btnContentDrag:RemoveDragListener()
		slot0._btnContentDrag:RemoveDragEndListener()
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._isStarDrag = false

	if slot0:_getPlaceNum() > 0 then
		slot0._isStarDrag = true

		Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragBegin, slot2.position, slot0._typeId, ArmPuzzlePipeEnum.ruleConnect[slot0._typeId])
	end
end

function slot0._onDragIng(slot0, slot1, slot2)
	if slot0._isStarDrag then
		Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragIng, slot2.position)
	end
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if slot0._isStarDrag then
		slot0._isStarDrag = false

		Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragEnd, slot2.position)
	end
end

function slot0._getPlaceNum(slot0)
	return Activity157RepairGameModel.instance:getPlaceNum(slot0._typeId)
end

function slot0.refreshUI(slot0)
	if not (slot0:_getPlaceNum() <= 0) then
		slot0._txtNum.text = slot1
	else
		slot0._txtNumZero.text = slot1
	end

	UISpriteSetMgr.instance:setArmPipeSprite(slot0._imageicon, slot2 and ArmPuzzlePipeEnum.UIDragEmptyRes[slot0._typeId] or ArmPuzzlePipeEnum.UIDragRes[slot0._typeId], true)

	if slot0._isLastZero ~= slot2 then
		slot0._isLastZero = slot2

		gohelper.setActive(slot0._txtNum, not slot2)
		gohelper.setActive(slot0._txtNumZero, slot2)
	end
end

function slot0.onDestroy(slot0)
end

return slot0

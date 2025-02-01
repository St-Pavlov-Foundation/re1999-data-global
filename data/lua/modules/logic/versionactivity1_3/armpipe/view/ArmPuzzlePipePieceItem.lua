module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipePieceItem", package.seeall)

slot0 = class("ArmPuzzlePipePieceItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "go_content")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "go_content/image_icon")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "go_content/image_NumBG/txt_Num")
	slot0._txtNumZero = gohelper.findChildText(slot0.viewGO, "go_content/image_NumBG/txt_NumZero")

	slot0:_editableInitView()
end

function slot0.addEventListeners(slot0)
	if slot0._btnUIdrag then
		slot0._btnUIdrag:AddDragBeginListener(slot0._onDragBegin, slot0)
		slot0._btnUIdrag:AddDragListener(slot0._onDragIng, slot0)
		slot0._btnUIdrag:AddDragEndListener(slot0._onDragEnd, slot0)
	end
end

function slot0.removeEventListeners(slot0)
	if slot0._btnUIdrag then
		slot0._btnUIdrag:RemoveDragBeginListener()
		slot0._btnUIdrag:RemoveDragListener()
		slot0._btnUIdrag:RemoveDragEndListener()
	end
end

function slot0.onStart(slot0)
end

function slot0.onDestroy(slot0)
end

function slot0._editableInitView(slot0)
	slot0._btnUIdrag = SLFramework.UGUI.UIDragListener.Get(slot0._gocontent)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._isStarDrag = false

	if slot0:_getPlaceNum() > 0 then
		slot0._isStarDrag = true

		ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragBegin, slot2.position, slot0._typeId, ArmPuzzlePipeEnum.ruleConnect[slot0._typeId])
	end
end

function slot0._onDragIng(slot0, slot1, slot2)
	if slot0._isStarDrag then
		ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragIng, slot2.position)
	end
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if slot0._isStarDrag then
		slot0._isStarDrag = false

		ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.UIPipeDragEnd, slot2.position)
	end
end

function slot0.setTypeId(slot0, slot1)
	slot0._typeId = slot1
end

function slot0.initItem(slot0, slot1)
end

function slot0._getPlaceNum(slot0)
	return ArmPuzzlePipeModel.instance:getPlaceNum(slot0._typeId)
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

return slot0

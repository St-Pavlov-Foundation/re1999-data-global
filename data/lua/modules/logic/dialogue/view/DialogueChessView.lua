module("modules.logic.dialogue.view.DialogueChessView", package.seeall)

slot0 = class("DialogueChessView", BaseView)

function slot0.onInitView(slot0)
	slot0._gochesscontainer = gohelper.findChild(slot0.viewGO, "#go_chesscontainer")
	slot0._gochessitem = gohelper.findChild(slot0.viewGO, "#go_chesscontainer/#go_chessitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gochessitem, false)

	slot0.chessItemList = {}

	slot0:addEventCb(DialogueController.instance, DialogueEvent.BeforePlayStep, slot0.onBeforePlayStep, slot0)
end

function slot0.onOpenFinish(slot0)
	slot0.openFinishDone = true

	slot0:onBeforePlayStep(slot0.tempStepCo)

	slot0.tempStepCo = nil
end

function slot0.initChessItem(slot0)
	if slot0.dialogueId then
		return
	end

	slot0.dialogueId = slot0.viewContainer.viewParam.dialogueId

	if not DialogueConfig.instance:getChessCoList(slot0.dialogueId) then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0:createChessItem(slot6)
	end
end

function slot0.onBeforePlayStep(slot0, slot1)
	slot0:initChessItem()

	if not slot0.openFinishDone then
		slot0.tempStepCo = slot1

		return
	end

	for slot6, slot7 in ipairs(slot0.chessItemList) do
		slot8 = slot7.chessCo.id == slot1.chessId

		gohelper.setActive(slot7.goTalking, slot8)
		gohelper.setActive(slot7.goFootShadow, slot8)

		if slot8 then
			slot7.animator:Play("jump", 0, 0)
		end
	end
end

function slot0.createChessItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0._gochessitem, slot1.id)

	gohelper.setActive(slot2.go, true)

	slot2.animator = slot2.go:GetComponent(gohelper.Type_Animator)
	slot2.imageChess = gohelper.findChildSingleImage(slot2.go, "#chess")

	slot2.imageChess:LoadImage(ResUrl.getChessDialogueSingleBg(slot1.res))

	slot2.goTalking = gohelper.findChild(slot2.go, "#go_talking")
	slot2.goFootShadow = gohelper.findChild(slot2.go, "light2")

	gohelper.setActive(slot2.goTalking, false)
	gohelper.setActive(slot2.goFootShadow, false)

	slot2.chessCo = slot1

	table.insert(slot0.chessItemList, slot2)

	slot3 = string.splitToNumber(slot1.pos, "#")

	recthelper.setAnchor(slot2.go.transform, slot3[1], slot3[2])

	return slot2
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.chessItemList) do
		slot5.imageChess:UnLoadImage()
	end
end

return slot0

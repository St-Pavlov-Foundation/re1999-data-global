module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogTaskView", package.seeall)

slot0 = class("AergusiDialogTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotask = gohelper.findChild(slot0.viewGO, "#go_task")
	slot0._gotarget1 = gohelper.findChild(slot0.viewGO, "#go_task/TargetList/#go_target1")
	slot0._txttarget1desc = gohelper.findChildText(slot0.viewGO, "#go_task/TargetList/#go_target1/#txt_target1desc")
	slot0._gotarget2 = gohelper.findChild(slot0.viewGO, "#go_task/TargetList/#go_target2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._taskItems = {}

	slot0:_addEvents()
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._gotarget1, false)
	gohelper.setActive(slot0._gotarget2, false)
end

function slot0.showTaskItems(slot0)
	gohelper.setActive(slot0._gotarget1, false)

	if LuaUtil.getStrLen(AergusiConfig.instance:getEvidenceConfig(AergusiDialogModel.instance:getCurDialogGroup()).puzzleTxt) ~= 0 then
		gohelper.setActive(slot0._gotarget1, true)

		slot0._txttarget1desc.text = slot2.puzzleTxt
	end

	for slot6, slot7 in pairs(slot0._taskItems) do
		slot7:hide()
	end

	for slot7 = #AergusiDialogModel.instance:getTargetGroupList(), 1, -1 do
		if not slot0._taskItems[slot7] then
			slot8 = AergusiDialogTaskItem.New()

			slot8:init(gohelper.cloneInPlace(slot0._gotarget2, "target" .. slot7), slot7)

			slot0._taskItems[slot7] = slot8
		end

		slot0._taskItems[slot7]:setCo(slot3[slot7])
		slot0._taskItems[slot7]:refreshItem()
	end
end

function slot0.onClose(slot0)
end

function slot0._addEvents(slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, slot0._onShowDialogGroupFinished, slot0)
	slot0:addEventCb(AergusiController.instance, AergusiEvent.OnStartDialogGroup, slot0._onStartDialogGroup, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnShowDialogGroupFinished, slot0._onShowDialogGroupFinished, slot0)
	slot0:removeEventCb(AergusiController.instance, AergusiEvent.OnStartDialogGroup, slot0._onStartDialogGroup, slot0)
end

function slot0._onShowDialogGroupFinished(slot0)
	slot0:showTaskItems()
	AergusiController.instance:dispatchEvent(AergusiEvent.OnGuideShowTask)
end

function slot0._onStartDialogGroup(slot0)
	for slot4, slot5 in pairs(slot0._taskItems) do
		slot5:refreshItem()
	end
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()

	if slot0._taskItems then
		for slot4, slot5 in pairs(slot0._taskItems) do
			slot5:destroy()
		end

		slot0._taskItems = nil
	end
end

return slot0

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogTaskItem", package.seeall)

slot0 = class("AergusiDialogTaskItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0._index = slot2
	slot0._groupId = 0
	slot0._txttarget2desc = gohelper.findChildText(slot1, "#txt_target2desc")
	slot0._goTargetFinished = gohelper.findChild(slot1, "#go_TargetFinished")

	gohelper.setSibling(slot1, 2)
	slot0:_addEvents()
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.setCo(slot0, slot1)
	slot0._groupId = slot1
end

function slot0.refreshItem(slot0)
	gohelper.setActive(slot0.go, false)

	if LuaUtil.getStrLen(AergusiConfig.instance:getEvidenceConfig(slot0._groupId).conditionStr) == 0 then
		return
	end

	gohelper.setActive(slot0.go, true)

	if AergusiDialogModel.instance:getCurDialogGroup() ~= slot0._groupId then
		slot0._txttarget2desc.text = string.format("<s>%s</s>", slot1.conditionStr)
	else
		slot0._txttarget2desc.text = slot1.conditionStr
	end

	gohelper.setActive(slot0._goTargetFinished, slot2 ~= slot0._groupId)
end

function slot0._addEvents(slot0)
end

function slot0._removeEvents(slot0)
end

function slot0.destroy(slot0)
	slot0:_removeEvents()
end

return slot0

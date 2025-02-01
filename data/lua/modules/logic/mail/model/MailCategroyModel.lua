module("modules.logic.mail.model.MailCategroyModel", package.seeall)

slot0 = class("MailCategroyModel", ListScrollModel)

function slot0.setCategoryList(slot0, slot1, slot2)
	slot0._moList = {}

	if slot1 then
		slot0._moList = slot1

		if slot2 then
			table.sort(slot0._moList, slot0._sortFunction)
		end
	end

	slot0:setList(slot0._moList)
	slot0:_refreshCount()
end

function slot0._sortFunction(slot0, slot1)
	slot2 = 0
	slot3 = 0

	if slot0.state < slot1.state then
		slot2 = 2
	elseif slot1.state < slot0.state then
		slot2 = -2
	end

	if slot0.createTime < slot1.createTime then
		slot3 = -1
	elseif slot1.createTime < slot0.createTime then
		slot3 = 1
	end

	return slot2 + slot3 > 0
end

function slot0.addMail(slot0)
	slot0:_refreshCount()
end

function slot0.refreshCategoryList(slot0, slot1)
	MailController.instance:dispatchEvent(MailEvent.OnMailDel, slot1)
	slot0:_refreshCount()
end

function slot0.refreshCategoryItem(slot0, slot1)
	MailController.instance:dispatchEvent(MailEvent.OnMailRead, slot1)
	slot0:_refreshCount()
end

function slot0._refreshCount(slot0)
	MailController.instance:dispatchEvent(MailEvent.OnMailCountChange)
end

slot0.instance = slot0.New()

return slot0

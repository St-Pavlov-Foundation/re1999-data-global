module("modules.logic.mail.model.MailModel", package.seeall)

slot0 = class("MailModel", BaseModel)

function slot0.onInit(slot0)
	slot0._curCategoryId = 0
	slot0._categoryList = {}
	slot0._categoryListItem = {}
	slot0._readedMailIds = {}

	TaskDispatcher.cancelTask(slot0.delExpiredMail, slot0)
end

function slot0.reInit(slot0)
	slot0._curCategoryId = 0
	slot0._categoryList = {}
	slot0._categoryListItem = {}
	slot0._readedMailIds = {}

	TaskDispatcher.cancelTask(slot0.delExpiredMail, slot0)
end

function slot0.setMailList(slot0)
	MailCategroyModel.instance:setCategoryList(slot0._categoryList, true)
end

function slot0.getReadedMailIds(slot0)
	return slot0._readedMailIds
end

function slot0.getMailList(slot0)
	return slot0._categoryList
end

function slot0.onGetMailItemList(slot0, slot1)
	slot0._categoryList = {}

	for slot5, slot6 in pairs(slot1) do
		if slot0:initMailMO(slot6) then
			table.insert(slot0._categoryList, slot7)

			if slot7.state == MailEnum.ReadStatus.Read then
				slot0._readedMailIds[slot7.id] = true
			end
		end
	end

	slot0:checkExpiredMail()
	MailCategroyModel.instance:setCategoryList(slot0._categoryList, true)
end

function slot0.checkExpiredMail(slot0)
	TaskDispatcher.cancelTask(slot0.delExpiredMail, slot0)

	slot0._willDelId = 0
	slot1 = 0
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(slot0._categoryList) do
		if tonumber(slot8.expireTime) <= 0 then
			table.insert(slot2, slot8)
		elseif slot9 / 1000 - ServerTime.now() > 0 then
			if slot10 < slot1 or slot1 == 0 then
				slot0._willDelId = slot8.id
				slot1 = slot10
			end

			table.insert(slot2, slot8)
		else
			table.insert(slot3, slot8.id)
		end
	end

	slot0._categoryList = slot2

	if slot0._willDelId ~= 0 then
		TaskDispatcher.runDelay(slot0.delExpiredMail, slot0, slot1)
	end

	if #slot3 > 0 then
		MailCategroyModel.instance:setCategoryList(slot0._categoryList)
		MailCategroyModel.instance:refreshCategoryList(slot3)
	end
end

function slot0.delExpiredMail(slot0)
	slot0:delMail({
		slot0._willDelId
	})
	slot0:checkExpiredMail()
end

function slot0.initMailMO(slot0, slot1)
	for slot7, slot8 in pairs(MailConfig.instance:getCategoryCO()) do
		table.insert({}, slot8)
	end

	if slot1.mailId ~= 0 then
		for slot7, slot8 in pairs(slot2) do
			if slot8.id == slot1.mailId then
				slot9 = MailCategroyMo.New()

				slot9:init(slot8)
				slot9:getItem(string.split(slot1.attachment, "|"), string.split(slot8.attachment, "|"))
				slot9:getRpc(slot1.state, slot1.createTime, slot1.params, slot1.incrId, slot8.needShowToast, slot1.mailId)

				if slot1.expireTime ~= nil then
					slot9:getExpireTime(slot1.expireTime)
				end

				return slot9
			end
		end
	else
		slot4 = MailCategroyMo.New()

		slot4:getMailType1(slot1)
		slot4:getItem(string.split(slot1.attachment, "|"))

		return slot4
	end
end

function slot0.readMail(slot0, slot1)
	slot2 = {
		slot1
	}

	for slot6, slot7 in pairs(slot0._categoryList) do
		if slot1 == slot7.id then
			slot7.state = MailEnum.ReadStatus.Read
		end
	end

	slot0._readedMailIds[slot1] = true

	MailCategroyModel.instance:setCategoryList(slot0._categoryList)
	MailCategroyModel.instance:refreshCategoryItem(slot2)
end

function slot0.readAllMail(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, tonumber(slot7))
	end

	if slot2 and next(slot2) then
		for slot6, slot7 in pairs(slot2) do
			for slot11, slot12 in pairs(slot0._categoryList) do
				if slot7 == slot12.id then
					slot12.state = MailEnum.ReadStatus.Read
				end
			end

			slot0._readedMailIds[slot7] = true
		end
	end

	MailCategroyModel.instance:setCategoryList(slot0._categoryList)
	MailCategroyModel.instance:refreshCategoryItem(slot2)
end

function slot0.delMail(slot0, slot1)
	slot2 = false

	for slot6, slot7 in pairs(slot1) do
		for slot11, slot12 in pairs(slot0._categoryList) do
			if slot7 == slot12.id then
				table.remove(slot0._categoryList, slot11)

				slot2 = true

				break
			end
		end
	end

	if slot2 then
		MailCategroyModel.instance:setCategoryList(slot0._categoryList)
		MailCategroyModel.instance:refreshCategoryList(slot1)
	end
end

function slot0.getItemList(slot0, slot1)
	for slot5, slot6 in pairs(slot0._categoryList) do
		if slot6.id == slot1 then
			return slot6
		end
	end

	return nil
end

function slot0.getCount(slot0)
	return #slot0._categoryList
end

function slot0.getUnreadCount(slot0)
	for slot5, slot6 in pairs(slot0._categoryList) do
		if slot6.state == MailEnum.ReadStatus.Unread then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.addMailModel(slot0, slot1)
	if not slot0:initMailMO(slot1[1]) then
		return
	end

	table.insert(slot0._categoryList, 1, slot2)
	slot0:checkExpiredMail()
	MailCategroyModel.instance:setCategoryList(slot0._categoryList)
	MailCategroyModel.instance:addMail()

	if slot2.mailId ~= 0 and slot2.needShowToast == 1 then
		MailController.instance:showGetMailToast(slot2.id, slot2.title)
	end
end

slot0.instance = slot0.New()

return slot0

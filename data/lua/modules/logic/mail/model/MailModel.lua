module("modules.logic.mail.model.MailModel", package.seeall)

local var_0_0 = class("MailModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._curCategoryId = 0
	arg_1_0._categoryList = {}
	arg_1_0._categoryListItem = {}
	arg_1_0._readedMailIds = {}

	TaskDispatcher.cancelTask(arg_1_0.delExpiredMail, arg_1_0)
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curCategoryId = 0
	arg_2_0._categoryList = {}
	arg_2_0._categoryListItem = {}
	arg_2_0._readedMailIds = {}

	TaskDispatcher.cancelTask(arg_2_0.delExpiredMail, arg_2_0)
end

function var_0_0.setMailList(arg_3_0)
	MailCategroyModel.instance:setCategoryList(arg_3_0._categoryList, true)
end

function var_0_0.getReadedMailIds(arg_4_0)
	return arg_4_0._readedMailIds
end

function var_0_0.getMailList(arg_5_0)
	return arg_5_0._categoryList
end

function var_0_0.onGetMailItemList(arg_6_0, arg_6_1)
	arg_6_0._categoryList = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		local var_6_0 = arg_6_0:initMailMO(iter_6_1)

		if var_6_0 then
			table.insert(arg_6_0._categoryList, var_6_0)

			if var_6_0.state == MailEnum.ReadStatus.Read then
				arg_6_0._readedMailIds[var_6_0.id] = true
			end
		end
	end

	arg_6_0:checkExpiredMail()
	MailCategroyModel.instance:setCategoryList(arg_6_0._categoryList, true)
end

function var_0_0.checkExpiredMail(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.delExpiredMail, arg_7_0)

	arg_7_0._willDelId = 0

	local var_7_0 = 0
	local var_7_1 = {}
	local var_7_2 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._categoryList) do
		local var_7_3 = iter_7_1.expireTime
		local var_7_4 = tonumber(var_7_3)

		if var_7_4 <= 0 then
			table.insert(var_7_1, iter_7_1)
		else
			local var_7_5 = var_7_4 / 1000 - ServerTime.now()

			if var_7_5 > 0 then
				if var_7_5 < var_7_0 or var_7_0 == 0 then
					arg_7_0._willDelId = iter_7_1.id
					var_7_0 = var_7_5
				end

				table.insert(var_7_1, iter_7_1)
			else
				table.insert(var_7_2, iter_7_1.id)
			end
		end
	end

	arg_7_0._categoryList = var_7_1

	if arg_7_0._willDelId ~= 0 then
		TaskDispatcher.runDelay(arg_7_0.delExpiredMail, arg_7_0, var_7_0)
	end

	if #var_7_2 > 0 then
		MailCategroyModel.instance:setCategoryList(arg_7_0._categoryList)
		MailCategroyModel.instance:refreshCategoryList(var_7_2)
	end
end

function var_0_0.delExpiredMail(arg_8_0)
	local var_8_0 = {
		arg_8_0._willDelId
	}

	arg_8_0:delMail(var_8_0)
	arg_8_0:checkExpiredMail()
end

function var_0_0.initMailMO(arg_9_0, arg_9_1)
	local var_9_0 = {}
	local var_9_1 = MailConfig.instance:getCategoryCO()

	for iter_9_0, iter_9_1 in pairs(var_9_1) do
		table.insert(var_9_0, iter_9_1)
	end

	if arg_9_1.mailId ~= 0 then
		for iter_9_2, iter_9_3 in pairs(var_9_0) do
			if iter_9_3.id == arg_9_1.mailId then
				local var_9_2 = MailCategroyMo.New()

				var_9_2:init(iter_9_3)

				local var_9_3 = string.split(arg_9_1.attachment, "|")
				local var_9_4 = string.split(iter_9_3.attachment, "|")

				var_9_2:getItem(var_9_3, var_9_4)
				var_9_2:getRpc(arg_9_1.state, arg_9_1.createTime, arg_9_1.params, arg_9_1.incrId, iter_9_3.needShowToast, arg_9_1.mailId)

				if arg_9_1.expireTime ~= nil then
					var_9_2:getExpireTime(arg_9_1.expireTime)
				end

				return var_9_2
			end
		end
	else
		local var_9_5 = MailCategroyMo.New()

		var_9_5:getMailType1(arg_9_1)
		var_9_5:getItem(string.split(arg_9_1.attachment, "|"))

		return var_9_5
	end
end

function var_0_0.readMail(arg_10_0, arg_10_1)
	local var_10_0 = {
		arg_10_1
	}

	for iter_10_0, iter_10_1 in pairs(arg_10_0._categoryList) do
		if arg_10_1 == iter_10_1.id then
			iter_10_1.state = MailEnum.ReadStatus.Read
		end
	end

	arg_10_0._readedMailIds[arg_10_1] = true

	MailCategroyModel.instance:setCategoryList(arg_10_0._categoryList)
	MailCategroyModel.instance:refreshCategoryItem(var_10_0)
end

function var_0_0.readAllMail(arg_11_0, arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		table.insert(var_11_0, tonumber(iter_11_1))
	end

	if var_11_0 and next(var_11_0) then
		for iter_11_2, iter_11_3 in pairs(var_11_0) do
			for iter_11_4, iter_11_5 in pairs(arg_11_0._categoryList) do
				if iter_11_3 == iter_11_5.id then
					iter_11_5.state = MailEnum.ReadStatus.Read
				end
			end

			arg_11_0._readedMailIds[iter_11_3] = true
		end
	end

	MailCategroyModel.instance:setCategoryList(arg_11_0._categoryList)
	MailCategroyModel.instance:refreshCategoryItem(var_11_0)
end

function var_0_0.delMail(arg_12_0, arg_12_1)
	local var_12_0 = false

	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		for iter_12_2, iter_12_3 in pairs(arg_12_0._categoryList) do
			if iter_12_1 == iter_12_3.id then
				table.remove(arg_12_0._categoryList, iter_12_2)

				var_12_0 = true

				break
			end
		end
	end

	if var_12_0 then
		MailCategroyModel.instance:setCategoryList(arg_12_0._categoryList)
		MailCategroyModel.instance:refreshCategoryList(arg_12_1)
	end
end

function var_0_0.getItemList(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._categoryList) do
		if iter_13_1.id == arg_13_1 then
			return iter_13_1
		end
	end

	return nil
end

function var_0_0.getCount(arg_14_0)
	return #arg_14_0._categoryList
end

function var_0_0.getUnreadCount(arg_15_0)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(arg_15_0._categoryList) do
		if iter_15_1.state == MailEnum.ReadStatus.Unread then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function var_0_0.addMailModel(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:initMailMO(arg_16_1[1])

	if not var_16_0 then
		return
	end

	table.insert(arg_16_0._categoryList, 1, var_16_0)
	arg_16_0:checkExpiredMail()
	MailCategroyModel.instance:setCategoryList(arg_16_0._categoryList)
	MailCategroyModel.instance:addMail()

	if var_16_0.mailId ~= 0 and var_16_0.needShowToast == 1 then
		MailController.instance:showGetMailToast(var_16_0.id, var_16_0.title)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

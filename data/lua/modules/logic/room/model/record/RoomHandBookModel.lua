module("modules.logic.room.model.record.RoomHandBookModel", package.seeall)

local var_0_0 = class("RoomHandBookModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._moList = nil
	arg_1_0._selectMo = nil
	arg_1_0._isreverse = false
end

function var_0_0.getSelectMo(arg_2_0)
	return arg_2_0._selectMo
end

function var_0_0.setSelectMo(arg_3_0, arg_3_1)
	arg_3_0._selectMo = arg_3_1
end

function var_0_0.checkCritterShowMutateBtn(arg_4_0, arg_4_1)
	return
end

function var_0_0.checkCritterRelationShip(arg_5_0)
	return
end

function var_0_0.onGetInfo(arg_6_0, arg_6_1)
	arg_6_0._moList = arg_6_1.bookInfos
	arg_6_0._moDict = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._moList) do
		arg_6_0._moDict[iter_6_1.id] = iter_6_1
	end
end

function var_0_0.getMoById(arg_7_0, arg_7_1)
	return arg_7_0._moDict and arg_7_0._moDict[arg_7_1]
end

function var_0_0.getCount(arg_8_0)
	return arg_8_0._moList and #arg_8_0._moList or 0
end

function var_0_0.setScrollReverse(arg_9_0)
	arg_9_0._isreverse = not arg_9_0._isreverse

	RoomHandBookListModel.instance:reverseCardBack(arg_9_0._isreverse)
	RoomHandBookController.instance:dispatchEvent(RoomHandBookEvent.reverseIcon)
end

function var_0_0.getReverse(arg_10_0)
	return arg_10_0._isreverse
end

function var_0_0.getSelectMoBackGroundId(arg_11_0)
	if arg_11_0._selectMo and arg_11_0._selectMo:getBackGroundId() then
		return arg_11_0._selectMo:getBackGroundId()
	end
end

function var_0_0.setBackGroundId(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.id
	local var_12_1 = arg_12_1.backgroundId

	if arg_12_0._selectMo then
		arg_12_0._selectMo:setBackGroundId(var_12_1)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

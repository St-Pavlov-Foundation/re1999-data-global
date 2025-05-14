module("modules.logic.room.model.common.RoomSkinListModel", package.seeall)

local var_0_0 = class("RoomSkinListModel", ListScrollModel)

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.id
	local var_1_1 = arg_1_1.id
	local var_1_2 = RoomConfig.instance:getRoomSkinPriority(var_1_0)
	local var_1_3 = RoomConfig.instance:getRoomSkinPriority(var_1_1)

	if var_1_2 ~= var_1_3 then
		return var_1_3 < var_1_2
	end

	local var_1_4 = RoomConfig.instance:getRoomSkinRare(var_1_0)
	local var_1_5 = RoomConfig.instance:getRoomSkinRare(var_1_1)

	if var_1_4 ~= var_1_5 then
		return var_1_5 < var_1_4
	end

	return var_1_0 < var_1_1
end

function var_0_0.onInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.clear(arg_4_0)
	arg_4_0:_clearData()
	var_0_0.super.clear(arg_4_0)
end

function var_0_0._clearData(arg_5_0)
	arg_5_0:_setSelectPartId()
	arg_5_0:setCurPreviewSkinId()
end

function var_0_0._setSelectPartId(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	arg_6_0._selectPartId = arg_6_1
end

function var_0_0.setRoomSkinList(arg_7_0, arg_7_1)
	arg_7_0:_setSelectPartId(arg_7_1)

	local var_7_0 = arg_7_0:getSelectPartId()
	local var_7_1 = {}
	local var_7_2 = RoomConfig.instance:getSkinIdList(var_7_0)

	for iter_7_0, iter_7_1 in ipairs(var_7_2) do
		local var_7_3 = {
			id = iter_7_1
		}

		var_7_1[#var_7_1 + 1] = var_7_3
	end

	table.sort(var_7_1, var_0_1)
	arg_7_0:setList(var_7_1)
end

function var_0_0.setCurPreviewSkinId(arg_8_0, arg_8_1)
	arg_8_0._curPreviewSkinId = arg_8_1

	if not arg_8_1 then
		return
	end

	local var_8_0
	local var_8_1 = arg_8_0:getList()

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		if iter_8_1.id == arg_8_1 then
			var_8_0 = iter_8_1

			break
		end
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_0._scrollViews) do
		iter_8_3:setSelect(var_8_0)
	end
end

function var_0_0.getCurPreviewSkinId(arg_9_0)
	return arg_9_0._curPreviewSkinId
end

function var_0_0.getSelectPartId(arg_10_0)
	return arg_10_0._selectPartId
end

var_0_0.instance = var_0_0.New()

return var_0_0

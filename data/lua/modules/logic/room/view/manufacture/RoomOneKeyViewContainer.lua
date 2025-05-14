module("modules.logic.room.view.manufacture.RoomOneKeyViewContainer", package.seeall)

local var_0_0 = class("RoomOneKeyViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = MixScrollParam.New()

	var_1_1.scrollGOPath = "right/#go_addPop/#scroll_production"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "right/#go_addPop/#scroll_production/viewport/content/#go_productionItem"
	var_1_1.cellClass = RoomOneKeyAddPopItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV

	table.insert(var_1_0, LuaMixScrollView.New(OneKeyAddPopListModel.instance, var_1_1))

	arg_1_0.roomOneKeyAddPopView = RoomOneKeyAddPopView.New()

	table.insert(var_1_0, arg_1_0.roomOneKeyAddPopView)

	arg_1_0.oneKeyView = RoomOneKeyView.New()

	table.insert(var_1_0, arg_1_0.oneKeyView)

	return var_1_0
end

function var_0_0.playOpenTransition(arg_2_0)
	local var_2_0 = "open"

	if ManufactureModel.instance:getRecordOneKeyType() == RoomManufactureEnum.OneKeyType.Customize then
		var_2_0 = "open2"
	end

	var_0_0.super.playOpenTransition(arg_2_0, {
		anim = var_2_0
	})
end

function var_0_0.oneKeyViewSetAddPopActive(arg_3_0, arg_3_1)
	arg_3_0.oneKeyView:setAddPopActive(arg_3_1)
end

return var_0_0

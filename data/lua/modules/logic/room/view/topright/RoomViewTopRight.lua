module("modules.logic.room.view.topright.RoomViewTopRight", package.seeall)

local var_0_0 = class("RoomViewTopRight", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._path = arg_1_1
	arg_1_0._resPath = arg_1_2
	arg_1_0._param = arg_1_3
end

function var_0_0.onInitView(arg_2_0)
	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:addEventCb(RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, arg_3_0._refreshShow, arg_3_0)
	arg_3_0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_3_0._refreshShow, arg_3_0)
	arg_3_0:addEventCb(RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, arg_3_0._refreshShow, arg_3_0)

	arg_3_0._resourceItemList = {}

	if string.nilorempty(arg_3_0._path) or string.nilorempty(arg_3_0._resPath) or not LuaUtil.tableNotEmpty(arg_3_0._param) then
		return
	end

	local var_3_0 = gohelper.findChild(arg_3_0.viewGO, arg_3_0._path)

	arg_3_0._topRight = arg_3_0.viewContainer:getResInst(arg_3_0._resPath, var_3_0, "topright")
	arg_3_0._goflyitem = gohelper.findChild(arg_3_0._topRight, "go_flyitem")
	arg_3_0._goresource = gohelper.findChild(arg_3_0._topRight, "container/resource")

	gohelper.setActive(arg_3_0._goflyitem, false)

	for iter_3_0 = 1, 6 do
		local var_3_1 = gohelper.cloneInPlace(arg_3_0._goresource, "resource" .. iter_3_0)

		gohelper.setActive(var_3_1, false)

		local var_3_2 = arg_3_0._param[iter_3_0]

		if var_3_2 then
			var_3_2.parent = arg_3_0
			var_3_2.index = iter_3_0

			local var_3_3 = gohelper.findChild(arg_3_0._topRight, "container/resource" .. iter_3_0)
			local var_3_4 = var_3_2.classDefine
			local var_3_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_3_3, var_3_4, var_3_2)
		end
	end

	gohelper.setActive(arg_3_0._goresource, false)

	arg_3_0._flyItemPoolList = arg_3_0:getUserDataTb_()
end

function var_0_0.onDestroyView(arg_4_0)
	return
end

function var_0_0._onOpenView(arg_5_0, arg_5_1)
	arg_5_0:_refreshShow()
end

function var_0_0._onCloseView(arg_6_0, arg_6_1)
	arg_6_0:_refreshShow()
end

function var_0_0._refreshShow(arg_7_0)
	local var_7_0 = arg_7_0:_getTopView()
	local var_7_1 = RoomWaterReformModel.instance:isWaterReform()
	local var_7_2 = RoomCharacterHelper.isInDialogInteraction()
	local var_7_3 = RoomSkinModel.instance:getIsShowRoomSkinList()
	local var_7_4 = RoomTransportController.instance:isTransportPathShow()

	gohelper.setActive(arg_7_0._topRight, var_7_0 == arg_7_0.viewName and not var_7_2 and not var_7_1 and not var_7_3 and not var_7_4)
end

function var_0_0._getTopView(arg_8_0)
	local var_8_0 = ViewMgr.instance:getOpenViewNameList()
	local var_8_1 = NavigateMgr.sortOpenViewNameList(var_8_0)

	for iter_8_0 = #var_8_1, 1, -1 do
		local var_8_2 = var_8_1[iter_8_0]
		local var_8_3 = ViewMgr.instance:getContainer(var_8_2)

		if var_8_3 and var_8_3._views then
			for iter_8_1 = #var_8_3._views, 1, -1 do
				if var_8_3._views[iter_8_1].__cname == arg_8_0.__cname then
					return var_8_2
				end
			end
		end
	end
end

function var_0_0.getFlyGO(arg_9_0)
	local var_9_0 = arg_9_0._flyItemPoolList[#arg_9_0._flyItemPoolList]

	if var_9_0 then
		table.remove(arg_9_0._flyItemPoolList, #arg_9_0._flyItemPoolList)
	else
		var_9_0 = gohelper.cloneInPlace(arg_9_0._goflyitem, "flyEffect")
	end

	gohelper.setActive(var_9_0, false)
	gohelper.setActive(var_9_0, true)

	return var_9_0
end

function var_0_0.returnFlyGO(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_1, false)
	table.insert(arg_10_0._flyItemPoolList, arg_10_1)
end

return var_0_0

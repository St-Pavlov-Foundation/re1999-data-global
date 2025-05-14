module("modules.logic.room.view.debug.RoomDebugSelectPackageView", package.seeall)

local var_0_0 = class("RoomDebugSelectPackageView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gopackageitem = gohelper.findChild(arg_1_0.viewGO, "scroll_package/viewport/content/#go_packageitem")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_add")
	arg_1_0._btncopy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_copy")
	arg_1_0._goselectcopy = gohelper.findChild(arg_1_0.viewGO, "#btn_copy/#go_selectcopy")
	arg_1_0._btndelete = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_delete")
	arg_1_0._goselectdelete = gohelper.findChild(arg_1_0.viewGO, "#btn_delete/#go_selectdelete")
	arg_1_0._btnrename = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_rename")
	arg_1_0._goselectrename = gohelper.findChild(arg_1_0.viewGO, "#btn_rename/#go_selectrename")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btncopy:AddClickListener(arg_2_0._btncopyOnClick, arg_2_0)
	arg_2_0._btndelete:AddClickListener(arg_2_0._btndeleteOnClick, arg_2_0)
	arg_2_0._btnrename:AddClickListener(arg_2_0._btnrenameOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btncopy:RemoveClickListener()
	arg_3_0._btndelete:RemoveClickListener()
	arg_3_0._btnrename:RemoveClickListener()
end

function var_0_0._btnaddOnClick(arg_4_0)
	RoomDebugController.instance:getDebugPackageInfo(function(arg_5_0)
		local var_5_0 = 0

		for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
			if var_5_0 < iter_5_1.packageMapId then
				var_5_0 = iter_5_1.packageMapId
			end
		end

		GameFacade.openInputBox({
			characterLimit = 100,
			sureBtnName = "确定",
			title = "输入新地图名",
			cancelBtnName = "取消",
			defaultInput = string.format("地图%d", var_5_0 + 1),
			sureCallback = function(arg_6_0)
				arg_4_0:_addCallback(arg_5_0, var_5_0, arg_6_0)
			end
		})
	end)
end

function var_0_0._addCallback(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_3 = arg_7_3 or string.format("地图%d", arg_7_2)

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if (iter_7_1.packageName or string.format("地图%d", iter_7_1.packageMapId)) == arg_7_3 then
			logError("重名")

			return
		end
	end

	RoomDebugController.instance:resetPackageJson(arg_7_2 + 1, arg_7_3)
	arg_7_0:_refreshUI()
	GameFacade.closeInputBox()
end

function var_0_0._btncopyOnClick(arg_8_0)
	arg_8_0:_clickSelectOp(2)
end

function var_0_0._copyCallback(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	RoomDebugController.instance:copyPackageJson(arg_9_2 + 1, arg_9_3, arg_9_1)
	arg_9_0:_refreshUI()
	GameFacade.closeInputBox()
end

function var_0_0._btndeleteOnClick(arg_10_0)
	arg_10_0:_clickSelectOp(3)
end

function var_0_0._btnClickOnClick(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._packageItemList[arg_11_1]

	if not var_11_0 then
		return
	end

	if arg_11_0._selectOp == 1 then
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugPackage, nil, nil, {
			packageMapId = var_11_0.packageMapId
		})
		ViewMgr.instance:closeAllPopupViews()
	elseif arg_11_0._selectOp == 2 then
		RoomDebugController.instance:getDebugPackageInfo(function(arg_12_0)
			local var_12_0 = 0

			for iter_12_0, iter_12_1 in ipairs(arg_12_0) do
				if var_12_0 < iter_12_1.packageMapId then
					var_12_0 = iter_12_1.packageMapId
				end
			end

			GameFacade.openInputBox({
				characterLimit = 100,
				sureBtnName = "确定",
				title = "输入新地图名",
				cancelBtnName = "取消",
				defaultInput = string.format("地图%d", var_12_0 + 1),
				sureCallback = function(arg_13_0)
					arg_11_0:_copyCallback(var_11_0.packageMapId, var_12_0, arg_13_0)
				end
			})
		end)
	elseif arg_11_0._selectOp == 3 then
		RoomDebugController.instance:deletePackageJson(var_11_0.packageMapId)
		arg_11_0:_refreshUI()
	elseif arg_11_0._selectOp == 4 then
		local var_11_1

		if string.nilorempty(var_11_0.packageName) then
			var_11_1 = string.format("地图%d", var_11_0.packageMapId)
		else
			var_11_1 = var_11_0.packageName
		end

		GameFacade.openInputBox({
			characterLimit = 100,
			sureBtnName = "确定",
			title = "输入新地图名",
			cancelBtnName = "取消",
			defaultInput = var_11_1,
			sureCallback = function(arg_14_0)
				arg_11_0:_renameCallback(var_11_0.packageMapId, arg_14_0)
			end
		})
	end
end

function var_0_0._btnrenameOnClick(arg_15_0)
	arg_15_0:_clickSelectOp(4)
end

function var_0_0._renameCallback(arg_16_0, arg_16_1, arg_16_2)
	RoomDebugController.instance:renamePackageJson(arg_16_1, arg_16_2)
	arg_16_0:_refreshUI()
	GameFacade.closeInputBox()
end

function var_0_0._editableInitView(arg_17_0)
	gohelper.setActive(arg_17_0._gopackageitem, false)

	arg_17_0._packageItemList = {}
	arg_17_0._selectOp = 1

	gohelper.setActive(arg_17_0._goselectcopy, false)
	gohelper.setActive(arg_17_0._goselectdelete, false)
end

function var_0_0._clickSelectOp(arg_18_0, arg_18_1)
	if arg_18_0._selectOp == arg_18_1 then
		arg_18_0._selectOp = 1
	else
		arg_18_0._selectOp = arg_18_1
	end

	gohelper.setActive(arg_18_0._goselectcopy, arg_18_0._selectOp == 2)
	gohelper.setActive(arg_18_0._goselectdelete, arg_18_0._selectOp == 3)
	gohelper.setActive(arg_18_0._goselectrename, arg_18_0._selectOp == 4)
end

function var_0_0._refreshUI(arg_19_0)
	RoomDebugController.instance:getDebugPackageInfo(function(arg_20_0)
		local var_20_0 = {}

		for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
			for iter_20_2, iter_20_3 in ipairs(iter_20_1.infos) do
				if var_20_0[iter_20_3.blockId] then
					logError("重复的blockId: " .. iter_20_3.blockId)
				end

				var_20_0[iter_20_3.blockId] = true
			end

			local var_20_1 = arg_19_0._packageItemList[iter_20_0]

			if not var_20_1 then
				var_20_1 = arg_19_0:getUserDataTb_()
				var_20_1.index = iter_20_0
				var_20_1.go = gohelper.cloneInPlace(arg_19_0._gopackageitem, "item" .. iter_20_0)
				var_20_1.txtid = gohelper.findChildText(var_20_1.go, "txt_id")
				var_20_1.btnclick = gohelper.findChildButtonWithAudio(var_20_1.go, "btn_click")

				var_20_1.btnclick:AddClickListener(arg_19_0._btnClickOnClick, arg_19_0, var_20_1.index)
				table.insert(arg_19_0._packageItemList, var_20_1)
			end

			var_20_1.packageMapId = iter_20_1.packageMapId

			if string.nilorempty(iter_20_1.packageName) then
				var_20_1.txtid.text = string.format("地图%d", iter_20_1.packageMapId)
			else
				var_20_1.txtid.text = iter_20_1.packageName
			end

			gohelper.setActive(var_20_1.go, true)
		end

		for iter_20_4 = #arg_20_0 + 1, #arg_19_0._packageItemList do
			local var_20_2 = arg_19_0._packageItemList[iter_20_4]

			gohelper.setActive(var_20_2.go, false)
		end
	end)
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0:_refreshUI()
end

function var_0_0.onClose(arg_22_0)
	return
end

function var_0_0.onDestroyView(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0._packageItemList) do
		iter_23_1.btnclick:RemoveClickListener()
	end
end

return var_0_0

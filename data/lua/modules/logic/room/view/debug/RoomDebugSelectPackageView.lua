module("modules.logic.room.view.debug.RoomDebugSelectPackageView", package.seeall)

slot0 = class("RoomDebugSelectPackageView", BaseView)

function slot0.onInitView(slot0)
	slot0._gopackageitem = gohelper.findChild(slot0.viewGO, "scroll_package/viewport/content/#go_packageitem")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_add")
	slot0._btncopy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_copy")
	slot0._goselectcopy = gohelper.findChild(slot0.viewGO, "#btn_copy/#go_selectcopy")
	slot0._btndelete = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_delete")
	slot0._goselectdelete = gohelper.findChild(slot0.viewGO, "#btn_delete/#go_selectdelete")
	slot0._btnrename = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_rename")
	slot0._goselectrename = gohelper.findChild(slot0.viewGO, "#btn_rename/#go_selectrename")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btncopy:AddClickListener(slot0._btncopyOnClick, slot0)
	slot0._btndelete:AddClickListener(slot0._btndeleteOnClick, slot0)
	slot0._btnrename:AddClickListener(slot0._btnrenameOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnadd:RemoveClickListener()
	slot0._btncopy:RemoveClickListener()
	slot0._btndelete:RemoveClickListener()
	slot0._btnrename:RemoveClickListener()
end

function slot0._btnaddOnClick(slot0)
	RoomDebugController.instance:getDebugPackageInfo(function (slot0)
		for slot5, slot6 in ipairs(slot0) do
			if 0 < slot6.packageMapId then
				slot1 = slot6.packageMapId
			end
		end

		GameFacade.openInputBox({
			characterLimit = 100,
			sureBtnName = "确定",
			title = "输入新地图名",
			cancelBtnName = "取消",
			defaultInput = string.format("地图%d", slot1 + 1),
			sureCallback = function (slot0)
				uv0:_addCallback(uv1, uv2, slot0)
			end
		})
	end)
end

function slot0._addCallback(slot0, slot1, slot2, slot3)
	slot3 = slot3 or string.format("地图%d", slot2)

	for slot7, slot8 in ipairs(slot1) do
		if (slot8.packageName or string.format("地图%d", slot8.packageMapId)) == slot3 then
			logError("重名")

			return
		end
	end

	RoomDebugController.instance:resetPackageJson(slot2 + 1, slot3)
	slot0:_refreshUI()
	GameFacade.closeInputBox()
end

function slot0._btncopyOnClick(slot0)
	slot0:_clickSelectOp(2)
end

function slot0._copyCallback(slot0, slot1, slot2, slot3)
	RoomDebugController.instance:copyPackageJson(slot2 + 1, slot3, slot1)
	slot0:_refreshUI()
	GameFacade.closeInputBox()
end

function slot0._btndeleteOnClick(slot0)
	slot0:_clickSelectOp(3)
end

function slot0._btnClickOnClick(slot0, slot1)
	if not slot0._packageItemList[slot1] then
		return
	end

	if slot0._selectOp == 1 then
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugPackage, nil, , {
			packageMapId = slot2.packageMapId
		})
		ViewMgr.instance:closeAllPopupViews()
	elseif slot0._selectOp == 2 then
		RoomDebugController.instance:getDebugPackageInfo(function (slot0)
			for slot5, slot6 in ipairs(slot0) do
				if 0 < slot6.packageMapId then
					slot1 = slot6.packageMapId
				end
			end

			GameFacade.openInputBox({
				characterLimit = 100,
				sureBtnName = "确定",
				title = "输入新地图名",
				cancelBtnName = "取消",
				defaultInput = string.format("地图%d", slot1 + 1),
				sureCallback = function (slot0)
					uv0:_copyCallback(uv1.packageMapId, uv2, slot0)
				end
			})
		end)
	elseif slot0._selectOp == 3 then
		RoomDebugController.instance:deletePackageJson(slot2.packageMapId)
		slot0:_refreshUI()
	elseif slot0._selectOp == 4 then
		slot3 = nil

		GameFacade.openInputBox({
			characterLimit = 100,
			sureBtnName = "确定",
			title = "输入新地图名",
			cancelBtnName = "取消",
			defaultInput = (not string.nilorempty(slot2.packageName) or string.format("地图%d", slot2.packageMapId)) and slot2.packageName,
			sureCallback = function (slot0)
				uv0:_renameCallback(uv1.packageMapId, slot0)
			end
		})
	end
end

function slot0._btnrenameOnClick(slot0)
	slot0:_clickSelectOp(4)
end

function slot0._renameCallback(slot0, slot1, slot2)
	RoomDebugController.instance:renamePackageJson(slot1, slot2)
	slot0:_refreshUI()
	GameFacade.closeInputBox()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gopackageitem, false)

	slot0._packageItemList = {}
	slot0._selectOp = 1

	gohelper.setActive(slot0._goselectcopy, false)
	gohelper.setActive(slot0._goselectdelete, false)
end

function slot0._clickSelectOp(slot0, slot1)
	if slot0._selectOp == slot1 then
		slot0._selectOp = 1
	else
		slot0._selectOp = slot1
	end

	gohelper.setActive(slot0._goselectcopy, slot0._selectOp == 2)
	gohelper.setActive(slot0._goselectdelete, slot0._selectOp == 3)
	gohelper.setActive(slot0._goselectrename, slot0._selectOp == 4)
end

function slot0._refreshUI(slot0)
	RoomDebugController.instance:getDebugPackageInfo(function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			for slot10, slot11 in ipairs(slot6.infos) do
				if slot1[slot11.blockId] then
					logError("重复的blockId: " .. slot11.blockId)
				end

				slot1[slot11.blockId] = true
			end

			if not uv0._packageItemList[slot5] then
				slot7 = uv0:getUserDataTb_()
				slot7.index = slot5
				slot7.go = gohelper.cloneInPlace(uv0._gopackageitem, "item" .. slot5)
				slot7.txtid = gohelper.findChildText(slot7.go, "txt_id")
				slot7.btnclick = gohelper.findChildButtonWithAudio(slot7.go, "btn_click")

				slot7.btnclick:AddClickListener(uv0._btnClickOnClick, uv0, slot7.index)
				table.insert(uv0._packageItemList, slot7)
			end

			slot7.packageMapId = slot6.packageMapId

			if string.nilorempty(slot6.packageName) then
				slot7.txtid.text = string.format("地图%d", slot6.packageMapId)
			else
				slot7.txtid.text = slot6.packageName
			end

			gohelper.setActive(slot7.go, true)
		end

		for slot5 = #slot0 + 1, #uv0._packageItemList do
			gohelper.setActive(uv0._packageItemList[slot5].go, false)
		end
	end)
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._packageItemList) do
		slot5.btnclick:RemoveClickListener()
	end
end

return slot0

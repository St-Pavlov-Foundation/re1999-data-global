module("modules.logic.room.view.debug.RoomDebugPackageItem", package.seeall)

local var_0_0 = class("RoomDebugPackageItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtdefineid = gohelper.findChildText(arg_1_0.viewGO, "#txt_defineid")
	arg_1_0._txtpackageorder = gohelper.findChildText(arg_1_0.viewGO, "#txt_packageorder")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._simagebirthhero = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_birthhero")
	arg_1_0._icon = gohelper.onceAddComponent(gohelper.findChild(arg_1_0.viewGO, "icon"), gohelper.Type_RawImage)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	local var_4_0 = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl)
	local var_4_1 = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift)
	local var_4_2 = RoomDebugPackageListModel.instance:getSelect()
	local var_4_3 = RoomMapBlockModel.instance:getFullBlockMOById(arg_4_0._mo.id)

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.C) then
		RoomDebugController.instance:debugSetPackageId(arg_4_0._mo.id, 0)
	elseif not var_4_0 then
		if not var_4_1 then
			RoomDebugPackageListModel.instance:setSelect(arg_4_0._mo.id)

			if var_4_3 then
				local var_4_4 = HexMath.hexToPosition(var_4_3.hexPoint, RoomBlockEnum.BlockSize)

				arg_4_0._scene.camera:tweenCamera({
					focusX = var_4_4.x,
					focusY = var_4_4.y
				})
			end
		else
			RoomDebugController.instance:debugSetMainRes(arg_4_0._mo.id)
		end
	elseif not var_4_2 or var_4_2 == arg_4_0._mo.id then
		RoomDebugController.instance:debugSetPackageOrder(arg_4_0._mo.id)
	else
		RoomDebugPackageListModel.instance:clearSelect()
		RoomDebugController.instance:exchangeOrder(var_4_2, arg_4_0._mo.id)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._scene = GameSceneMgr.instance:getCurScene()
	arg_5_0._isSelect = false

	gohelper.addUIClickAudio(arg_5_0._btnclick.gameObject, AudioEnum.UI.UI_Common_Click)
end

function var_0_0._refreshUI(arg_6_0)
	arg_6_0._txtdefineid.text = "地块id:" .. arg_6_0._mo.id
	arg_6_0._txtpackageorder.text = string.format("序号: %s", arg_6_0._mo.packageOrder)
	arg_6_0._txtname.text = RoomHelper.getBlockPrefabName(arg_6_0._mo.config.prefabPath)

	arg_6_0:_refreshCharacter(arg_6_0._mo.id)
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._goselect, arg_7_0._isSelect)

	arg_7_0._mo = arg_7_1

	arg_7_0:_refreshUI()
	arg_7_0:_refreshBlock(arg_7_1 and arg_7_1.blockId)
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goselect, arg_8_1)

	arg_8_0._isSelect = arg_8_1
end

function var_0_0._refreshBlock(arg_9_0, arg_9_1)
	local var_9_0 = GameSceneMgr.instance:getCurScene()
	local var_9_1 = arg_9_0._lastOldBlockId

	arg_9_0._lastOldBlockId = arg_9_1

	if var_9_1 then
		var_9_0.inventorymgr:removeBlockEntity(var_9_1)
	end

	gohelper.setActive(arg_9_0._icon, arg_9_1 and true or false)

	if arg_9_1 then
		var_9_0.inventorymgr:addBlockEntity(arg_9_1)

		local var_9_2 = var_9_0.inventorymgr:getIndexById(arg_9_1)

		OrthCameraRTMgr.instance:setRawImageUvRect(arg_9_0._icon, var_9_2)
	end
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0._simagebirthhero:UnLoadImage()
	arg_10_0:_refreshBlock(nil)
end

function var_0_0._refreshCharacter(arg_11_0, arg_11_1)
	local var_11_0 = RoomConfig.instance:getSpecialBlockConfig(arg_11_1)

	gohelper.setActive(arg_11_0._simagebirthhero.gameObject, var_11_0 ~= nil)

	if not var_11_0 then
		return
	end

	local var_11_1 = HeroConfig.instance:getHeroCO(var_11_0.heroId)

	if not var_11_1 then
		return
	end

	local var_11_2 = SkinConfig.instance:getSkinCo(var_11_1.skinId)

	if not var_11_2 then
		return
	end

	arg_11_0._simagebirthhero:LoadImage(ResUrl.getHeadIconSmall(var_11_2.headIcon))
end

return var_0_0

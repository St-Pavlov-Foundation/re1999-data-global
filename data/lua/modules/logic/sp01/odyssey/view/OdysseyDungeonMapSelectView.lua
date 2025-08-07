module("modules.logic.sp01.odyssey.view.OdysseyDungeonMapSelectView", package.seeall)

local var_0_0 = class("OdysseyDungeonMapSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._screenClick = SLFramework.UGUI.UIClickListener.Get(arg_1_0._gofullscreen)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	if GamepadController.instance:isOpen() then
		arg_2_0:addEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_2_0.onGamepadKeyDown, arg_2_0)
	end

	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnInitMapSelect, arg_2_0.onInitMapSelect, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnDisposeOldMap, arg_2_0.onDisposeOldMap, arg_2_0)
	arg_2_0:addEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnMapUpdate, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.DailyRefresh, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_3_0.onGamepadKeyDown, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnInitMapSelect, arg_3_0.onInitMapSelect, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnDisposeOldMap, arg_3_0.onDisposeOldMap, arg_3_0)
	arg_3_0:removeEventCb(OdysseyDungeonController.instance, OdysseyEvent.OnMapUpdate, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.DailyRefresh, arg_3_0.refreshUI, arg_3_0)
	arg_3_0._screenClick:RemoveClickUpListener()
end

var_0_0.ItemFocusOffsetPos = Vector3(-1, 0, 0)

function var_0_0.onMapItemClickDown(arg_4_0, arg_4_1)
	arg_4_0.curClickMapItem = arg_4_1
end

function var_0_0.onScreenClickUp(arg_5_0)
	if OdysseyDungeonModel.instance:getDraggingMapState() then
		return
	end

	arg_5_0:setIconSelectState()

	if not arg_5_0.curClickMapItem then
		ViewMgr.instance:closeView(ViewName.OdysseyDungeonMapSelectInfoView)

		return
	end

	local var_5_0 = arg_5_0.mapSelectItemTab[arg_5_0.curClickMapItem.config.id]
	local var_5_1 = arg_5_0:getMapItemRootPos(var_5_0.pos) + var_0_0.ItemFocusOffsetPos

	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusMapSelectItem, var_5_1, true)
	OdysseyDungeonController.instance:openDungeonMapSelectInfoView(arg_5_0.curClickMapItem.config.id)
	arg_5_0:saveMapItemNewUnlockData(arg_5_0.curClickMapItem.config.id)
	arg_5_0:refreshMapItemReddot()

	arg_5_0.curClickMapItem = nil
end

function var_0_0.onGamepadKeyDown(arg_6_0, arg_6_1)
	if arg_6_1 ~= GamepadEnum.KeyCode.A then
		return
	end

	local var_6_0 = GamepadController.instance:getScreenPos()
	local var_6_1 = CameraMgr.instance:getMainCamera():ScreenPointToRay(var_6_0)
	local var_6_2 = UnityEngine.Physics2D.RaycastAll(var_6_1.origin, var_6_1.direction)
	local var_6_3 = var_6_2.Length - 1

	for iter_6_0 = 0, var_6_3 do
		local var_6_4 = var_6_2[iter_6_0]
		local var_6_5 = MonoHelper.getLuaComFromGo(var_6_4.transform.parent.gameObject, OdysseyDungeonMapSelectItem)

		if var_6_5 then
			var_6_5:onClickDown()
		end
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.mapSelectItemTab = arg_7_0:getUserDataTb_()
	arg_7_0.mapIconItemTab = arg_7_0:getUserDataTb_()
	arg_7_0.mainCamera = CameraMgr.instance:getMainCamera()

	arg_7_0:saveMapItemNewUnlockData(1)
end

function var_0_0.onInitMapSelect(arg_8_0, arg_8_1)
	arg_8_0._screenClick:AddClickUpListener(arg_8_0.onScreenClickUp, arg_8_0)

	arg_8_0.mapSelectRootGO = arg_8_1
	arg_8_0.rootGO = gohelper.findChild(arg_8_0.mapSelectRootGO, "root")
	arg_8_0.rootScale = transformhelper.getLocalScale(arg_8_0.rootGO.transform)

	arg_8_0:refreshUI()

	if not OdysseyDungeonModel.instance:getNeedFocusMainMapSelectItem() then
		local var_8_0 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MapSelectPos)
		local var_8_1 = string.splitToNumber(var_8_0.value, "#")

		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusMapSelectItem, Vector3(var_8_1[1], var_8_1[2], 0), false)
	else
		arg_8_0:onFocusMainMapSelectItem(false)
	end
end

function var_0_0.onFocusMainMapSelectItem(arg_9_0, arg_9_1)
	local var_9_0, var_9_1 = OdysseyDungeonModel.instance:getCurMainElement()

	if var_9_1 and var_9_1.mapId then
		local var_9_2 = arg_9_0.mapSelectItemTab[var_9_1.mapId]
		local var_9_3 = arg_9_0:getMapItemRootPos(var_9_2.pos)

		var_9_2.mapComp:playMainTaskEffect()
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnFocusMapSelectItem, var_9_3, arg_9_1)
	end

	OdysseyDungeonModel.instance:setNeedFocusMainMapSelectItem(false)
end

function var_0_0.getMapItemRootPos(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.mapSelectRootGO.transform:InverseTransformPoint(arg_10_1.transform.position)
	local var_10_1 = -var_10_0.x or 0
	local var_10_2 = -var_10_0.y or 0
	local var_10_3 = Vector3()

	var_10_3:Set(var_10_1, var_10_2, 0)

	return var_10_3
end

function var_0_0.refreshUI(arg_11_0)
	if not OdysseyDungeonModel.instance:getIsInMapSelectState() then
		return
	end

	local var_11_0 = OdysseyConfig.instance:getAllDungeonMapCoList()
	local var_11_1 = gohelper.findChild(arg_11_0.rootGO, "#go_mapItem")
	local var_11_2 = gohelper.findChild(arg_11_0.rootGO, "#go_mapIconItem")

	gohelper.setActive(var_11_1, false)
	gohelper.setActive(var_11_2, false)

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_3 = arg_11_0.mapSelectItemTab[iter_11_1.id]

		if not var_11_3 then
			var_11_3 = {
				config = iter_11_1,
				pos = gohelper.findChild(arg_11_0.rootGO, "#go_map" .. iter_11_1.id)
			}
			var_11_3.go = gohelper.clone(var_11_1, var_11_3.pos, "mapItem")
			var_11_3.mapComp = MonoHelper.addLuaComOnceToGo(var_11_3.go, OdysseyDungeonMapSelectItem, {
				iter_11_1,
				arg_11_0
			})
			arg_11_0.mapSelectItemTab[iter_11_1.id] = var_11_3
		end

		gohelper.setActive(var_11_3.go, true)
		var_11_3.mapComp:updateInfo()

		local var_11_4 = arg_11_0.mapIconItemTab[iter_11_1.id]

		if not var_11_4 then
			var_11_4 = {
				config = iter_11_1,
				iconPos = gohelper.findChild(arg_11_0.rootGO, "#go_mapIcon" .. iter_11_1.id)
			}
			var_11_4.go = gohelper.clone(var_11_2, var_11_4.iconPos, "mapIconItem")
			var_11_4.simageLockIcon = gohelper.findChildSingleImage(var_11_4.go, "simage_lockIcon")
			var_11_4.simageSelect = gohelper.findChildSingleImage(var_11_4.go, "simage_select")
			arg_11_0.mapIconItemTab[iter_11_1.id] = var_11_4
		end

		gohelper.setActive(var_11_4.go, true)

		local var_11_5 = string.format("map/odyssey_bigmap_map_%s_0", var_11_4.config.id)
		local var_11_6 = string.format("map/odyssey_bigmap_map_%s_1", var_11_4.config.id)

		var_11_4.simageLockIcon:LoadImage(ResUrl.getSp01OdysseySingleBg(var_11_5))
		var_11_4.simageSelect:LoadImage(ResUrl.getSp01OdysseySingleBg(var_11_6))

		local var_11_7 = OdysseyDungeonModel.instance:getMapInfo(var_11_4.config.id)

		gohelper.setActive(var_11_4.simageLockIcon.gameObject, not var_11_7)
	end

	arg_11_0:setIconSelectState()
	arg_11_0:refreshMapItemReddot()
end

function var_0_0.setIconSelectState(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.mapSelectItemTab) do
		iter_12_1.mapComp:setSelectState(arg_12_0.curClickMapItem and iter_12_1.config.id == arg_12_0.curClickMapItem.config.id)
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0.mapIconItemTab) do
		gohelper.setActive(iter_12_3.simageSelect.gameObject, arg_12_0.curClickMapItem and arg_12_0.curClickMapItem.config.id == iter_12_3.config.id)
	end
end

function var_0_0.saveMapItemNewUnlockData(arg_13_0, arg_13_1)
	if OdysseyDungeonModel.instance:getMapInfo(arg_13_1) then
		OdysseyDungeonModel.instance:saveLocalCurNewLock(OdysseyEnum.LocalSaveKey.MapNew, {
			arg_13_1
		})
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	end
end

function var_0_0.refreshMapItemReddot(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.mapSelectItemTab) do
		iter_14_1.mapComp:refreshReddotShowState()
	end
end

function var_0_0.onDisposeOldMap(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.mapSelectItemTab) do
		gohelper.destroy(iter_15_1.go)
	end

	for iter_15_2, iter_15_3 in pairs(arg_15_0.mapIconItemTab) do
		iter_15_3.simageLockIcon:UnLoadImage()
		iter_15_3.simageSelect:UnLoadImage()
		gohelper.destroy(iter_15_3.go)
	end

	arg_15_0.mapSelectItemTab = {}
	arg_15_0.mapIconItemTab = {}
end

function var_0_0.onClose(arg_16_0)
	arg_16_0:onDisposeOldMap()
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0

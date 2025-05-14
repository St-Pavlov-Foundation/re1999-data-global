module("modules.logic.room.view.RoomInventorySelectEffect", package.seeall)

local var_0_0 = class("RoomInventorySelectEffect", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._goreclaim = gohelper.findChild(arg_4_0.viewGO, "go_content/go_count/#reclaim")
	arg_4_0._gomassif = gohelper.findChild(arg_4_0.viewGO, "go_content/go_count/#reclaim/reclaim_massif/#massif")
	arg_4_0._goreclaimtips = gohelper.findChild(arg_4_0.viewGO, "go_content/#go_reclaimtips")
	arg_4_0._gomassiftips = gohelper.findChild(arg_4_0.viewGO, "go_content/#go_reclaimtips/#massiftips")

	gohelper.setActive(arg_4_0._gomassif, false)
	gohelper.setActive(arg_4_0._gomassiftips, false)
	gohelper.setActive(arg_4_0._goreclaimtips, true)

	arg_4_0._isViewShow = false
	arg_4_0._isViewShowing = false
	arg_4_0._nextPlayTipsTime = 0
	arg_4_0._isFlag = false
	arg_4_0._massifEffList = {}
	arg_4_0._massifTipEffList = {}
	arg_4_0._reclaimEffTab = arg_4_0:_getUserDataTbEffect(arg_4_0._goreclaim)
	arg_4_0._backBlockIds = {}
	arg_4_0._tipsInfoList = {}
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockListDataChanged, arg_5_0._onBackBlockChanged, arg_5_0)
	arg_5_0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockPlayUIAnim, arg_5_0._onBackBlockPlayUIAnim, arg_5_0)
end

function var_0_0.onClose(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._delayPlayTipsEffect, arg_6_0)

	if arg_6_0._reclaimEffTab then
		arg_6_0._reclaimEffTab:dispose()
	end

	arg_6_0._reclaimEffTab = nil

	for iter_6_0 = 1, #arg_6_0._massifEffList do
		arg_6_0._massifEffList[iter_6_0]:dispose()
	end

	arg_6_0._massifEffList = {}

	for iter_6_1 = 1, #arg_6_0._massifTipEffList do
		arg_6_0._massifTipEffList[iter_6_1]:dispose()
	end

	arg_6_0._massifTipEffList = {}
end

function var_0_0._onBackBlockChanged(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	tabletool.addValues(arg_7_0._backBlockIds, arg_7_1)

	for iter_7_0 = 1, #arg_7_1 do
		local var_7_0 = RoomConfig.instance:getBlock(arg_7_1[iter_7_0])

		if var_7_0 then
			arg_7_0:_addPackageId(var_7_0.packageId)
		end
	end

	if arg_7_3 and #arg_7_3 > 0 then
		for iter_7_1 = 1, #arg_7_3 do
			arg_7_0:_addBuildingId(arg_7_3[iter_7_1])
		end
	end

	arg_7_0:_playEffect()
end

function var_0_0._onBackBlockPlayUIAnim(arg_8_0)
	arg_8_0:_playEffect()
end

function var_0_0._getIsShow(arg_9_0)
	if RoomMapBlockModel.instance:isBackMore() or RoomBuildingController.instance:isBuildingListShow() then
		return false
	end

	return true
end

function var_0_0._playEffect(arg_10_0)
	arg_10_0:_playMassifEffect()
	arg_10_0:_playTipsEffect()
end

function var_0_0._addPackageId(arg_11_0, arg_11_1)
	local var_11_0 = true
	local var_11_1 = arg_11_0:_getTipsInfo(arg_11_1, var_11_0)

	if var_11_1 then
		var_11_1.count = var_11_1.count + 1
	else
		local var_11_2 = RoomConfig.instance:getBlockPackageConfig(arg_11_1)

		if var_11_2 then
			local var_11_3 = {
				count = 1,
				id = arg_11_1,
				isBlock = var_11_0,
				name = var_11_2.name,
				rare = var_11_2.rare
			}

			table.insert(arg_11_0._tipsInfoList, var_11_3)
		end
	end
end

function var_0_0._addBuildingId(arg_12_0, arg_12_1)
	local var_12_0 = false
	local var_12_1 = arg_12_0:_getTipsInfo(arg_12_1, var_12_0)

	if var_12_1 then
		var_12_1.count = var_12_1.count + 1
	else
		local var_12_2 = RoomConfig.instance:getBuildingConfig(arg_12_1)

		if var_12_2 then
			local var_12_3 = {
				count = 1,
				id = arg_12_1,
				isBlock = var_12_0,
				name = var_12_2.name,
				rare = var_12_2.rare
			}

			table.insert(arg_12_0._tipsInfoList, var_12_3)
		end
	end
end

function var_0_0._getTipsInfo(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._tipsInfoList

	for iter_13_0 = 1, #var_13_0 do
		local var_13_1 = var_13_0[iter_13_0]

		if var_13_1.id == arg_13_1 and var_13_1.isBlock == arg_13_2 then
			return var_13_1
		end
	end
end

function var_0_0._getUserDataTbEffect(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getUserDataTb_()

	var_14_0.go = arg_14_1
	var_14_0.effectTime = 2
	var_14_0.isRunning = false

	function var_14_0.playEffect(arg_15_0, arg_15_1)
		arg_15_0.isRunning = true

		TaskDispatcher.cancelTask(arg_15_0._playEffect, arg_15_0)
		TaskDispatcher.runDelay(arg_15_0._playEffect, arg_15_0, arg_15_1 or 0)
	end

	function var_14_0._playEffect(arg_16_0)
		gohelper.setActive(arg_16_0.go, false)
		gohelper.setActive(arg_16_0.go, true)
		TaskDispatcher.cancelTask(arg_16_0._stopEffect, arg_16_0)
		TaskDispatcher.runDelay(arg_16_0._stopEffect, arg_16_0, arg_16_0.effectTime or 1.5)
	end

	function var_14_0._stopEffect(arg_17_0)
		arg_17_0.isRunning = false

		gohelper.setActive(arg_17_0.go, false)
	end

	function var_14_0._clearTask(arg_18_0)
		TaskDispatcher.cancelTask(arg_18_0._playEffect, arg_18_0)
		TaskDispatcher.cancelTask(arg_18_0._stopEffect, arg_18_0)
	end

	function var_14_0.dispose(arg_19_0)
		arg_19_0:_clearTask()
		arg_19_0:_stopEffect()
	end

	return var_14_0
end

function var_0_0._playMassifEffect(arg_20_0)
	if not arg_20_0:_getIsShow() then
		return
	end

	local var_20_0 = arg_20_0._backBlockIds

	arg_20_0._backBlockIds = {}

	local var_20_1 = math.min(5, #var_20_0)

	if var_20_1 > 0 then
		arg_20_0._reclaimEffTab.effectTime = 3

		arg_20_0._reclaimEffTab:playEffect()
	end

	for iter_20_0 = 1, var_20_1 do
		local var_20_2 = arg_20_0._massifEffList[iter_20_0]

		if not var_20_2 then
			local var_20_3 = gohelper.cloneInPlace(arg_20_0._gomassif, "massif" .. iter_20_0)

			var_20_2 = arg_20_0:_getUserDataTbEffect(var_20_3)

			table.insert(arg_20_0._massifEffList, var_20_2)
		end

		var_20_2:playEffect(iter_20_0 * 0.06)
	end
end

function var_0_0._delayPlayTipsEffect(arg_21_0)
	if #arg_21_0._tipsInfoList > 0 then
		arg_21_0:_playTipsEffect()
	end
end

function var_0_0._playTipsEffect(arg_22_0)
	if not arg_22_0:_getIsShow() then
		return
	end

	local var_22_0 = Time.time
	local var_22_1 = arg_22_0._tipsInfoList
	local var_22_2 = 1
	local var_22_3 = RoomInventoryBlockModel.instance:getCurPackageMO()

	for iter_22_0 = 1, 5 do
		local var_22_4 = arg_22_0._massifTipEffList[iter_22_0]

		if not var_22_4 then
			local var_22_5 = gohelper.cloneInPlace(arg_22_0._gomassiftips, "gomassiftips" .. iter_22_0)

			var_22_4 = arg_22_0:_getUserDataTbEffect(var_22_5)
			var_22_4._imagerare = gohelper.findChildImage(var_22_5, "bg/rare")
			var_22_4._txtname = gohelper.findChildText(var_22_5, "bg/txt_name")
			var_22_4._txtnum = gohelper.findChildText(var_22_5, "bg/txt_num")
			var_22_4._goicon = gohelper.findChild(var_22_5, "bg/txt_num/icon")
			var_22_4._gobuildingicon = gohelper.findChild(var_22_5, "bg/txt_num/building_icon")
			var_22_4.finishTime = 0
			var_22_4.effectTime = 3.7

			table.insert(arg_22_0._massifTipEffList, var_22_4)
		end

		if var_22_0 < var_22_4.finishTime then
			var_22_2 = math.min(var_22_2, var_22_4.finishTime - var_22_0)
		elseif #var_22_1 > 0 then
			local var_22_6 = var_22_1[1]

			table.remove(var_22_1, 1)

			local var_22_7 = var_22_3 and var_22_6.isBlock and var_22_3.id == var_22_6.id
			local var_22_8 = var_22_7 and "#FFFFFF" or "#FFFFFF"

			var_22_4._txtname.text = var_22_7 and luaLang("room_backblock_curpackage") or var_22_6.name
			var_22_4._txtnum.text = "+" .. var_22_6.count
			var_22_4.finishTime = var_22_0 + var_22_4.effectTime

			if var_22_4.isBlock ~= var_22_6.isBlock then
				var_22_4.isBlock = var_22_6.isBlock

				gohelper.setActive(var_22_4._goicon, var_22_6.isBlock)
				gohelper.setActive(var_22_4._gobuildingicon, not var_22_6.isBlock)
			end

			if var_22_4.txtColorStr ~= var_22_8 then
				var_22_4.txtColorStr = var_22_8

				SLFramework.UGUI.GuiHelper.SetColor(var_22_4._txtnum, var_22_8)
				SLFramework.UGUI.GuiHelper.SetColor(var_22_4._txtname, var_22_8)
			end

			local var_22_9 = RoomBlockPackageEnum.RareIcon[var_22_6.rare] or RoomBlockPackageEnum.RareIcon[1]

			UISpriteSetMgr.instance:setRoomSprite(var_22_4._imagerare, var_22_9)
			var_22_4:playEffect()
			gohelper.setAsLastSibling(var_22_4.go)
		end

		if #var_22_1 < 1 then
			break
		end
	end

	if #var_22_1 > 0 then
		TaskDispatcher.runDelay(arg_22_0._delayPlayTipsEffect, arg_22_0, var_22_2)
	end
end

return var_0_0

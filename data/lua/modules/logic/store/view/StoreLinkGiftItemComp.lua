module("modules.logic.store.view.StoreLinkGiftItemComp", package.seeall)

local var_0_0 = class("StoreLinkGiftItemComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0.viewGO = arg_1_1
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txteng = gohelper.findChildText(arg_1_0.viewGO, "#txt_name/#txt_eng")
	arg_1_0._txtremain = gohelper.findChildText(arg_1_0.viewGO, "txt_remain")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "total/txt_total")
	arg_1_0._txtmaterialNum = gohelper.findChildText(arg_1_0.viewGO, "cost/txt_materialNum")
	arg_1_0._imagematerial = gohelper.findChildImage(arg_1_0.viewGO, "cost/simage_material")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "reward/simage_icon")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "reward/simage_icon")
	arg_1_0._goimagedesc = gohelper.findChild(arg_1_0.viewGO, "reward/image_dec")
	arg_1_0._gototal = gohelper.findChild(arg_1_0.viewGO, "total")
	arg_1_0._rewartTb = arg_1_0:_createRewardTb(gohelper.findChild(arg_1_0.viewGO, "reward/reward1"), 1)
	arg_1_0._rewart2Tb = arg_1_0:_createRewardTb(gohelper.findChild(arg_1_0.viewGO, "reward/reward2"), 2)
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "go_lock")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.viewGO, "go_canget")
	arg_1_0._goreward3 = gohelper.findChild(arg_1_0.viewGO, "reward/reward3")
	arg_1_0._txtrewardnum3 = gohelper.findChildText(arg_1_0.viewGO, "reward/reward3/normal/num3/txt_num")

	arg_1_0:addEventListeners()
end

function var_0_0.addEventListeners(arg_2_0)
	if not arg_2_0._isRunAddEventListeners then
		arg_2_0._isRunAddEventListeners = true

		TaskController.instance:registerCallback(TaskEvent.OnFinishTask, arg_2_0._onFinishTask, arg_2_0)
	end
end

function var_0_0.removeEventListeners(arg_3_0)
	if arg_3_0._isRunAddEventListeners then
		arg_3_0._isRunAddEventListeners = false

		TaskController.instance:unregisterCallback(TaskEvent.OnFinishTask, arg_3_0._onFinishTask, arg_3_0)
	end
end

function var_0_0.onStart(arg_4_0)
	return
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0._rewartTb then
		arg_5_0:_disposeRewardTb(arg_5_0._rewartTb)

		arg_5_0._rewartTb = nil
	end

	if arg_5_0._rewart2Tb then
		arg_5_0:_disposeRewardTb(arg_5_0._rewart2Tb)

		arg_5_0._rewart2Tb = nil
	end

	if arg_5_0._simageicon then
		arg_5_0._simageicon:UnLoadImage()
	end

	arg_5_0:removeEventListeners()
	arg_5_0:__onDispose()
end

function var_0_0._onFinishTask(arg_6_0, arg_6_1)
	if arg_6_0._mo and arg_6_0._mo.config and arg_6_0._mo.config.taskid == arg_6_1 then
		arg_6_0:onUpdateMO(arg_6_0._mo)
	end
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	if arg_7_0._mo then
		arg_7_0._txtname.text = arg_7_0._mo.config.name
		arg_7_0._txteng.text = arg_7_0._mo.config.nameEn

		arg_7_0:_refreshPrice()
		arg_7_0:_refreshReward()
	end
end

function var_0_0._refreshPrice(arg_8_0)
	local var_8_0 = arg_8_0._mo
	local var_8_1 = var_8_0.maxBuyCount
	local var_8_2 = var_8_1 - var_8_0.buyCount
	local var_8_3

	if var_8_0.isChargeGoods then
		var_8_3 = StoreConfig.instance:getChargeRemainText(var_8_1, var_8_0.refreshTime, var_8_2, var_8_0.offlineTime)
	else
		var_8_3 = StoreConfig.instance:getRemainText(var_8_1, var_8_0.refreshTime, var_8_2, var_8_0.offlineTime)
	end

	if string.nilorempty(var_8_3) then
		gohelper.setActive(arg_8_0._txtremain, false)
	else
		gohelper.setActive(arg_8_0._txtremain, true)

		arg_8_0._txtremain.text = var_8_3
	end

	local var_8_4 = var_8_0.cost

	if string.nilorempty(var_8_4) or var_8_4 == 0 then
		arg_8_0._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(arg_8_0._imagematerial, false)
	elseif var_8_0.isChargeGoods then
		arg_8_0._txtmaterialNum.text = StoreModel.instance:getCostPriceFull(var_8_0.id)

		gohelper.setActive(arg_8_0._imagematerial, false)

		arg_8_0._costQuantity = var_8_4
	else
		local var_8_5 = GameUtil.splitString2(var_8_4, true)
		local var_8_6 = var_8_5[var_8_0.buyCount + 1] or var_8_5[#var_8_5]

		arg_8_0._costType = var_8_6[1]
		arg_8_0._costId = var_8_6[2]
		arg_8_0._costQuantity = var_8_6[3]

		local var_8_7, var_8_8 = ItemModel.instance:getItemConfigAndIcon(arg_8_0._costType, arg_8_0._costId)

		arg_8_0._txtmaterialNum.text = arg_8_0._costQuantity

		gohelper.setActive(arg_8_0._imagematerial, true)

		local var_8_9 = 0

		if string.len(arg_8_0._costId) == 1 then
			var_8_9 = arg_8_0._costType .. "0" .. arg_8_0._costId
		else
			var_8_9 = arg_8_0._costType .. arg_8_0._costId
		end

		local var_8_10 = string.format("%s_1", var_8_9)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_8_0._imagematerial, var_8_10)
	end
end

function var_0_0._refreshReward(arg_9_0)
	local var_9_0 = GameUtil.splitString2(arg_9_0._mo.config.product, true)
	local var_9_1 = arg_9_0:_getRewardCount(var_9_0)
	local var_9_2 = StoreConfig.instance:getChargeConditionalConfig(arg_9_0._mo.config.taskid)
	local var_9_3 = var_9_2 and GameUtil.splitString2(var_9_2.bonus, true)
	local var_9_4 = arg_9_0:_getRewardCount(var_9_3)
	local var_9_5 = arg_9_0._mo.goodsId
	local var_9_6 = arg_9_0._mo.buyCount and arg_9_0._mo.buyCount > 0
	local var_9_7 = StoreCharageConditionalHelper.isCharageCondition(var_9_5)
	local var_9_8 = StoreCharageConditionalHelper.isCharageTaskNotFinish(var_9_5)
	local var_9_9 = var_9_2.bigImg2
	local var_9_10 = true

	if not var_9_6 and var_9_7 then
		var_9_10 = false
		var_9_9 = arg_9_0._mo.config.bigImg
	elseif var_9_6 then
		var_9_9 = var_9_2.bigImg3
	end

	arg_9_0._simageicon:LoadImage(ResUrl.getStorePackageIcon(var_9_9), arg_9_0._onIconLoadFinish, arg_9_0)
	gohelper.setActive(arg_9_0._rewartTb.go, var_9_10)
	gohelper.setActive(arg_9_0._rewart2Tb.go, var_9_10)
	gohelper.setActive(arg_9_0._goimagedesc, var_9_10)
	gohelper.setActive(arg_9_0._gototal, var_9_10)
	gohelper.setActive(arg_9_0._goreward3, not var_9_10)
	gohelper.setActive(arg_9_0._golock, var_9_6 and not var_9_7)
	gohelper.setActive(arg_9_0._gocanget, var_9_6 and var_9_7 and var_9_8)

	if var_9_10 then
		arg_9_0._txttotal.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("store_linkgift_totalcount_txt"), var_9_1 + var_9_4)

		arg_9_0:_setRewardTbNum(arg_9_0._rewartTb, var_9_1)
		arg_9_0:_setRewardTbNum(arg_9_0._rewart2Tb, var_9_4)
		arg_9_0:_setRewardTbHasget(arg_9_0._rewartTb, var_9_6)
		arg_9_0:_setRewardTbHasget(arg_9_0._rewart2Tb, var_9_6 and StoreCharageConditionalHelper.isCharageTaskFinish(var_9_5))
	else
		arg_9_0._txtrewardnum3.text = arg_9_0:_getRewardNumStr(var_9_1 + var_9_4)
	end
end

function var_0_0._onIconLoadFinish(arg_10_0)
	arg_10_0._imageicon:SetNativeSize()
end

function var_0_0._createRewardTb(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getUserDataTb_()

	var_11_0.go = arg_11_1
	var_11_0.gonormal = gohelper.findChild(arg_11_1, "normal")
	var_11_0.gohasget = gohelper.findChild(arg_11_1, "hasget")
	var_11_0.txtnum = gohelper.findChildText(arg_11_1, string.format("normal/num%s/txt_num", arg_11_2))
	var_11_0.txtnum2 = gohelper.findChildText(arg_11_1, string.format("hasget/num%s/txt_num", arg_11_2))

	return var_11_0
end

function var_0_0._getRewardNumStr(arg_12_0, arg_12_1)
	return string.format("×<size=32>%s", arg_12_1)
end

function var_0_0._setRewardTbNum(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 then
		local var_13_0 = arg_13_0:_getRewardNumStr(arg_13_2)

		arg_13_1.txtnum.text = var_13_0
		arg_13_1.txtnum2.text = var_13_0
	end
end

function var_0_0._setRewardTbHasget(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 then
		gohelper.setActive(arg_14_1.gonormal, not arg_14_2)
		gohelper.setActive(arg_14_1.gohasget, arg_14_2)
	end
end

function var_0_0._disposeRewardTb(arg_15_0, arg_15_1)
	return
end

function var_0_0._getRewardCount(arg_16_0, arg_16_1)
	local var_16_0 = 0

	if arg_16_1 and #arg_16_1 > 0 then
		for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
			if iter_16_1 and #iter_16_1 >= 2 then
				var_16_0 = var_16_0 + iter_16_1[3]
			end
		end
	end

	return var_16_0
end

return var_0_0

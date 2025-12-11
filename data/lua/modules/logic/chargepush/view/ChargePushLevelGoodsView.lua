module("modules.logic.chargepush.view.ChargePushLevelGoodsView", package.seeall)

local var_0_0 = class("ChargePushLevelGoodsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Close")
	arg_1_0.btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_emptyLeft")
	arg_1_0.btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_emptyRight")
	arg_1_0.btnTop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_emptyTop")
	arg_1_0.btnBottom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_emptyBottom")
	arg_1_0.txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/info/#scroll_desc/Viewport/#txt_desc")
	arg_1_0.txtLevel = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/info/level/#txt_level")
	arg_1_0.goGiftItem = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_gift/Viewport/Content/#go_giftitem")

	gohelper.setActive(arg_1_0.goGiftItem, false)

	arg_1_0.goodsItemList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnLeft, arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnRight, arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnTop, arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnBottom, arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addEventCb(PayController.instance, PayEvent.PayFinished, arg_2_0._payFinished, arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_2_0._payFinished, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnClose)
	arg_3_0:removeClickCb(arg_3_0.btnLeft)
	arg_3_0:removeClickCb(arg_3_0.btnRight)
	arg_3_0:removeClickCb(arg_3_0.btnTop)
	arg_3_0:removeClickCb(arg_3_0.btnBottom)
	arg_3_0:removeEventCb(PayController.instance, PayEvent.PayFinished, arg_3_0._payFinished, arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_3_0._payFinished, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._payFinished(arg_5_0)
	if not arg_5_0.config then
		return
	end

	local var_5_0 = string.splitToNumber(arg_5_0.config.containedgoodsId, "#")
	local var_5_1 = false

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_2 = StoreModel.instance:getGoodsMO(iter_5_1)

		if var_5_2 and not var_5_2:isSoldOut() then
			var_5_1 = true

			break
		end
	end

	if var_5_1 then
		arg_5_0:refreshView()

		return
	end

	if ChargePushController.instance:tryShowNextPush(arg_5_0.config.className) then
		return
	end

	arg_5_0:closeThis()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshParam()
	arg_6_0:refreshView()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.refreshParam(arg_8_0)
	arg_8_0.config = arg_8_0.viewParam and arg_8_0.viewParam.config
end

function var_0_0.refreshView(arg_9_0)
	if not arg_9_0.config then
		return
	end

	arg_9_0.txtDesc.text = arg_9_0.config.desc
	arg_9_0.txtLevel.text = PlayerModel.instance:getPlayerLevel()

	local var_9_0 = {}
	local var_9_1 = string.splitToNumber(arg_9_0.config.containedgoodsId, "#")

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = StoreModel.instance:getGoodsMO(iter_9_1)

		if var_9_2 and not var_9_2:isSoldOut() then
			table.insert(var_9_0, iter_9_1)
		end
	end

	for iter_9_2 = 1, 2 do
		if not var_9_0[iter_9_2] then
			var_9_0[iter_9_2] = 0
		end
	end

	for iter_9_3 = 1, math.max(#var_9_0, #arg_9_0.goodsItemList) do
		local var_9_3 = arg_9_0:getItem(iter_9_3)

		arg_9_0:updateItem(var_9_3, var_9_0[iter_9_3])
	end
end

function var_0_0.getItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.goodsItemList[arg_10_1]

	if not var_10_0 then
		var_10_0 = arg_10_0:getUserDataTb_()
		arg_10_0.goodsItemList[arg_10_1] = var_10_0
		var_10_0.go = gohelper.cloneInPlace(arg_10_0.goGiftItem, tostring(arg_10_1))
		var_10_0.goHas = gohelper.findChild(var_10_0.go, "#go_has")
		var_10_0.goEmpty = gohelper.findChild(var_10_0.go, "#go_empty")
	end

	return var_10_0
end

function var_0_0.updateItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1.goodsId = arg_11_2

	if not arg_11_2 then
		gohelper.setActive(arg_11_1.go, false)

		return
	end

	gohelper.setActive(arg_11_1.go, true)

	local var_11_0 = StoreConfig.instance:getGoodsConfig(arg_11_2, true) == nil

	gohelper.setActive(arg_11_1.goEmpty, var_11_0)
	gohelper.setActive(arg_11_1.goHas, not var_11_0)

	if var_11_0 then
		return
	end

	local var_11_1 = StoreModel.instance:getGoodsMO(arg_11_2)

	if not arg_11_1.goodsItem then
		local var_11_2 = arg_11_0.viewContainer:getSetting().otherRes.itemRes
		local var_11_3 = arg_11_0.viewContainer:getResInst(var_11_2, arg_11_1.goHas, "goodsItem")

		arg_11_1.goodsItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_3, PackageStoreGoodsItem)

		arg_11_1.goodsItem:setClickCallback(arg_11_0.onClickGoodsItem, arg_11_0)
	end

	local var_11_4 = StorePackageGoodsMO.New()

	var_11_4:init(var_11_1.belongStoreId, var_11_1.goodsId, var_11_1.buyCount, var_11_1.offlineTime)
	arg_11_1.goodsItem:onUpdateMO(var_11_4)
end

function var_0_0.onClickGoodsItem(arg_12_0, arg_12_1)
	return
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

function var_0_0.onClickClose(arg_15_0)
	arg_15_0:closeThis()
end

function var_0_0.onClickModalMask(arg_16_0)
	arg_16_0:closeThis()
end

return var_0_0

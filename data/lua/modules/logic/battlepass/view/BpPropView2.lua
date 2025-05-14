module("modules.logic.battlepass.view.BpPropView2", package.seeall)

local var_0_0 = class("BpPropView2", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._bgClick = gohelper.getClick(arg_1_0.viewGO)
	arg_1_0._scrollitem = gohelper.findChild(arg_1_0.viewGO, "#scroll")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll/itemcontent")
	arg_1_0._goeff = gohelper.findChild(arg_1_0.viewGO, "#go_eff")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btnOK")
	arg_1_0._btnBuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btnBuy")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "title/level/#txt_lv")
	arg_1_0._scrollContent2 = gohelper.findChild(arg_1_0.viewGO, "#scroll2/Viewport/#go_rewards")
	arg_1_0._item = gohelper.findChild(arg_1_0.viewGO, "#scroll2/Viewport/#go_rewards/#go_Items")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._bgClick:AddClickListener(arg_2_0._onClickBG, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._onClickOK, arg_2_0)
	arg_2_0._btnBuy:AddClickListener(arg_2_0.openChargeView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnBuy:RemoveClickListener()
	arg_3_0._bgClick:RemoveClickListener()
end

function var_0_0._onClickBG(arg_4_0)
	if not arg_4_0._openDt or arg_4_0._openDt + 1 > UnityEngine.Time.time then
		return
	end

	StatController.instance:track(StatEnum.EventName.ClickBPRewardWindowButton, {
		[StatEnum.EventProperties.ButtonName] = "关闭"
	})
	arg_4_0:closeThis()
end

function var_0_0._onClickOK(arg_5_0)
	StatController.instance:track(StatEnum.EventName.ClickBPRewardWindowButton, {
		[StatEnum.EventProperties.ButtonName] = "确定"
	})
	arg_5_0:closeThis()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._openDt = UnityEngine.Time.time
	CommonPropListItem.hasOpen = false

	arg_6_0:_setPropItems()
	NavigateMgr.instance:addEscape(ViewName.BpPropView2, arg_6_0._onClickBG, arg_6_0)

	if CommonPropListModel.instance:isHadHighRareProp() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards_High_1)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	end

	local var_6_0 = BpModel.instance:getBpLv()

	arg_6_0._txtlv.text = var_6_0

	gohelper.setActive(arg_6_0._item, false)

	local var_6_1 = {}
	local var_6_2 = {}

	for iter_6_0 = 1, var_6_0 do
		local var_6_3 = BpConfig.instance:getBonusCO(BpModel.instance.id, iter_6_0)

		arg_6_0:_calcBonus(var_6_1, var_6_2, var_6_3.payBonus)
	end

	arg_6_0:_sortList(var_6_2)
	gohelper.CreateObjList(arg_6_0, arg_6_0._createItem, var_6_2, arg_6_0._scrollContent2, arg_6_0._item)
end

function var_0_0._sortList(arg_7_0, arg_7_1)
	table.sort(arg_7_1, function(arg_8_0, arg_8_1)
		if arg_7_0:getIsSkin(arg_8_0) ~= arg_7_0:getIsSkin(arg_8_1) then
			return arg_7_0:getIsSkin(arg_8_0)
		elseif arg_7_0:getIsSummon(arg_8_0) ~= arg_7_0:getIsSummon(arg_8_1) then
			return arg_7_0:getIsSummon(arg_8_0)
		elseif arg_7_0:getIsEquip(arg_8_0) ~= arg_7_0:getIsEquip(arg_8_1) then
			return arg_7_0:getIsEquip(arg_8_0)
		elseif CommonPropListModel.instance:_getQuality(arg_8_0) ~= CommonPropListModel.instance:_getQuality(arg_8_1) then
			return CommonPropListModel.instance:_getQuality(arg_8_0) > CommonPropListModel.instance:_getQuality(arg_8_1)
		elseif arg_8_0.materilType ~= arg_8_1.materilType then
			return arg_8_0.materilType > arg_8_1.materilType
		elseif arg_8_0.materilType == MaterialEnum.MaterialType.Item and arg_8_1.materilType == MaterialEnum.MaterialType.Item and CommonPropListModel.instance:_getSubType(arg_8_0) ~= CommonPropListModel.instance:_getSubType(arg_8_1) then
			return CommonPropListModel.instance:_getSubType(arg_8_0) < CommonPropListModel.instance:_getSubType(arg_8_1)
		elseif arg_8_0.materilId ~= arg_8_1.materilId then
			return arg_8_0.materilId > arg_8_1.materilId
		end
	end)
end

function var_0_0.getIsSkin(arg_9_0, arg_9_1)
	return arg_9_1.materilType == MaterialEnum.MaterialType.HeroSkin
end

function var_0_0.getIsEquip(arg_10_0, arg_10_1)
	return arg_10_1.materilType == MaterialEnum.MaterialType.Equip and arg_10_1.materilId == 1000
end

function var_0_0.getIsSummon(arg_11_0, arg_11_1)
	return arg_11_1.materilType == MaterialEnum.MaterialType.Item and arg_11_1.materilId == 140001
end

function var_0_0._calcBonus(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	for iter_12_0, iter_12_1 in pairs(string.split(arg_12_3, "|")) do
		local var_12_0 = string.splitToNumber(iter_12_1, "#")
		local var_12_1 = var_12_0[2]
		local var_12_2 = var_12_0[3]

		if not arg_12_1[var_12_1] then
			arg_12_1[var_12_1] = {
				materilType = var_12_0[1],
				materilId = var_12_0[2],
				quantity = var_12_0[3],
				[4] = var_12_0[4],
				[5] = var_12_0[5]
			}

			table.insert(arg_12_2, arg_12_1[var_12_1])
		else
			arg_12_1[var_12_1].quantity = arg_12_1[var_12_1].quantity + var_12_2
		end
	end
end

function var_0_0._createItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = gohelper.findChild(arg_13_1, "#go_Limit")
	local var_13_1 = gohelper.findChild(arg_13_1, "#go_item")
	local var_13_2 = gohelper.findChild(arg_13_1, "#go_new")
	local var_13_3 = arg_13_2.materilType
	local var_13_4 = arg_13_2.materilId
	local var_13_5 = arg_13_2.quantity
	local var_13_6 = IconMgr.instance:getCommonPropItemIcon(var_13_1)

	var_13_6:setMOValue(var_13_3, var_13_4, var_13_5, nil, true)

	local var_13_7 = var_13_5 and var_13_5 ~= 0

	if arg_13_0:getIsSkin(arg_13_2) then
		var_13_7 = false
	end

	var_13_6:isShowEquipAndItemCount(var_13_7)

	if var_13_7 then
		var_13_6:setCountText(GameUtil.numberDisplay(var_13_5))
	end

	var_13_6:setCountFontSize(43)
	gohelper.setActive(var_13_0, arg_13_2[4] == 1)
	gohelper.setActive(var_13_2, arg_13_2[5] == 1)
end

function var_0_0.onClickModalMask(arg_14_0)
	arg_14_0:closeThis()
end

function var_0_0._setPropItems(arg_15_0)
	CommonPropListModel.instance:setPropList(arg_15_0.viewParam)

	local var_15_0 = CommonPropListModel.instance:getList()

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_1 = arg_15_0:getResInst(arg_15_0.viewContainer._viewSetting.otherRes[1], arg_15_0._gocontent, "cell" .. iter_15_0)

		transformhelper.setLocalScale(var_15_1.transform, 0.7, 0.7, 0.7)

		local var_15_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_1, CommonPropListItem)

		var_15_2._index = iter_15_0
		var_15_2._view = arg_15_0

		var_15_2:onUpdateMO(iter_15_1)

		function var_15_2.callback()
			var_15_2:setCountFontSize(43)
		end
	end
end

function var_0_0.openChargeView(arg_17_0)
	StatController.instance:track(StatEnum.EventName.ClickBPRewardWindowButton, {
		[StatEnum.EventProperties.ButtonName] = "解锁吼吼典藏光碟"
	})
	ViewMgr.instance:openView(ViewName.BpChargeView)
	arg_17_0:closeThis()
end

function var_0_0.onClose(arg_18_0)
	CommonPropListModel.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)

	CommonPropListItem.hasOpen = false
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0

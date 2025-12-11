module("modules.logic.sp01.act208.view.V2a9_Act208RewardItem", package.seeall)

local var_0_0 = class("V2a9_Act208RewardItem", LuaCompBase)

function var_0_0._setActiveByRegion(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = SettingsModel.instance:getRegion()
	local var_1_1 = false

	for iter_1_0, iter_1_1 in ipairs(arg_1_2 or {}) do
		if var_1_0 == iter_1_1 then
			var_1_1 = true

			break
		end
	end

	gohelper.setActive(arg_1_1, var_1_1)
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._simageItem = gohelper.findChildSingleImage(arg_2_0.go, "#simage_Item")
	arg_2_0._txtNum = gohelper.findChildText(arg_2_0.go, "image_NumBG/#txt_Num")
	arg_2_0._imageQuality = gohelper.findChildImage(arg_2_0.go, "#img_Quality")
	arg_2_0._btnclick = gohelper.findChildButtonWithAudio(arg_2_0.go, "#btn_click")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_5_0)
	if arg_5_0.state == nil then
		return
	end

	if arg_5_0.state == Act208Enum.BonusState.NotGet or arg_5_0.state == Act208Enum.BonusState.HaveGet then
		if arg_5_0.bonusData == nil then
			logError("bonusData is nil")

			return
		end

		local var_5_0 = arg_5_0.bonusData[1]
		local var_5_1 = arg_5_0.bonusData[2]
		local var_5_2 = arg_5_0.bonusData[3]

		MaterialTipController.instance:showMaterialInfo(var_5_0, var_5_1, false, nil, false)

		return
	end

	Act208Controller.instance:getBonus(arg_5_0.actId, arg_5_0.id)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._txt_tips_overseas_zh_jpGo = gohelper.findChild(arg_6_0.go, "tips/txt_tips_overseas_zh_jp")
	arg_6_0._txt_tips_overseas_tw_krGo = gohelper.findChild(arg_6_0.go, "tips/txt_tips_overseas_tw_kr")
	arg_6_0._txt_tips_overseas_globalGo = gohelper.findChild(arg_6_0.go, "tips/txt_tips_overseas_global")

	arg_6_0:_setActiveByRegion(arg_6_0._txt_tips_overseas_zh_jpGo, {
		RegionEnum.zh,
		RegionEnum.jp
	})
	arg_6_0:_setActiveByRegion(arg_6_0._txt_tips_overseas_tw_krGo, {
		RegionEnum.tw,
		RegionEnum.ko
	})
	arg_6_0:_setActiveByRegion(arg_6_0._txt_tips_overseas_globalGo, {
		RegionEnum.en
	})

	arg_6_0._goCanGet = gohelper.findChild(arg_6_0.go, "go_canget")
	arg_6_0._goReceive = gohelper.findChild(arg_6_0.go, "go_receive")

	gohelper.setActive(arg_6_0._goCanGet, false)
	gohelper.setActive(arg_6_0._goReceive, false)
end

function var_0_0.setData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.actId = arg_7_1
	arg_7_0.id = arg_7_2.id
	arg_7_0.config = arg_7_2

	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = arg_8_0.config
	local var_8_1 = string.splitToNumber(var_8_0.bonus, "#")
	local var_8_2 = var_8_1[1]
	local var_8_3 = var_8_1[2]
	local var_8_4 = var_8_1[3]

	arg_8_0.bonusData = var_8_1

	local var_8_5, var_8_6 = ItemModel.instance:getItemConfigAndIcon(var_8_2, var_8_3, true)

	if var_8_0.isAllBonus == Act208Enum.RewardType.Common then
		arg_8_0._simageItem:LoadImage(var_8_6)

		arg_8_0._txtNum.text = tostring(var_8_4)

		local var_8_7 = var_8_5.rare and var_8_5.rare or 5

		UISpriteSetMgr.instance:setOptionalGiftSprite(arg_8_0._imageQuality, "bg_pinjidi_" .. var_8_7)
	elseif var_8_0.isAllBonus == Act208Enum.RewardType.Final then
		-- block empty
	end
end

function var_0_0.setState(arg_9_0, arg_9_1)
	arg_9_0.state = arg_9_1.status

	gohelper.setActive(arg_9_0._goCanGet, arg_9_1.status == Act208Enum.BonusState.CanGet)
	gohelper.setActive(arg_9_0._goReceive, arg_9_1.status == Act208Enum.BonusState.HaveGet)
end

function var_0_0.onDestroy(arg_10_0)
	return
end

return var_0_0

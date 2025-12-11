module("modules.logic.sp01.act208.view.V2a9_Act208MainView", package.seeall)

local var_0_0 = class("V2a9_Act208MainView", BaseView)

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

function var_0_0.onInitView(arg_2_0)
	arg_2_0._simageFullBG = gohelper.findChildSingleImage(arg_2_0.viewGO, "Root/#simage_FullBG")
	arg_2_0._simageTitle = gohelper.findChildSingleImage(arg_2_0.viewGO, "Root/Title/#simage_Title")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(Act208Controller.instance, Act208Event.onGetInfo, arg_3_0.refreshState, arg_3_0)
	arg_3_0:addEventCb(Act208Controller.instance, Act208Event.onGetBonus, arg_3_0.refreshState, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeEventCb(Act208Controller.instance, Act208Event.onGetInfo, arg_4_0.refreshState, arg_4_0)
	arg_4_0:removeEventCb(Act208Controller.instance, Act208Event.onGetBonus, arg_4_0.refreshState, arg_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._txt_dec_overseas_zh_jpGo = gohelper.findChild(arg_5_0.viewGO, "Root/txt_dec_overseas_zh_jp")
	arg_5_0._txt_dec_overseas_tw_krGo = gohelper.findChild(arg_5_0.viewGO, "Root/txt_dec_overseas_tw_kr")
	arg_5_0._txt_dec_overseas_globalGo = gohelper.findChild(arg_5_0.viewGO, "Root/txt_dec_overseas_global")

	arg_5_0:_setActiveByRegion(arg_5_0._txt_dec_overseas_zh_jpGo, {
		RegionEnum.zh,
		RegionEnum.jp
	})
	arg_5_0:_setActiveByRegion(arg_5_0._txt_dec_overseas_tw_krGo, {
		RegionEnum.tw,
		RegionEnum.ko
	})
	arg_5_0:_setActiveByRegion(arg_5_0._txt_dec_overseas_globalGo, {
		RegionEnum.en
	})

	arg_5_0._goRewardParent = gohelper.findChild(arg_5_0.viewGO, "Root/reward")

	local var_5_0 = arg_5_0._goRewardParent.transform.childCount

	arg_5_0._rewardItemList = {}

	for iter_5_0 = 1, var_5_0 do
		local var_5_1 = arg_5_0._goRewardParent.transform:GetChild(iter_5_0 - 1)
		local var_5_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_1.gameObject, V2a9_Act208RewardItem)

		table.insert(arg_5_0._rewardItemList, var_5_2)
	end
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.actId = arg_7_0.viewParam.actId

	local var_7_0 = Act208Helper.getCurPlatformType()

	Act208Controller.instance:getActInfo(arg_7_0.actId, var_7_0)
	arg_7_0:_checkParent()
	arg_7_0:refreshUI()
end

function var_0_0._checkParent(arg_8_0)
	local var_8_0 = arg_8_0.viewParam.parent

	if var_8_0 then
		gohelper.addChild(var_8_0, arg_8_0.viewGO)
	end
end

function var_0_0.refreshUI(arg_9_0)
	local var_9_0 = arg_9_0.actId
	local var_9_1 = Act208Config.instance:getBonusListById(var_9_0)

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = arg_9_0._rewardItemList[iter_9_1.id]

		if var_9_2 ~= nil then
			var_9_2:setData(var_9_0, iter_9_1)
		end
	end
end

function var_0_0.refreshState(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= arg_10_0.actId then
		return
	end

	local var_10_0 = Act208Model.instance:getInfo(arg_10_1)

	if not var_10_0 then
		return
	end

	if arg_10_2 ~= nil then
		local var_10_1 = var_10_0.bonusDic[arg_10_2]

		arg_10_0._rewardItemList[arg_10_2]:setState(var_10_1)
	else
		for iter_10_0, iter_10_1 in ipairs(var_10_0.bonusList) do
			arg_10_0._rewardItemList[iter_10_1.id]:setState(iter_10_1)
		end
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0

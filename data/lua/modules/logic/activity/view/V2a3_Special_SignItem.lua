module("modules.logic.activity.view.V2a3_Special_SignItem", package.seeall)

local var_0_0 = class("V2a3_Special_SignItem", LinkageActivity_Page2RewardBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "icon/#txt_num")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "icon/#simage_icon")

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

local var_0_1 = string.split

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)
end

function var_0_0.onDestroyView(arg_5_0)
	var_0_0.super.onDestroyView(arg_5_0)
end

function var_0_0._editableAddEvents(arg_6_0)
	var_0_0.super._editableInitView(arg_6_0)
	arg_6_0._click:AddClickListener(arg_6_0._onClick, arg_6_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_6_0._OnOpenView, arg_6_0)
end

function var_0_0._editableRemoveEvents(arg_7_0)
	arg_7_0._click:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_7_0._OnOpenView, arg_7_0)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._simageiconImg = gohelper.findChildImage(arg_8_0._simageicon.gameObject, "")
	arg_8_0._bgImg = gohelper.findChildImage(arg_8_0.viewGO, "icon/bg")
	arg_8_0._go_nextday = gohelper.findChild(arg_8_0.viewGO, "go_nextday")
	arg_8_0._goCanGet = gohelper.findChild(arg_8_0.viewGO, "go_canget")
	arg_8_0._goGet = gohelper.findChild(arg_8_0.viewGO, "go_hasget")
	arg_8_0._click = gohelper.getClick(gohelper.findChild(arg_8_0.viewGO, "clickarea"))
	arg_8_0._txtnum.text = ""

	arg_8_0:setActive_goGet(false)
	arg_8_0:setActive_goCanGet(false)
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	var_0_0.super.onUpdateMO(arg_9_0, arg_9_1)

	local var_9_0 = arg_9_0:isType101RewardGet()
	local var_9_1 = var_9_0 and "#808080" or "#ffffff"
	local var_9_2 = arg_9_0:getNorSignActivityCo()
	local var_9_3 = arg_9_0._index
	local var_9_4 = var_0_1(var_9_2.bonus, "|")
	local var_9_5 = #var_9_4

	assert(var_9_5 == 1, string.format("[V2a3_Special_SignItem] rewardCount=%s", tostring(var_9_5)))

	local var_9_6 = string.splitToNumber(var_9_4[1], "#")

	arg_9_1._itemCo = var_9_6

	local var_9_7 = arg_9_0:_assetGetViewContainer():getItemIconResUrl(var_9_6[1], var_9_6[2])

	GameUtil.loadSImage(arg_9_0._simageicon, var_9_7)
	UIColorHelper.set(arg_9_0._simageiconImg, var_9_1)
	UIColorHelper.set(arg_9_0._bgImg, var_9_1)

	arg_9_0._txtnum.text = luaLang("multiple") .. var_9_6[3]

	arg_9_0:setActive_goGet(var_9_0)
	arg_9_0:setActive_goCanGet(arg_9_0:isType101RewardCouldGet())

	local var_9_8 = arg_9_0:getType101LoginCount()

	arg_9_0:setActive_goTmr(var_9_8 + 1 == var_9_3)
end

function var_0_0.setActive_goCanGet(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goCanGet, arg_10_1)
end

function var_0_0.setActive_goGet(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._goGet, arg_11_1)
end

function var_0_0.setActive_goTmr(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._go_nextday, arg_12_1)
end

function var_0_0._onClick(arg_13_0)
	if not arg_13_0:isActOnLine() then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	if arg_13_0:isType101RewardCouldGet() then
		arg_13_0:sendGet101BonusRequest()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tags_2000013)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_25050217)

	local var_13_0 = arg_13_0._mo._itemCo

	MaterialTipController.instance:showMaterialInfo(var_13_0[1], var_13_0[2])
end

function var_0_0._OnOpenView(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.RoomBlockPackageGetView then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shenghuo_building_collect_20234002)
	end
end

return var_0_0

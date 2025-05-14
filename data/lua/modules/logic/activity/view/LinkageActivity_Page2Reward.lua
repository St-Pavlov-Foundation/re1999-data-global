module("modules.logic.activity.view.LinkageActivity_Page2Reward", package.seeall)

local var_0_0 = class("LinkageActivity_Page2Reward", LinkageActivity_Page2RewardBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "image_NumBG/#txt_Num")
	arg_1_0._goCanGet = gohelper.findChild(arg_1_0.viewGO, "#go_CanGet")
	arg_1_0._goGet = gohelper.findChild(arg_1_0.viewGO, "#go_Get")

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

function var_0_0.ctor(arg_4_0, arg_4_1)
	var_0_0.super.ctor(arg_4_0, arg_4_1)
end

function var_0_0.onDestroyView(arg_5_0)
	GameUtil.onDestroyViewMember(arg_5_0, "_itemIcon")
	FrameTimerController.onDestroyViewMember(arg_5_0, "_frameTimer")
	var_0_0.super.onDestroyView(arg_5_0)
end

function var_0_0._editableAddEvents(arg_6_0)
	var_0_0.super._editableInitView(arg_6_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_6_0._OnOpenView, arg_6_0)
end

function var_0_0._editableRemoveEvents(arg_7_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_7_0._OnOpenView, arg_7_0)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._txtNum.text = ""

	arg_8_0:setActive_goGet(false)
	arg_8_0:setActive_goCanGet(false)

	arg_8_0._imageRewardGo = gohelper.findChild(arg_8_0.viewGO, "image_Reward")
	arg_8_0._itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_8_0._imageRewardGo)
	arg_8_0._imageRewardBG = gohelper.findChildImage(arg_8_0.viewGO, "image_RewardBG")
	arg_8_0._imageTipsBGGo = gohelper.findChild(arg_8_0.viewGO, "image_TipsBG")
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	var_0_0.super.onUpdateMO(arg_9_0, arg_9_1)

	local var_9_0 = arg_9_0:isType101RewardGet()
	local var_9_1 = var_9_0 and "#808080" or "#ffffff"
	local var_9_2 = arg_9_0:getNorSignActivityCo()
	local var_9_3 = arg_9_0._index
	local var_9_4 = var_0_1(var_9_2.bonus, "|")
	local var_9_5 = #var_9_4

	assert(var_9_5 == 1, string.format("[LinkageActivity_Page2Reward] rewardCount=%s", tostring(var_9_5)))

	local var_9_6 = string.splitToNumber(var_9_4[1], "#")
	local var_9_7 = var_9_6[1]
	local var_9_8 = var_9_6[2]
	local var_9_9 = var_9_6[3]

	arg_9_1._itemCo = var_9_6

	arg_9_0._itemIcon:setMOValue(var_9_7, var_9_8, var_9_9)
	arg_9_0._itemIcon:isShowQuality(false)
	arg_9_0._itemIcon:isShowEquipAndItemCount(false)
	arg_9_0._itemIcon:customOnClickCallback(arg_9_0._onClick, arg_9_0)

	if arg_9_0._itemIcon:isEquipIcon() then
		arg_9_0._itemIcon:setScale(0.7)
	else
		arg_9_0._itemIcon:setScale(0.8)
	end

	arg_9_0._itemIcon:setItemColor(var_9_1)
	UIColorHelper.set(arg_9_0._imageRewardBG, var_9_1)

	arg_9_0._txtNum.text = luaLang("multiple") .. var_9_9

	arg_9_0:setActive_goGet(var_9_0)
	arg_9_0:setActive_goCanGet(arg_9_0:isType101RewardCouldGet())

	local var_9_10 = arg_9_0:getType101LoginCount()

	arg_9_0:setActive_goTmr(var_9_10 + 1 == var_9_3)
end

function var_0_0.setActive_goCanGet(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goCanGet, arg_10_1)
end

function var_0_0.setActive_goGet(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._goGet, arg_11_1)
end

function var_0_0.setActive_goTmr(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._imageTipsBGGo, arg_12_1)
end

function var_0_0._onClaimAllCb(arg_13_0)
	if not arg_13_0:isType101RewardCouldGetAnyOne() then
		FrameTimerController.onDestroyViewMember(arg_13_0, "_frameTimer")

		arg_13_0._frameTimer = FrameTimerController.instance:register(function()
			if ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.RoomBlockPackageGetView) then
				FrameTimerController.onDestroyViewMember(arg_13_0, "_frameTimer")
				arg_13_0:_assetGetViewContainer():switchPage(1)
			end
		end, nil, 6, 6)

		arg_13_0._frameTimer:Start()
	end
end

function var_0_0._onClick(arg_15_0)
	if not arg_15_0:isActOnLine() then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	if arg_15_0:isType101RewardCouldGet() then
		arg_15_0:sendGet101BonusRequest(arg_15_0._onClaimAllCb, arg_15_0)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tags_2000013)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_25050217)

	local var_15_0 = arg_15_0._mo._itemCo

	MaterialTipController.instance:showMaterialInfo(var_15_0[1], var_15_0[2])
end

function var_0_0._OnOpenView(arg_16_0, arg_16_1)
	if arg_16_1 == ViewName.RoomBlockPackageGetView then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shenghuo_building_collect_20234002)
	end
end

return var_0_0

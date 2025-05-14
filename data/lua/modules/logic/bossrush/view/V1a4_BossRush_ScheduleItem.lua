module("modules.logic.bossrush.view.V1a4_BossRush_ScheduleItem", package.seeall)

local var_0_0 = class("V1a4_BossRush_ScheduleItem", LuaCompBase)
local var_0_1 = string.split
local var_0_2 = string.splitToNumber

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._goBg = gohelper.findChildImage(arg_1_1, "#go_Bg")
	arg_1_0._imageStatus = gohelper.findChildImage(arg_1_1, "verticalLayout/#image_Status")
	arg_1_0._txtPointValue = gohelper.findChildText(arg_1_1, "verticalLayout/#image_Status/#txt_PointValue")

	arg_1_0:_initItems(arg_1_1)

	arg_1_0._txtPointValue.text = ""

	gohelper.setActive(arg_1_0._goBg, false)
end

function var_0_0._initItems(arg_2_0, arg_2_1)
	arg_2_0._itemList = {}

	local var_2_0 = 1
	local var_2_1 = gohelper.findChild(arg_2_1, "verticalLayout/item" .. var_2_0)
	local var_2_2 = V1a4_BossRush_ScheduleItemRewardItem

	while not gohelper.isNil(var_2_1) do
		arg_2_0._itemList[var_2_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_1, var_2_2)
		var_2_0 = var_2_0 + 1
		var_2_1 = gohelper.findChild(arg_2_1, "verticalLayout/item" .. var_2_0)
	end
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0._mo = arg_3_1

	arg_3_0:_refresh()
	arg_3_0:_playOpen()
end

function var_0_0.onDestroyView(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._playOpenInner, arg_4_0)
	GameUtil.onDestroyViewMemberList(arg_4_0, "_itemList")
end

function var_0_0._refresh(arg_5_0)
	local var_5_0 = arg_5_0._mo.stageRewardCO
	local var_5_1 = var_5_0.display > 0
	local var_5_2 = var_0_1(var_5_0.reward, "|")

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._itemList) do
		iter_5_1:setActive(false)
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_2) do
		local var_5_3 = var_0_2(iter_5_3, "#")
		local var_5_4 = arg_5_0._itemList[iter_5_2]

		if var_5_4 then
			var_5_4:setData(var_5_3)
			var_5_4:setActive(true)
		end
	end

	UISpriteSetMgr.instance:setV1a4BossRushSprite(arg_5_0._imageStatus, BossRushConfig.instance:getRewardStatusSpriteName(var_5_1, arg_5_0:_isGot()))
	gohelper.setActive(arg_5_0._goBg, var_5_1)

	arg_5_0._txtPointValue.text = var_5_0.rewardPointNum

	SLFramework.UGUI.GuiHelper.SetColor(arg_5_0._txtPointValue, arg_5_0:_isGot() and BossRushEnum.Color.POINTVALUE_GOT or BossRushEnum.Color.POINTVALUE_NORMAL)
end

function var_0_0.refreshByDisplayTarget(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1
	arg_6_0._index = arg_6_1._index

	arg_6_0:_refresh()
	gohelper.setActive(arg_6_0._goBg, false)
end

function var_0_0._isNewGot(arg_7_0)
	local var_7_0 = arg_7_0._index
	local var_7_1 = V1a4_BossRush_ScheduleViewListModel.instance:getStaticData()
	local var_7_2 = var_7_1.fromIndex
	local var_7_3 = var_7_1.toIndex

	return var_7_2 <= var_7_0 and var_7_0 <= var_7_3
end

function var_0_0._isAlreadyGot(arg_8_0)
	local var_8_0 = arg_8_0._mo.isGot
	local var_8_1 = arg_8_0._index
	local var_8_2 = V1a4_BossRush_ScheduleViewListModel.instance:getStaticData().fromIndex

	return var_8_0 or var_8_1 < var_8_2
end

function var_0_0._isGot(arg_9_0)
	return arg_9_0:_isAlreadyGot() or arg_9_0:_isNewGot()
end

function var_0_0._playOpen(arg_10_0)
	if arg_10_0:_isGot() then
		local var_10_0 = V1a4_BossRush_ScheduleViewListModel.instance:getStaticData().fromIndex

		TaskDispatcher.runDelay(arg_10_0._playOpenInner, arg_10_0, 0.1 + (arg_10_0._index - var_10_0) * 0.02)
	end
end

local var_0_3 = BossRushEnum.AnimScheduleItemRewardItem
local var_0_4 = BossRushEnum.AnimScheduleItemRewardItem_HasGet

function var_0_0._playOpenInner(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._itemList) do
		if arg_11_0:_isNewGot() then
			iter_11_1:playAnim(var_0_3.ReceiveEnter)
			iter_11_1:playAnim_HasGet(var_0_4.Got)
		else
			iter_11_1:playAnim(arg_11_0:_isGot() and var_0_3.Got or var_0_3.Idle)
		end
	end
end

return var_0_0

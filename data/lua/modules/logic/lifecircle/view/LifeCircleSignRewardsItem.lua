module("modules.logic.lifecircle.view.LifeCircleSignRewardsItem", package.seeall)

local var_0_0 = class("LifeCircleSignRewardsItem", RougeSimpleItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_rewards")
	arg_1_0._gorewardtemplate = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#go_reward_template")
	arg_1_0._goimagestatus = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#go_image_status")
	arg_1_0._goimagestatuslight = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#go_image_status_light")
	arg_1_0._goimportant = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#go_important")
	arg_1_0._txtpointvalue = gohelper.findChildText(arg_1_0.viewGO, "#go_rewards/#go_important/#txt_pointvalue")
	arg_1_0._txtpointvalue_normal = gohelper.findChildText(arg_1_0.viewGO, "#go_rewards/#txt_pointvalue_normal")

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

local var_0_1 = string.splitToNumber
local var_0_2 = string.split

function var_0_0.ctor(arg_4_0, ...)
	arg_4_0:__onInit()
	var_0_0.super.ctor(arg_4_0, ...)

	arg_4_0._rewardItemList = {}
	arg_4_0._isLastOne = false
end

function var_0_0.onDestroyView(arg_5_0)
	var_0_0.super.onDestroyView(arg_5_0)
	GameUtil.onDestroyViewMemberList(arg_5_0, "_rewardItemList")
	arg_5_0:__onDispose()
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._gorewardtemplate, false)
end

function var_0_0.setData(arg_7_0, arg_7_1)
	var_0_0.super.setData(arg_7_0, arg_7_1)

	local var_7_0 = arg_7_0._mo.bonus

	arg_7_0._isLastOne = string.nilorempty(var_7_0)

	local var_7_1 = arg_7_0:isClaimable()
	local var_7_2 = arg_7_0:isClaimed()
	local var_7_3 = var_7_1 or var_7_2
	local var_7_4 = arg_7_0._isLastOne and {} or var_0_2(var_7_0, "|")
	local var_7_5 = arg_7_0._isLastOne and 2 or #var_7_4

	for iter_7_0 = 1, var_7_5 do
		local var_7_6
		local var_7_7 = not arg_7_0._isLastOne and var_0_1(var_7_4[iter_7_0], "#") or nil

		if iter_7_0 > #arg_7_0._rewardItemList then
			var_7_6 = arg_7_0:_create_LifeCircleSignRewardsItemItem(iter_7_0)

			table.insert(arg_7_0._rewardItemList, var_7_6)
		else
			var_7_6 = arg_7_0._rewardItemList[iter_7_0]
		end

		var_7_6:onUpdateMO(var_7_7)
		var_7_6:setActive(true)
	end

	for iter_7_1 = var_7_5 + 1, #arg_7_0._rewardItemList do
		arg_7_0._rewardItemList[iter_7_1]:setActive(false)
	end

	arg_7_0._txtpointvalue.text = arg_7_0:logindaysid()
	arg_7_0._txtpointvalue_normal.text = arg_7_0._isLastOne and luaLang("LifeCircleSignRewardsItemItemLastOnePtValue") or var_7_1 and "" or arg_7_0:logindaysid()

	gohelper.setActive(arg_7_0._goimportant, var_7_1)
	gohelper.setActive(arg_7_0._goimagestatus, not var_7_3)
	gohelper.setActive(arg_7_0._goimagestatuslight, var_7_3)
end

function var_0_0.isLastOne(arg_8_0)
	return arg_8_0._isLastOne
end

function var_0_0.stageid(arg_9_0)
	return arg_9_0._mo.stageid
end

function var_0_0.logindaysid(arg_10_0)
	return arg_10_0._mo.logindaysid
end

function var_0_0._create_LifeCircleSignRewardsItemItem(arg_11_0, arg_11_1)
	local var_11_0 = gohelper.cloneInPlace(arg_11_0._gorewardtemplate)
	local var_11_1 = LifeCircleSignRewardsItemItem.New({
		parent = arg_11_0,
		baseViewContainer = arg_11_0:baseViewContainer()
	})

	var_11_1:setIndex(arg_11_1)
	var_11_1:init(var_11_0)

	return var_11_1
end

function var_0_0._totalLoginDays(arg_12_0)
	return arg_12_0:parent():totalLoginDays()
end

function var_0_0.onItemClick(arg_13_0)
	if arg_13_0:isClaimable() then
		LifeCircleController.instance:sendSignInTotalRewardRequest(arg_13_0:stageid())

		return false
	end

	return true
end

function var_0_0.isClaimed(arg_14_0)
	if arg_14_0._isLastOne then
		return false
	end

	local var_14_0 = arg_14_0:stageid()

	return SignInModel.instance:isClaimedAccumulateReward(var_14_0)
end

function var_0_0.isClaimable(arg_15_0)
	if arg_15_0._isLastOne then
		return false
	end

	local var_15_0 = arg_15_0:stageid()

	return LifeCircleController.instance:isClaimableAccumulateReward(var_15_0)
end

return var_0_0

module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryRewardItem", package.seeall)

local var_0_0 = class("Activity165StoryRewardItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "#go_reward")

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

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addEvents()
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0:removeEvents()
end

function var_0_0.init(arg_6_0, arg_6_1)
	arg_6_0.viewGO = arg_6_1

	arg_6_0:onInitView()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._rewarditems = {}
	arg_7_0._rewardGoPrefabs = gohelper.findChild(arg_7_0.viewGO, "layout/go_reward")
	arg_7_0._godarkpoint = gohelper.findChild(arg_7_0.viewGO, "darkpoint")
	arg_7_0._golightpoint = gohelper.findChild(arg_7_0.viewGO, "lightpoint")
	arg_7_0._golayout = gohelper.findChild(arg_7_0.viewGO, "layout")
end

function var_0_0.onUpdateParam(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = DungeonConfig.instance:getRewardItems(tonumber(arg_8_2.bonus))

	arg_8_0._storyId = arg_8_2.storyId
	arg_8_0._actId = Activity165Model.instance:getActivityId()
	arg_8_0._storyMo = Activity165Model.instance:getStoryMo(arg_8_0._actId, arg_8_0._storyId)
	arg_8_0._index = arg_8_1

	local var_8_1 = #var_8_0

	for iter_8_0 = 1, var_8_1 do
		local var_8_2 = var_8_0[iter_8_0]
		local var_8_3 = arg_8_0:getRewardItem(iter_8_0)

		arg_8_0:onRefreshItem(arg_8_1, iter_8_0)
		gohelper.setActive(var_8_3.go, true)

		var_8_3.rewardCfg = var_8_2
		var_8_3.itemCfg, var_8_3.iconPath = ItemModel.instance:getItemConfigAndIcon(var_8_2[1], var_8_2[2])

		var_8_3.simagereward:LoadImage(var_8_3.iconPath)
		UISpriteSetMgr.instance:setUiFBSprite(var_8_3.imagebg, "bg_pinjidi_" .. var_8_3.itemCfg.rare)

		var_8_3.txtpointvalue.text = luaLang("multiple") .. var_8_2[3]
	end

	gohelper.setActive(arg_8_0.viewGO, true)
end

function var_0_0.getRewardItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._rewarditems[arg_9_1]

	if not var_9_0 then
		var_9_0 = arg_9_0:getUserDataTb_()

		local var_9_1 = gohelper.clone(arg_9_0._rewardGoPrefabs, arg_9_0._golayout, "reward_" .. tostring(arg_9_1))

		var_9_0.imagebg = gohelper.findChildImage(var_9_1, "item/image_rare")
		var_9_0.simagereward = gohelper.findChildSingleImage(var_9_1, "item/simage_icon")
		var_9_0.txtpointvalue = gohelper.findChildText(var_9_1, "item/txt_num")
		var_9_0.imagereward = var_9_0.simagereward:GetComponent(gohelper.Type_Image)
		var_9_0.btn = gohelper.findChildButtonWithAudio(var_9_1, "item/btn_click")
		var_9_0.goalreadygot = gohelper.findChild(var_9_1, "go_hasget")
		var_9_0.btncanget = gohelper.findChildButtonWithAudio(var_9_1, "go_canget")

		var_9_0.btn:AddClickListener(arg_9_0.onClickItem, arg_9_0, var_9_0)

		var_9_0.go = var_9_1
		arg_9_0._rewarditems[arg_9_1] = var_9_0
	end

	return var_9_0
end

function var_0_0.onRefreshItem(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._storyMo then
		return
	end

	local var_10_0 = arg_10_0:getRewardItem(arg_10_2)
	local var_10_1 = arg_10_0._storyMo:getUnlockEndingCount() or 0

	var_10_0.hasGetBonus = arg_10_1 <= (arg_10_0._storyMo:getclaimRewardCount() or 0)
	var_10_0.unlock = arg_10_1 <= var_10_1
	var_10_0.canGetBonus = var_10_0.unlock and not var_10_0.hasGetBonus

	gohelper.setActive(var_10_0.goalreadygot, var_10_0.hasGetBonus)
	gohelper.setActive(var_10_0.btncanget.gameObject, var_10_0.canGetBonus)
	gohelper.setActive(arg_10_0._godarkpoint, not var_10_0.unlock)
	gohelper.setActive(arg_10_0._golightpoint.gameObject, var_10_0.unlock)
end

function var_0_0.onClickItem(arg_11_0, arg_11_1)
	MaterialTipController.instance:showMaterialInfo(arg_11_1.rewardCfg[1], arg_11_1.rewardCfg[2])
end

function var_0_0.checkBonus(arg_12_0)
	if not arg_12_0._storyMo then
		return
	end

	local var_12_0 = arg_12_0._storyMo:getUnlockEndingCount()
	local var_12_1 = arg_12_0._storyMo:getclaimRewardCount()
	local var_12_2 = arg_12_0._storyMo:getAllEndingRewardCo()
	local var_12_3 = false

	for iter_12_0 = 1, #var_12_2 do
		if iter_12_0 <= var_12_0 and not (iter_12_0 <= var_12_1) then
			var_12_3 = true

			break
		end
	end

	if var_12_3 then
		TaskDispatcher.runDelay(arg_12_0.onGetBonusCallback, arg_12_0, 0.5)
	end
end

function var_0_0.onGetBonusCallback(arg_13_0)
	Activity165Rpc.instance:sendAct165GainMilestoneRewardRequest(arg_13_0._actId, arg_13_0._storyId)
end

function var_0_0.onStart(arg_14_0)
	return
end

function var_0_0.onDestroy(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._rewarditems) do
		iter_15_1.btn:RemoveClickListener()
		iter_15_1.btncanget:RemoveClickListener()
		iter_15_1.simagereward:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_15_0.onGetBonusCallback, arg_15_0)
end

return var_0_0

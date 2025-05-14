module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryItem", package.seeall)

local var_0_0 = class("Activity165StoryItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagepic = gohelper.findChildImage(arg_1_0.viewGO, "#simage_pic")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._gostoryname = gohelper.findChild(arg_1_0.viewGO, "#go_storyname")
	arg_1_0._txtstoryname = gohelper.findChildText(arg_1_0.viewGO, "#go_storyname/#txt_storyname")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "#go_reward")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_reward/#txt_num")
	arg_1_0._btnreword = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_reward/#btn_reword")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnreword:AddClickListener(arg_2_0._btnrewordOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnreword:RemoveClickListener()
end

function var_0_0._btnrewordOnClick(arg_4_0)
	Activity165Controller.instance:dispatchEvent(Activity165Event.onClickOpenStoryRewardBtn, arg_4_0._mo.storyId)
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0:addEvents()
end

function var_0_0.removeEventListeners(arg_6_0)
	arg_6_0:removeEvents()
end

function var_0_0._btnclickOnClick(arg_7_0)
	if arg_7_0._mo and arg_7_0._mo.isUnlock then
		Activity165Controller.instance:openActivity165EditView(arg_7_0._mo.storyId)
	else
		GameFacade.showToast(ToastEnum.Act165StoryLock)
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._rewardCanClaim = gohelper.findChild(arg_8_0.viewGO, "#go_reward/claim")
	arg_8_0._rewardfinish = gohelper.findChild(arg_8_0.viewGO, "#go_reward/finish")
	arg_8_0._rewardReddot = gohelper.findChild(arg_8_0.viewGO, "#go_reward/claim/go_reddot")
	arg_8_0._viewAnim = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.init(arg_9_0, arg_9_1)
	arg_9_0.viewGO = arg_9_1
	arg_9_0.actId = Activity165Model.instance:getActivityId()

	arg_9_0:onInitView()
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._mo = arg_10_1

	local var_10_0 = arg_10_1 and arg_10_1:getUnlockEndingCount() or 0
	local var_10_1 = arg_10_1 and arg_10_1:getAllEndingRewardCo()

	arg_10_0.allRewordCount = var_10_1 and tabletool.len(var_10_1) or 0

	local var_10_2 = luaLang("act126_story_reword_count")
	local var_10_3 = math.min(var_10_0, arg_10_0.allRewordCount)

	arg_10_0._txtnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(var_10_2, var_10_3, arg_10_0.allRewordCount)

	local var_10_4 = arg_10_1 and arg_10_1.isUnlock
	local var_10_5

	var_10_5 = arg_10_1 and arg_10_1:isFinish()

	local var_10_6 = arg_10_1 and arg_10_1.storyCo and arg_10_1.storyCo.pic or "v2a1_strangetale_pic" .. arg_10_2

	if not var_10_4 then
		var_10_6 = var_10_6 .. "_locked"
	end

	UISpriteSetMgr.instance:setV2a1Act165_2Sprite(arg_10_0._simagepic, var_10_6, true)
	gohelper.setActive(arg_10_0._gofinish.gameObject, false)
	arg_10_0:refreshRewardState()

	arg_10_0._txtstoryname.text = arg_10_1 and arg_10_1:getStoryName(63) or 0

	arg_10_0:_playUnlock()
	RedDotController.instance:addRedDot(arg_10_0._rewardReddot, RedDotEnum.DotNode.Act165HasReward, arg_10_2)
end

function var_0_0.refreshRewardState(arg_11_0)
	local var_11_0 = arg_11_0._mo and arg_11_0._mo:getUnlockEndingCount() or 0
	local var_11_1 = arg_11_0._mo and arg_11_0._mo:getclaimRewardCount() or 0
	local var_11_2 = var_11_1 >= arg_11_0.allRewordCount

	gohelper.setActive(arg_11_0._rewardCanClaim.gameObject, var_11_1 < var_11_0 and not var_11_2)
	gohelper.setActive(arg_11_0._rewardfinish.gameObject, var_11_2)
end

function var_0_0.onOpen(arg_12_0)
	return
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

function var_0_0._playUnlock(arg_15_0)
	if not arg_15_0._mo then
		return
	end

	local var_15_0 = arg_15_0._mo.isUnlock
	local var_15_1 = arg_15_0._mo:isNewUnlock()

	if var_15_0 and var_15_1 then
		arg_15_0._viewAnim:Play(Activity165Enum.StoryItemAnim.Unlock, 0, 0)
		arg_15_0._mo:cancelNewUnlockStory()
	end
end

function var_0_0._checkUnlock(arg_16_0)
	local var_16_0 = arg_16_0._mo and arg_16_0._mo.isUnlock

	gohelper.setActive(arg_16_0._goreward.gameObject, var_16_0)
	gohelper.setActive(arg_16_0._gostoryname.gameObject, var_16_0)
end

return var_0_0

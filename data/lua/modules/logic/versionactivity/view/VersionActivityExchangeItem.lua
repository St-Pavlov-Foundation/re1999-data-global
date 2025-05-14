module("modules.logic.versionactivity.view.VersionActivityExchangeItem", package.seeall)

local var_0_0 = class("VersionActivityExchangeItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._txtneed = gohelper.findChildText(arg_1_0.go, "state/txt_need")
	arg_1_0._gounfinishstate = gohelper.findChild(arg_1_0.go, "state/go_unfinishstate")
	arg_1_0._gofinishstate = gohelper.findChild(arg_1_0.go, "state/go_finishstate")
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_0.go, "#go_rewardcontent")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_click")
	arg_1_0._goget = gohelper.findChild(arg_1_0.go, "go_get")
	arg_1_0._golingqu = gohelper.findChild(arg_1_0.go, "go_get/#lingqu")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.go, "go_finish")
	arg_1_0._gounfinish = gohelper.findChild(arg_1_0.go, "go_unfinish")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.go, "go_selected")
	arg_1_0._goselectedbg = gohelper.findChildSingleImage(arg_1_0.go, "go_selected/bg")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.go, "#go_rewardcontent/anim/#go_rewarditem")
	arg_1_0._imgiconbgunselect = gohelper.findChildImage(arg_1_0.go, "hero/img_iconbgunselect")
	arg_1_0._imgiconbgselect = gohelper.findChildImage(arg_1_0.go, "hero/img_iconbgselect")
	arg_1_0._imgheadicon = gohelper.findChildSingleImage(arg_1_0.go, "hero/mask/img_headicon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnClickOnClick, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0.updateLingqu, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0.updateLingqu, arg_3_0)
end

function var_0_0._btnClickOnClick(arg_4_0)
	if arg_4_0.state == -1 then
		-- block empty
	elseif arg_4_0.state == 1 then
		local var_4_0 = {}

		var_4_0.mark = true

		StoryController.instance:playStory(arg_4_0.config.storyId, var_4_0)
	elseif ItemModel.instance:getItemQuantity(arg_4_0.needArr[1], arg_4_0.needArr[2]) >= arg_4_0.needArr[3] then
		local var_4_1 = {}

		var_4_1.mark = true

		StoryController.instance:playStory(arg_4_0.config.storyId, var_4_1, arg_4_0.sendExchange112Request, arg_4_0)
	else
		local var_4_2 = ItemModel.instance:getItemConfigAndIcon(arg_4_0.needArr[1], arg_4_0.needArr[2])

		ToastController.instance:showToast(3202, var_4_2 and var_4_2.name or arg_4_0.needArr[2])
	end

	arg_4_0:onClick()
end

function var_0_0.sendExchange112Request(arg_5_0)
	if arg_5_0.state == 0 then
		UIBlockMgr.instance:startBlock("VersionActivityExchangeItem")

		if arg_5_0._animatorPlayer then
			arg_5_0._animatorPlayer:Play(UIAnimationName.Close, arg_5_0.sendRequest, arg_5_0)
		else
			arg_5_0:sendRequest()
		end
	end

	gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, false)
end

function var_0_0.sendRequest(arg_6_0)
	UIBlockMgr.instance:endBlock("VersionActivityExchangeItem")
	Activity112Rpc.instance:sendExchange112Request(arg_6_0.config.activityId, arg_6_0.config.id)
end

function var_0_0.onClick(arg_7_0)
	arg_7_0.selectFunc(arg_7_0.selectFuncObj, arg_7_0.config)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.rewardItemList = {}
	arg_8_0.click = gohelper.findChildClick(arg_8_0.go, "")

	arg_8_0.click:AddClickListener(arg_8_0.onClick, arg_8_0)
	arg_8_0._goselectedbg:LoadImage(ResUrl.getVersionActivityExchangeIcon("img_bg_jiangjilan_xuanzhong"))

	arg_8_0._animator = arg_8_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_8_0.go)
	arg_8_0._gorewardcontentcg = gohelper.findChild(arg_8_0._gorewardcontent, "anim"):GetComponent(typeof(UnityEngine.CanvasGroup))
end

function var_0_0.setSelectFunc(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.selectFunc = arg_9_1
	arg_9_0.selectFuncObj = arg_9_2
end

function var_0_0.updateSelect(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goselected, arg_10_0.config.id == arg_10_1)
	gohelper.setActive(arg_10_0._imgiconbgselect.gameObject, arg_10_0.config.id == arg_10_1)
	gohelper.setActive(arg_10_0._imgiconbgunselect.gameObject, arg_10_0.config.id ~= arg_10_1)
end

var_0_0.DefaultHeadOffsetX = 2.4
var_0_0.DefaultHeadOffsetY = -70.9

function var_0_0.updateItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.config = arg_11_1
	arg_11_0.needArr = string.splitToNumber(arg_11_1.items, "#")

	arg_11_0._imgheadicon:LoadImage(arg_11_1.head)

	local var_11_0 = string.splitToNumber(arg_11_1.chatheadsOffSet, "#")

	recthelper.setAnchor(arg_11_0._imgheadicon.transform, var_11_0[1] or var_0_0.DefaultHeadOffsetX, var_11_0[2] or var_0_0.DefaultHeadOffsetY)

	arg_11_0.state = -1
	arg_11_0.state = VersionActivity112Model.instance:getRewardState(arg_11_0.config.activityId, arg_11_0.config.id)

	local var_11_1 = GameUtil.splitString2(arg_11_1.bonus, true)

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		local var_11_2 = arg_11_0.rewardItemList[iter_11_0]

		if var_11_2 == nil then
			var_11_2 = {
				go = gohelper.cloneInPlace(arg_11_0._gorewarditem, "item" .. iter_11_0)
			}

			local var_11_3 = gohelper.findChild(var_11_2.go, "go_iconroot")

			var_11_2.icon = IconMgr.instance:getCommonItemIcon(var_11_3)
			arg_11_0.rewardItemList[iter_11_0] = var_11_2
		end

		var_11_2.icon:setMOValue(iter_11_1[1], iter_11_1[2], iter_11_1[3])
		var_11_2.icon:isShowCount(true)
		var_11_2.icon:setScale(0.5, 0.5, 0.5)
		var_11_2.icon:setCountFontSize(52)
		gohelper.setActive(var_11_2.go, true)
		gohelper.setActive(gohelper.findChild(var_11_2.go, "go_finish"), arg_11_0.state == 1)
	end

	for iter_11_2 = #var_11_1 + 1, #arg_11_0.rewardItemList do
		gohelper.setActive(arg_11_0.rewardItemList[iter_11_2].go, false)
	end

	arg_11_0._gorewardcontentcg.alpha = arg_11_0.state == 1 and 0.45 or 1

	gohelper.setActive(arg_11_0._gofinish, arg_11_0.state == 1)

	arg_11_0._txtneed.text = arg_11_0.needArr[3]

	arg_11_0:updateNeed()
	arg_11_0:updateLingqu()

	arg_11_0._animator.enabled = true

	if arg_11_3 then
		arg_11_0._animator:Play(UIAnimationName.Open, 0, 0)
		arg_11_0._animator:Update(0)

		local var_11_4 = arg_11_0._animator:GetCurrentAnimatorStateInfo(0).length

		if var_11_4 <= 0 then
			var_11_4 = 1
		end

		arg_11_0._animator:Play(UIAnimationName.Open, 0, -0.066 * (arg_11_2 - 1) / var_11_4)
		arg_11_0._animator:Update(0)
	else
		arg_11_0._animator:Play(UIAnimationName.Open, 0, 1)
		arg_11_0._animator:Update(0)
	end
end

function var_0_0.updateNeed(arg_12_0)
	local var_12_0 = ItemModel.instance:getItemQuantity(arg_12_0.needArr[1], arg_12_0.needArr[2])

	gohelper.setActive(arg_12_0._gounfinishstate, var_12_0 < arg_12_0.needArr[3])
	gohelper.setActive(arg_12_0._gofinishstate, var_12_0 >= arg_12_0.needArr[3])
end

function var_0_0.updateLingqu(arg_13_0)
	local var_13_0 = ItemModel.instance:getItemQuantity(arg_13_0.needArr[1], arg_13_0.needArr[2])

	gohelper.setActive(arg_13_0._golingqu, true)
	gohelper.setActive(arg_13_0._goget, arg_13_0.state == 0 and var_13_0 >= arg_13_0.needArr[3])
	gohelper.setActive(arg_13_0._gounfinish, arg_13_0.state == 0 and var_13_0 < arg_13_0.needArr[3])
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0.rewardItemList = nil

	arg_14_0.click:RemoveClickListener()
	arg_14_0._goselectedbg:UnLoadImage()
end

return var_0_0

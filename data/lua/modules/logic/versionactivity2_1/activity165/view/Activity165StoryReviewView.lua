module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryReviewView", package.seeall)

local var_0_0 = class("Activity165StoryReviewView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._goendingnode = gohelper.findChild(arg_1_0.viewGO, "#go_endingnode")
	arg_1_0._goend1 = gohelper.findChild(arg_1_0.viewGO, "#go_endingnode/#go_end1")
	arg_1_0._goend2 = gohelper.findChild(arg_1_0.viewGO, "#go_endingnode/#go_end2")
	arg_1_0._goend3 = gohelper.findChild(arg_1_0.viewGO, "#go_endingnode/#go_end3")
	arg_1_0._goend4 = gohelper.findChild(arg_1_0.viewGO, "#go_endingnode/#go_end4")
	arg_1_0._goend5 = gohelper.findChild(arg_1_0.viewGO, "#go_endingnode/#go_end5")
	arg_1_0._goend6 = gohelper.findChild(arg_1_0.viewGO, "#go_endingnode/#go_end6")
	arg_1_0._btnstory1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Btn/#btn_story1")
	arg_1_0._btnstory2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Btn/#btn_story2")
	arg_1_0._btnstory3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Btn/#btn_story3")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstory1:AddClickListener(arg_2_0._btnstory1OnClick, arg_2_0)
	arg_2_0._btnstory2:AddClickListener(arg_2_0._btnstory2OnClick, arg_2_0)
	arg_2_0._btnstory3:AddClickListener(arg_2_0._btnstory3OnClick, arg_2_0)
	arg_2_0._animationEvent:AddEventListener(Activity165Enum.ReviewViewAnim.Switch, arg_2_0.switchAnimCB, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstory1:RemoveClickListener()
	arg_3_0._btnstory2:RemoveClickListener()
	arg_3_0._btnstory3:RemoveClickListener()
	arg_3_0._animationEvent:RemoveEventListener(Activity165Enum.ReviewViewAnim.Switch)

	for iter_3_0, iter_3_1 in pairs(arg_3_0._endingItem) do
		iter_3_1.btn:RemoveClickListener()
	end
end

function var_0_0._btnstory1OnClick(arg_4_0)
	arg_4_0:_switchAnim(1)
end

function var_0_0._btnstory2OnClick(arg_5_0)
	arg_5_0:_switchAnim(2)
end

function var_0_0._btnstory3OnClick(arg_6_0)
	arg_6_0:_switchAnim(3)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._btnState = arg_7_0:getUserDataTb_()

	local var_7_0 = Activity165Model.instance:getAllActStory()

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		local var_7_1 = gohelper.findChild(arg_7_0.viewGO, "Btn/#btn_story" .. iter_7_0 .. "/selectbg")
		local var_7_2 = gohelper.findChild(arg_7_0.viewGO, "Btn/#btn_story" .. iter_7_0 .. "/normalbg")
		local var_7_3 = gohelper.findChildText(var_7_1, "txt_story")
		local var_7_4 = gohelper.findChildText(var_7_2, "txt_story")

		arg_7_0._btnState[iter_7_0] = {
			select = var_7_1,
			normal = var_7_2
		}
		var_7_3.text = iter_7_1:getStoryName()
		var_7_4.text = iter_7_1:getStoryName()
	end

	arg_7_0._endingItem = arg_7_0:getUserDataTb_()

	for iter_7_2 = 1, 6 do
		local var_7_5 = gohelper.findChildImage(arg_7_0.viewGO, "#go_endingnode/#go_end" .. iter_7_2)
		local var_7_6 = gohelper.findChild(var_7_5.gameObject, "#unlock")
		local var_7_7 = gohelper.findChildButtonWithAudio(var_7_5.gameObject, "btn")

		arg_7_0._endingItem[iter_7_2] = {
			icon = var_7_5,
			unlock = var_7_6,
			btn = var_7_7
		}
	end

	arg_7_0._viewAnim = SLFramework.AnimatorPlayer.Get(arg_7_0.viewGO)
	arg_7_0._animationEvent = arg_7_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._actId = Activity165Model.instance:getActivityId()

	local var_9_0 = arg_9_0.viewParam.storyId

	arg_9_0._enterView = arg_9_0.viewParam.view

	arg_9_0:_onShowEnding(var_9_0)
	arg_9_0:_activeTagBtn()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0._onShowEnding(arg_12_0, arg_12_1)
	arg_12_0._pageIndex = arg_12_1

	for iter_12_0, iter_12_1 in pairs(arg_12_0._btnState) do
		gohelper.setActive(iter_12_1.select, iter_12_0 == arg_12_1)
		gohelper.setActive(iter_12_1.normal, iter_12_0 ~= arg_12_1)
	end

	arg_12_0._mo = Activity165Model.instance:getStoryMo(arg_12_0._actId, arg_12_1)

	local var_12_0 = 1

	for iter_12_2, iter_12_3 in pairs(arg_12_0._mo.unlockEndings) do
		local var_12_1 = arg_12_0._endingItem[var_12_0]

		var_12_0 = var_12_0 + 1

		local var_12_2 = Activity165Config.instance:getEndingCo(arg_12_0._actId, iter_12_2).pic

		if not string.nilorempty(var_12_2) then
			UISpriteSetMgr.instance:setV2a1Act165_2Sprite(var_12_1.icon, var_12_2)
		end

		local function var_12_3()
			Activity165Controller.instance:openActivity165EditView(arg_12_1, iter_12_2)
		end

		var_12_1.btn:RemoveClickListener()
		var_12_1.btn:AddClickListener(var_12_3, arg_12_0)
		gohelper.setActive(var_12_1.icon.gameObject, true)

		local var_12_4 = arg_12_0:_isCanPlayUnlockAnim(iter_12_2)

		gohelper.setActive(var_12_1.unlock.gameObject, var_12_4)

		if var_12_4 then
			AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_review)
		end
	end

	local var_12_5 = Activity165Config.instance:getEndingCosByStoryId(arg_12_0._actId, arg_12_1)
	local var_12_6 = tabletool.len(var_12_5)

	for iter_12_4 = var_12_0, var_12_6 do
		local var_12_7 = arg_12_0._endingItem[iter_12_4]
		local var_12_8 = "v2a1_strangetale_ending_locked"

		if not string.nilorempty(var_12_8) then
			UISpriteSetMgr.instance:setV2a1Act165_2Sprite(var_12_7.icon, var_12_8)
		end

		gohelper.setActive(var_12_7.icon.gameObject, true)
		var_12_7.btn:RemoveClickListener()

		local function var_12_9()
			GameFacade.showToast(ToastEnum.Act165EndingLock)
		end

		var_12_7.btn:AddClickListener(var_12_9, arg_12_0)
	end

	for iter_12_5 = var_12_6 + 1, #arg_12_0._endingItem do
		local var_12_10 = arg_12_0._endingItem[iter_12_5]

		gohelper.setActive(var_12_10.icon.gameObject, false)
	end

	Activity165Model.instance:setEndingRedDot(arg_12_1)

	if arg_12_0._enterView then
		arg_12_0._enterView:_checkRedDot()
	end
end

function var_0_0._isCanPlayUnlockAnim(arg_15_0, arg_15_1)
	if not arg_15_0._mo or not arg_15_1 then
		return false
	end

	if GameUtil.playerPrefsGetNumberByUserId(arg_15_0:_playUnlockKey(arg_15_1), 0) == 0 then
		GameUtil.playerPrefsSetNumberByUserId(arg_15_0:_playUnlockKey(arg_15_1), 1)

		return true
	end
end

function var_0_0._activeTagBtn(arg_16_0)
	for iter_16_0 = 1, Activity165Model.instance:getStoryCount() do
		local var_16_0 = Activity165Model.instance:getStoryMo(arg_16_0._actId, iter_16_0)
		local var_16_1 = var_16_0 and var_16_0.isUnlock
		local var_16_2 = arg_16_0["_btnstory" .. iter_16_0]

		if var_16_2 then
			gohelper.setActive(var_16_2.gameObject, var_16_1)
		end
	end
end

function var_0_0._playUnlockKey(arg_17_0, arg_17_1)
	return string.format("Activity165EndingItem_isUnlock_%s_%s_%s", arg_17_0._actId, arg_17_0._mo.storyId, arg_17_1)
end

function var_0_0._switchAnim(arg_18_0, arg_18_1)
	if arg_18_0._pageIndex == arg_18_1 then
		return
	end

	arg_18_0._pageIndex = arg_18_1

	arg_18_0._viewAnim:Play(Activity165Enum.ReviewViewAnim.Switch, nil, arg_18_0)
end

function var_0_0.switchAnimCB(arg_19_0)
	arg_19_0:_onShowEnding(arg_19_0._pageIndex)
end

return var_0_0

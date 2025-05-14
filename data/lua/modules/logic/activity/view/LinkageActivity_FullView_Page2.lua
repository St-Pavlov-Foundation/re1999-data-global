module("modules.logic.activity.view.LinkageActivity_FullView_Page2", package.seeall)

local var_0_0 = class("LinkageActivity_FullView_Page2", LinkageActivity_Page2)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#txt_Descr")
	arg_1_0._btnArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Video/#btn_Arrow")
	arg_1_0._simageIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Video/#simage_Icon")
	arg_1_0._btnChange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Change")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnArrow:AddClickListener(arg_2_0._btnArrowOnClick, arg_2_0)
	arg_2_0._btnChange:AddClickListener(arg_2_0._btnChangeOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnArrow:RemoveClickListener()
	arg_3_0._btnChange:RemoveClickListener()
end

local var_0_1 = 2
local var_0_2 = "switch"

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)
end

function var_0_0.onDestroyView(arg_5_0)
	GameUtil.onDestroyViewMember_SImage(arg_5_0, "_simageIcon")
	var_0_0.super.onDestroyView(arg_5_0)
end

function var_0_0._editableAddEvents(arg_6_0)
	arg_6_0._animEvent_video:AddEventListener(var_0_2, arg_6_0._onSwitch, arg_6_0)
	arg_6_0._clickIcon:AddClickListener(arg_6_0._onClickIcon, arg_6_0)
end

function var_0_0._editableRemoveEvents(arg_7_0)
	arg_7_0._clickIcon:RemoveClickListener()
	arg_7_0._animEvent_video:RemoveEventListener(var_0_2)
end

function var_0_0._editableInitView(arg_8_0)
	var_0_0.super._editableInitView(arg_8_0)

	local var_8_0 = arg_8_0:getDataList()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		arg_8_0:addReward(iter_8_0, gohelper.findChild(arg_8_0.viewGO, "Reward/" .. iter_8_0), LinkageActivity_Page2Reward)
	end

	local var_8_1 = gohelper.findChild(arg_8_0.viewGO, "Video")

	arg_8_0._txtTips = gohelper.findChildText(var_8_1, "image_TipsBG/txt_Tips")

	arg_8_0:addVideo(1, gohelper.findChild(var_8_1, "av/1"), LinkageActivity_Page2Video)
	arg_8_0:addVideo(2, gohelper.findChild(var_8_1, "av/2"), LinkageActivity_Page2Video)

	arg_8_0._clickIcon = gohelper.getClick(arg_8_0._simageIcon.gameObject)
	arg_8_0._anim_video = var_8_1:GetComponent(gohelper.Type_Animator)
	arg_8_0._animEvent_video = gohelper.onceAddComponent(var_8_1, gohelper.Type_AnimationEventWrap)
	arg_8_0._s_isReceiveGetian = ActivityType101Model.instance:isType101RewardGet(arg_8_0:actId(), 1)

	arg_8_0:setActive(false)
end

function var_0_0._btnArrowOnClick(arg_9_0)
	local var_9_0 = 3 - arg_9_0:_currentVideoIndex()

	arg_9_0:selectedVideo(var_9_0)
end

function var_0_0._btnChangeOnClick(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_switch_20220009)
	arg_10_0:selectedPage(1)
end

function var_0_0.onUpdateMO(arg_11_0, arg_11_1)
	var_0_0.super.onUpdateMO(arg_11_0, arg_11_1)
	arg_11_0:selectedVideo(arg_11_0:_currentVideoIndex())
end

function var_0_0.onSelectedVideo(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 then
		arg_12_0._anim_video:Play(UIAnimationName.Idle, 0, 1)
		arg_12_0:_refreshByIndex(arg_12_1)
		arg_12_0:_onSwitch()

		return
	end

	arg_12_0:_playAnim_switchTo(arg_12_1)
end

function var_0_0._currentVideoIndex(arg_13_0)
	return arg_13_0:curVideoIndex() or var_0_1
end

function var_0_0._onClickIcon(arg_14_0)
	local var_14_0 = arg_14_0:_getCurConfigIndex()
	local var_14_1, var_14_2 = arg_14_0:itemCo2TIQ(var_14_0)

	MaterialTipController.instance:showMaterialInfo(var_14_1, var_14_2)
end

function var_0_0._playAnim_switchTo(arg_15_0, arg_15_1)
	local var_15_0 = "switch" .. tostring(arg_15_1)

	arg_15_0._anim_video:Play(var_15_0, 0, 0)
end

function var_0_0._onSwitch(arg_16_0)
	local var_16_0 = arg_16_0:_currentVideoIndex()

	arg_16_0:getVideo(var_16_0):setAsLastSibling()
	arg_16_0:_refreshByIndex(var_16_0)
end

function var_0_0._refreshByIndex(arg_17_0, arg_17_1)
	arg_17_1 = arg_17_0:_getCurConfigIndex(arg_17_1)

	local var_17_0 = arg_17_0:getItemIconResUrl(arg_17_1)

	GameUtil.loadSImage(arg_17_0._simageIcon, var_17_0)

	arg_17_0._txtTips.text = arg_17_0:getLinkageActivityCO_desc(arg_17_1)
end

function var_0_0._onUpdateMO_videoList(arg_18_0)
	local var_18_0 = arg_18_0:_isReceiveGetian()

	assert(#arg_18_0._videoItemList == 2)

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._videoItemList) do
		local var_18_1 = arg_18_0:getLinkageActivityCO_res_video(var_18_0 and iter_18_0 or 3 - iter_18_0)
		local var_18_2 = {
			videoName = var_18_1
		}

		iter_18_1:onUpdateMO(var_18_2)
	end
end

function var_0_0._isReceiveGetian(arg_19_0)
	return arg_19_0._s_isReceiveGetian
end

function var_0_0._selectedVideo_slient(arg_20_0, arg_20_1)
	arg_20_0._curVideoIndex = arg_20_1

	arg_20_0:_onSwitch()
end

function var_0_0.onPostSelectedPage(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0 ~= arg_21_1 then
		if arg_21_0._s_isReceiveGetian then
			local var_21_0 = ActivityType101Model.instance:isType101RewardGet(arg_21_0:actId(), 1)

			if arg_21_0._s_isReceiveGetian ~= var_21_0 then
				arg_21_0._s_isReceiveGetian = var_21_0
			end
		end

		arg_21_0:_selectedVideo_slient(var_0_1)
	end

	var_0_0.super.onPostSelectedPage(arg_21_0, arg_21_1, arg_21_2)
end

function var_0_0._getCurConfigIndex(arg_22_0, arg_22_1)
	arg_22_1 = arg_22_1 or arg_22_0:_currentVideoIndex()

	return arg_22_0:_isReceiveGetian() and arg_22_1 or 3 - arg_22_1
end

return var_0_0

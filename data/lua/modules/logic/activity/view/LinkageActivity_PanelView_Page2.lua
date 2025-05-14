module("modules.logic.activity.view.LinkageActivity_PanelView_Page2", package.seeall)

local var_0_0 = class("LinkageActivity_PanelView_Page2", LinkageActivity_Page2)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#txt_Descr")
	arg_1_0._btnArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Video/#btn_Arrow")
	arg_1_0._simageIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Video/#simage_Icon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnArrow:AddClickListener(arg_2_0._btnArrowOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnArrow:RemoveClickListener()
end

local var_0_1 = 2
local var_0_2 = "switch"

function var_0_0.ctor(arg_4_0, ...)
	var_0_0.super.ctor(arg_4_0, ...)
end

function var_0_0._editableAddEvents(arg_5_0)
	arg_5_0._animEvent_video:AddEventListener(var_0_2, arg_5_0._onSwitch, arg_5_0)
	arg_5_0._clickIcon:AddClickListener(arg_5_0._onClickIcon, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	arg_6_0._clickIcon:RemoveClickListener()
	arg_6_0._animEvent_video:RemoveEventListener(var_0_2)
end

function var_0_0._editableInitView(arg_7_0)
	var_0_0.super._editableInitView(arg_7_0)

	local var_7_0 = arg_7_0:getDataList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		arg_7_0:addReward(iter_7_0, gohelper.findChild(arg_7_0.viewGO, "Reward/" .. iter_7_0), LinkageActivity_Page2Reward)
	end

	local var_7_1 = gohelper.findChild(arg_7_0.viewGO, "Video")

	arg_7_0._txtTips = gohelper.findChildText(var_7_1, "image_TipsBG/txt_Tips")

	arg_7_0:addVideo(1, gohelper.findChild(var_7_1, "av/1"), LinkageActivity_Page2Video)
	arg_7_0:addVideo(2, gohelper.findChild(var_7_1, "av/2"), LinkageActivity_Page2Video)

	arg_7_0._clickIcon = gohelper.getClick(arg_7_0._simageIcon.gameObject)
	arg_7_0._anim_video = var_7_1:GetComponent(gohelper.Type_Animator)
	arg_7_0._animEvent_video = gohelper.onceAddComponent(var_7_1, gohelper.Type_AnimationEventWrap)
	arg_7_0._s_isReceiveGetian = ActivityType101Model.instance:isType101RewardGet(arg_7_0:actId(), 1)

	arg_7_0:setActive(false)
end

function var_0_0.onDestroyView(arg_8_0)
	GameUtil.onDestroyViewMember_SImage(arg_8_0, "_simageIcon")
	var_0_0.super.onDestroyView(arg_8_0)
end

function var_0_0._btnArrowOnClick(arg_9_0)
	local var_9_0 = 3 - arg_9_0:_currentVideoIndex()

	arg_9_0:selectedVideo(var_9_0)
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	var_0_0.super.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0:selectedVideo(arg_10_0:_currentVideoIndex())
end

function var_0_0.onSelectedVideo(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3 then
		arg_11_0._anim_video:Play(UIAnimationName.Idle, 0, 1)
		arg_11_0:_refreshByIndex(arg_11_1)

		return
	end

	arg_11_0:_playAnim_switchTo(arg_11_1)
end

function var_0_0._currentVideoIndex(arg_12_0)
	return arg_12_0:curVideoIndex() or var_0_1
end

function var_0_0._onClickIcon(arg_13_0)
	local var_13_0 = arg_13_0:_getCurConfigIndex()
	local var_13_1, var_13_2 = arg_13_0:itemCo2TIQ(var_13_0)

	MaterialTipController.instance:showMaterialInfo(var_13_1, var_13_2)
end

function var_0_0._playAnim_switchTo(arg_14_0, arg_14_1)
	local var_14_0 = "switch" .. tostring(arg_14_1)

	arg_14_0._anim_video:Play(var_14_0, 0, 0)
end

function var_0_0._onSwitch(arg_15_0)
	local var_15_0 = arg_15_0:_currentVideoIndex()

	arg_15_0:getVideo(var_15_0):setAsLastSibling()
	arg_15_0:_refreshByIndex(var_15_0)
end

function var_0_0._refreshByIndex(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_0:_getCurConfigIndex(arg_16_1)

	local var_16_0 = arg_16_0:getItemIconResUrl(arg_16_1)

	GameUtil.loadSImage(arg_16_0._simageIcon, var_16_0)

	arg_16_0._txtTips.text = arg_16_0:getLinkageActivityCO_desc(arg_16_1)
end

function var_0_0._onUpdateMO_videoList(arg_17_0)
	local var_17_0 = arg_17_0:_isReceiveGetian()

	assert(#arg_17_0._videoItemList == 2)

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._videoItemList) do
		local var_17_1 = arg_17_0:getLinkageActivityCO_res_video(var_17_0 and iter_17_0 or 3 - iter_17_0)
		local var_17_2 = {
			videoName = var_17_1
		}

		iter_17_1:onUpdateMO(var_17_2)
	end
end

function var_0_0._isReceiveGetian(arg_18_0)
	return arg_18_0._s_isReceiveGetian
end

function var_0_0._selectedVideo_slient(arg_19_0, arg_19_1)
	arg_19_0._curVideoIndex = arg_19_1

	arg_19_0:_onSwitch()
end

function var_0_0.onPostSelectedPage(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0 ~= arg_20_1 then
		if arg_20_0._s_isReceiveGetian then
			local var_20_0 = ActivityType101Model.instance:isType101RewardGet(arg_20_0:actId(), 1)

			if arg_20_0._s_isReceiveGetian ~= var_20_0 then
				arg_20_0._s_isReceiveGetian = var_20_0
			end
		end

		arg_20_0:_selectedVideo_slient(var_0_1)
	end

	var_0_0.super.onPostSelectedPage(arg_20_0, arg_20_1, arg_20_2)
end

function var_0_0._getCurConfigIndex(arg_21_0, arg_21_1)
	arg_21_1 = arg_21_1 or arg_21_0:_currentVideoIndex()

	return arg_21_0:_isReceiveGetian() and arg_21_1 or 3 - arg_21_1
end

return var_0_0

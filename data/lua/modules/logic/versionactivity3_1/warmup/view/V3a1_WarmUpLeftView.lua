module("modules.logic.versionactivity3_1.warmup.view.V3a1_WarmUpLeftView", package.seeall)

local var_0_0 = class("V3a1_WarmUpLeftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePaper = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/Map/#simage_Paper")
	arg_1_0._simageMapMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/Map/#simage_MapMask")
	arg_1_0._simageMap1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/Map/#simage_MapMask/Map/#simage_Map1")
	arg_1_0._simageMap2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/Map/#simage_MapMask/Map/#simage_Map2")
	arg_1_0._goPath1 = gohelper.findChild(arg_1_0.viewGO, "Middle/Map/#simage_MapMask/Map/Path/#go_Path1")
	arg_1_0._goPath2 = gohelper.findChild(arg_1_0.viewGO, "Middle/Map/#simage_MapMask/Map/Path/#go_Path2")
	arg_1_0._goPath3 = gohelper.findChild(arg_1_0.viewGO, "Middle/Map/#simage_MapMask/Map/Path/#go_Path3")
	arg_1_0._goPath4 = gohelper.findChild(arg_1_0.viewGO, "Middle/Map/#simage_MapMask/Map/Path/#go_Path4")
	arg_1_0._goPath5 = gohelper.findChild(arg_1_0.viewGO, "Middle/Map/#simage_MapMask/Map/Path/#go_Path5")
	arg_1_0._simageShadow = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/Map/#simage_Shadow")
	arg_1_0._simagepicsmall = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/Map/#simage_pic_small")
	arg_1_0._gopoints = gohelper.findChild(arg_1_0.viewGO, "Middle/Map/#go_points")
	arg_1_0._simagebgclick = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/#simage_bg_click")
	arg_1_0._simagepic = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/#simage_pic")
	arg_1_0._gotips = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/#go_tips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._itemClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._itemClick:RemoveClickListener()
end

local var_0_1 = -1
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = SLFramework.AnimatorPlayer
local var_0_5 = {
	Clicked = 1
}
local var_0_6 = 5

function var_0_0.ctor(arg_4_0)
	arg_4_0._draggedState = var_0_1
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._middleGo = gohelper.findChild(arg_5_0.viewGO, "Middle")
	arg_5_0._godrag = arg_5_0._simagepicsmall.gameObject
	arg_5_0._guideGo = gohelper.findChild(arg_5_0._godrag, "image_Drag")
	arg_5_0._animatorPlayer = var_0_4.Get(arg_5_0._middleGo)
	arg_5_0._animtor = arg_5_0._animatorPlayer.animator
	arg_5_0._animEvent = gohelper.onceAddComponent(arg_5_0._middleGo, gohelper.Type_AnimationEventWrap)
	arg_5_0._itemClick = gohelper.getClickWithAudio(arg_5_0._godrag, AudioEnum.UI.Play_UI_Universal_Click)

	arg_5_0:_setActive_drag(true)

	arg_5_0._gopointsTrans = arg_5_0._gopoints.gameObject.transform

	local var_5_0 = arg_5_0._gopointsTrans.childCount

	arg_5_0._posTranList = arg_5_0:getUserDataTb_()

	for iter_5_0 = 0, var_5_0 - 1 do
		table.insert(arg_5_0._posTranList, arg_5_0._gopointsTrans:GetChild(iter_5_0))
	end

	arg_5_0._godragTrans = arg_5_0._godrag.transform
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0.onDataUpdateFirst(arg_7_0)
	if isDebugBuild then
		assert(arg_7_0.viewContainer:getEpisodeCount() <= var_0_6, "invalid config json_activity125 actId: " .. arg_7_0.viewContainer:actId())
	end

	arg_7_0._draggedState = arg_7_0:_checkIsDone() and var_0_2 or var_0_1
end

function var_0_0.onDataUpdate(arg_8_0)
	arg_8_0:_refresh()
end

function var_0_0.onSwitchEpisode(arg_9_0)
	local var_9_0 = arg_9_0:_checkIsDone()

	if arg_9_0._draggedState == var_0_2 and not var_9_0 then
		arg_9_0._draggedState = var_0_1 - 1
	elseif arg_9_0._draggedState < var_0_1 and var_9_0 then
		arg_9_0._draggedState = var_0_2
	end

	arg_9_0:_refresh()
end

function var_0_0._episodeId(arg_10_0)
	return arg_10_0.viewContainer:getCurSelectedEpisode()
end

function var_0_0._episode2Index(arg_11_0, arg_11_1)
	return arg_11_0.viewContainer:episode2Index(arg_11_1 or arg_11_0:_episodeId())
end

function var_0_0._checkIsDone(arg_12_0, arg_12_1)
	return arg_12_0.viewContainer:checkIsDone(arg_12_1 or arg_12_0:_episodeId())
end

function var_0_0._saveStateDone(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.viewContainer:saveStateDone(arg_13_2 or arg_13_0:_episodeId(), arg_13_1)
end

function var_0_0._saveState(arg_14_0, arg_14_1, arg_14_2)
	assert(arg_14_1 ~= 1999, "please call _saveStateDone instead")
	arg_14_0.viewContainer:saveState(arg_14_2 or arg_14_0:_episodeId(), arg_14_1)
end

function var_0_0._getState(arg_15_0, arg_15_1, arg_15_2)
	return arg_15_0.viewContainer:getState(arg_15_2 or arg_15_0:_episodeId(), arg_15_1)
end

function var_0_0._setActive_drag(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._godrag, arg_16_1)
	gohelper.setActive(arg_16_0._gotips, arg_16_1)
end

function var_0_0._setActive_guide(arg_17_0, arg_17_1)
	gohelper.setActive(arg_17_0._guideGo, arg_17_1)
end

function var_0_0._refresh(arg_18_0)
	local var_18_0 = arg_18_0:_checkIsDone()
	local var_18_1 = arg_18_0:_episode2Index()
	local var_18_2 = arg_18_0.viewContainer:getImgResUrl(var_18_1)

	arg_18_0._simagepicsmall:LoadImage(var_18_2)
	arg_18_0._simagepic:LoadImage(var_18_2)
	arg_18_0:_dock(var_18_1)

	if var_18_0 then
		arg_18_0:_setActive_guide(false)
		arg_18_0:_setActive_drag(false)
		arg_18_0:_playAnimOpened()
	else
		local var_18_3 = arg_18_0:_getState()

		if var_18_3 == 0 then
			arg_18_0:_setActive_guide(arg_18_0._draggedState <= var_0_1)
			arg_18_0:_setActive_drag(true)
			arg_18_0:_playAnimIdle()
		elseif var_0_5.Clicked == var_18_3 then
			arg_18_0:_setActive_guide(false)
			arg_18_0:_setActive_drag(false)
			arg_18_0:_playAnimOpened()
			arg_18_0:_playAnimAfterClicked()
		else
			logError("[V3a1_WarmUpLeftView] invalid state: " .. tostring(var_18_3))
		end
	end
end

function var_0_0.onClose(arg_19_0)
	arg_19_0._animEvent:RemoveAllEventListener()
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

function var_0_0._playAnimIdle(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0:_playAnim("map", arg_21_1, arg_21_2)
end

function var_0_0._playAnimOpened(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:_playAnim("pic", arg_22_1, arg_22_2)
end

function var_0_0._playAnimClick(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:_playAnim(UIAnimationName.Click, arg_23_1, arg_23_2)
end

function var_0_0._playAnim(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0._animatorPlayer:Play(arg_24_1, arg_24_2 or function()
		return
	end, arg_24_3)
end

function var_0_0._onItemClick(arg_26_0)
	arg_26_0:_setActive_drag(false)
	arg_26_0:_saveState(var_0_5.Clicked)
	arg_26_0:_playAnimAfterClicked()
	arg_26_0.viewContainer:setLocalIsPlayCurByUser()
end

local var_0_7 = "V3a1_WarmUpLeftView:kBlock_Click"
local var_0_8 = 9.99

function var_0_0._playAnimAfterClicked(arg_27_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(var_0_7, var_0_8, arg_27_0.viewName)
	arg_27_0.viewContainer:addNeedWaitCount()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
	arg_27_0:_playAnimClick(function()
		UIBlockHelper.instance:endBlock(var_0_7)
		UIBlockMgrExtend.setNeedCircleMv(true)
		arg_27_0:_saveStateDone(true)
	end)
	arg_27_0.viewContainer:openDesc()
end

function var_0_0._play_ui_fuleyuan_yure_open(arg_29_0)
	return
end

function var_0_0._play_ui_fuleyuan_yure_paper(arg_30_0)
	return
end

function var_0_0._play_ui_fuleyuan_yure_whoosh(arg_31_0)
	return
end

function var_0_0._dock(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0._posTranList[arg_32_1]

	arg_32_0._godragTrans:SetParent(var_32_0)
	transformhelper.setLocalPos(arg_32_0._godragTrans, 0, 0, 0)
end

return var_0_0

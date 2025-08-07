module("modules.logic.sp01.assassin2.story.littlegame.AssassinPointGameView", package.seeall)

local var_0_0 = class("AssassinPointGameView", BaseView)
local var_0_1 = {
	Disconnected = 1,
	Connected = 2
}
local var_0_2 = {
	1,
	2,
	3,
	4
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gogame1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_game1")
	arg_1_0._gopoints = gohelper.findChild(arg_1_0.viewGO, "root/#go_game1/#go_points")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "root/top/#txt_title")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "root/#go_topright")
	arg_1_0._btnfind = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_topright/#btn_find")
	arg_1_0._golightbg = gohelper.findChild(arg_1_0.viewGO, "root/simage_light")
	arg_1_0._golighteye = gohelper.findChild(arg_1_0.viewGO, "root/#go_topright/#btn_find/image_light")
	arg_1_0._gogreyeye = gohelper.findChild(arg_1_0.viewGO, "root/#go_topright/#btn_find/image_grey")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfind:AddClickListener(arg_2_0._btnfindOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfind:RemoveClickListener()
end

function var_0_0._btnfindOnClick(arg_4_0)
	if arg_4_0._useEye then
		return
	end

	arg_4_0._useEye = true

	arg_4_0:initEyeBg()
	arg_4_0:startConnectAllLines()
	gohelper.setActive(arg_4_0._gopoints, arg_4_0._useEye)
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_clickeye)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._useEye = false
	arg_5_0._pointView2 = arg_5_0.viewContainer._views[2]
	arg_5_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_5_0.viewGO)

	arg_5_0:initEyeBg()
	arg_5_0:initPoints()
	arg_5_0:initDialogs()
end

function var_0_0.initEyeBg(arg_6_0)
	gohelper.setActive(arg_6_0._golightbg, arg_6_0._useEye)
	gohelper.setActive(arg_6_0._golighteye, arg_6_0._useEye)
	gohelper.setActive(arg_6_0._gogreyeye, not arg_6_0._useEye)
end

function var_0_0.initPoints(arg_7_0)
	arg_7_0._pointGoTab = arg_7_0:getUserDataTb_()
	arg_7_0._pointClickTab = arg_7_0:getUserDataTb_()
	arg_7_0._pointAnimatorTab = arg_7_0:getUserDataTb_()
	arg_7_0._pointsTran = arg_7_0._gopoints.transform
	arg_7_0._pointCount = arg_7_0._pointsTran.childCount
	arg_7_0._collectPointCount = 0
	arg_7_0._pointStatusMap = {}

	for iter_7_0 = 1, arg_7_0._pointCount do
		local var_7_0 = arg_7_0._pointsTran:GetChild(iter_7_0 - 1).gameObject

		if gohelper.isNil(var_7_0) then
			break
		end

		local var_7_1 = gohelper.findChild(var_7_0, "point")

		arg_7_0._pointGoTab[iter_7_0] = var_7_1

		local var_7_2 = gohelper.getClickWithAudio(var_7_1, AudioEnum2_9.DungeonMiniGame.play_ui_clickPoint)

		var_7_2:AddClickListener(arg_7_0._onClickPoint, arg_7_0, iter_7_0)

		arg_7_0._pointClickTab[iter_7_0] = var_7_2

		gohelper.setActive(var_7_1, false)

		local var_7_3 = gohelper.findChild(var_7_1, "select")

		gohelper.setActive(var_7_3, false)

		arg_7_0._pointStatusMap[iter_7_0] = var_0_1.Disconnected

		local var_7_4 = SLFramework.AnimatorPlayer.Get(var_7_0)

		arg_7_0._pointAnimatorTab[iter_7_0] = var_7_4
	end

	gohelper.setActive(arg_7_0._gopoints, arg_7_0._useEye)
end

function var_0_0._onClickPoint(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._pointGoTab[arg_8_1]

	if gohelper.isNil(var_8_0) then
		return
	end

	if not arg_8_0:isAllLineConnected() then
		return
	end

	arg_8_0:setPointSelect(arg_8_1, true)
	arg_8_0._pointView2:onClickLineConnectPoint(arg_8_1)
end

function var_0_0.isAllLineConnected(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._pointStatusMap) do
		if iter_9_1 ~= var_0_1.Connected then
			return false
		end
	end

	return true
end

function var_0_0.startConnectAllLines(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._pointAnimatorTab) do
		arg_10_0._playConnectLineAnimDone({
			callTarget = arg_10_0,
			lineIndex = iter_10_0
		})
	end

	arg_10_0._animatorPlayer:Play("click", arg_10_0.onAllLineConnectDone, arg_10_0)

	arg_10_0._connectLineAudioFlow = FlowParallel.New()

	for iter_10_2, iter_10_3 in ipairs(var_0_2) do
		arg_10_0._connectLineAudioFlow:addWork(DelayDoFuncWork.New(arg_10_0.playFindEyeSuccAudio, arg_10_0, iter_10_3))
	end

	arg_10_0._connectLineAudioFlow:start()
end

function var_0_0.playFindEyeSuccAudio(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum2_9.DungeonMiniGame.play_ui_findEyeSucc)
end

function var_0_0.onAllLineConnectDone(arg_12_0)
	arg_12_0:playDialog(2)
end

function var_0_0._playConnectLineAnimDone(arg_13_0)
	local var_13_0 = arg_13_0.callTarget
	local var_13_1 = arg_13_0.lineIndex

	var_13_0._pointStatusMap[var_13_1] = var_0_1.Connected

	local var_13_2 = var_13_0._pointGoTab[var_13_1]

	gohelper.setActive(var_13_2, true)
end

function var_0_0.initDialogs(arg_14_0)
	arg_14_0._dialogIdList = VersionActivity2_9DungeonHelper.getLittleGameDialogIds(AssassinEnum.ConstId.DialogId_PointGame)
	arg_14_0._dialogCount = arg_14_0._dialogIdList and #arg_14_0._dialogIdList or 0

	arg_14_0:playDialog(1, arg_14_0.triggerGuide, arg_14_0)
end

function var_0_0.playDialog(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0._dialogIdList and arg_15_0._dialogIdList[arg_15_1]

	VersionActivity2_9DungeonController.instance:openAssassinStoryDialogView(var_15_0, arg_15_2, arg_15_3)
end

function var_0_0.triggerGuide(arg_16_0)
	AssassinController.instance:dispatchEvent(AssassinEvent.TriggerPointGameGuide)
end

function var_0_0.onClickPointError(arg_17_0, arg_17_1)
	arg_17_0:setPointSelect(arg_17_1, false)
end

function var_0_0.setPointSelect(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0._pointGoTab[arg_18_1]

	if gohelper.isNil(var_18_0) then
		return
	end

	local var_18_1 = gohelper.findChild(var_18_0, "select")

	gohelper.setActive(var_18_1, arg_18_2)
end

function var_0_0.releaseAllListeners(arg_19_0)
	if arg_19_0._pointClickTab then
		for iter_19_0, iter_19_1 in pairs(arg_19_0._pointClickTab) do
			iter_19_1:RemoveClickListener()
		end
	end
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0._episodeId = arg_20_0.viewParam and arg_20_0.viewParam.episodeId
end

function var_0_0.onClose(arg_21_0)
	arg_21_0:releaseAllListeners()

	if arg_21_0._connectLineAudioFlow then
		arg_21_0._connectLineAudioFlow:destroy()

		arg_21_0._connectLineAudioFlow = nil
	end
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0

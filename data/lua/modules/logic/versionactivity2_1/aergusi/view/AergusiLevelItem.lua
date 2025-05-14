module("modules.logic.versionactivity2_1.aergusi.view.AergusiLevelItem", package.seeall)

local var_0_0 = class("AergusiLevelItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._animator = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.go, "Root/unlock")
	arg_1_0._imagehasstar = gohelper.findChildImage(arg_1_0.go, "Root/unlock/Info/#image_HasStar")
	arg_1_0._imagenostar = gohelper.findChildImage(arg_1_0.go, "Root/unlock/Info/#image_NoStar")
	arg_1_0._txtstagename = gohelper.findChildText(arg_1_0.go, "Root/unlock/Info/#txt_StageName")
	arg_1_0._txtstagenum = gohelper.findChildText(arg_1_0.go, "Root/unlock/Info/#txt_StageNum")
	arg_1_0._imageinfo = gohelper.findChildImage(arg_1_0.go, "Root/#image_Info")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "Root/unlock/#btn_Click")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.go, "Root/#go_Locked")
	arg_1_0._imageItemMask = gohelper.findChildImage(arg_1_0.go, "Root/#go_Locked/image_ItemMask")

	gohelper.setActive(arg_1_0._gounlock, true)
	gohelper.setActive(arg_1_0._golocked, true)

	arg_1_0._itemAni = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0:addEventListeners()
end

function var_0_0.refreshItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._index = arg_2_2
	arg_2_0._episodeMo = arg_2_1
	arg_2_0._config = AergusiConfig.instance:getEpisodeConfig(nil, arg_2_1.episodeId)
	arg_2_0._episodeId = arg_2_0._config.episodeId

	if AergusiModel.instance:isEpisodeUnlock(arg_2_0._episodeId) then
		arg_2_0._imageItemMask.raycastTarget = false

		if AergusiModel.instance:getNewUnlockEpisode() == arg_2_0._episodeId then
			arg_2_0._itemAni:Play("idlegray", 0, 0)
		else
			arg_2_0._itemAni:Play("idle", 0, 0)
		end
	else
		arg_2_0._itemAni:Play("idlegray", 0, 0)
	end

	local var_2_0 = AergusiModel.instance:isEpisodePassed(arg_2_0._episodeId)

	gohelper.setActive(arg_2_0._imagenostar.gameObject, not var_2_0)
	gohelper.setActive(arg_2_0._imagehasstar.gameObject, var_2_0)

	local var_2_1 = AergusiModel.instance:isStoryEpisode(arg_2_0._episodeId)

	gohelper.setActive(arg_2_0._imageinfo.gameObject, not var_2_1)

	arg_2_0._txtstagenum.text = arg_2_0._index
	arg_2_0._txtstagename.text = arg_2_0._config.name

	arg_2_0:_checkFirstTimeEnter()
end

function var_0_0._checkFirstTimeEnter(arg_3_0)
	local var_3_0 = AergusiModel.instance:getNewFinishEpisode()
	local var_3_1 = AergusiModel.instance:isStoryEpisode(arg_3_0._episodeId)

	if var_3_0 == arg_3_0._episodeId then
		AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_over)
		arg_3_0._itemAni:Play("finish", 0, 0)

		local var_3_2 = AergusiModel.instance:getEpisodeClueConfigs(arg_3_0._episodeId, false)

		if var_3_1 and #var_3_2 > 0 then
			GameFacade.showToast(ToastEnum.Act163GetClueTip)
		end

		AergusiModel.instance:setNewFinishEpisode(0)
	end

	if AergusiModel.instance:getNewUnlockEpisode() == arg_3_0._episodeId then
		local var_3_3 = arg_3_0._index == 1 and 0.68 or 1.34

		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("waitUnlock")
		AergusiModel.instance:setNewUnlockEpisode(0)
		TaskDispatcher.runDelay(arg_3_0._playUnlock, arg_3_0, var_3_3)
	end
end

function var_0_0._playUnlock(arg_4_0)
	UIBlockMgr.instance:endBlock("waitUnlock")
	AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_open)
	arg_4_0._itemAni:Play("unlock")
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0._btnclick:AddClickListener(arg_5_0._btnclickOnClick, arg_5_0)
end

function var_0_0.removeEventListeners(arg_6_0)
	arg_6_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_7_0)
	if not AergusiModel.instance:isEpisodeUnlock(arg_7_0._episodeId) then
		GameFacade.showToast(ToastEnum.Act163LevelLocked)

		return
	end

	AergusiController.instance:dispatchEvent(AergusiEvent.EnterEpisode, arg_7_0._episodeId)
end

function var_0_0.destroy(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._playUnlock, arg_8_0)
	arg_8_0:removeEventListeners()
end

return var_0_0

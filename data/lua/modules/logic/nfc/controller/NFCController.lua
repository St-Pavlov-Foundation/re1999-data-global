module("modules.logic.nfc.controller.NFCController", package.seeall)

local var_0_0 = class("NFCController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.onNFCRead(arg_5_0, arg_5_1)
	if arg_5_1 == nil then
		logNormal("参数为空")

		return
	end

	if not LoginController.instance:isEnteredGame() then
		logNormal("没有进入游戏")

		return
	end

	if GameSceneMgr.instance:isClosing() then
		logNormal("切换场景中")

		return
	end

	if GameSceneMgr.instance:isLoading() then
		logNormal("加载场景中")

		return
	end

	if VirtualSummonScene.instance:isOpen() then
		logNormal("抽卡场景")

		return
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		logNormal("不在主场景")

		return
	end

	if StoryModel.instance:isPlayingVideo() or StoryModel.instance:isSpecialVideoPlaying() or LimitedRoleController.instance:isPlaying() then
		logNormal("播放视频中")

		return
	end

	if GuideController.instance:isGuiding() or GuideModel.instance:isDoingClickGuide() then
		logNormal("引导中")

		return
	end

	local var_5_0 = WebViewController.urlParse(arg_5_1)

	if not var_5_0 then
		logNormal("未读取出参数")

		return
	end

	if not var_5_0.ver or not var_5_0.id then
		logNormal("卡片缺少版本号和id")

		return
	end

	local var_5_1 = tonumber(var_5_0.ver)

	if not var_5_1 or var_5_1 ~= NFCEnum.NFCVersion.BGMSwitch then
		logNormal("卡片版本信息错误")

		return
	end

	local var_5_2 = var_5_0.id
	local var_5_3 = tonumber(var_5_2)
	local var_5_4 = NFCConfig.instance:getNFCRecognizeCo(var_5_3)

	if not var_5_4 then
		logNormal("找不到nfc表")

		return
	end

	if var_5_4.type == OpenEnum.UnlockFunc.BGMSwitch then
		arg_5_0:openReadBGMSwitch(var_5_4)
	end
end

function var_0_0.openReadBGMSwitch(arg_6_0, arg_6_1)
	if not var_0_0.instance:isInMainView() then
		GameFacade.showToast(ToastEnum.NFCNotInMainView)

		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch) then
		GameFacade.showToast(arg_6_1.unlockId)

		return
	end

	if not GuideModel.instance:isGuideFinish(BGMSwitchEnum.BGMGuideId) then
		logNormal("BGM界面引导未完成")

		return
	end

	local var_6_0 = ViewMgr.instance:isOpen(ViewName.BGMSwitchView)

	if not var_6_0 then
		local var_6_1 = ViewMgr.instance:isOpen(ViewName.MainThumbnailView)

		BGMSwitchController.instance:openBGMSwitchView(var_6_1)
		BGMSwitchModel.instance:setEggHideState(true)
	end

	local var_6_2 = arg_6_1.param

	if not BGMSwitchModel.instance:getBgmInfo(var_6_2) then
		GameFacade.showToast(arg_6_1.unclaimedId)

		return
	end

	arg_6_0._curBgmId = var_6_2

	if not var_6_0 then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_6_0.onBgmSwitchViewOpen, arg_6_0)
	else
		local var_6_3 = BGMSwitchModel.instance:getCurBgm()

		if var_6_3 ~= nil and var_6_2 == var_6_3 then
			logNormal("正在播放该BGM")

			return
		end

		arg_6_0:setCurBGM(arg_6_0._curBgmId, true)
	end
end

function var_0_0.onBgmSwitchViewOpen(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.BGMSwitchView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_7_0.onBgmSwitchViewOpen, arg_7_0)
		arg_7_0:setCurBGM(arg_7_0._curBgmId)
	end
end

function var_0_0.setCurBGM(arg_8_0, arg_8_1, arg_8_2)
	BGMSwitchModel.instance:setCurBgm(arg_8_1)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected, arg_8_1, arg_8_2)
end

function var_0_0.isInMainView(arg_9_0)
	local var_9_0 = ViewMgr.instance:getOpenViewNameList()
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_2 = ViewMgr.instance:getSetting(iter_9_1)

		if iter_9_1 ~= ViewName.MainView and iter_9_1 ~= ViewName.BGMSwitchView and var_9_2.viewType == ViewType.Full and var_9_2.layer ~= UILayerName.Message then
			table.insert(var_9_1, iter_9_1)
		end
	end

	local var_9_3 = true

	if #var_9_1 > 0 then
		var_9_3 = false
	end

	return var_9_3
end

var_0_0.instance = var_0_0.New()

return var_0_0

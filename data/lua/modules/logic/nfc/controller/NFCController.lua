module("modules.logic.nfc.controller.NFCController", package.seeall)

local var_0_0 = class("NFCController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._isInit = false
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._isInit = false
end

function var_0_0._initHandleFunc(arg_5_0)
	arg_5_0.NFCHandleFunction = {
		[NFCEnum.NFCVFunctionType.BGMSwitch] = arg_5_0.handleBGMSwitchRead,
		[NFCEnum.NFCVFunctionType.PlayerCard] = arg_5_0.handlePlayerCardRead
	}
	arg_5_0.NFCViewDic = {
		[ViewName.BGMSwitchView] = NFCEnum.NFCVFunctionType.BGMSwitch,
		[ViewName.NewPlayerCardContentView] = NFCEnum.NFCVFunctionType.PlayerCard,
		[ViewName.PlayerView] = NFCEnum.NFCVFunctionType.PlayerCard
	}
end

function var_0_0.onNFCRead(arg_6_0, arg_6_1)
	if arg_6_1 == nil then
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

	local var_6_0 = WebViewController.urlParse(arg_6_1)

	if not var_6_0 then
		logNormal("未读取出参数")

		return
	end

	if not var_6_0.ver or not var_6_0.id then
		logNormal("卡片缺少版本号和id")

		return
	end

	local var_6_1 = tonumber(var_6_0.ver)

	if not var_6_1 or not NFCEnum.NFCVersionDic[var_6_1] then
		logNormal("卡片版本信息错误")

		return
	end

	local var_6_2 = var_6_0.id
	local var_6_3 = tonumber(var_6_2)
	local var_6_4 = NFCConfig.instance:getNFCRecognizeCo(var_6_3)

	if not var_6_4 then
		logNormal("找不到nfc表")

		return
	end

	if arg_6_0._isInit == false then
		arg_6_0:_initHandleFunc()

		arg_6_0._isInit = true
	end

	if not OpenModel.instance:isFunctionUnlock(var_6_4.type) then
		GameFacade.showToast(var_6_4.unlockId)

		return
	end

	local var_6_5 = var_6_4.type
	local var_6_6 = arg_6_0.NFCHandleFunction[var_6_5]

	if var_6_6 == nil then
		logNormal("找不到对应的nfc处理方法, type:" .. var_6_5)

		return
	end

	arg_6_0._curNFCCardId = var_6_4.id

	var_6_6(arg_6_0, var_6_4)
end

function var_0_0.handleBGMSwitchRead(arg_7_0, arg_7_1)
	if not arg_7_0:isInMainView(arg_7_1.type) then
		GameFacade.showToast(arg_7_1.notMainTipsId)

		return
	end

	if not GuideModel.instance:isGuideFinish(BGMSwitchEnum.BGMGuideId) then
		logNormal("BGM界面引导未完成")

		return
	end

	local var_7_0 = ViewMgr.instance:isOpen(ViewName.BGMSwitchView)

	if not var_7_0 then
		local var_7_1 = ViewMgr.instance:isOpen(ViewName.MainThumbnailView)

		BGMSwitchController.instance:openBGMSwitchView(var_7_1)
		BGMSwitchModel.instance:setEggHideState(true)
	end

	local var_7_2 = arg_7_1.param

	if not BGMSwitchModel.instance:getBgmInfo(var_7_2) then
		GameFacade.showToast(arg_7_1.unclaimedId)

		return
	end

	arg_7_0._curBgmId = var_7_2

	if not var_7_0 then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_7_0.onBgmSwitchViewOpen, arg_7_0)
	else
		local var_7_3 = BGMSwitchModel.instance:getCurBgm()

		if var_7_3 ~= nil and var_7_2 == var_7_3 then
			logNormal("正在播放该BGM")

			return
		end

		arg_7_0:setCurBGM(arg_7_0._curBgmId, true)
	end
end

function var_0_0.onBgmSwitchViewOpen(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.BGMSwitchView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_8_0.onBgmSwitchViewOpen, arg_8_0)
		arg_8_0:setCurBGM(arg_8_0._curBgmId)
	end
end

function var_0_0.setCurBGM(arg_9_0, arg_9_1, arg_9_2)
	BGMSwitchModel.instance:setCurBgm(arg_9_1)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected, arg_9_1, arg_9_2)
end

function var_0_0.handlePlayerCardRead(arg_10_0, arg_10_1)
	if not GuideModel.instance:isGuideFinish(PlayerCardEnum.PlayerCardGuideId) then
		logNormal("旅券集界面引导未完成")

		return
	end

	if not tonumber(arg_10_1.param) then
		logNormal("nfc表参数错误")

		return
	end

	if not ViewMgr.instance:isOpen(ViewName.NewPlayerCardContentView) then
		if not arg_10_0:isInMainView(arg_10_1.type) then
			GameFacade.showToast(arg_10_1.notMainTipsId)

			return
		end

		arg_10_0:openNewPlayerCardContentView()
	else
		local var_10_0 = PlayerCardController.instance:getCurViewParam()
		local var_10_1 = var_10_0 and tonumber(var_10_0.userId) == tonumber(PlayerModel.instance:getMyUserId())

		if not var_10_1 then
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullViewFinish, arg_10_0.onNewPlayerCardContentViewClose, arg_10_0)
		end

		local var_10_2 = ViewMgr.instance:getOpenViewNameList()
		local var_10_3 = {}

		for iter_10_0 = 1, #var_10_2 do
			local var_10_4 = var_10_2[iter_10_0]

			if var_10_4 ~= ViewName.NewPlayerCardContentView then
				table.insert(var_10_3, var_10_4)
			else
				if var_10_1 then
					table.insert(var_10_3, var_10_4)
				end

				break
			end
		end

		ViewMgr.instance:closeAllViews(var_10_3)
	end
end

function var_0_0.onNewPlayerCardContentViewOpen(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.NewPlayerCardContentView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_11_0.onNewPlayerCardContentViewOpen, arg_11_0)
		arg_11_0:checkTheme(arg_11_0._curNFCCardId)
	end
end

function var_0_0.openNewPlayerCardContentView(arg_12_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_12_0.onNewPlayerCardContentViewOpen, arg_12_0)
	PlayerCardController.instance:openPlayerCardView()
end

function var_0_0.onNewPlayerCardContentViewClose(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.NewPlayerCardContentView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullViewFinish, arg_13_0.onNewPlayerCardContentViewClose, arg_13_0)
		arg_13_0:openNewPlayerCardContentView()
	end
end

function var_0_0.checkTheme(arg_14_0, arg_14_1)
	local var_14_0 = NFCConfig.instance:getNFCRecognizeCo(arg_14_1)

	if not var_14_0 then
		logNormal("找不到nfc表")

		return
	end

	if var_14_0.unclaimedId == nil or var_14_0.unclaimedId == 0 then
		return
	end

	local var_14_1 = tostring(var_14_0.param)

	if ItemModel.instance:getItemCount(var_14_1) <= 0 then
		GameFacade.showToast(var_14_0.unclaimedId)
	end
end

function var_0_0.isInMainView(arg_15_0, arg_15_1)
	local var_15_0 = ViewMgr.instance:getOpenViewNameList()
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_2 = ViewMgr.instance:getSetting(iter_15_1)

		if iter_15_1 ~= ViewName.MainView and arg_15_0.NFCViewDic[iter_15_1] ~= arg_15_1 and var_15_2.viewType == ViewType.Full and var_15_2.layer ~= UILayerName.Message then
			table.insert(var_15_1, iter_15_1)
		end
	end

	local var_15_3 = true

	if #var_15_1 > 0 then
		var_15_3 = false
	end

	return var_15_3
end

function var_0_0._startBlack(arg_16_0)
	return
end

function var_0_0._endBlack(arg_17_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0

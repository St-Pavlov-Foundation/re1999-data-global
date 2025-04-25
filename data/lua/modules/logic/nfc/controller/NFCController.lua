module("modules.logic.nfc.controller.NFCController", package.seeall)

slot0 = class("NFCController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onNFCRead(slot0, slot1)
	if slot1 == nil then
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

	if not WebViewController.urlParse(slot1) then
		logNormal("未读取出参数")

		return
	end

	if not slot3.ver or not slot3.id then
		logNormal("卡片缺少版本号和id")

		return
	end

	if not tonumber(slot3.ver) or slot4 ~= NFCEnum.NFCVersion.BGMSwitch then
		logNormal("卡片版本信息错误")

		return
	end

	if not NFCConfig.instance:getNFCRecognizeCo(tonumber(slot3.id)) then
		logNormal("找不到nfc表")

		return
	end

	if slot7.type == OpenEnum.UnlockFunc.BGMSwitch then
		slot0:openReadBGMSwitch(slot7)
	end
end

function slot0.openReadBGMSwitch(slot0, slot1)
	if not uv0.instance:isInMainView() then
		GameFacade.showToast(ToastEnum.NFCNotInMainView)

		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch) then
		GameFacade.showToast(slot1.unlockId)

		return
	end

	if not GuideModel.instance:isGuideFinish(BGMSwitchEnum.BGMGuideId) then
		logNormal("BGM界面引导未完成")

		return
	end

	if not ViewMgr.instance:isOpen(ViewName.BGMSwitchView) then
		BGMSwitchController.instance:openBGMSwitchView(ViewMgr.instance:isOpen(ViewName.MainThumbnailView))
		BGMSwitchModel.instance:setEggHideState(true)
	end

	if not BGMSwitchModel.instance:getBgmInfo(slot1.param) then
		GameFacade.showToast(slot1.unclaimedId)

		return
	end

	slot0._curBgmId = slot4

	if not slot3 then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onBgmSwitchViewOpen, slot0)
	else
		if BGMSwitchModel.instance:getCurBgm() ~= nil and slot4 == slot6 then
			logNormal("正在播放该BGM")

			return
		end

		slot0:setCurBGM(slot0._curBgmId, true)
	end
end

function slot0.onBgmSwitchViewOpen(slot0, slot1)
	if slot1 == ViewName.BGMSwitchView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onBgmSwitchViewOpen, slot0)
		slot0:setCurBGM(slot0._curBgmId)
	end
end

function slot0.setCurBGM(slot0, slot1, slot2)
	BGMSwitchModel.instance:setCurBgm(slot1)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected, slot1, slot2)
end

function slot0.isInMainView(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		slot8 = ViewMgr.instance:getSetting(slot7)

		if slot7 ~= ViewName.MainView and slot7 ~= ViewName.BGMSwitchView and slot8.viewType == ViewType.Full and slot8.layer ~= UILayerName.Message then
			table.insert(slot2, slot7)
		end
	end

	slot3 = true

	if #slot2 > 0 then
		slot3 = false
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0

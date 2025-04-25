module("modules.logic.scene.view.LoadingView", package.seeall)

slot0 = class("LoadingView", BaseView)
slot1 = 5
slot2 = 0.1

function slot0.ctor(slot0)
	slot0._totalWeight = 0
end

function slot0.onInitView(slot0)
	slot0.root = gohelper.findChild(slot0.viewGO, "root")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "root/center/#simage_icon")
	slot0._simageiconhui = gohelper.findChildSingleImage(slot0.viewGO, "root/center/#simage_iconhui")
	slot0._txttip = gohelper.findChildText(slot0.viewGO, "root/center/#txt_tip")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0:setlineWidth()
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0.viewGO, true)
	gohelper.setSibling(slot0.viewGO, 2)
	slot0._simagebg:LoadImage(ResUrl.getLoadingBg("full/bg_loading"))

	slot0._enableClose = false
	slot0._waitClose = false

	slot0._animator:Play(UIAnimationName.Open, 0, 0)
	TaskDispatcher.runDelay(slot0._onDelayStartAudio, slot0, 0.8)
	slot0:_setIcon()
	slot0:_setRandomText()
	slot0:addEventCb(GameSceneMgr.instance, SceneEventName.AgainOpenLoading, slot0._againOpenLoading, slot0)
	slot0:addEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, slot0._delayCloseLoading, slot0)
	slot0:addEventCb(GameSceneMgr.instance, SceneEventName.SetManualClose, slot0._setManualClose, slot0)
	slot0:addEventCb(GameSceneMgr.instance, SceneEventName.ManualClose, slot0._manualClose, slot0)
end

function slot0.setlineWidth(slot0)
	slot4 = UnityEngine.Screen.width / 2 - 242 - 115

	for slot8 = 1, 2 do
		recthelper.setWidth(gohelper.findChild(slot0.root, string.format("duan_xian%s", slot8)).transform, slot4)
		recthelper.setWidth(gohelper.findChild(slot0.root, string.format("xian%s", slot8)).transform, slot4)
	end
end

function slot0._onDelayStartAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_loading_scene)
end

function slot0.onClose(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomHelper.logEnd("关闭loading")
	end

	gohelper.setActive(slot0.viewGO, false)
	slot0._simagebg:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._errorCloseLoading, slot0)
	TaskDispatcher.cancelTask(slot0._waitClose, slot0)
	TaskDispatcher.cancelTask(slot0._onDelayStartAudio, slot0)
	slot0:removeEventCb(GameSceneMgr.instance, SceneEventName.AgainOpenLoading, slot0._againOpenLoading, slot0)
	slot0:removeEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, slot0._delayCloseLoading, slot0)
	slot0:removeEventCb(GameSceneMgr.instance, SceneEventName.SetManualClose, slot0._setManualClose, slot0)
	slot0:removeEventCb(GameSceneMgr.instance, SceneEventName.ManualClose, slot0._manualClose, slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
	TaskDispatcher.cancelTask(slot0.loadingAnimEnd, slot0)
end

function slot0._againOpenLoading(slot0)
	logNormal("loading打开状态下，又调用了打开loading，取消计时，继续走")
	TaskDispatcher.cancelTask(slot0._errorCloseLoading, slot0)
end

function slot0._setIcon(slot0)
	if slot0:_getRandomCO(slot0:_getFitIcons()) then
		slot3 = slot2.pic

		slot0._simageicon:LoadImage(ResUrl.getLoadingBg(slot3))
		slot0._simageiconhui:LoadImage(ResUrl.getLoadingBg(slot3))
	end
end

function slot0._getFitIcons(slot0)
	slot1 = uv0.getLoadingSceneType(slot0.viewParam)
	slot3 = {}

	for slot7, slot8 in pairs(SceneConfig.instance:getLoadingIcons()) do
		for slot13, slot14 in pairs(string.splitToNumber(slot8.scenes, "#")) do
			if slot14 == slot1 then
				table.insert(slot3, slot8)
			end
		end
	end

	return slot3
end

function slot0._setRandomText(slot0)
	if slot0:_getRandomCO(slot0:_getFitTips()) and slot0._txttip then
		slot0._txttip.text = slot2.content
	else
		slot0._txttip.text = ""
	end
end

function slot0.getLoadingSceneType(slot0)
	slot1 = LoadingEnum.LoadingSceneType.Other

	if slot0 == SceneType.Main then
		slot1 = LoadingEnum.LoadingSceneType.Main
	elseif slot0 == SceneType.Summon then
		slot1 = LoadingEnum.LoadingSceneType.Summon
	elseif slot0 == SceneType.Room then
		slot1 = LoadingEnum.LoadingSceneType.Room
	elseif slot0 == SceneType.Explore then
		slot1 = LoadingEnum.LoadingSceneType.Explore
	end

	return slot1
end

function slot0._getFitTips(slot0)
	slot1 = uv0.getLoadingSceneType(slot0.viewParam)
	slot2 = PlayerModel.instance:getPlayerLevel()
	slot3 = {}

	for slot7, slot8 in pairs(lua_loading_text.configList) do
		for slot13, slot14 in pairs(string.splitToNumber(slot8.scenes, "#")) do
			if slot14 == slot1 then
				if slot2 == 0 then
					table.insert(slot3, slot8)
				elseif slot8.unlocklevel <= slot2 then
					table.insert(slot3, slot8)
				end
			end
		end
	end

	return slot3
end

function slot0._getRandomCO(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		slot2 = 0 + slot7.weight
	end

	for slot7, slot8 in ipairs(slot1) do
		if math.floor(math.random() * slot2) < slot8.weight then
			return slot8
		else
			slot3 = slot3 - slot8.weight
		end
	end

	if #slot1 > 1 then
		return slot1[math.random(1, slot4)]
	elseif slot4 == 1 then
		return slot1[1]
	end
end

function slot0._errorCloseLoading(slot0)
	logError(string.format("loading超时，关闭loading看看 sceneType_%d sceneId_%d isLoading_%s", GameSceneMgr.instance:getCurSceneType() or -1, GameSceneMgr.instance:getCurSceneId() or -1, GameSceneMgr.instance:isLoading() and "true" or "false"))
	slot0:_delayCloseLoading()
end

function slot0._delayCloseLoading(slot0)
	if not slot0._needManualClose then
		slot0:_closeLoading()
	else
		logNormal("暂时无法关闭loading，设置了手动关闭")
	end
end

function slot0._closeLoading(slot0)
	slot0._animator:Play("loading_close")
	TaskDispatcher.cancelTask(slot0._onDelayStartAudio, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_loading_scene)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomHelper.logElapse("进入小屋场景完成，开始关闭loading")
	end

	TaskDispatcher.runDelay(slot0.closeThis, slot0, 1)
	TaskDispatcher.runDelay(slot0.loadingAnimEnd, slot0, 0.5)
end

function slot0.loadingAnimEnd(slot0)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.LoadingAnimEnd)
end

function slot0._setManualClose(slot0)
	logNormal(Time.time .. " LoadingView:_setManualClose")

	slot0._needManualClose = true
end

function slot0._manualClose(slot0)
	logNormal(Time.time .. " LoadingView:_manualClose")

	slot0._needManualClose = nil

	slot0:_closeLoading()
end

return slot0

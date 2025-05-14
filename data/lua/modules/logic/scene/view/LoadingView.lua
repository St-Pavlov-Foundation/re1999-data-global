module("modules.logic.scene.view.LoadingView", package.seeall)

local var_0_0 = class("LoadingView", BaseView)
local var_0_1 = 5
local var_0_2 = 0.1

function var_0_0.ctor(arg_1_0)
	arg_1_0._totalWeight = 0
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.root = gohelper.findChild(arg_2_0.viewGO, "root")
	arg_2_0._simagebg = gohelper.findChildSingleImage(arg_2_0.viewGO, "#simage_bg")
	arg_2_0._simageicon = gohelper.findChildSingleImage(arg_2_0.viewGO, "root/center/#simage_icon")
	arg_2_0._simageiconhui = gohelper.findChildSingleImage(arg_2_0.viewGO, "root/center/#simage_iconhui")
	arg_2_0._txttip = gohelper.findChildText(arg_2_0.viewGO, "root/center/#txt_tip")
	arg_2_0._animator = arg_2_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_2_0:setlineWidth()
end

function var_0_0.onOpen(arg_3_0)
	gohelper.setActive(arg_3_0.viewGO, true)
	gohelper.setSibling(arg_3_0.viewGO, 2)
	arg_3_0._simagebg:LoadImage(ResUrl.getLoadingBg("full/bg_loading"))

	arg_3_0._enableClose = false
	arg_3_0._waitClose = false

	arg_3_0._animator:Play(UIAnimationName.Open, 0, 0)
	TaskDispatcher.runDelay(arg_3_0._onDelayStartAudio, arg_3_0, 0.8)
	arg_3_0:_setIcon()
	arg_3_0:_setRandomText()
	arg_3_0:addEventCb(GameSceneMgr.instance, SceneEventName.AgainOpenLoading, arg_3_0._againOpenLoading, arg_3_0)
	arg_3_0:addEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, arg_3_0._delayCloseLoading, arg_3_0)
	arg_3_0:addEventCb(GameSceneMgr.instance, SceneEventName.SetManualClose, arg_3_0._setManualClose, arg_3_0)
	arg_3_0:addEventCb(GameSceneMgr.instance, SceneEventName.ManualClose, arg_3_0._manualClose, arg_3_0)
end

function var_0_0.setlineWidth(arg_4_0)
	local var_4_0 = 242
	local var_4_1 = 115
	local var_4_2 = UnityEngine.Screen.width / 2 - var_4_0 - var_4_1

	for iter_4_0 = 1, 2 do
		local var_4_3 = string.format("duan_xian%s", iter_4_0)
		local var_4_4 = string.format("xian%s", iter_4_0)
		local var_4_5 = gohelper.findChild(arg_4_0.root, var_4_3).transform
		local var_4_6 = gohelper.findChild(arg_4_0.root, var_4_4).transform

		recthelper.setWidth(var_4_5, var_4_2)
		recthelper.setWidth(var_4_6, var_4_2)
	end
end

function var_0_0._onDelayStartAudio(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_loading_scene)
end

function var_0_0.onClose(arg_6_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomHelper.logEnd("关闭loading")
	end

	gohelper.setActive(arg_6_0.viewGO, false)
	arg_6_0._simagebg:UnLoadImage()
	TaskDispatcher.cancelTask(arg_6_0._errorCloseLoading, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._waitClose, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._onDelayStartAudio, arg_6_0)
	arg_6_0:removeEventCb(GameSceneMgr.instance, SceneEventName.AgainOpenLoading, arg_6_0._againOpenLoading, arg_6_0)
	arg_6_0:removeEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, arg_6_0._delayCloseLoading, arg_6_0)
	arg_6_0:removeEventCb(GameSceneMgr.instance, SceneEventName.SetManualClose, arg_6_0._setManualClose, arg_6_0)
	arg_6_0:removeEventCb(GameSceneMgr.instance, SceneEventName.ManualClose, arg_6_0._manualClose, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.closeThis, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.loadingAnimEnd, arg_6_0)
end

function var_0_0._againOpenLoading(arg_7_0)
	logNormal("loading打开状态下，又调用了打开loading，取消计时，继续走")
	TaskDispatcher.cancelTask(arg_7_0._errorCloseLoading, arg_7_0)
end

function var_0_0._setIcon(arg_8_0)
	local var_8_0 = arg_8_0:_getFitIcons()
	local var_8_1 = arg_8_0:_getRandomCO(var_8_0)

	if var_8_1 then
		local var_8_2 = var_8_1.pic

		arg_8_0._simageicon:LoadImage(ResUrl.getLoadingBg(var_8_2))
		arg_8_0._simageiconhui:LoadImage(ResUrl.getLoadingBg(var_8_2))
	end
end

function var_0_0._getFitIcons(arg_9_0)
	local var_9_0 = var_0_0.getLoadingSceneType(arg_9_0.viewParam)
	local var_9_1 = SceneConfig.instance:getLoadingIcons()
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in pairs(var_9_1) do
		local var_9_3 = string.splitToNumber(iter_9_1.scenes, "#")

		for iter_9_2, iter_9_3 in pairs(var_9_3) do
			if iter_9_3 == var_9_0 then
				table.insert(var_9_2, iter_9_1)
			end
		end
	end

	return var_9_2
end

function var_0_0._setRandomText(arg_10_0)
	local var_10_0 = arg_10_0:_getFitTips()
	local var_10_1 = arg_10_0:_getRandomCO(var_10_0)

	if var_10_1 and arg_10_0._txttip then
		arg_10_0._txttip.text = var_10_1.content
	else
		arg_10_0._txttip.text = ""
	end
end

function var_0_0.getLoadingSceneType(arg_11_0)
	local var_11_0 = LoadingEnum.LoadingSceneType.Other

	if arg_11_0 == SceneType.Main then
		var_11_0 = LoadingEnum.LoadingSceneType.Main
	elseif arg_11_0 == SceneType.Summon then
		var_11_0 = LoadingEnum.LoadingSceneType.Summon
	elseif arg_11_0 == SceneType.Room then
		var_11_0 = LoadingEnum.LoadingSceneType.Room
	elseif arg_11_0 == SceneType.Explore then
		var_11_0 = LoadingEnum.LoadingSceneType.Explore
	end

	return var_11_0
end

function var_0_0._getFitTips(arg_12_0)
	local var_12_0 = var_0_0.getLoadingSceneType(arg_12_0.viewParam)
	local var_12_1 = PlayerModel.instance:getPlayerLevel()
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in pairs(lua_loading_text.configList) do
		local var_12_3 = string.splitToNumber(iter_12_1.scenes, "#")

		for iter_12_2, iter_12_3 in pairs(var_12_3) do
			if iter_12_3 == var_12_0 then
				if var_12_1 == 0 then
					table.insert(var_12_2, iter_12_1)
				elseif var_12_1 >= iter_12_1.unlocklevel then
					table.insert(var_12_2, iter_12_1)
				end
			end
		end
	end

	return var_12_2
end

function var_0_0._getRandomCO(arg_13_0, arg_13_1)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		var_13_0 = var_13_0 + iter_13_1.weight
	end

	local var_13_1 = math.floor(math.random() * var_13_0)

	for iter_13_2, iter_13_3 in ipairs(arg_13_1) do
		if var_13_1 < iter_13_3.weight then
			return iter_13_3
		else
			var_13_1 = var_13_1 - iter_13_3.weight
		end
	end

	local var_13_2 = #arg_13_1

	if var_13_2 > 1 then
		return arg_13_1[math.random(1, var_13_2)]
	elseif var_13_2 == 1 then
		return arg_13_1[1]
	end
end

function var_0_0._errorCloseLoading(arg_14_0)
	local var_14_0 = GameSceneMgr.instance:getCurSceneType()
	local var_14_1 = GameSceneMgr.instance:getCurSceneId()
	local var_14_2 = GameSceneMgr.instance:isLoading()

	logError(string.format("loading超时，关闭loading看看 sceneType_%d sceneId_%d isLoading_%s", var_14_0 or -1, var_14_1 or -1, var_14_2 and "true" or "false"))
	arg_14_0:_delayCloseLoading()
end

function var_0_0._delayCloseLoading(arg_15_0)
	if not arg_15_0._needManualClose then
		arg_15_0:_closeLoading()
	else
		logNormal("暂时无法关闭loading，设置了手动关闭")
	end
end

function var_0_0._closeLoading(arg_16_0)
	arg_16_0._animator:Play("loading_close")
	TaskDispatcher.cancelTask(arg_16_0._onDelayStartAudio, arg_16_0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_loading_scene)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomHelper.logElapse("进入小屋场景完成，开始关闭loading")
	end

	TaskDispatcher.runDelay(arg_16_0.closeThis, arg_16_0, 1)
	TaskDispatcher.runDelay(arg_16_0.loadingAnimEnd, arg_16_0, 0.5)
end

function var_0_0.loadingAnimEnd(arg_17_0)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.LoadingAnimEnd)
end

function var_0_0._setManualClose(arg_18_0)
	logNormal(Time.time .. " LoadingView:_setManualClose")

	arg_18_0._needManualClose = true
end

function var_0_0._manualClose(arg_19_0)
	logNormal(Time.time .. " LoadingView:_manualClose")

	arg_19_0._needManualClose = nil

	arg_19_0:_closeLoading()
end

return var_0_0

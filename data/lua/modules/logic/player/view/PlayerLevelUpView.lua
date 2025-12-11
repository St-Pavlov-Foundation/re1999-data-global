module("modules.logic.player.view.PlayerLevelUpView", package.seeall)

local var_0_0 = class("PlayerLevelUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebgbar = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bgbar")
	arg_1_0._txtlevelbefore = gohelper.findChildText(arg_1_0.viewGO, "level/#txt_levelbefore")
	arg_1_0._txtlevelafter = gohelper.findChildText(arg_1_0.viewGO, "level/#txt_levelafter")
	arg_1_0._txtlevelafteeffect = gohelper.findChildText(arg_1_0.viewGO, "level/#txt_levelafteeffect")
	arg_1_0._gomaxpower = gohelper.findChild(arg_1_0.viewGO, "up/#go_maxpower")
	arg_1_0._txtmaxpower = gohelper.findChildText(arg_1_0.viewGO, "up/#go_maxpower/#go_BG/#txt_maxpower")
	arg_1_0._txtnextpower = gohelper.findChildText(arg_1_0.viewGO, "up/#go_maxpower/#go_BG/#txt_maxpower/#txt_nextpower")
	arg_1_0._gopower = gohelper.findChild(arg_1_0.viewGO, "up/#go_power")
	arg_1_0._txtpower = gohelper.findChildText(arg_1_0.viewGO, "up/#go_power/#txt_power")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	if not arg_4_0._canClose then
		return
	end

	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebgbar:LoadImage(ResUrl.getMessageIcon("bg_tc1"))

	arg_5_0._animation = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animation))

	if arg_5_0._animation then
		arg_5_0._animation:Play("levelup", UnityEngine.PlayMode.StopAll)
		arg_5_0._animation:PlayQueued("levelup_loop", UnityEngine.QueueMode.CompleteOthers, UnityEngine.PlayMode.StopAll)
	end

	TaskDispatcher.runDelay(arg_5_0._setCanClose, arg_5_0, 1.8)
end

function var_0_0._setCanClose(arg_6_0)
	arg_6_0._canClose = true
end

function var_0_0._refreshUI(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LevelUp)

	local var_7_0 = PlayerModel.instance:getPlayinfo()
	local var_7_1 = var_7_0.level
	local var_7_2 = math.max(var_7_0.level - arg_7_0._levelup, 1)

	arg_7_0._txtlevelbefore.text = var_7_2
	arg_7_0._txtlevelafter.text = var_7_1
	arg_7_0._txtlevelafteeffect.text = var_7_1

	local var_7_3 = PlayerConfig.instance:getPlayerLevelCO(var_7_1)
	local var_7_4 = PlayerConfig.instance:getPlayerLevelCO(var_7_2)

	if var_7_3.maxAutoRecoverPower > var_7_4.maxAutoRecoverPower then
		gohelper.setActive(arg_7_0._gomaxpower, true)

		arg_7_0._txtmaxpower.text = string.format(luaLang("player_levelup_maxpower"), var_7_4.maxAutoRecoverPower)
		arg_7_0._txtnextpower.text = var_7_3.maxAutoRecoverPower
	else
		gohelper.setActive(arg_7_0._gomaxpower, false)
	end

	local var_7_5 = 0

	if var_7_2 < var_7_1 then
		for iter_7_0 = var_7_2, var_7_1 - 1 do
			local var_7_6 = PlayerConfig.instance:getPlayerLevelCO(iter_7_0)

			var_7_5 = var_7_5 + (var_7_6 and var_7_6.addUpRecoverPower or 0)
		end
	end

	if var_7_5 > 0 then
		gohelper.setActive(arg_7_0._gopower, true)

		arg_7_0._txtpower.text = string.format(luaLang("player_levelup_power"), var_7_5)
	else
		gohelper.setActive(arg_7_0._gopower, false)
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0._levelup = arg_8_0.viewParam or 1

	arg_8_0:_refreshUI()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._levelup = arg_9_0.viewParam or 1

	arg_9_0:_refreshUI()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._setCanClose, arg_11_0)
	arg_11_0._simagebgbar:UnLoadImage()
end

return var_0_0

module("modules.logic.player.view.PlayerLevelUpView", package.seeall)

slot0 = class("PlayerLevelUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebgbar = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bgbar")
	slot0._txtlevelbefore = gohelper.findChildText(slot0.viewGO, "level/#txt_levelbefore")
	slot0._txtlevelafter = gohelper.findChildText(slot0.viewGO, "level/#txt_levelafter")
	slot0._txtlevelafteeffect = gohelper.findChildText(slot0.viewGO, "level/#txt_levelafteeffect")
	slot0._gomaxpower = gohelper.findChild(slot0.viewGO, "up/#go_maxpower")
	slot0._txtmaxpower = gohelper.findChildText(slot0.viewGO, "up/#go_maxpower/#txt_maxpower")
	slot0._txtnextpower = gohelper.findChildText(slot0.viewGO, "up/#go_maxpower/#txt_maxpower/#txt_nextpower")
	slot0._gopower = gohelper.findChild(slot0.viewGO, "up/#go_power")
	slot0._txtpower = gohelper.findChildText(slot0.viewGO, "up/#go_power/#txt_power")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	if not slot0._canClose then
		return
	end

	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebgbar:LoadImage(ResUrl.getMessageIcon("bg_tc1"))

	slot0._animation = slot0.viewGO:GetComponent(typeof(UnityEngine.Animation))

	if slot0._animation then
		slot0._animation:Play("levelup", UnityEngine.PlayMode.StopAll)
		slot0._animation:PlayQueued("levelup_loop", UnityEngine.QueueMode.CompleteOthers, UnityEngine.PlayMode.StopAll)
	end

	TaskDispatcher.runDelay(slot0._setCanClose, slot0, 1.8)
end

function slot0._setCanClose(slot0)
	slot0._canClose = true
end

function slot0._refreshUI(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LevelUp)

	slot1 = PlayerModel.instance:getPlayinfo()
	slot2 = slot1.level
	slot3 = math.max(slot1.level - slot0._levelup, 1)
	slot0._txtlevelbefore.text = slot3
	slot0._txtlevelafter.text = slot2
	slot0._txtlevelafteeffect.text = slot2

	if PlayerConfig.instance:getPlayerLevelCO(slot3).maxAutoRecoverPower < PlayerConfig.instance:getPlayerLevelCO(slot2).maxAutoRecoverPower then
		gohelper.setActive(slot0._gomaxpower, true)

		slot0._txtmaxpower.text = string.format(luaLang("player_levelup_maxpower"), slot5.maxAutoRecoverPower)
		slot0._txtnextpower.text = slot4.maxAutoRecoverPower
	else
		gohelper.setActive(slot0._gomaxpower, false)
	end

	slot6 = 0

	if slot3 < slot2 then
		for slot10 = slot3, slot2 - 1 do
			slot6 = slot6 + (PlayerConfig.instance:getPlayerLevelCO(slot10) and slot11.addUpRecoverPower or 0)
		end
	end

	if slot6 > 0 then
		gohelper.setActive(slot0._gopower, true)

		slot0._txtpower.text = string.format(luaLang("player_levelup_power"), slot6)
	else
		gohelper.setActive(slot0._gopower, false)
	end
end

function slot0.onUpdateParam(slot0)
	slot0._levelup = slot0.viewParam or 1

	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0._levelup = slot0.viewParam or 1

	slot0:_refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._setCanClose, slot0)
	slot0._simagebgbar:UnLoadImage()
end

return slot0

module("modules.logic.versionactivity1_9.enter.view.VersionActivity1_9EnterBgmView", package.seeall)

slot0 = class("VersionActivity1_9EnterBgmView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, slot0.onSelectActId, slot0, LuaEventSystem.Low)
end

function slot0.onOpen(slot0)
	slot0._isFirstOpenMainAct = VersionActivityEnterHelper.getActId(slot0.viewParam.activityIdList[VersionActivityEnterHelper.getTabIndex(slot0.viewParam.activityIdList, slot0.viewParam.jumpActId)]) == VersionActivity1_9Enum.ActivityId.Dungeon

	slot0:modifyBgm(slot2)

	slot0._isFirstOpenMainAct = false
end

function slot0.onSelectActId(slot0, slot1)
	slot0:modifyBgm(slot1)
end

function slot0.initActHandle(slot0)
	if not slot0.actHandleDict then
		slot0.actHandleDict = {
			[VersionActivity1_9Enum.ActivityId.BossRush] = slot0.playBossRushBgm
		}
	end
end

function slot0.modifyBgm(slot0, slot1)
	slot0._isMainAct = slot1 == VersionActivity1_9Enum.ActivityId.Dungeon
	slot2 = 0

	if slot0._isMainAct then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity1_9Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		slot0.playingActId = nil
		slot0.bgmId = nil

		if slot0._isFirstOpenMainAct then
			slot0._isFirstOpenMainAct = false
			slot2 = 3.5

			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_9Enter.play_ui_jinye_open)
		else
			slot2 = 1

			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_9Enter.play_ui_jinye_unfold)
		end
	end

	slot0._actId = slot1

	TaskDispatcher.cancelTask(slot0._delayModifyBgm, slot0)
	TaskDispatcher.runDelay(slot0._delayModifyBgm, slot0, slot2)
end

function slot0._delayModifyBgm(slot0)
	slot0:_doModifyBgm(slot0._actId)
end

function slot0._doModifyBgm(slot0, slot1)
	slot0:initActHandle()
	slot0.actHandleDict[slot1] or slot0.defaultBgmHandle(slot0, slot1)
end

function slot0.defaultBgmHandle(slot0, slot1)
	if slot0.playingActId == slot1 then
		return
	end

	slot0.playingActId = slot1

	if ActivityConfig.instance:getActivityEnterViewBgm(slot1) == 0 then
		logError("actId : " .. tostring(slot1) .. " 没有配置背景音乐")

		slot2 = AudioEnum.Bgm.Act1_9DungeonBgm
	end

	if slot2 == slot0.bgmId and not slot0._isMainAct then
		return
	end

	slot0.bgmId = slot2

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity1_9Main)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity1_9Main, slot2)
end

function slot0.playBossRushBgm(slot0, slot1)
	slot0.playingActId = slot1
	slot2 = ActivityConfig.instance:getActivityEnterViewBgm(slot1)
	slot0.bgmId = slot2

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity1_9Main, FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity1_9Main, slot2)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayModifyBgm, slot0)
end

return slot0

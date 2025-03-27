module("modules.logic.versionactivity2_4.enter.view.VersionActivity2_4EnterBgmView", package.seeall)

slot0 = class("VersionActivity2_4EnterBgmView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, slot0.onSelectActId, slot0, LuaEventSystem.Low)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, slot0.onSelectActId, slot0, LuaEventSystem.Low)
end

function slot0._editableInitView(slot0)
	slot0:initActHandle()
end

function slot0.initActHandle(slot0)
	if not slot0.actHandleDict then
		slot0.actHandleDict = {
			[BossRushConfig.instance:getActivityId()] = slot0._bossrushBgmHandle
		}
	end
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam.activitySettingList or {}
	slot0._isFirstOpenMainAct = VersionActivityEnterHelper.getActId(slot1[VersionActivityEnterHelper.getTabIndex(slot1, slot0.viewParam.jumpActId)]) == VersionActivity2_4Enum.ActivityId.Dungeon

	slot0:modifyBgm(slot4)

	slot0._isFirstOpenMainAct = false
end

function slot0.onSelectActId(slot0, slot1)
	slot0:modifyBgm(slot1)
end

function slot0.modifyBgm(slot0, slot1)
	slot0._isMainAct = slot1 == VersionActivity2_4Enum.ActivityId.Dungeon
	slot2 = 0

	if slot0._isMainAct then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity2_4Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		slot0.playingActId = nil
		slot0.bgmId = nil

		if slot0._isFirstOpenMainAct then
			slot0._isFirstOpenMainAct = false
			slot2 = 3.5
		else
			slot2 = 1
		end
	end

	slot0._actId = slot1

	TaskDispatcher.cancelTask(slot0._doModifyBgm, slot0)
	TaskDispatcher.runDelay(slot0._doModifyBgm, slot0, slot2)
end

function slot0._doModifyBgm(slot0)
	slot0.actHandleDict[slot0._actId] or slot0.defaultBgmHandle(slot0, slot0._actId)
end

function slot0.defaultBgmHandle(slot0, slot1)
	if slot0.playingActId == slot1 then
		return
	end

	slot0.playingActId = slot1

	if ActivityConfig.instance:getActivityEnterViewBgm(slot1) == 0 then
		logError("actId : " .. tostring(slot1) .. " 没有配置背景音乐")

		slot2 = AudioEnum.Bgm.Act2_0DungeonBgm
	end

	if not slot0._isMainAct and slot2 == slot0.bgmId then
		return
	end

	slot0.bgmId = slot2

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_4Main)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity2_4Main, slot2)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._doModifyBgm, slot0)
end

function slot0._bossrushBgmHandle(slot0, slot1)
	slot0.playingActId = slot1
	slot2 = ActivityConfig.instance:getActivityEnterViewBgm(slot1)
	slot0.bgmId = slot2

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_4Main, FightEnum.AudioSwitchGroup, FightEnum.AudioSwitch.Comeshow)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity2_4Main, slot2)
end

return slot0

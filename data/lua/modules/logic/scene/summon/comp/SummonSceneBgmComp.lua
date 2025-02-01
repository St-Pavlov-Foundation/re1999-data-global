module("modules.logic.scene.summon.comp.SummonSceneBgmComp", package.seeall)

slot0 = class("SummonSceneBgmComp", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._sceneLevelCO = lua_scene_level.configDict[slot2]

	if slot0._sceneLevelCO and slot0._sceneLevelCO.bgm and slot0._sceneLevelCO.bgm > 0 then
		slot0._bgmId = slot0._sceneLevelCO.bgm
	end

	if slot0._bgmId then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.Summon, slot0._bgmId, AudioEnum.UI.Stop_UIMusic, nil, , AudioEnum.SwitchGroup.Summon, AudioEnum.SwitchState.SummonNormal)
	end
end

function slot0.Play(slot0, slot1)
	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.SummonTab), AudioMgr.instance:getIdFromString(slot1 == SummonEnum.ResultType.Equip and AudioEnum.SwitchState.SummonEquip or AudioEnum.SwitchState.SummonChar))
end

function slot0.onSceneClose(slot0)
	if slot0._bgmId then
		slot0._bgmId = nil

		AudioBgmManager.instance:stopAndClear(AudioBgmEnum.Layer.Summon)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_help_close)
end

function slot0.onSceneHide(slot0)
	slot0:onSceneClose()
end

return slot0

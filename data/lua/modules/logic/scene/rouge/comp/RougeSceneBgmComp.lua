module("modules.logic.scene.rouge.comp.RougeSceneBgmComp", package.seeall)

slot0 = class("RougeSceneBgmComp", BaseSceneComp)

function slot0.onScenePrepared(slot0, slot1, slot2)
	slot0:changeBgm()
	RougeMapController.instance:registerCallback(RougeMapEvent.onChangeMapInfo, slot0.changeBgm, slot0)
end

function slot0.changeBgm(slot0)
	slot2 = AudioEnum.Bgm.RougeMain

	if RougeMapModel.instance:getLayerCo() and slot1.bgm ~= 0 then
		slot2 = slot1.bgm
	end

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.RougeScene, slot2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function slot0.onSceneClose(slot0, slot1, slot2)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onChangeMapInfo, slot0.changeBgm, slot0)
end

return slot0
